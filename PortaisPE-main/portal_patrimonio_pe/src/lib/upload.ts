/// <reference types="vite/client" />

/**
 * Interface do objeto imagem retornado pelo Keystone após upload.
 */
export interface KeystoneImage {
  id: string;
  url: string;
}

interface UploadResult {
  [key: string]: {
    id: string;
    imagem: KeystoneImage | null;
  } | null;
}

/**
 * Monta a URL base da API GraphQL do Keystone.
 */
function getApiUrl(): string {
  const base = import.meta.env.VITE_API_BASE_URL || '';
  return base ? `${base.replace(/\/$/, '')}/api/graphql` : '/api/graphql';
}

/**
 * Faz upload de um arquivo para o Keystone via multipart/form-data.
 *
 * O Keystone aceita upload de arquivos atravé do protocolo multipart GraphQL
 * usando os campos:
 *   - 'operations': JSON com a mutation e variáveis (file = null)
 *   - 'map': JSON mapeando índice do arquivo para a variável
 *   - '0', '1', ...: os arquivos binários
 *
 * @param file - Arquivo a ser enviado
 * @param mutation - Mutation GraphQL (ex: `mutation ($file: Upload!) { createServico(data: { imagem: { upload: $file } }) { id imagem { id url } } }`)
 * @param variablePath - Caminho da variável no map (default: 'variables.file')
 * @returns Objeto com id e url da imagem
 */
export async function uploadToKeystone(
  file: File,
  mutation?: string,
  variablePath?: string
): Promise<KeystoneImage> {
  const apiUrl = getApiUrl();
  const varPath = variablePath ?? 'variables.file';

  // Mutation padrão para upload de imagem avulsa (se não for especificada)
  const defaultMutation = `mutation ($file: Upload!) {
    uploadImage: createServico(data: { imagem: { upload: $file } }) {
      id
      imagem {
        id
        url
      }
    }
  }`;

  const gqlMutation = mutation ?? defaultMutation;

  const formData = new FormData();

  // Campo 'operations': define a query e as variáveis
  formData.append(
    'operations',
    JSON.stringify({
      query: gqlMutation,
      variables: { file: null },
    })
  );

  // Campo 'map': mapeia o índice do arquivo para a variável correspondente
  formData.append('map', JSON.stringify({ '0': [varPath] }));

  // Campo '0': o arquivo binário
  formData.append('0', file);

  const response = await fetch(apiUrl, {
    method: 'POST',
    credentials: 'include',
    body: formData,
  });

  if (!response.ok) {
    throw new Error(`Erro HTTP ${response.status}: ${response.statusText}`);
  }

  const result = await response.json();

  if (result.errors && result.errors.length > 0) {
    const messages = result.errors.map((e: { message: string }) => e.message).join('; ');
    throw new Error(`Erro no upload: ${messages}`);
  }

  // Extrai o resultado dinamicamente (primeira chave do data)
  const data = result.data as UploadResult;
  const firstKey = Object.keys(data)[0];
  const mutationResult = data[firstKey];

  if (!mutationResult?.imagem) {
    throw new Error('Upload realizado mas nenhuma imagem foi retornada');
  }

  return mutationResult.imagem;
}

/**
 * Função simplificada para upload de imagem para o campo `imagem` de um Serviço.
 *
 * @param file - Arquivo de imagem a ser enviado
 * @returns Objeto com id e url da imagem
 */
export async function uploadImage(file: File): Promise<KeystoneImage> {
  const mutation = `mutation ($file: Upload!) {
    createServico(data: { imagem: { upload: $file } }) {
      id
      imagem {
        id
        url
      }
    }
  }`;

  return uploadToKeystone(file, mutation);
}

export default uploadImage;

