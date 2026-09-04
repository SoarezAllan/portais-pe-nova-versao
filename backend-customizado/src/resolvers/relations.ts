import { prisma } from '../prisma.js';
import type { ListConfig } from '../config/lists.js';

/**
 * Resolve campos de relação "to-one" (ex.: Servico.areaResponsavel).
 * O id da FK está no parent como `<relationField>Id`.
 */
export function resolveToOne(parent: any, relationField: string, delegate: string) {
  const fk = parent[`${relationField}Id`];
  if (!fk) return null;
  return (prisma as any)[delegate].findUnique({ where: { id: fk } });
}

/**
 * Gera os resolvers de campos de relação para todos os tipos.
 * - to-one: busca pelo FK `<relationField>Id` no registo pai.
 * - to-many: consulta o delegate relacionado filtrando pelo campo inverso que aponta para o pai.
 */
export function buildRelationResolvers(configs: ListConfig[]) {
  const resolvers: Record<string, Record<string, any>> = {};

  for (const cfg of configs) {
    const fieldResolvers: Record<string, any> = {};

    // To-one
    for (const [graphqlField, relationField] of Object.entries(cfg.relations)) {
      fieldResolvers[graphqlField] = async (parent: any) => {
        if (parent[graphqlField] !== undefined) return parent[graphqlField];
        const fk = parent[`${relationField}Id`] ?? parent[relationField]?.id;
        if (!fk) return null;
        const delegate = (prisma as any)[relationField];
        if (!delegate) return null;
        return delegate.findUnique({ where: { id: fk } });
      };
    }

    // To-many
    for (const [graphqlField, delegateName] of Object.entries(cfg.manyRelations)) {
      fieldResolvers[graphqlField] = async (parent: any, args: any) => {
        // Se o parent já trouxe a lista resolvida
        if (Array.isArray(parent[graphqlField])) {
          return parent[graphqlField];
        }

        const parentId = parent.id;
        if (!parentId) return [];
        const where = args?.where || {};
        const orderBy = args?.orderBy || [];
        const take = args?.take;
        const skip = args?.skip || 0;

        const delegate = (prisma as any)[delegateName];
        if (!delegate) return [];

        // Casos especiais mapeados com precisão conforme schema.prisma
        let relationFilter: Record<string, any> = {};

        if (cfg.type === 'User' && graphqlField === 'areas') {
          relationFilter = { from_User_areas: { some: { id: parentId } } };
        } else if (cfg.type === 'User' && graphqlField === 'noticias') {
          relationFilter = { autorId: parentId };
        } else if (cfg.type === 'AreaResponsavel') {
          relationFilter = { areaResponsavelId: parentId };
          if (graphqlField === 'subareas') relationFilter = { areaId: parentId };
          if (graphqlField === 'gerencias') relationFilter = { areaId: parentId };
        } else if (cfg.type === 'Gerencia' && graphqlField === 'setores') {
          relationFilter = { gerenciaId: parentId };
        } else if (cfg.type === 'Subarea') {
          relationFilter = { subareaId: parentId };
        } else if (cfg.type === 'Noticia' && graphqlField === 'tags') {
          relationFilter = { noticias: { some: { id: parentId } } };
        } else if (cfg.type === 'Tag' && graphqlField === 'noticias') {
          relationFilter = { tags: { some: { id: parentId } } };
        } else if (cfg.type === 'PaginaQuemSomos') {
          relationFilter = { paginaId: parentId };
        } else if (cfg.type === 'Portfolio' && graphqlField === 'galeria') {
          relationFilter = { portfolioId: parentId };
        } else {
          const reverseField = cfg.type.charAt(0).toLowerCase() + cfg.type.slice(1);
          relationFilter = { [`${reverseField}Id`]: parentId };
        }

        return delegate.findMany({
          where: {
            ...(where as any),
            ...relationFilter,
          },
          orderBy: orderBy.length ? orderBy : undefined,
          take,
          skip,
        });
      };
    }

    if (Object.keys(fieldResolvers).length > 0) {
      resolvers[cfg.type] = fieldResolvers;
    }
  }

  return resolvers;
}
