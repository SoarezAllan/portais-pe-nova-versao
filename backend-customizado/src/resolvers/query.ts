import { getListConfig, getDelegate } from '../config/lists.js';
import { convertFilter } from './filter.js';
import { buildListFilter } from '../auth/permissions.js';
import { queryCache } from '../cache.js';
import type { Context } from '../context.js';

/**
 * Gera todos os resolvers de Query de forma genérica com base nas listas config.
 */
export function buildQueryResolvers() {
  const listKeys = [
    'user', 'auditLog', 'servico', 'solucao', 'noticia', 'legislacao', 'curso',
    'tag', 'areaResponsavel', 'gerencia', 'setor', 'subarea', 'gestores',
    'paginaQuemSomos', 'quemSomosMuralItem', 'quemSomosTimeItem',
    'quemSomosSubareaItem', 'portfolio', 'portfolioImagem', 'acesso',
  ];

  const resolvers: Record<string, any> = {};

  for (const key of listKeys) {
    const cfg = getListConfig(key)!;
    const delegate = getDelegate(cfg.prisma);

    // singletons: <item>(where: { id }): T
    resolvers[cfg.item] = async (parents: any, args: any, ctx: Context) => {
      const { where } = args;
      const id = where?.id;
      if (!id) return null;
      const accessFilter = buildListFilter(cfg.type, ctx.session);

      // Cache para consultas públicas
      const cacheKey = !ctx.session ? `${cfg.type}::item::${id}` : null;
      if (cacheKey) {
        const cached = queryCache.get(cacheKey);
        if (cached !== null) return cached;
      }

      const result = await delegate.findFirst({
        where: { id, ...accessFilter },
      });

      if (cacheKey && result) {
        queryCache.set(cacheKey, result);
      }

      return result;
    };

    // list: <list>(where, orderBy, take, skip, cursor): [T]
    resolvers[cfg.list] = async (parents: any, args: any, ctx: Context) => {
      const { where = {}, orderBy = [], take, skip = 0 } = args;
      const baseFilter = convertFilter(where);
      const accessFilter = buildListFilter(cfg.type, ctx.session);
      const finalWhere = { ...baseFilter, ...accessFilter };

      // Cache para consultas públicas
      const cacheKey = !ctx.session ? `${cfg.type}::list::${JSON.stringify({ where, orderBy, take, skip })}` : null;
      if (cacheKey) {
        const cached = queryCache.get(cacheKey);
        if (cached !== null) return cached;
      }

      const result = await delegate.findMany({
        where: finalWhere,
        orderBy: orderBy.length ? orderBy : undefined,
        take: take ?? undefined,
        skip,
      });

      if (cacheKey && result) {
        queryCache.set(cacheKey, result);
      }

      return result;
    };

    // count: <list>Count(where): Int
    resolvers[cfg.count] = async (parents: any, args: any, ctx: Context) => {
      const { where = {} } = args || {};
      const baseFilter = convertFilter(where);
      const accessFilter = buildListFilter(cfg.type, ctx.session);
      const finalWhere = { ...baseFilter, ...accessFilter };

      const cacheKey = !ctx.session ? `${cfg.type}::count::${JSON.stringify(where)}` : null;
      if (cacheKey) {
        const cached = queryCache.get(cacheKey);
        if (cached !== null) return cached;
      }

      const result = await delegate.count({ where: finalWhere });

      if (cacheKey) {
        queryCache.set(cacheKey, result);
      }

      return result;
    };
  }

  return resolvers;
}
