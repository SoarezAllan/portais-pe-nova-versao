import { list } from '@keystone-6/core';
import { text, relationship, timestamp } from '@keystone-6/core/fields';

export const AreaResponsavel = list({
   db: { map: 'AreasResponsaveis' },
 
   graphql: {
     plural: 'areas',
   },

   access: {
     operation: {
       query: () => true,
       create: ({ session }) => session?.data?.role === 'admin',
       update: ({ session }) => session?.data?.role === 'admin',
       delete: ({ session }) => session?.data?.role === 'admin',
     },
   },
 
   ui: {
     label: 'Areas',
     singular: 'Area',
     plural: 'Areas',
     labelField: 'nome',
   },
 
   hooks: {
    afterOperation: async ({ operation, item, originalItem, context }) => {
      if (!context.session) return;

      const usuario = context.session?.data;

      let mudancasFormatadas = '';
      if (operation === 'update' && originalItem) {
        const alteracoes: string[] = [];
        Object.keys(item).forEach((campo) => {
          if (item[campo] !== originalItem?.[campo]) {
            alteracoes.push(
              `${campo}: De: ${originalItem?.[campo] ?? '-'} Para: ${item[campo] ?? '-'}`
            );
          }
        });
        mudancasFormatadas = alteracoes.join('\n') || 'Nenhuma alteracao detectada.';
      } else if (operation === 'create') {
        mudancasFormatadas = `Area criada: ${item.nome}`;
      } else if (operation === 'delete') {
        mudancasFormatadas = `Area excluida: ${originalItem.nome}`;
      }

      await context.sudo().db.AuditLog.createOne({
        data: {
          usuario: usuario?.email || usuario?.name || 'Usuario Desconhecido',
          operacao: operation.toUpperCase(),
          tabela: 'AreaResponsavel',
          itemId: (item?.id || originalItem?.id)?.toString() || 'Desconhecido',
          itemTitulo: item?.nome || originalItem?.nome || 'Sem titulo',
          mudancas: mudancasFormatadas,
        },
      });
    },
  },

  fields: {
    nome: text({
      label: 'Nome da Area',
      validation: { isRequired: true },
    }),

    subareas: relationship({
      ref: 'Subarea.area',
      many: true,
      label: 'Subareas',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    gerencias: relationship({
      ref: 'Gerencia.area',
      many: true,
      label: 'Gerencias',
      ui: {
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' },
      },
    }),

    servicos: relationship({
      ref: 'Servico.areaResponsavel',
      many: true,
      ui: {
        itemView: { fieldMode: 'hidden' },
        createView: { fieldMode: 'hidden' },
        listView: { fieldMode: 'hidden' },
      },
    }),

    cursos: relationship({ ref: 'Curso.areaResponsavel', many: true }),
    solucoes: relationship({ ref: 'Solucao.areaResponsavel', many: true }),
    noticias: relationship({ ref: 'Noticia.areaResponsavel', many: true }),
    tags: relationship({ ref: 'Tag.areaResponsavel', many: true }),
    legislacoes: relationship({ ref: 'Legislacao.areaResponsavel', many: true }),

    gestores: relationship({
      ref: 'Gestores.areaResponsavel',
      many: true,
    }),

    // ← back-reference para as páginas Quem Somos de cada portal
    paginasQuemSomos: relationship({
      ref: 'PaginaQuemSomos.areaResponsavel',
      many: true,
      label: 'Páginas Quem Somos',
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
    deletedAt: timestamp({
      label: 'Excluido em',
      ui: { createView: { fieldMode: 'hidden' }, itemView: { fieldMode: 'read' } },
    }),
    deletedBy: text({
      label: 'Excluido por',
      ui: { createView: { fieldMode: 'hidden' }, itemView: { fieldMode: 'read' } },
    }),
  },
});