import { GraphQLClient } from 'graphql-request';

export function getApiUrl(): string {
  if (import.meta.env.VITE_API_URL) {
    return import.meta.env.VITE_API_URL;
  }
  if (typeof window !== 'undefined') {
    // Detecta dinamicamente se estamos acessando via hostname (ex: http://GGPAE-027:5173), IP ou localhost
    return `${window.location.protocol}//${window.location.hostname}:3001/api/graphql`;
  }
  return 'http://localhost:3001/api/graphql';
}

export const API_URL = getApiUrl();

export function getAuthHeaders(): Record<string, string> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
  };
  if (typeof window !== 'undefined') {
    const token = localStorage.getItem('keystone_token');
    if (token) {
      headers['Authorization'] = `Bearer ${token}`;
    }
  }
  return headers;
}

export const graphqlClient = new GraphQLClient(API_URL, {
  credentials: 'include',
  headers: getAuthHeaders(),
});

export async function graphqlRequest<T>(query: string, variables?: Record<string, any>): Promise<T> {
  const currentUrl = getApiUrl();
  const client = new GraphQLClient(currentUrl, {
    credentials: 'include',
    headers: getAuthHeaders(),
  });
  return client.request<T>(query, variables);
}

export async function uploadFile(file: File): Promise<{ id: string; url: string }> {
  const currentUrl = getApiUrl();
  const formData = new FormData();
  formData.append('operations', JSON.stringify({
    query: `mutation ($file: Upload!) { uploadImage(file: $file) { id url } }`,
    variables: { file: null },
  }));
  formData.append('map', JSON.stringify({ '0': ['variables.file'] }));
  formData.append('0', file);

  const response = await fetch(currentUrl, {
    method: 'POST',
    credentials: 'include',
    body: formData,
  });

  const result = await response.json();
  if (result.errors) throw new Error(result.errors[0]?.message || 'Upload failed');
  return result.data.uploadImage;
}

export function applyAreaFilter(where: Record<string, any>, areaIds: string[], isAdmin: boolean): Record<string, any> {
  if (isAdmin || !areaIds.length) return where;
  return {
    ...where,
    areaResponsavel: { id: { in: areaIds } },
  };
}

export function generateSlug(text: string): string {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

export const DEFAULT_DOCUMENT = JSON.stringify({
  type: 'doc',
  content: [{ type: 'paragraph' }],
});
