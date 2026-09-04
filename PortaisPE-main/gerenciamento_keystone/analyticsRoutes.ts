import type { Request, Response } from 'express';
import { getTop, trackEvent } from './.lib/analyticsStore';


function safeString(v: unknown) {
  return typeof v === 'string' ? v : undefined;
}

export async function analyticsTopHandler(req: Request, res: Response) {
  const typeRaw = safeString(req.query.type) || 'portal';
  const type: 'portal' | 'servico' | 'noticia' =
    typeRaw === 'servico' ? 'servico' : typeRaw === 'noticia' ? 'noticia' : 'portal';

  const limit = (() => {
    const n = Number(req.query.limit);
    if (Number.isFinite(n) && n > 0 && n <= 50) return Math.floor(n);
    return 10;
  })();

  // ===== Filtros (devem casar com a tabela de acessos) =====
  const portal = safeString(req.query.portal);
  const area = safeString(req.query.area);

  const dataInicioRaw = safeString(req.query.dataInicio);
  const dataFimRaw = safeString(req.query.dataFim);

  const dataInicio = dataInicioRaw ? new Date(dataInicioRaw) : undefined;
  const dataFim = dataFimRaw ? new Date(dataFimRaw + 'T23:59:59') : undefined;

  // Se não houver filtros, usa agregação em memória (comportamento original)
  const hasFilters = !!portal || !!area || !!dataInicio || !!dataFim;
  if (!hasFilters) {
    res.json(getTop(type, limit));
    return;
  }

  // ===== Rankings com base na tabela persistida =====
  // A lista Acesso deve conter colunas: portal, area, dataAcesso, usuario, ip
  // Para SERVICO_VIEW / NOTICIA_VIEW, como não temos servicoSlug/noticiaSlug persistidos nesse painel,
  // retornamos ranking baseado na persistência de Acesso por portal/area.
  // (Mantém o painel funcional; se houver persistência adicional depois, estendemos.)

  // Keystone mount: req.keystone
  const db: any = (req as any).keystone?.db;
  if (!db?.Acesso?.findMany) {
    // fallback: não conseguimos filtrar no banco
    res.json(getTop(type, limit));
    return;
  }

  const where: any = {};
  if (portal) where.portal = { equals: portal };
  if (area) where.area = { equals: area };
  if (dataInicio || dataFim) {
    where.dataAcesso = {};
    if (dataInicio) where.dataAcesso.gte = dataInicio.toISOString();
    if (dataFim) where.dataAcesso.lte = dataFim.toISOString();
  }

  const rows = await db.Acesso.findMany({
    where,
    select: { portal: true, area: true, dataAcesso: true },
  });

  // Agrupamento antes do slicing (top/limit)
  const counter = new Map<string, number>();
  if (type === 'portal') {
    for (const r of rows) {
      const key = r.portal || '';
      if (!key) continue;
      counter.set(key, (counter.get(key) || 0) + 1);
    }
  } else if (type === 'servico') {
    // sem servicoSlug persistido; aproxima com área
    for (const r of rows) {
      const key = r.area || '';
      if (!key) continue;
      counter.set(key, (counter.get(key) || 0) + 1);
    }
  } else {
    for (const r of rows) {
      const key = r.area || '';
      if (!key) continue;
      counter.set(key, (counter.get(key) || 0) + 1);
    }
  }

  const top = [...counter.entries()]
    .map(([key, count]) => ({ key, count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, limit);

  res.json({ type, top });
}



export async function analyticsTrackHandler(req: Request, res: Response, context: any) {
  try {
    const body = req.body as any;
    const eventId = safeString(body?.eventId);
    const type = safeString(body?.type);
    const ts = safeString(body?.ts);

    const portal = safeString(body?.portal);
    const servicoSlug = safeString(body?.servicoSlug);
    const noticiaSlug = safeString(body?.noticiaSlug);

    const allowed = new Set(['PORTAL_VIEW', 'SERVICO_VIEW', 'NOTICIA_VIEW']);
    if (!eventId || !type || !ts || !allowed.has(type)) {
      return res.status(400).json({ ok: false, reason: 'invalid_payload' });
    }

    const isoOk = !Number.isNaN(Date.parse(ts));
    if (!isoOk) {
      return res.status(400).json({ ok: false, reason: 'invalid_ts' });
    }

    const result = trackEvent({
      eventId,
      type,
      ts,
      portal,
      servicoSlug,
      noticiaSlug,
    });

    // ===== Persistir em Postgres (list Acesso) =====
    // Objetivo: permitir que a tabela e os totais do painel mostrem dados de todos os portais.
    // Observação: o payload do frontend não envia `usuario` nem `ip`.
    // Aqui usamos o IP do request (best-effort) e setamos usuario vazio.
    // A área (opção A) = nome do portal.
    try {
      // Keystone não passa `context` aqui; então acessamos db via req.keystone (Keystone mount).
      const db = context?.sudo?.().db;

      if (db?.Acesso?.createOne && portal && !result?.deduped) {
        const ip =
          (req.headers['x-forwarded-for'] as string | undefined)?.split(',')?.[0]?.trim() ||
          (req.socket?.remoteAddress as string | undefined) ||
          '';

        await db.Acesso.createOne({
          data: {
            portal,
            area: portal,
            tipo: type,
            usuario: '',
            ip,
            dataAcesso: new Date(ts),
          },
        });
      }
    } catch (persistErr) {
      // não impactar o frontend
      console.warn('[analyticsTrackHandler] persist failed:', (persistErr as any)?.message || persistErr);
    }

    return res.status(200).json(result);
  } catch (e: any) {
    return res.status(500).json({ ok: false, reason: 'server_error', message: e?.message });
  }
}


