import { createClient } from '@sanity/client';
import imageUrlBuilder from '@sanity/image-url'; // 1. Importa a ferramenta de imagens

const client = createClient({
  projectId: 'abdi2nus', 
  dataset: 'production',
  useCdn: false, 
  apiVersion: '2025-09-11', 
});

// 2. Cria a "máquina" de processar imagens com a sua configuração
const builder = imageUrlBuilder(client);

// 3. Exporta a função 'urlFor' para ser usada em qualquer lugar do seu site
export const urlFor = (source) => builder.image(source);

export default client;