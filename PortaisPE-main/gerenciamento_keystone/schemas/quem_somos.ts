import { list } from '@keystone-6/core';
import {
  text,
  timestamp,
  relationship,
  image,
  checkbox,
} from '@keystone-6/core/fields';

import { logAction } from '../schemas_adm/AuditLog';

export const QuemSomosMuralItem = list({
   graphql: {
     plural: 'quemSomosMuralItens',
   },
   access: {
     operation: {
       query: () => true,
       create: ({ session }: any) => !!session,
       update: ({ session }: any) => !!session,
       delete: ({ session }: any) => !!session,
     },
   },
   ui: {
     label: 'Mural - Quem Somos',
     labelField: 'titulo',
     listView: { initialColumns: ['titulo', 'valor', 'ativo'] },
   },
   fields: {
    valor: text({ label: 'Valor' }),
    titulo: text({ label: 'Título', validation: { isRequired: true } }),
    descricao: text({ label: 'Descrição', ui: { displayMode: 'textarea' } }),
    pagina: relationship({
      ref: 'PaginaQuemSomos.muralItens',
      many: false,
      ui: { hideCreate: true },
    }),
    ativo: checkbox({
      label: 'Status de Visibilidade',
      defaultValue: true,
      ui: {
        views: './admin/views/ocultarItem',
        description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR',
      },
    }),
    createdAt: timestamp({ defaultValue: { kind: 'now' } }),
  },
});

export const QuemSomosTimeItem = list({
   graphql: {
     plural: 'quemSomosTimeItens',
   },
   access: {
    operation: {
      query: () => true,
      create: ({ session }: any) => !!session,
      update: ({ session }: any) => !!session,
      delete: ({ session }: any) => !!session,
    },
  },
  ui: {
    label: 'Time - Quem Somos',
    labelField: 'nome',
    listView: { initialColumns: ['nome', 'cargo', 'ativo'] },
  },
  fields: {
    nome: text({ validation: { isRequired: true } }),
    cargo: text({ validation: { isRequired: true } }),
    descricao: text({ ui: { displayMode: 'textarea' } }),
    foto: image({
      label: 'Foto',
      storage: 'my_local_images',
    }),
    pagina: relationship({
      ref: 'PaginaQuemSomos.time',
      many: false,
      ui: { hideCreate: true },
    }),
    ativo: checkbox({
      label: 'Status de Visibilidade',
      defaultValue: true,
      ui: {
        views: './admin/views/ocultarItem',
        description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR',
      },
    }),
    createdAt: timestamp({ defaultValue: { kind: 'now' } }),
  },
});

export const QuemSomosSubareaItem = list({
   graphql: {
     plural: 'quemSomosSubareaItens',
   },
   access: {
    operation: {
      query: () => true,
      create: ({ session }: any) => !!session,
      update: ({ session }: any) => !!session,
      delete: ({ session }: any) => !!session,
    },
  },
  ui: {
    label: 'Conteúdo por Subárea - Quem Somos',
    labelField: 'conteudo',
    listView: { initialColumns: ['subarea', 'conteudo', 'ativo'] },
  },
  fields: {
    subarea: relationship({
      ref: 'Subarea',
      label: 'Subárea',
      ui: { displayMode: 'select', hideCreate: true },
      validation: { isRequired: true },
    }),
    conteudo: text({
      label: 'Conteúdo',
      ui: { displayMode: 'textarea' },
    }),
    pagina: relationship({
      ref: 'PaginaQuemSomos.conteudosPorSubarea',
      many: false,
      ui: { hideCreate: true },
    }),
    ativo: checkbox({
      label: 'Status de Visibilidade',
      defaultValue: true,
      ui: {
        views: './admin/views/ocultarItem',
        description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR',
      },
    }),
    createdAt: timestamp({ defaultValue: { kind: 'now' } }),
  },
});

export const PaginaQuemSomos = list({
  graphql: { plural: 'paginasQuemSomos' },
  access: {
    operation: {
      query: () => true,
      create: ({ session }: any) => !!session,
      update: ({ session }: any) => !!session,
      delete: ({ session }: any) => !!session,
    },
  },
  ui: {
    label: 'Página Quem Somos',
    labelField: 'tituloDaPagina',
    listView: { initialColumns: ['tituloDaPagina', 'areaResponsavel'] },
  },
  hooks: {
    afterOperation: async (args) => {
      await logAction({ ...args, listKey: 'PaginaQuemSomos' });
    },
  },
  fields: {
    tituloDaPagina: text({
      label: 'Título da Página',
      defaultValue: 'Quem Somos',
      validation: { isRequired: true },
    }),
    muralTextoIntrodutorio: text({
      label: 'Mural: Texto Introdutório',
      ui: { displayMode: 'textarea' },
    }),
    timeTitulo: text({
      label: 'Título da Seção do Time',
      defaultValue: 'Nosso Time',
    }),
    muralItens: relationship({
      ref: 'QuemSomosMuralItem.pagina',
      many: true,
      label: 'Itens do Mural',
      ui: {
        displayMode: 'cards',
        cardFields: ['valor', 'titulo', 'descricao'],
        inlineCreate: { fields: ['valor', 'titulo', 'descricao'] },
        inlineEdit: { fields: ['valor', 'titulo', 'descricao'] },
        inlineConnect: true,
      },
    }),
    conteudosPorSubarea: relationship({
      ref: 'QuemSomosSubareaItem.pagina',
      many: true,
      label: 'Conteúdo por Subárea',
      ui: {
        displayMode: 'cards',
        cardFields: ['subarea', 'conteudo'],
        inlineCreate: { fields: ['subarea', 'conteudo'] },
        inlineEdit: { fields: ['subarea', 'conteudo'] },
        inlineConnect: false,
      },
    }),
    time: relationship({
      ref: 'QuemSomosTimeItem.pagina',
      many: true,
      label: 'Time',
      ui: {
        displayMode: 'cards',
        cardFields: ['nome', 'cargo'],
        inlineCreate: { fields: ['nome', 'cargo', 'descricao', 'foto'] },
        inlineEdit: { fields: ['nome', 'cargo', 'descricao', 'foto'] },
        inlineConnect: false,
      },
    }),
    areaResponsavel: relationship({
      ref: 'AreaResponsavel.paginasQuemSomos',
      many: false,
      label: 'Área Responsável',
      ui: { displayMode: 'select' },
      validation: { isRequired: true },
    }),
    subarea: relationship({
      ref: 'Subarea',
      label: 'Subárea',
      ui: { displayMode: 'select' },
    }),
    createdAt: timestamp({
      defaultValue: { kind: 'now' },
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),
    createdBy: text({
      label: 'Criado por',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),
  },
});
