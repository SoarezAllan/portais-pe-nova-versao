import { list } from '@keystone-6/core';
import { text, select, timestamp, relationship } from '@keystone-6/core/fields';
// 👇 Importamos a sua função de permissão existente
import { isAdmin } from '../auth/permissions'; 

export const SolicitacaoCadastro = list({
  access: {
    operation: {
      // 🔒 Apenas Admin pode VER a lista
      query: ({ session }) => isAdmin(session),
      
      // 🔓 Qualquer um (mesmo sem login) pode CRIAR (para o formulário do site funcionar)
      create: () => true, 
      
      // 🔒 Apenas Admin pode APROVAR/REJEITAR
      update: ({ session }) => isAdmin(session),
      
      // 🔒 Apenas Admin pode DELETAR
      delete: ({ session }) => isAdmin(session),
    },
  },

  ui: {
    label: 'Solicitações de Cadastro',
    singular: 'Solicitação',
    plural: 'Solicitações',
    
    // 👇 AQUI ESTÁ A CORREÇÃO: Esconde do menu se não for Admin
    isHidden: ({ session }) => !isAdmin(session),
    
    hideCreate: true, // Esconde botão "Criar" (pois vem do site)
    
    listView: {
      initialColumns: ['nome', 'email', 'secretaria', 'status', 'dataSolicitacao'],
      initialSort: { field: 'dataSolicitacao', direction: 'DESC' },
    },
  },

  fields: {
    nome: text({ validation: { isRequired: true }, label: 'Nome Completo' }),
    email: text({ 
      validation: { isRequired: true }, 
      isIndexed: 'unique',
      label: 'E-mail (Login)',
    }),
    secretaria: text({ validation: { isRequired: true }, label: 'Secretaria/Órgão' }),
    motivo: text({ 
      label: 'Motivo',
      ui: { displayMode: 'textarea' }
    }),
    
    // Senha (temporária)
    senha: text({ 
      validation: { isRequired: true, length: { min: 8 } }, 
      label: 'Senha Desejada',
      ui: { 
        displayMode: 'input',
        itemView: { fieldMode: 'hidden' }, 
        createView: { fieldMode: 'edit' },
      }
    }),

    dataSolicitacao: timestamp({
      label: 'Data da Solicitação',
      defaultValue: { kind: 'now' },
      ui: { createView: { fieldMode: 'hidden' } }
    }),

    status: select({
      label: 'Status',
      options: [
        { label: 'Pendente', value: 'PENDENTE' },
        { label: 'Aprovado', value: 'APROVADO' },
        { label: 'Rejeitado', value: 'REJEITADO' },
      ],
      defaultValue: 'PENDENTE',
      ui: { 
        displayMode: 'segmented-control',
        // Esconde o status na criação (sempre nasce Pendente)
        createView: { fieldMode: 'hidden' } 
      }
    }),
    
    usuarioCriado: relationship({
      ref: 'User', 
      label: 'Usuário Criado',
      ui: { 
        itemView: { fieldMode: 'read' },
        createView: { fieldMode: 'hidden' }
      }
    }),
  },
  
  // HOOK PARA CRIAÇÃO AUTOMÁTICA DE USUÁRIO
  hooks: {
    afterChange: async ({ operation, item, context }) => {
      if (operation === 'update' && item.status === 'APROVADO' && !item.usuarioCriadoId) {
        
        const { nome, email, senha, secretaria } = item; // Pegamos a secretaria também

        // Cria o usuário na lista principal 'User'
        // O campo 'password' do Keystone faz o hash automaticamente
        const novoUsuario = await context.db.User.createOne({
          data: {
            name: nome,
            email: email,
            password: senha, 
            // Definindo o papel padrão (ajuste conforme suas opções em user.ts)
            role: 'operator', 
            // Se o seu User tem campo 'setor' ou 'gerencia', você precisaria adaptar aqui.
            // Como 'secretaria' não é um campo padrão do seu User (no código anterior),
            // talvez você queira salvar isso em algum lugar ou ignorar por enquanto.
          },
        });

        // Vincula e limpa a senha
        await context.db.SolicitacaoCadastro.updateOne({
          where: { id: item.id },
          data: {
            usuarioCriado: { connect: { id: novoUsuario.id } },
            senha: '', 
          },
        });
      }
    },
  },
});