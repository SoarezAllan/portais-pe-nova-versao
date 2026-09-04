import { list } from '@keystone-6/core';
import { text, select } from '@keystone-6/core/fields';
import { relationship, timestamp } from '@keystone-6/core/fields';
import { logAction } from '../schemas_adm/AuditLog';
import { resolveAreaAndAudit } from '../schemas_adm/areaAuditHelpers'; // Importar a função auxiliar
import { canDeleteOperation, canDeleteFilter } from '../schemas_adm/deletePermissionHelpers';

export const Legislacao = list({
  db: { map: 'Legislacoes' },

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
    label: 'Legislação',
    singular: 'Legislação',
    plural: 'Legislações',
    labelField: 'titulo',
    listView: {
      initialColumns: ['titulo', 'categoria', 'areaResponsavel', 'subarea', 'updatedAt'],
      initialSort: { field: 'titulo', direction: 'ASC' },
    },
  },

  graphql: {
    plural: 'legislacoes',
  },

  hooks: {
    resolveInput: async ({ operation, resolvedData, context }) => {
      // Reativar e garantir que resolveAreaAndAudit esteja sendo usado
      return resolveAreaAndAudit({ operation, resolvedData, context });
    },
    afterOperation: async (args) => {
      await logAction({ ...args, listKey: 'Legislacao' });
    },
  },

  fields: {
    titulo: text({
      validation: { isRequired: true },
      label: 'Título da Legislação *',
    }),

    linkExterno: text({
      validation: { isRequired: true },
      label: 'Link Externo (URL) *',
      ui: { description: 'URL completa para o texto da legislação.' },
    }),

    // O campo 'area' estático foi removido para usar o relacionamento 'subarea' como autoritativo,
    // seguindo a lógica do schema de Serviços.

    categoria: select({
      label: 'Categoria da Legislação *',
      options: [
        { label: 'Federal', value: 'federal' },
        { label: 'Estadual', value: 'estadual' },
        { label: 'Municipal', value: 'municipal' },
        { label: 'Normativa Interna', value: 'normativa_interna' },
      ],
      validation: { isRequired: true },
      ui: { displayMode: 'select' },
    }),

    // Vínculo com a grande Área (controle de acesso)
    areaResponsavel: relationship({
      ref: 'AreaResponsavel.legislacoes',
      label: 'Área Responsável *',
      ui: { displayMode: 'select' },
    }),

    // Vínculo com a Subárea (detalhamento) - agora é o campo principal para a área da legislação
    subarea: relationship({
      ref: 'Subarea.legislacoes',
      label: 'Área da Legislação *',
      ui: { displayMode: 'select' },
      validation: { isRequired: true }, // Tornar obrigatório, similar ao serviço
    }),

    resumo: text({
      label: 'Resumo / Ementa *',
      ui: { displayMode: 'textarea' },
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
