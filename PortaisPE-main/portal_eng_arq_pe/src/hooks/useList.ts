/// <reference types="vite/client" />

/**
 * Hook genérico `useList` para buscar listas paginadas do GraphQL
 * com filtro automático por área do operador.
 *
 * Dependências:
 * - useAuth() de './useAuth'
 * - graphqlRequest() do apiClient (src/api/index.jsx)
 */

import { useState, useEffect, useCallback } from 'react';
import { useAuth } from './useAuth';
import apiClient from '../api';

interface GraphQLError {
  message: string;
  locations?: { line: number; column: number }[];
  path?: string[];
}

interface UseListOptions {
  queryName: string;
  fields: string;
  baseWhere?: Record<string, unknown>;
  take?: number;
  skip?: number;
}

interface UseListReturn {
  data: unknown[] | null;
  loading: boolean;
  error: string | null;
  total: number;
  refetch: () => void;
  setSkip: (skip: number) => void;
}

/**
 * Monta o filtro `where` combinando o baseWhere com o filtro de área
 * quando o usuário não é admin.
 */
function buildWhere(
  baseWhere: Record<string, unknown> | undefined,
  isAdmin: boolean,
  areaIds: string[]
): string {
  const areaFilter =
    !isAdmin && areaIds.length > 0
      ? { areaResponsavel: { id: { in: areaIds } } }
      : null;

  if (!baseWhere && !areaFilter) return '';
  if (baseWhere && !areaFilter) return JSON.stringify(baseWhere);
  if (!baseWhere && areaFilter) return JSON.stringify(areaFilter);

  // Ambos existem: combinar com AND
  return JSON.stringify({ AND: [baseWhere, areaFilter] });
}

/**
 * Converte um objeto JavaScript para string de argumento GraphQL literal,
 * de forma segura sem usar `any` indiscriminadamente.
 *
 * Exemplo: { id: { in: ["abc"] }, ativo: { equals: true } }
 *  → `{ id: { in: ["abc"] }, ativo: { equals: true } }`
 */
function jsonToGqlValue(value: unknown): string {
  if (value === null || value === undefined) return 'null';
  if (typeof value === 'boolean') return value ? 'true' : 'false';
  if (typeof value === 'number') return String(value);
  if (typeof value === 'string') return JSON.stringify(value);

  if (Array.isArray(value)) {
    const items = value.map((item) => jsonToGqlValue(item));
    return `[${items.join(', ')}]`;
  }

  if (typeof value === 'object') {
    const entries = Object.entries(value as Record<string, unknown>);
    const fields = entries.map(
      ([key, val]) => `${key}: ${jsonToGqlValue(val)}`
    );
    return `{ ${fields.join(', ')} }`;
  }

  return String(value);
}

/**
 * Hook genérico para listar dados do GraphQL com suporte a:
 * - Paginação (take/skip)
 * - Filtro base (baseWhere)
 * - Filtro automático por área do operador
 *
 * @param options - Configurações da consulta
 * @returns Estado da consulta
 */
export function useList({
  queryName,
  fields,
  baseWhere,
  take = 10,
  skip = 0,
}: UseListOptions): UseListReturn {
  const { isAdmin, areaIds } = useAuth();

  const [data, setData] = useState<unknown[] | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [total, setTotal] = useState(0);
  const [currentSkip, setCurrentSkip] = useState(skip);
  const [refreshKey, setRefreshKey] = useState(0);

  const refetch = useCallback(() => {
    setRefreshKey((prev) => prev + 1);
  }, []);

  useEffect(() => {
    let cancelled = false;

    async function fetchData() {
      setLoading(true);
      setError(null);

      try {
        // Monta o where com filtro de área
        const whereRaw = buildWhere(baseWhere, isAdmin, areaIds);
        const whereClause = whereRaw ? `where: ${whereRaw}` : '';
        const skipClause = currentSkip > 0 ? `skip: ${currentSkip}` : '';
        const takeClause = `take: ${take}`;

        const args = [whereClause, takeClause, skipClause]
          .filter(Boolean)
          .join(', ');

        const query = `query List${queryName.charAt(0).toUpperCase() + queryName.slice(1)} { 
          items: ${queryName}(${args}) {
            ${fields}
          }
          total: ${queryName}Meta(${whereClause}) {
            count
          }
        }`;

        const response = await apiClient.post('/api/graphql', { query });

        if (cancelled) return;

        const responseData = response.data;

        if (responseData?.errors) {
          const messages = responseData.errors
            .map((e: GraphQLError) => e.message)
            .join('; ');
          throw new Error(messages);
        }

        const resultData = responseData?.data;
        setData(resultData?.items ?? []);
        setTotal(resultData?.total?.count ?? 0);
      } catch (err) {
        if (!cancelled) {
          setError(
            err instanceof Error ? err.message : 'Erro desconhecido ao buscar dados'
          );
          setData([]);
        }
      } finally {
        if (!cancelled) {
          setLoading(false);
        }
      }
    }

    fetchData();

    return () => {
      cancelled = true;
    };
  }, [queryName, fields, isAdmin, areaIds, take, currentSkip, refreshKey, baseWhere]);

  return {
    data,
    loading,
    error,
    total,
    refetch,
    setSkip: setCurrentSkip,
  };
}

export default useList;

