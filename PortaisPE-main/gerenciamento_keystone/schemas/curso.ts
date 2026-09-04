import { list } from '@keystone-6/core';

import {
  text,
  select,
  timestamp,
  relationship,
} from '@keystone-6/core/fields';

import { logAction } from '../schemas_adm/AuditLog';
import { resolveAreaAndAudit } from '../schemas_adm/areaAuditHelpers';
import { canDeleteOperation, canDeleteFilter } from '../schemas_adm/deletePermissionHelpers';

export const Curso = list({
  db: {
    map: 'Cursos',
  },

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
    label: 'Cursos',
    singular: 'Curso',
    plural: 'Cursos',
    labelField: 'titulo',
    listView: {
      initialColumns: [
        'titulo',
        'status',
        'modalidade',
        'dataDoCurso',
        'areaResponsavel',
        'subarea',
      ],
      initialSort: {
        field: 'dataDoCurso',
        direction: 'DESC',
      },
    },
  },

  graphql: {
    plural: 'cursos',
  },

  hooks: {
    resolveInput: async ({ operation, resolvedData, context }) => {
      return resolveAreaAndAudit({ operation, resolvedData, context });
    },
    afterOperation: async (args) => {
      await logAction({ ...args, listKey: 'Curso' });
    },
  },

  fields: {
    titulo: text({
      label: 'Título do Curso *',
      validation: { isRequired: true },
      ui: { description: 'Informe o nome completo do curso.' },
    }),

    status: select({
      label: 'Status do Curso *',
      options: [
        { label: 'Programado', value: 'PROGRAMADO' },
        { label: 'Realizado', value: 'REALIZADO' },
      ],
      defaultValue: 'PROGRAMADO',
      validation: { isRequired: true },
      ui: {
        displayMode: 'select',
        description: 'Informe se o curso ainda será realizado ou já ocorreu.',
      },
    }),

    resumo: text({
      label: 'Resumo para o Card *',
      ui: {
        displayMode: 'textarea',
        description: 'Máximo de 300 caracteres.',
      },
      validation: {
        isRequired: true,
        length: { max: 300 },
      },
    }),

    linkExterno: text({
      label: 'Link Externo',
      ui: {
        description: 'Opcional. Link para inscrição, material ou página externa.',
      },
    }),

    dataDoCurso: timestamp({
      label: 'Data do Curso *',
      validation: { isRequired: true },
      defaultValue: { kind: 'now' },
      ui: { description: 'Informe a data prevista ou realizada do curso.' },
    }),

    areaResponsavel: relationship({
      ref: 'AreaResponsavel.cursos',
      label: 'Área *',
      ui: {
        displayMode: 'select',
        description: 'Área responsável pelo curso.',
      },
    }),

    subarea: relationship({
      ref: 'Subarea.cursos',
      label: 'Subárea *',
      validation: { isRequired: true },
      ui: {
        displayMode: 'select',
        description: 'Selecione a subárea responsável pelo curso.',
      },
    }),

    modalidade: select({
      label: 'Modalidade *',
      options: [
        { label: 'Presencial', value: 'PRESENCIAL' },
        { label: 'EAD', value: 'EAD' },
      ],
      defaultValue: 'PRESENCIAL',
      validation: { isRequired: true },
      ui: {
        displayMode: 'segmented-control',
        description: 'Informe se o curso é presencial ou EAD.',
      },
    }),

    local: text({
      label: 'Local de Realização',
      ui: {
        displayMode: 'textarea',
        description: 'Informe o local onde o curso será realizado ou a plataforma online.',
      },
    }),

    createdAt: timestamp({
      label: 'Criado em',
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

    updatedAt: timestamp({
      label: 'Atualizado em',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),

    updatedBy: text({
      label: 'Atualizado por',
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),
  },
});
