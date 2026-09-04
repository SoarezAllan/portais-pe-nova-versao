// ARQUIVO: schemas/faq.ts (PADRONIZADO)

import { list } from '@keystone-6/core';
import { text, checkbox } from '@keystone-6/core/fields';
import { document } from '@keystone-6/fields-document';
import { cleanDocumentFieldHook } from '../schemas_adm/cleanFragmentHelpers';

export const Faq = list({
   access: {
     operation: { 
       query: () => true,
       create: ({ session }) => !!session, 
       update: ({ session }) => !!session, 
       delete: ({ session }) => !!session 
     },
   },

   graphql: {
     plural: 'faqs',
   },

   ui: {
     label: 'FAQ (Perguntas Frequentes)',
     singular: 'Pergunta Frequente',
     plural: 'Perguntas Frequentes',
     listView: {
       initialColumns: ['pergunta', 'ativo'],
       initialSort: { field: 'pergunta', direction: 'ASC' },
     },
   },
 
   fields: {
    pergunta: text({
      label: 'Pergunta',
      validation: { isRequired: true }, 
      isIndexed: 'unique',
      ui: {
        displayMode: 'textarea', 
        description: 'A pergunta que será exibida no frontend.'
      },
    }),

    resposta: document({ 
      label: 'Resposta',
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
    ativo: checkbox({
      label: 'Ativo (Visível no Portal)',
      defaultValue: true,
      ui: { views: './admin/views/ocultarItem', description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR' },
    }),
  },
});
