import { prisma } from '../prisma.js';
import { buildQueryResolvers } from './query.js';
import { buildMutationResolvers, buildAuthResolvers, buildUploadResolver } from './mutation.js';
import { buildFieldResolvers } from './fields.js';
import { buildRelationResolvers } from './relations.js';
import { getListConfig } from '../config/lists.js';
import type { Context } from '../context.js';

const listKeys = [
  'user', 'auditLog', 'servico', 'solucao', 'noticia', 'legislacao', 'curso',
  'tag', 'areaResponsavel', 'gerencia', 'setor', 'subarea', 'gestores',
  'paginaQuemSomos', 'quemSomosMuralItem', 'quemSomosTimeItem',
  'quemSomosSubareaItem', 'portfolio', 'portfolioImagem', 'acesso',
];

const configs = listKeys.map((k) => getListConfig(k)!).filter(Boolean);

function mergeTypeResolvers(...sources: Record<string, Record<string, any>>[]) {
  const result: Record<string, Record<string, any>> = {};
  for (const src of sources) {
    for (const [typeName, fields] of Object.entries(src)) {
      result[typeName] = {
        ...result[typeName],
        ...fields,
      };
    }
  }
  return result;
}

export const resolvers: Record<string, any> = {
  Query: {
    ...buildQueryResolvers(),

    authenticatedItem: async (parent: any, args: any, ctx: Context) => {
      if (!ctx.session) return null;
      const user = await prisma.user.findUnique({ where: { id: ctx.session.data.id } });
      if (!user) return null;
      const areas = await prisma.areaResponsavel.findMany({
        where: { from_User_areas: { some: { id: user.id } } },
      });
      return { __typename: 'User', ...user, areas };
    },
  },

  Mutation: {
    ...buildMutationResolvers(),
    ...buildAuthResolvers(),
    ...buildUploadResolver(),
  },

  AuthenticatedItem: {
    __resolveType: () => 'User',
  },

  UserAuthenticationWithPasswordResult: {
    __resolveType: (obj: any) =>
      obj.__typename ||
      (obj.sessionToken ? 'UserAuthenticationWithPasswordSuccess' : 'UserAuthenticationWithPasswordFailure'),
  },

  ...mergeTypeResolvers(
    buildFieldResolvers(configs),
    buildRelationResolvers(configs),
  ),
};
