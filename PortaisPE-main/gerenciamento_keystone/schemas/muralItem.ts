import { list } from '@keystone-6/core';
import { text, relationship, timestamp } from '@keystone-6/core/fields';
import { logAction } from '../schemas_adm/AuditLog';

export const MuralItem = list({
  db: { map: 'MuralItems' },

  access: {
    operation: {
      query: () => true,
      create: ({ session }) => !!session,
      update: ({ session }) => !!session,
      delete: ({ session }) => session?.data?.role === 'admin',
    },
  },

  ui: {
    label: 'Mural',
    singular: 'Item do Mural',
    plural: 'Itens do Mural',
    labelField: 'titulo',
    listView: {
      initialColumns: ['titulo', 'areaResponsavel'],
      initialSort: { field: 'titulo', direction: 'ASC' },
    },
  },

  hooks: {
    afterOperation: async (args) => {
      await logAction({ ...args, listKey: 'MuralItem' });
    },
  },

  fields: {
    titulo: text({
      label: 'Título',
      validation: { isRequired: true },
    }),

    descricao: text({
      label: 'Descrição',
      ui: { displayMode: 'textarea' },
    }),

    areaResponsavel: relationship({
      ref: 'AreaResponsavel.muralItems',
      label: 'Área Responsável',
      ui: { displayMode: 'select' },
    }),

    createdAt: timestamp({
      label: 'Criado em',
      defaultValue: { kind: 'now' },
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    updatedAt: timestamp({
      label: 'Atualizado em',
      db: { updatedAt: true },
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),
  },
});