export const subareaIcones = {
  engenharia: '🏗️',
  arquitetura: '📐',
  patrimonio_imobiliario: '🏠',
  patrimonio_movel: '🛋️',
  frota: '🚗',
  contratos_corporativos: '📋',
  outros: '🔗',
};

export const normalizeId = (label) =>
  (label || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s]/g, '')
    .trim()
    .replace(/\s+/g, '_');

export const getIcone = (label) =>
  subareaIcones[normalizeId(label)] || '🔹';