import { list } from '@keystone-6/core';
import {
  text,
  relationship,
  image,
  select,
} from '@keystone-6/core/fields';

export const Gestores = list({
  access: {
    operation: {
      query: () => true,
      create: ({ session }) => !!session,
      update: ({ session }) => !!session,
      delete: ({ session }) => !!session,
    },
  },

  graphql: {
    plural: 'gestores',
  },

  ui: {
label: 'Equipe',
    singular: 'Gestor',
    plural: 'Gestores',
    labelField: 'nome',

    listView: {
      initialColumns: [
        'foto',
        'nome',
        'cargo',
        'areaResponsavel',
        'subarea',
      ],
      initialSort: {
        field: 'nome',
        direction: 'ASC',
      },
    },
  },

  fields: {
    nome: text({
      label: 'Nome',
      validation: { isRequired: true },
    }),

    cargo: text({
      label: 'Cargo',
      validation: { isRequired: true },
    }),

    descricao: text({
      label: 'Descrição',
      ui: {
        displayMode: 'textarea',
      },
    }),

    foto: image({
      storage: 'my_local_images',
      label: 'Foto do Gestor',
    }),

    areaResponsavel: relationship({
      ref: 'AreaResponsavel.gestores',
      label: 'Área Responsável *',
      ui: {
        displayMode: 'select',
      },
    }),

    // 🚨 IMPORTANTE:
    // NÃO EXISTE MAIS RELAÇÃO COM PaginaQuemSomos
    // isso evita o erro "two way relationship expects..."
  },
});