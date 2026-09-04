/// <reference types="vite/client" />

/** Área responsável por um conteúdo */
export interface Area {
  id: string;
  nome: string;
}

/** Subárea vinculada a uma área */
export interface Subarea {
  id: string;
  nome: string;
}

/** Dados públicos do usuário autenticado */
export interface UserPublic {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'operator';
  areas?: Area[];
}

/** Imagem enviada ao Keystone (via storage local) */
export interface ApiImage {
  id: string;
  url: string;
  filesize?: number;
  width?: number;
  height?: number;
  extension?: string;
}

/** Parâmetros de paginação para useList */
export interface PaginationParams {
  take: number;
  skip: number;
}
