import { list } from '@keystone-6/core';
import {
  text,
  image,
  relationship,
  timestamp,
  checkbox,
} from '@keystone-6/core/fields';
import { document } from '@keystone-6/fields-document';
import { logAction } from '../schemas_adm/AuditLog';
import { resolveAreaAndAudit } from '../schemas_adm/areaAuditHelpers';
import { cleanDocument } from '../utils/cleanDocument';
import { cleanDocumentFieldHook } from '../schemas_adm/cleanFragmentHelpers';
import { canDeleteOperation, canDeleteFilter } from '../schemas_adm/deletePermissionHelpers';

export const Servico = list({
  db: { map: 'Servicos' },

  access: {
    operation: {
      query: () => true,
      create: ({ session }) => !!session,
      update: ({ session }) => !!session,
      delete: canDeleteOperation,
    },
    filter: {
      delete: canDeleteFilter,
    },
  },

  ui: {
    label: 'Serviços',
    singular: 'Serviço',
    plural: 'Serviços',
    labelField: 'titulo',
    listView: {
      initialColumns: [
        'titulo',
        'ativo',
        'updatedAt',
        'updatedBy',
        'createdAt',
      ],
      initialSort: { field: 'titulo', direction: 'ASC' },
    },
  },

  graphql: {
    plural: 'servicos',
  },

  hooks: {
    resolveInput: async ({ operation, resolvedData, context }) => {
      return resolveAreaAndAudit({ operation, resolvedData, context });
    },
    afterOperation: async (args) => {
      await logAction({ ...args, listKey: 'Servico' });
    },
  },

  fields: {
    titulo: text({
      label: 'Título do Serviço *',
      validation: { isRequired: true },
    }),

    slug: text({
      label: 'URL do serviço *',
      isIndexed: 'unique',
      validation: { isRequired: true },
    }),

    imagem: image({
      storage: 'my_local_images',
    }),

    imagemAlt: text({
      label: 'Texto alternativo da imagem',
      validation: { isRequired: false },
      ui: {
        itemView: { fieldMode: 'edit' },
        createView: { fieldMode: 'edit' },
      },
    }),

    resumo: text({
      label: 'Resumo *',
      ui: { displayMode: 'textarea' },
      validation: { isRequired: true, length: { max: 300 } },
    }),

    oQueE: document({
      label: 'O que é este serviço? *',
      formatting: {
        inlineMarks: {
          bold: true,
          italic: true,
          underline: true,
          strikethrough: true,
          code: true,
        },
        listTypes: { ordered: true, unordered: true },
        alignment: { center: true, end: true },
        headingLevels: [2, 3, 4],
        blockTypes: { blockquote: true, code: true },
        softBreaks: true,
      },
      links: true,
      hooks: {
        resolveInput: cleanDocumentFieldHook,
      },
    }),

    quemPrecisa: document({
      label: 'Quem precisa / Quando é necessário? *',
      formatting: {
        inlineMarks: {
          bold: true,
          italic: true,
          underline: true,
          strikethrough: true,
          code: true,
        },
        listTypes: { ordered: true, unordered: true },
        alignment: { center: true, end: true },
        headingLevels: [2, 3, 4],
        blockTypes: { blockquote: true, code: true },
        softBreaks: true,
      },
      links: true,
      hooks: {
        resolveInput: cleanDocumentFieldHook,
      },
    }),

    comoSolicitar: document({
      label: 'Como solicitar? *',
      formatting: {
        inlineMarks: {
          bold: true,
          italic: true,
          underline: true,
          strikethrough: true,
          code: true,
        },
        listTypes: { ordered: true, unordered: true },
        alignment: { center: true, end: true },
        headingLevels: [2, 3, 4],
        blockTypes: { blockquote: true, code: true },
        softBreaks: true,
      },
      links: true,
      hooks: {
        resolveInput: cleanDocumentFieldHook,
      },
    }),

    maisInformacoes: document({
      label: 'Mais Informações *',
      formatting: {
        inlineMarks: {
          bold: true,
          italic: true,
          underline: true,
          strikethrough: true,
          code: true,
        },
        listTypes: { ordered: true, unordered: true },
        alignment: { center: true, end: true },
        headingLevels: [2, 3, 4],
        blockTypes: { blockquote: true, code: true },
        softBreaks: true,
      },
      links: true,
      hooks: {
        resolveInput: cleanDocumentFieldHook,
      },
    }),

    areaResponsavel: relationship({
      ref: 'AreaResponsavel.servicos',
      label: 'Área Responsável *',
      ui: { displayMode: 'select' },
    }),

    subarea: relationship({
      ref: 'Subarea.servicos',
      label: 'Área do Serviço *',
      ui: { displayMode: 'select' },
      validation: { isRequired: true },
    }),

    ativo: checkbox({
      label: 'Ativo (Visível no Portal)',
      defaultValue: true,
      ui: {
        views: './admin/views/ocultarItem',
        description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR',
      },
    }),

    createdAt: timestamp({
      label: 'Criado em',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: {
          fieldMode: ({ session }) => session?.data?.role === 'admin' ? 'read' : 'hidden',
        },
      },
    }),

    createdBy: text({
      label: 'Criado por',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: {
          fieldMode: ({ session }) => session?.data?.role === 'admin' ? 'read' : 'hidden',
        },
      },
    }),

    updatedAt: timestamp({
      label: 'Atualizado em',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: {
          fieldMode: ({ session }) => session?.data?.role === 'admin' ? 'read' : 'hidden',
        },
      },
    }),

    updatedBy: text({
      label: 'Atualizado por',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: {
          fieldMode: ({ session }) => session?.data?.role === 'admin' ? 'read' : 'hidden',
        },
      },
    }),

    deletedAt: timestamp({
      label: 'Excluído em',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: {
          fieldMode: ({ session }) => session?.data?.role === 'admin' ? 'read' : 'hidden',
        },
      },
    }),

    deletedBy: text({
      label: 'Excluído por',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: {
          fieldMode: ({ session }) => session?.data?.role === 'admin' ? 'read' : 'hidden',
        },
      },
    }),
  },
});
