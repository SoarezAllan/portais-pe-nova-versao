import { createAuth } from '@keystone-6/auth';
import { statelessSessions } from '@keystone-6/core/session';
import { sendPasswordResetEmail } from '../.lib/email';

/**
 * CONFIGURAÇÃO DE SESSÃO
 */
const sessionMaxAge = 60 * 60 * 24 * 30; // 30 dias
const sessionSecret =
  process.env.SESSION_SECRET || 'uma-chave-secreta-muito-longa-e-segura';

const session = statelessSessions({
  maxAge: sessionMaxAge,
  secret: sessionSecret,
});

/**
 * CONFIGURAÇÃO DE AUTENTICAÇÃO
 */
const auth = createAuth({
  listKey: 'User',
  identityField: 'email',
  secretField: 'password',
  sessionData: 'id name email role areas { id nome }',

  // ✅ ATIVA RESET DE SENHA DO KEYSTONE
  passwordResetLink: {
    sendToken: async ({ token, identity }) => {
      console.log('📩 Enviando email de recuperação');

      await sendPasswordResetEmail(identity, token);
    },

    tokensValidForMins: 60,
  },
});

// EXPORTAÇÃO
const { withAuth } = auth;
export { withAuth, session, auth };