import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { graphqlRequest, applyAreaFilter } from '@/lib/api';
import { GRAPHQL_NAMES } from '@/lib/graphqlNames';
import { useAuth } from './useAuth';
import type { GraphQLName } from '@/lib/graphqlNames';

/** Gera uma query de listagem com os nomes GraphQL corretos (plural para list, singular para type). */
function buildListQuery(name: GraphQLName, fields: string, hasOrderBy: boolean) {
  if (hasOrderBy) {
    return `query Get${name.type}s($take: Int, $skip: Int, $orderBy: [${name.type}OrderByInput!], $where: ${name.type}WhereInput) {
      items: ${name.list}(take: $take, skip: $skip, orderBy: $orderBy, where: $where) { ${fields} }
      total: ${name.count}(where: $where)
    }`;
  }
  return `query Get${name.type}s($take: Int, $skip: Int, $where: ${name.type}WhereInput) {
    items: ${name.list}(take: $take, skip: $skip, where: $where) { ${fields} }
    total: ${name.count}(where: $where)
  }`;
}

function buildItemQuery(name: GraphQLName, fields: string) {
  return `query Get${name.type}($id: ID!) { item: ${name.item}(where: { id: $id }) { ${fields} } }`;
}

function buildCreateMutation(name: GraphQLName, fields: string) {
  return `mutation Create${name.type}($data: ${name.type}CreateInput!) { item: ${name.create}(data: $data) { ${fields} } }`;
}

function buildUpdateMutation(name: GraphQLName, fields: string) {
  return `mutation Update${name.type}($id: ID!, $data: ${name.type}UpdateInput!) { item: ${name.update}(where: { id: $id }, data: $data) { ${fields} } }`;
}

function buildDeleteMutation(name: GraphQLName) {
  return `mutation Delete${name.type}($id: ID!) { delete${name.type}(where: { id: $id }) { id } }`;
}

interface ListOptions {
  fields: string;
  where?: Record<string, any>;
  orderBy?: Record<string, string>;
  take?: number;
  skip?: number;
}

/**
 * Hook genérico que usa o mapeamento GraphQLName para gerar as queries corretas.
 * `listName` deve ser uma chave de GRAPHQL_NAMES: 'servicos' | 'noticias' | 'legislacaos' | 'cursos' | 'quemSomos'.
 */
export function useList(listName: keyof typeof GRAPHQL_NAMES, options: ListOptions) {
  const { isAdmin, areaIds } = useAuth();
  const queryClient = useQueryClient();
  const name = GRAPHQL_NAMES[listName];

  const { fields, where = {}, orderBy, take = 50, skip = 0 } = options;
  const filteredWhere = applyAreaFilter(where, areaIds, isAdmin);

  const hasOrderBy = !!orderBy;
  const listQuery = buildListQuery(name, fields, hasOrderBy);
  const itemQuery = buildItemQuery(name, fields);
  const createMutationStr = buildCreateMutation(name, fields);
  const updateMutationStr = buildUpdateMutation(name, fields);
  const deleteMutationStr = buildDeleteMutation(name);

  const variables: Record<string, any> = {
    where: filteredWhere,
    take,
    skip,
  };
  if (orderBy) {
    variables.orderBy = [orderBy];
  }

  const list = useQuery({
    queryKey: [listName, 'list', filteredWhere, orderBy, take, skip],
    queryFn: () =>
      graphqlRequest<{ items: any[]; total: number }>(listQuery, variables),
  });

  const create = useMutation({
    mutationFn: (data: any) => graphqlRequest<{ item: any }>(createMutationStr, { data }),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: [listName] }),
  });

  const update = useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) =>
      graphqlRequest<{ item: any }>(updateMutationStr, { id, data }),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: [listName] }),
  });

  const remove = useMutation({
    mutationFn: (id: string) => graphqlRequest<{ delete: any }>(deleteMutationStr, { id }),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: [listName] }),
  });

  return { list, create, update, remove };
}
