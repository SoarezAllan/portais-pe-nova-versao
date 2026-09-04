import { list } from '@keystone-6/core';
import { text, relationship, timestamp } from '@keystone-6/core/fields';
import { logAction } from '../schemas_adm/AuditLog';

export const Subarea = list({
   db: { map: 'Subareas' },
 
   graphql: {
     plural: 'subareas',
   },

   access: {
     operation: {
       query: () => true,
       create: ({ session }) => !!session,
       update: ({ session }) => !!session,
       delete: ({ session }) => session?.data?.role === 'admin',
     },
   },
 
   ui: {
     label: 'Subáreas',
     singular: 'Subárea',
     plural: 'Subáreas',
     labelField: 'nome',
     listView: {
       initialColumns: ['nome', 'area'],
       initialSort: { field: 'nome', direction: 'ASC' },
     },
   },
 
   hooks: {
     afterOperation: async (args) => {
       await logAction({ ...args, listKey: 'Subarea' });
     },
   },
 
   fields: {
    nome: text({
      label: 'Nome da Subárea',
      validation: { isRequired: true },
    }),

    area: relationship({
      ref: 'AreaResponsavel.subareas',
      label: 'Área',
      ui: { displayMode: 'select' },
    }),

    servicos: relationship({
      ref: 'Servico.subarea',
      many: true,
      label: 'Serviços',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    cursos: relationship({
      ref: 'Curso.subarea',
      many: true,
      label: 'Cursos',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    noticias: relationship({
      ref: 'Noticia.subarea',
      many: true,
      label: 'Notícias',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    legislacoes: relationship({
      ref: 'Legislacao.subarea',
      many: true,
      label: 'Legislações',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    solucoes: relationship({
      ref: 'Solucao.subarea',
      many: true,
      label: 'Soluções',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    tags: relationship({
      ref: 'Tag.subarea',
      many: true,
      label: 'Tags',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
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