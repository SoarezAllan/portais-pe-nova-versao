import { graphql } from '@keystone-6/core';
import { sendPasswordResetEmail } from '../.lib/email';

/**
 * ESTA MUTAÇÃO CUSTOMIZADA GERA UMA SENHA TEMPORÁRIA
 * E ATUALIZA O USUÁRIO NO BANCO DE DADOS DIRETAMENTE.
 */
export const extendGraphqlSchema = graphql.extend(base => ({
  mutation: {
    forgotPassword: graphql.field({
      type: graphql.String,
      args: {
        email: graphql.arg({ type: graphql.nonNull(graphql.String) }),
      },
      async resolve(root, { email }, context) {
        try {
          // 1. Busca o usuário pelo e-mail
          const user = await context.db.User.findOne({
            where: { email },
          });

          if (!user) {
            return 'EMAIL_NAO_ENCONTRADO';
          }

          // 2. Gera uma senha temporária simples (ex: PE-123456)
          const tempPassword = 'PE-' + Math.random().toString(36).substring(2, 8).toUpperCase();

          // 3. Atualiza a senha do usuário no banco de dados
          await context.db.User.updateOne({
            where: { email },
            data: { password: tempPassword },
          });

          // 4. Constrói o link de redefinição com email e senha temporária
          const resetLink = `/reiniciar-senha/?email=${encodeURIComponent(email)}&token=${encodeURIComponent(tempPassword)}`;
          
          // 5. Envia o e-mail com o link
          await sendPasswordResetEmail(email, resetLink);

          return 'SENHA_ENVIADA';
        } catch (error) {
          console.error('ERRO NO FORGOT PASSWORD:', error);
          return 'ERRO_AO_PROCESSAR';
        }
      },
    }),

    // Mutação customizada para redefinir senha com senha temporária
    resetPassword: graphql.field({
      type: graphql.String,
      args: {
        email: graphql.arg({ type: graphql.nonNull(graphql.String) }),
        tempPassword: graphql.arg({ type: graphql.nonNull(graphql.String) }),
        newPassword: graphql.arg({ type: graphql.nonNull(graphql.String) }),
      },
      async resolve(root, { email, tempPassword, newPassword }, context) {
        try {
          // 1. Busca o usuário pelo e-mail
          const user = await context.db.User.findOne({
            where: { email },
          });

          if (!user) {
            return 'USUARIO_NAO_ENCONTRADO';
          }

          // 2. Verifica se a senha temporária está correta
          if (user.password !== tempPassword) {
            return 'SENHA_TEMPORARIA_INVALIDA';
          }

          // 3. Atualiza a senha para a nova senha
          await context.db.User.updateOne({
            where: { email },
            data: { password: newPassword },
          });

          return 'SENHA_REDEFINIDA';
        } catch (error) {
          console.error('ERRO NO RESET PASSWORD:', error);
          return 'ERRO_AO_PROCESSAR';
        }
      },
    }),
  },
}));
