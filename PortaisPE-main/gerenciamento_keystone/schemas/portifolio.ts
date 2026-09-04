import { list } from '@keystone-6/core';
import {
  text,
  image,
  relationship,
  timestamp,
  checkbox,
} from '@keystone-6/core/fields';

import { document } from '@keystone-6/fields-document';

import { resolveAreaAndAudit } from '../schemas_adm/areaAuditHelpers';
import { cleanDocumentFieldHook } from '../schemas_adm/cleanFragmentHelpers';

function canAccessPortfolio(user: any) {
  if (!user) return false;

  const role =
    user.role ||
    user.tipo ||
    user.perfil;

  const area =
    user.areaResponsavelNome ||
    user.areaResponsavel?.nome ||
    user.area?.nome ||
    user.area;

  const isAdmin =
    role === 'admin' ||
    role === 'ADMIN';

  const isOperator =
    role === 'operator' ||
    role === 'OPERADOR';

  const isEngenharia =
    area === 'Engenharia e Arquitetura' ||
    area === 'ENGENHARIA E ARQUITETURA';

  return isAdmin || (isOperator && isEngenharia);
}

export const Portfolio = list({
  db: {
    map: 'Portfolios',
  },

  access: {
    operation: {
      query: ({ session }) => {
        if (!session) return true;

        return canAccessPortfolio(session.data);
      },

      create: ({ session }) =>
        canAccessPortfolio(session?.data),

      update: ({ session }) =>
        canAccessPortfolio(session?.data),

      delete: ({ session }) =>
        canAccessPortfolio(session?.data),
    },
  },

  ui: {
    label: 'Portfólio',

    singular: 'Portfólio',

    plural: 'Portfólios',

    labelField: 'titulo',

    listView: {
      initialColumns: [
        'titulo',
        'ativo',
        'areaResponsavel',
        'subarea',
      ],

      initialSort: {
        field: 'titulo',
        direction: 'ASC',
      },
    },

    isHidden: ({ session }) => {
      if (!session) return true;

      return !canAccessPortfolio(session.data);
    },
  },

  graphql: {
    plural: 'portfolios',
  },

  hooks: {
    afterOperation: async (args) => {
      const { logAction } = await import(
        '../schemas_adm/AuditLog'
      );

      await logAction({
        ...args,
        listKey: 'Portfolio',
      });
    },
  },

  fields: {

    titulo: text({
      label: 'Título',

      validation: {
        isRequired: true,
      },
    }),

    slug: text({
      label: 'Slug',

      isIndexed: 'unique',

      validation: {
        isRequired: true,
      },
    }),

    resumo: text({
      label: 'Resumo',

      validation: {
        isRequired: true,
        length: {
          max: 500,
        },
      },

      ui: {
        displayMode: 'textarea',
      },
    }),

    imagem: image({
      storage: 'my_local_images',

      label: 'Imagem de Capa',
    }),

    imagemAlt: text({
      label: 'Texto Alternativo',

      validation: {
        isRequired: true,
      },
    }),

    galeria: relationship({
      ref: 'PortfolioImagem.portfolio',

      many: true,

      label: 'Galeria de Imagens',
    }),

    corpo: document({
      label: 'Corpo de Texto',

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
      ref: 'AreaResponsavel',

      label: 'Área',

      ui: {
        displayMode: 'select',
      },
    }),

    subarea: relationship({
      ref: 'Subarea',

      label: 'Subárea',

      ui: {
        displayMode: 'select',
      },
    }),

    ativo: checkbox({
      label: 'Ativo (Visível no Portal)',
      defaultValue: true,
      ui: { views: './admin/views/ocultarItem', description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR' },
    }),

    createdAt: timestamp({
      label: 'Criado em',

      defaultValue: {
        kind: 'now',
      },

      ui: {
        createView: {
          fieldMode: 'hidden',
        },

        itemView: {
          fieldMode: 'read',
        },
      },
    }),

    createdBy: text({
      label: 'Criado por',

      ui: {
        createView: {
          fieldMode: 'hidden',
        },

        itemView: {
          fieldMode: 'read',
        },
      },
    }),

    updatedAt: timestamp({
      label: 'Atualizado em',

      ui: {
        createView: {
          fieldMode: 'hidden',
        },

        itemView: {
          fieldMode: 'read',
        },
      },
    }),

    updatedBy: text({
      label: 'Atualizado por',

      ui: {
        createView: {
          fieldMode: 'hidden',
        },

        itemView: {
          fieldMode: 'read',
        },
      },
    }),
  },
});
