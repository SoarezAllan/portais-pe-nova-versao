import { list } from '@keystone-6/core';
import { text, relationship, timestamp } from '@keystone-6/core/fields';
import { logAction } from '../schemas_adm/AuditLog';

export const Gerencia = list({
 
   db: {
     map: 'Gerencias',
   },

   graphql: {
     plural: 'gerencias',
   },

   access: {
 
     operation: {
 
       query: ({ session }) => session?.role === 'admin',
 
       create: ({ session }) => session?.role === 'admin',
 
       update: ({ session }) => session?.role === 'admin',
 
       delete: ({ session }) =>
         session?.role === 'admin',
 
     },
 
   },
 
   ui: {
 
     label: 'Gerências',
 
     singular: 'Gerência',
 
     plural: 'Gerências',
 
     labelField: 'nome',
 
     listView: {
 
       initialColumns: [
 
         'nome',
 
         'area',
 
       ],
 
       initialSort: {
 
         field: 'nome',
 
         direction: 'ASC',
 
       },
 
     },
 
   },
 
   hooks: {

    afterOperation: async (args) => {

      await logAction({

        ...args,

        listKey: 'Gerencia',

      });

    },

  },

  fields: {

    nome: text({

      label: 'Nome da Gerência',

      validation: {

        isRequired: true,

      },

    }),

    responsavel: text({

      label: 'Nome do Responsável',

    }),

    telefone1: text({

      label: 'Contato 1',

    }),

    telefone2: text({

      label: 'Contato 2',

    }),

    email: text({

      label: 'E-mail',

      hooks: {

        validateInput: ({

          resolvedData,

          addValidationError,

        }) => {

          const email = resolvedData.email;

          if (

            email &&

            !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)

          ) {

            addValidationError(

              'Informe um e-mail válido'

            );

          }

        },

      },

    }),

    area: relationship({

      ref: 'AreaResponsavel.gerencias',

      label: 'Área',

      ui: {

        displayMode: 'select',

      },

    }),

    setores: relationship({

      ref: 'Setor.gerencia',

      many: true,

      label: 'Setores',

      ui: {

        itemView: {

          fieldMode: 'read',

        },

        createView: {

          fieldMode: 'hidden',

        },

      },

    }),

    createdAt: timestamp({

      label: 'Criado em',

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