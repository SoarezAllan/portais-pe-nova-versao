import type { ListConfig } from '../config/lists.js';

/**
 * Formata um campo de imagem do Prisma (colunas _id, _filesize, etc.)
 * para o formato Keystone `ImageFieldOutput`.
 */
export function formatImageField(parent: any, baseName: string) {
  const id = parent[`${baseName}_id`];
  if (!id) return null;
  const ext = parent[`${baseName}_extension`] || 'jpg';
  return {
    id,
    filesize: parent[`${baseName}_filesize`] ?? 0,
    width: parent[`${baseName}_width`] ?? 0,
    height: parent[`${baseName}_height`] ?? 0,
    extension: ext,
    url: `/images/${id}.${ext}`,
  };
}

const EMPTY_DOCUMENT = [{ type: 'paragraph', children: [{ text: '' }] }];

function parseDocument(value: any) {
  if (!value) return EMPTY_DOCUMENT;
  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value);
      return Array.isArray(parsed) && parsed.length > 0 ? parsed : (parsed ? [parsed] : EMPTY_DOCUMENT);
    } catch {
      return [{ type: 'paragraph', children: [{ text: value }] }];
    }
  }
  if (Array.isArray(value)) {
    return value.length > 0 ? value : EMPTY_DOCUMENT;
  }
  if (typeof value === 'object') {
    return [value];
  }
  return EMPTY_DOCUMENT;
}

/**
 * Gera os resolvers de campos para tipos que têm campos de imagem e/ou Document.
 * Retorna um objeto { <TypeName>: { campo: resolver } }.
 */
export function buildFieldResolvers(configs: ListConfig[]) {
  const resolvers: Record<string, Record<string, any>> = {};

  const docTypes = [
    'Servico_oQueE_Document',
    'Servico_quemPrecisa_Document',
    'Servico_comoSolicitar_Document',
    'Servico_maisInformacoes_Document',
    'Solucao_corpo_Document',
    'Noticia_corpo_Document',
    'Portfolio_corpo_Document',
  ];

  for (const dt of docTypes) {
    resolvers[dt] = {
      document: (parent: any) => parseDocument(parent?._raw ?? parent),
    };
  }

  for (const cfg of configs) {
    const fieldResolvers: Record<string, any> = {};

    // Campos de imagem
    for (const [graphqlField, prismaBase] of Object.entries(cfg.imageFields)) {
      fieldResolvers[graphqlField] = (parent: any) => formatImageField(parent, prismaBase);
    }

    // Campos Document -> retornam objeto { _raw: parent[docField] }
    for (const docField of cfg.documentFields) {
      fieldResolvers[docField] = (parent: any) => ({
        _raw: parent[docField],
      });
    }

    if (Object.keys(fieldResolvers).length > 0) {
      resolvers[cfg.type] = fieldResolvers;
    }
  }

  // Field resolvers de segurança para User
  resolvers['User'] = {
    ...(resolvers['User'] || {}),
    password: (parent: any) => ({ isSet: Boolean(parent.password) }),
    passwordResetToken: (parent: any) => ({ isSet: Boolean(parent.passwordResetToken) }),
    resetCode: (parent: any, args: any, ctx: any) => {
      if (ctx?.isAdmin || (ctx?.session?.data?.id && ctx.session.data.id === parent.id)) {
        return parent.resetCode || null;
      }
      return null;
    },
  };

  return resolvers;
}
