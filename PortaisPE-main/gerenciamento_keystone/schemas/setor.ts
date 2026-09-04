import { list } from '@keystone-6/core';
import { text, relationship, timestamp } from '@keystone-6/core/fields';
import { logAction } from '../schemas_adm/AuditLog';

export const Setor = list({
   db: { map: 'Setores' },
   
   graphql: {
     plural: 'setores',
   },

   access: {
     operation: {
       query: ({ session }) => session?.role === 'admin',
       create: ({ session }) => session?.role === 'admin',
       update: ({ session }) => session?.role === 'admin',
       delete: ({ session }) => session?.role === 'admin',
     },
   },
   ui: {
     label: 'Setores',
     singular: 'Setor',
     plural: 'Setores',
     labelField: 'nome',
     listView: {
       initialColumns: ['nome', 'gerencia'],
       initialSort: { field: 'nome', direction: 'ASC' },
     },
   },
   hooks: {
     afterOperation: async (args) => {
       await logAction({ ...args, listKey: 'Setor' });
     },
   },
   fields: {
    nome: text({
      label: 'Nome do Setor',
      validation: { isRequired: true },
    }),
    gerencia: relationship({
      ref: 'Gerencia.setores',
      label: 'Gerência',
      ui: { displayMode: 'select' },
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