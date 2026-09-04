import { list } from '@keystone-6/core';
import { text, timestamp, select } from '@keystone-6/core/fields';
export const Acesso = list({
  access: {
    operation: {
      query: ({ session }) => !!session,
      create: () => true,
      update: ({ session }) => !!session,
      delete: ({ session }) => !!session,
    },
  },
  graphql: {
    plural: 'acessos',
  },
  ui: {
    label: 'Acessos',
    labelField: 'usuario',
    listView: {
      initialColumns: ['dataAcesso', 'portal', 'tipo', 'area', 'usuario', 'ip'],
      initialSort: {
        field: 'dataAcesso',
        direction: 'DESC',
      },
    },
  },
  fields: {
    portal: text({
      label: 'Portal',
      validation: { isRequired: true },
    }),
    tipo: select({
      label: 'Tipo de Evento',
      options: [
        { label: 'Visualização de Portal', value: 'PORTAL_VIEW' },
        { label: 'Visualização de Serviço', value: 'SERVICO_VIEW' },
        { label: 'Visualização de Notícia', value: 'NOTICIA_VIEW' },
      ],
      defaultValue: 'PORTAL_VIEW',
      validation: { isRequired: true },
    }),
    area: text({
      label: 'Área',
    }),
    usuario: text({
      label: 'Usuário',
    }),
    ip: text({
      label: 'IP',
    }),
    dataAcesso: timestamp({
      label: 'Data/Hora do Acesso',
      defaultValue: { kind: 'now' },
    }),
  },
});