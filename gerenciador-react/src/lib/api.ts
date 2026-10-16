import { GraphQLClient } from 'graphql-request';

export function getApiUrl(): string {
  if (import.meta.env.VITE_API_URL) {
    return import.meta.env.VITE_API_URL;
  }
  // Usa o proxy do Vite (/api -> backend) para funcionar tanto em localhost quanto em rede
  return '/api/graphql';
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

export interface UploadedImage {
  id: string;
  url: string;
  filesize?: number;
  width?: number;
  height?: number;
  extension?: string;
}

export async function uploadFile(file: File): Promise<UploadedImage> {
  const currentUrl = getApiUrl();
  const formData = new FormData();
  formData.append('operations', JSON.stringify({
    query: `mutation ($file: Upload!) { uploadImage(file: $file) { id url filesize width height extension } }`,
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
