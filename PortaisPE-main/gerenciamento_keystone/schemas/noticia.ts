import { list } from '@keystone-6/core';
import {
  text,
  image,
  timestamp,
  relationship,
  checkbox,
} from '@keystone-6/core/fields';

import { document } from '@keystone-6/fields-document';
import { logAction } from '../schemas_adm/AuditLog';
import { cleanDocumentFieldHook } from '../schemas_adm/cleanFragmentHelpers';
import { canDeleteOperation, canDeleteFilter } from '../schemas_adm/deletePermissionHelpers';

export const Noticia = list({
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

   graphql: {
     plural: 'noticias',
   },

   ui: {
label: 'Notícias',
     labelField: 'titulo',
     listView: {
       initialColumns: [
         'titulo',
         'ativo',
         'dataPublicacao',
         'autor',
         'destaque',
         'areaResponsavel',
         'subarea',
       ],
       initialSort: {
         field: 'dataPublicacao',
         direction: 'DESC',
       },
     },
   },
 
   hooks: {
    resolveInput: async ({
      operation,
      resolvedData,
      context,
    }) => {
      let data = { ...resolvedData };

      if (operation === 'create' && !data.autor) {
        data.autor = {
          connect: {
            id: context.session?.itemId,
          },
        };
      }

      return data;
    },

    afterOperation: async (args) => {
      await logAction({ ...args, listKey: 'Noticia' });
    },
  },

  fields: {
    titulo: text({
      label: 'Título da Matéria *',
      validation: { isRequired: true },
    }),

    subtitulo: text({
      label: 'Subtítulo *',
    }),

    autor: relationship({
      ref: 'User.noticias',
      label: 'Autor (Automático)',
      many: false,
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),

    areaResponsavel: relationship({
      ref: 'AreaResponsavel.noticias',
      label: 'Área *',
      ui: { displayMode: 'select' },
    }),

    subarea: relationship({
      ref: 'Subarea.noticias',
      label: 'Subárea *',
      ui: { displayMode: 'select' },
    }),

    ativo: checkbox({
      label: 'Ativo (Visível no Portal)',
      defaultValue: true,
      ui: { views: './admin/views/ocultarItem', description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR' },
    }),

    createdAt: timestamp({
      label: 'Criado em',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),

    createdBy: text({
      label: 'Criado por',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),

    dataPublicacao: timestamp({
      label: 'Data de Publicação *',
      defaultValue: { kind: 'now' },
      validation: { isRequired: true },
    }),

    imagemPrincipal: image({
      label: 'Imagem Principal *',
      storage: 'my_local_images',
      ui: { description: 'Imagem de capa da notícia.' },
    }),

    imagemPrincipalAlt: text({
      label: 'Texto Alternativo da Imagem (Alt)',
      validation: { isRequired: true },
    }),

    corpo: document({
      label: 'Corpo da Matéria *',
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
      dividers: true,
      layouts: [[1, 1], [1, 1, 1]],
      hooks: {
        resolveInput: cleanDocumentFieldHook,
      },
    }),

    tags: relationship({
      ref: 'Tag.noticias',
      many: true,
      label: 'Tags (Tópicos)',
      ui: { displayMode: 'select' },
    }),

    destaque: checkbox({
      label: 'Destaque no Carrossel da Home?',
      defaultValue: false,
      ui: { description: 'Marque para que a notícia apareça no carrossel da página inicial.' },
    }),

    resumo: text({
      label: 'Resumo (Para o Carrossel)',
      ui: { displayMode: 'textarea' },
      validation: { isRequired: true, length: { max: 250 } },
    }),

    slug: text({
      label: 'Endereço da Notícia (URL) *',
      isIndexed: 'unique',
      validation: { isRequired: true },
    }),
  },
});
