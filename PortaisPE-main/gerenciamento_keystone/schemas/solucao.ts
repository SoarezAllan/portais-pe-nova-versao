import { list } from '@keystone-6/core';
import { text, image, select, relationship, timestamp, checkbox } from '@keystone-6/core/fields';
import { document } from '@keystone-6/fields-document';
import { resolveAreaAndAudit } from '../schemas_adm/areaAuditHelpers';
import { cleanDocumentFieldHook } from '../schemas_adm/cleanFragmentHelpers';
import { canDeleteOperation, canDeleteFilter } from '../schemas_adm/deletePermissionHelpers';

export const Solucao = list({
  db: { map: 'Solucoes' },

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
    label: 'Projetos e inovação',
    singular: 'Solução',
    plural: 'Soluções',
    labelField: 'titulo',
    listView: {
      initialColumns: ['titulo', 'ativo', 'categoria', 'areaResponsavel', 'subarea'],
      initialSort: { field: 'titulo', direction: 'ASC' },
    },
  },

  graphql: {
    plural: 'solucoes',
  },

  hooks: {
    afterOperation: async (args) => {
      const { logAction } = await import('../schemas_adm/AuditLog');
      await logAction({ ...args, listKey: 'Solucao' });
    },
  },

  fields: {
    titulo: text({
      validation: { isRequired: true },
      label: 'Título da Solução *',
    }),

    slug: text({
      isIndexed: 'unique',
      label: 'URL da Solução *',
      validation: { isRequired: true },
      ui: { description: 'Ex: Link para página de detalhamento, ex: /geope' },
    }),

    categoria: select({
      label: 'Área da Solução *',
      options: [
        { label: 'Georeferênciamento', value: 'geo' },
        { label: 'Business Intelligence', value: 'bi' },
        { label: 'Aplicações', value: 'aplicacoes' },
        { label: 'Projetos', value: 'projetos' },
        { label: 'Outros', value: 'outros' },
      ],
      validation: { isRequired: true },
      ui: { displayMode: 'select' },
    }),

    imagem: image({
      storage: 'my_local_images',
      label: 'Imagem do Card *',
    }),

    imagemAlt: text({
      label: 'Texto Alternativo da Imagem (SEO)',
      validation: { isRequired: true },
      ui: { description: 'Descrição da imagem.' },
    }),

    resumo: text({
      label: 'Resumo (Para o Card da Home) *',
      ui: { displayMode: 'textarea' },
      validation: { isRequired: true, length: { max: 300 } },
    }),

    corpo: document({
      label: 'Conteúdo Detalhado da Solução *',
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

    linkExterno: text({
      label: 'Link Externo',
      ui: { description: 'URL da solução.' },
    }),

    areaResponsavel: relationship({
      ref: 'AreaResponsavel.solucoes',
      label: 'Área *',
      ui: { displayMode: 'select' },
    }),

    subarea: relationship({
      ref: 'Subarea.solucoes',
      label: 'Subárea',
      ui: { displayMode: 'select' },
    }),

    ativo: checkbox({
      label: 'Ativo (Visível no Portal)',
      defaultValue: true,
      ui: { views: './admin/views/ocultarItem', description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR' },
    }),

    createdAt: timestamp({
      label: 'Criado em',
      ui: { createView: { fieldMode: 'hidden' }, itemView: { fieldMode: 'read' } },
    }),
    createdBy: text({
      label: 'Criado por',
      ui: { createView: { fieldMode: 'hidden' }, itemView: { fieldMode: 'read' } },
    }),
    updatedAt: timestamp({
      label: 'Atualizado em',
      ui: { createView: { fieldMode: 'hidden' }, itemView: { fieldMode: 'read' } },
    }),
    updatedBy: text({
      label: 'Atualizado por',
      ui: { createView: { fieldMode: 'hidden' }, itemView: { fieldMode: 'read' } },
    }),
  },
});
