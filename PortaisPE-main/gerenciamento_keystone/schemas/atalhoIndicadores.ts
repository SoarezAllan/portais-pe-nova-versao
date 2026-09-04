import { list } from '@keystone-6/core';
import { text } from '@keystone-6/core/fields';

export const AtalhoIndicadores = list({
  db: { map: 'AtalhoIndicadores' },

  access: {
    operation: {
      query: ({ session }) => session?.data?.role === 'admin',
      create: () => false,
      update: () => false,
      delete: () => false,
    },
  },

  ui: {
    label: 'Atalhos',
    singular: 'Atalho',
    plural: 'Atalhos',
    labelField: 'nome',
    isHidden: ({ session }) => session?.data?.role !== 'admin',
    listView: {
      initialColumns: ['nome'],
    },
  },

  graphql: {
    plural: 'atalhos',
  },

  fields: {
    nome: text({
      label: 'Nome',
      ui: {
        views: './admin/views/atalhoIndicadoresView',
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),
  },
});