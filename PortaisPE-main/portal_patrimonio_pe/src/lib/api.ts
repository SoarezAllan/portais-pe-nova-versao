/// <reference types="vite/client" />

import apiClient from '../api';

interface GraphQLResponse<T = unknown> {
  data?: T;
  errors?: { message: string; locations?: { line: number; column: number }[]; path?: string[] }[];
}

/**
 * Executa uma requisição GraphQL dinâmica via apiClient (axios).
 *
 * @param query - String da query/mutation GraphQL
 * @param variables - Variáveis da query
 * @returns Dados da resposta ou lança erro
 */
export async function graphqlRequest<T = unknown>(
  query: string,
  variables?: Record<string, unknown>
): Promise<T> {
  try {
    const response = await apiClient.post<GraphQLResponse<T>>('/api/graphql', {
      query,
      variables,
    });

    const { data: responseData, errors } = response.data;

    if (errors && errors.length > 0) {
      const messages = errors.map((e) => e.message).join('; ');
      throw new Error(messages);
    }

    if (!responseData) {
      throw new Error('Resposta vazia do servidor');
    }

    return responseData;
  } catch (err) {
    if (err instanceof Error) {
      throw err;
    }
    throw new Error('Erro desconhecido ao conectar com o servidor');
  }
}

export default graphqlRequest;

