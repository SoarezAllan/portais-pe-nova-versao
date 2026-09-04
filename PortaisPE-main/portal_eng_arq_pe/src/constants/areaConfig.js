// ⚠️ ARQUIVO DE COMPATIBILIDADE RETROATIVA
// A fonte única de verdade é siteConfig.
// Mantido para não quebrar imports existentes.
import siteConfig from '../config/siteConfig';

export const AREA_NOME = siteConfig.SITE_AREA;
export const SUBAREAS = siteConfig.SUBAREAS;

export default { AREA_NOME, SUBAREAS };
