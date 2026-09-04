export const SITE_AREA = import.meta.env.VITE_SITE_AREA || 'Patrimônio';
export const SITE_TITLE = import.meta.env.VITE_SITE_TITLE || 'Patrimônio de Pernambuco';
export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || '';
export const SUBAREAS = import.meta.env.VITE_SITE_SUBAREAS ? import.meta.env.VITE_SITE_SUBAREAS.split('|') : ['Patrimônio Imobiliário', 'Patrimônio Móvel'];

export default {
  SITE_AREA,
  SITE_TITLE,
  API_BASE_URL,
  SUBAREAS,
};
