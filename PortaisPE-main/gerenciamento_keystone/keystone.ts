require('dotenv').config();

import { config, graphql } from '@keystone-6/core';
import { lists } from './schema';
import { withAuth, session } from './auth/auth';
import { sendPasswordResetEmail } from './.lib/email';


function generateTempPassword() {
  return Math.random().toString(36).slice(-8);
}

const FRONTEND_URL = process.env.FRONTEND_URL || '';

const FRONTEND_URLS = (process.env.FRONTEND_URLS || '')
  .split(',')
  .map((s) => s.trim())
  .filter(Boolean);

const BACKEND_PORT =
  process.env.BACKEND_PORT ||
  process.env.PORT ||
  '3001';

const BACKEND_URL =
  process.env.BACKEND_URL ||
  `http://localhost:${BACKEND_PORT}`;

const LOGIN_URL = `http://localhost:${BACKEND_PORT}/gerenciador-login`;

console.log('===============================');
console.log('BACKEND_URL:', BACKEND_URL);
console.log('FRONTEND_URL:', FRONTEND_URL);
console.log('FRONTEND_URLS:', FRONTEND_URLS);
console.log('LOGIN_URL:', LOGIN_URL);
console.log('===============================');

export default withAuth(
  config({
    db: {
      provider: 'postgresql',
      url: process.env.DATABASE_URL!,
    },

    lists,
    session,

    ui: {
      isAccessAllowed: ({ session }) => {
        // Permite acesso a usuários autenticados
        return !!session;
      },
      // Customização do Admin UI
      // (o arquivo já existe em admin/config.tsx e é referenciado pelo Keystone starter)
    },




    server: {
      port: Number(BACKEND_PORT),

      cors: {
        origin: true,
        credentials: true,
      },

      extendExpressApp: (app, context) => {
        const express = require('express');
        const path = require('path');
        const fs = require('fs');

        // Servir páginas de login/recuperação pelo backend (elimina CORS)
        const loginDir = path.resolve(__dirname, '../../login');

        app.get('/gerenciador-login', (req, res) => {
          const filePath = path.join(loginDir, 'index.html');
          if (!fs.existsSync(filePath)) {
            return res.status(404).send('Login page not found');
          }
          res.sendFile(filePath);
        });

        app.get('/recuperar-senha', (req, res) => {
          const filePath = path.join(loginDir, 'recuperar-senha/index.html');
          if (!fs.existsSync(filePath)) {
            return res.status(404).send('Recuperar senha page not found');
          }
          res.sendFile(filePath);
        });

        app.get('/reiniciar-senha', (req, res) => {
          const filePath = path.join(loginDir, 'reiniciar-senha/index.html');
          if (!fs.existsSync(filePath)) {
            return res.status(404).send('Reiniciar senha page not found');
          }
          res.sendFile(filePath);
        });

        // Static files for login pages (CSS, JS, etc.)
        app.use('/login', express.static(loginDir));

        // Rota compatível: /indicadores-button
        app.get('/indicadores-button', (req, res) => {
          res.redirect('/indicadores_de_acesso');
        });

        // Painel de Indicadores (HTML estático)
        app.get('/indicadores_de_acesso', (req, res) => {
          const filePath = path.join(loginDir, 'indicadores_de_acesso/index.html');

          console.log('[KESTONE] /indicadores_de_acesso ->', filePath);
          console.log('[KESTONE] /indicadores_de_acesso exists ->', fs.existsSync(filePath));

          if (!fs.existsSync(filePath)) {
            return res
              .status(404)
              .send('Indicadores de Acesso: arquivo não encontrado no caminho:' + filePath);
          }

          res.sendFile(filePath);
        });

        // ===== Analytics (Top Portal/Serviço/Notícia) =====

        app.post(
          '/analytics/track',
          express.json({ limit: '200kb' }),
          async (req: any, res: any) => {
            const { analyticsTrackHandler } = await import('./analyticsRoutes');
            return analyticsTrackHandler(req, res, context);
          }
        );

        app.get('/analytics/top', async (req: any, res: any) => {
          const { analyticsTopHandler } = await import('./analyticsRoutes');
          return analyticsTopHandler(req, res);
        });

      },
    },

    storage: {
      my_local_images: {
        kind: 'local',
        type: 'image',
        storagePath: 'public/images',
        serverRoute: {
          path: '/images',
        },
        generateUrl: (path) => `${BACKEND_URL}/images${path}`,
      },
    },

    graphql: {
      extendGraphqlSchema: graphql.extend(() => ({
        mutation: {

          forgotPassword: graphql.field({
            type: graphql.Boolean,
            args: {
              email: graphql.arg({
                type: graphql.nonNull(graphql.String),
              }),
            },
            async resolve(_, { email }, context) {
              const sudo = context.sudo();

              const user = await sudo.db.User.findOne({
                where: { email },
              });

              if (!user) {
                throw new Error('Email não encontrado');
              }

              const tempPassword = generateTempPassword();

              await sudo.db.User.updateOne({
                where: { id: user.id },
                data: { resetCode: tempPassword },
              });

              const resetLink = `${LOGIN_URL}/reiniciar-senha/?email=${encodeURIComponent(email)}&token=${tempPassword}`;

              console.log('LINK RESET:', resetLink);

              await sendPasswordResetEmail(email, resetLink);

              console.log(`✅ Código enviado para ${email}`);

              return true;
            },
          }),

          resetPassword: graphql.field({
            type: graphql.Boolean,
            args: {
              email: graphql.arg({
                type: graphql.nonNull(graphql.String),
              }),
              tempPassword: graphql.arg({
                type: graphql.nonNull(graphql.String),
              }),
              newPassword: graphql.arg({
                type: graphql.nonNull(graphql.String),
              }),
            },
            async resolve(_, { email, tempPassword, newPassword }, context) {
              const sudo = context.sudo();

              const user = await sudo.db.User.findOne({
                where: { email },
              });

              if (!user) {
                throw new Error('Usuário não encontrado');
              }

              if (user.resetCode !== tempPassword) {
                throw new Error('Senha temporária inválida');
              }

              await sudo.db.User.updateOne({
                where: { id: user.id },
                data: {
                  password: newPassword,
                  resetCode: '',
                },
              });

              console.log(`🔒 Senha atualizada para ${email}`);

              return true;
            },
          }),
        },
      })),
    },
  })
);