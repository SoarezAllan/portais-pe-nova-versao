export const SITE_AREA = import.meta.env.VITE_SITE_AREA || 'Serviços Corporativos';
export const SITE_TITLE = import.meta.env.VITE_SITE_TITLE || 'Serviços Corporativos de Pernambuco';
export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || '';
export const SUBAREAS = import.meta.env.VITE_SITE_SUBAREAS
  ? import.meta.env.VITE_SITE_SUBAREAS.split('|')
  : ['Frota', 'Água e Energia', 'Telemática', 'Contratos Corporativos'];
export default {
  SITE_AREA,
  SITE_TITLE,
  API_BASE_URL,
  SUBAREAS,
};