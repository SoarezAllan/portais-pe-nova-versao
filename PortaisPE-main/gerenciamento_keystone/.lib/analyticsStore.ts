type EventType = 'PORTAL_VIEW' | 'SERVICO_VIEW' | 'NOTICIA_VIEW';

type AnalyticsEvent = {
  eventId: string;
  type: EventType;
  ts: string; // ISO
  portal?: string;
  servicoSlug?: string;
  noticiaSlug?: string;
};

type TopRow = { key: string; count: number };

type TopResponse = {
  type: 'portal' | 'servico' | 'noticia';
  top: TopRow[];
};

const MAX_KEYS = 5000;
const MAX_EVENTID_CACHE = 20000;
const TTL_MS = 1000 * 60 * 60 * 24 * 30; // 30 dias

const seenEventIds = new Map<string, number>(); // eventId -> lastSeenTs

// aggregated counters
const countersPortal = new Map<string, number>();
const countersServico = new Map<string, number>();
const countersNoticia = new Map<string, number>();

function gc() {
  const now = Date.now();
  for (const [id, ts] of seenEventIds.entries()) {
    if (now - ts > TTL_MS) seenEventIds.delete(id);
  }

  // Soft cap: if too many keys, we can't fully GC maps without persistence,
  // but we can reduce by trimming smallest entries.
  if (countersPortal.size > MAX_KEYS) trimSmallest(countersPortal);
  if (countersServico.size > MAX_KEYS) trimSmallest(countersServico);
  if (countersNoticia.size > MAX_KEYS) trimSmallest(countersNoticia);

  if (seenEventIds.size > MAX_EVENTID_CACHE) {
    // delete oldest
    const entries = [...seenEventIds.entries()].sort((a, b) => a[1] - b[1]);
    const toDelete = entries.length - MAX_EVENTID_CACHE;
    for (let i = 0; i < toDelete; i++) {
      seenEventIds.delete(entries[i][0]);
    }
  }
}

function trimSmallest(map: Map<string, number>) {
  const entries = [...map.entries()];
  entries.sort((a, b) => a[1] - b[1]);
  const over = entries.length - MAX_KEYS;
  if (over <= 0) return;
  for (let i = 0; i < over; i++) map.delete(entries[i][0]);
}

export function trackEvent(input: AnalyticsEvent) {
  gc();

  if (!input?.eventId || !input?.type || !input?.ts) return { ok: false as const, reason: 'invalid' };

  const last = seenEventIds.get(input.eventId);
  const now = Date.now();
  if (last) {
    // dedupe: ignore if seen recently
    if (now - last <= TTL_MS) return { ok: true as const, deduped: true as const };
  }

  seenEventIds.set(input.eventId, now);

  const portal = input.portal || '';
  if (input.type === 'PORTAL_VIEW' && portal) {
    countersPortal.set(portal, (countersPortal.get(portal) || 0) + 1);
  }

  if (input.type === 'SERVICO_VIEW' && input.servicoSlug) {
    countersServico.set(input.servicoSlug, (countersServico.get(input.servicoSlug) || 0) + 1);
    // keep portal too (best-effort)
    if (portal) countersPortal.set(portal, (countersPortal.get(portal) || 0) + 1);
  }

  if (input.type === 'NOTICIA_VIEW' && input.noticiaSlug) {
    countersNoticia.set(input.noticiaSlug, (countersNoticia.get(input.noticiaSlug) || 0) + 1);
    if (portal) countersPortal.set(portal, (countersPortal.get(portal) || 0) + 1);
  }

  return { ok: true as const };
}

export function getTop(type: TopResponse['type'], limit = 10): TopResponse {
  const map =
    type === 'portal' ? countersPortal : type === 'servico' ? countersServico : countersNoticia;

  const rows: TopRow[] = [...map.entries()]
    .map(([key, count]) => ({ key, count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, limit);

  return { type, top: rows };
}

export function getRawSummary() {
  gc();
  return {
    portalKeys: countersPortal.size,
    servicoKeys: countersServico.size,
    noticiaKeys: countersNoticia.size,
  };
}

