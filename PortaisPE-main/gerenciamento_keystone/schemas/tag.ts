import { list } from '@keystone-6/core';
import { text, relationship } from '@keystone-6/core/fields';
import { resolveAreaAndAudit } from '../schemas_adm/areaAuditHelpers';
import { canDeleteOperation, canDeleteFilter } from '../schemas_adm/deletePermissionHelpers';

export const Tag = list({
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
    isHidden: ({ session }) => !session,
    labelField: 'nome',
  },

  fields: {
    nome: text({
      validation: { isRequired: true },
      label: 'Nome da Tag',
      isIndexed: 'unique',
    }),

    // Vínculo com a grande Área (controle de acesso)
    areaResponsavel: relationship({
      ref: 'AreaResponsavel.tags',
      label: 'Área',
      ui: { displayMode: 'select' },
    }),

    // Vínculo com a Subárea (detalhamento)
    subarea: relationship({
      ref: 'Subarea.tags',
      label: 'Subárea',
      ui: { displayMode: 'select' },
    }),

    noticias: relationship({
      ref: 'Noticia.tags',
      many: true,
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),
  },

  hooks: {
    resolveInput: async ({ operation, resolvedData, context }) => {
      return resolveAreaAndAudit({ operation, resolvedData, context });
    },
  },
});
