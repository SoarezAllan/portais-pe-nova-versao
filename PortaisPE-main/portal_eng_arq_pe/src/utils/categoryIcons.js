/**
 * Resolvedor Inteligente de Emojis/Ícones para Subáreas e Categorias
 * Detecta e atribui automaticamente o melhor emoji para qualquer subárea cadastrada no Gerenciador.
 */
export function getCategoryEmoji(name) {
  if (!name) return '🔹';

  // 1. Se o próprio nome já começar com um emoji (ex: "🚁 Drones")
  const emojiRegex = /^(\p{Extended_Pictographic}|\p{Emoji_Presentation})/u;
  const match = name.trim().match(emojiRegex);
  if (match) return match[0];

  // 2. Normalização para busca por palavras-chave
  const norm = name
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim();

  // Mapeamentos inteligentes por tema
  if (norm.includes('imobiliari') || norm.includes('imove') || norm.includes('predial')) return '🏠';
  if (norm.includes('movel') || norm.includes('moveis') || norm.includes('mobiliari')) return '🛋️';
  if (norm.includes('engenharia') || norm.includes('obra') || norm.includes('construc')) return '🏗️';
  if (norm.includes('arquitet') || norm.includes('planta') || norm.includes('desenho')) return '📐';
  if (norm.includes('cartograf') || norm.includes('mapa') || norm.includes('geo') || norm.includes('gis') || norm.includes('topograf')) return '🗺️';
  if (norm.includes('avalia') || norm.includes('pericia') || norm.includes('laudo')) return '🏢';
  if (norm.includes('frota') || norm.includes('veiculo') || norm.includes('transporte') || norm.includes('carro')) return '🚗';
  if (norm.includes('agua') && norm.includes('energia')) return '⚡';
  if (norm.includes('agua') || norm.includes('hidr') || norm.includes('saneam')) return '💧';
  if (norm.includes('energia') || norm.includes('eletric') || norm.includes('luz')) return '⚡';
  if (norm.includes('telemat') || norm.includes('tecnolog') || norm.includes('informat') || norm.includes('rede') || norm.includes('telecom')) return '📡';
  if (norm.includes('contrato') || norm.includes('convenio') || norm.includes('licitac') || norm.includes('compras') || norm.includes('jurid')) return '📋';
  if (norm.includes('seguranc') || norm.includes('vigilanc') || norm.includes('portaria') || norm.includes('blind')) return '🛡️';
  if (norm.includes('limpeza') || norm.includes('conservac') || norm.includes('facilities')) return '🧹';
  if (norm.includes('sustentab') || norm.includes('ambient') || norm.includes('verde') || norm.includes('ecolog')) return '🌿';
  if (norm.includes('curso') || norm.includes('capacit') || norm.includes('treinament') || norm.includes('educac')) return '🎓';
  if (norm.includes('noticia') || norm.includes('comunicac') || norm.includes('imprensa') || norm.includes('jornal')) return '📰';
  if (norm.includes('inovac') || norm.includes('soluc') || norm.includes('pesquisa') || norm.includes('ideia')) return '💡';
  if (norm.includes('financ') || norm.includes('orcament') || norm.includes('contabil') || norm.includes('fiscal')) return '💰';
  if (norm.includes('pessoal') || norm.includes('recursos humanos') || norm.includes('rh') || norm.includes('gestao')) return '👥';
  if (norm.includes('saude') || norm.includes('medic') || norm.includes('hospital')) return '🏥';
  if (norm.includes('document') || norm.includes('arquivo') || norm.includes('memoria')) return '📁';
  if (norm.includes('auditor') || norm.includes('fiscalizac') || norm.includes('controle')) return '🔍';

  return '🔹';
}

export default getCategoryEmoji;
