import { list } from '@keystone-6/core';
import {
  text,
  image,
  relationship,
  checkbox,
} from '@keystone-6/core/fields';

export const PortfolioImagem = list({
   db: {
     map: 'PortfolioImagens',
   },

   graphql: {
     plural: 'portfolioImagens',
   },

   ui: {
     label: 'Imagem do Portfólio',
     singular: 'Imagem do Portfólio',
     plural: 'Imagens do Portfólio',
     labelField: 'titulo',
     listView: { initialColumns: ['titulo', 'ativo'] },
   },
 
   access: {
     operation: {
       query: () => true,
       create: ({ session }) => !!session,
       update: ({ session }) => !!session,
       delete: ({ session }) => !!session,
     },
   },
 
   fields: {
    titulo: text({
      label: 'Descrição',
    }),

    imagem: image({
      storage: 'my_local_images',
      label: 'Imagem',
    }),

    portfolio: relationship({
      ref: 'Portfolio.galeria',
      label: 'Portfólio',
    }),

    ativo: checkbox({
      label: 'Status de Visibilidade',
      defaultValue: true,
      ui: {
        views: './admin/views/ocultarItem',
        description: 'Marque para VISÍVEL no portal, desmarque para OCULTAR',
      },
    }),
  },
});