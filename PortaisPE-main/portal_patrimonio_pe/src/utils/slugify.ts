/**
 * Gera uma slug a partir de um texto, removendo acentos,
 * substituindo espaços por hífen, removendo caracteres especiais
 * e retornando em lowercase.
 *
 * @param text - Texto de entrada para gerar a slug
 * @returns Slug gerada
 */
export function generateSlug(text: string): string {
  if (!text) return '';

  // Mapa de acentos para substituição
  const accentMap: Record<string, string> = {
    à: 'a', á: 'a', â: 'a', ã: 'a', ä: 'a', å: 'a',
    è: 'e', é: 'e', ê: 'e', ë: 'e',
    ì: 'i', í: 'i', î: 'i', ï: 'i',
    ò: 'o', ó: 'o', ô: 'o', õ: 'o', ö: 'o', ø: 'o',
    ù: 'u', ú: 'u', û: 'u', ü: 'u',
    ý: 'y', ÿ: 'y',
    ñ: 'n', ç: 'c',
    À: 'a', Á: 'a', Â: 'a', Ã: 'a', Ä: 'a', Å: 'a',
    È: 'e', É: 'e', Ê: 'e', Ë: 'e',
    Ì: 'i', Í: 'i', Î: 'i', Ï: 'i',
    Ò: 'o', Ó: 'o', Ô: 'o', Õ: 'o', Ö: 'o', Ø: 'o',
    Ù: 'u', Ú: 'u', Û: 'u', Ü: 'u',
    Ý: 'y',
    Ñ: 'n', Ç: 'c',
  };

  return text
    .trim()
    // Remove acentos usando regex + mapa
    .replace(/[àáâãäåæèéêëìíîïòóôõöøùúûüýÿñç]/gi, (char) => accentMap[char] || char)
    // Remove caracteres especiais (mantém letras, números, espaços e hífens)
    .replace(/[^a-z0-9\s-]/gi, '')
    // Substitui espaços por hífen
    .replace(/\s+/g, '-')
    // Remove hífens consecutivos
    .replace(/-+/g, '-')
    // Remove hífens do início e fim
    .replace(/^-+|-+$/g, '')
    // Retorna em lowercase
    .toLowerCase();
}

export default generateSlug;

