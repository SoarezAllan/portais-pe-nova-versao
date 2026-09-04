import { getContext } from '@keystone-6/core/context';
import config from '../keystone';
import * as PrismaModule from '../node_modules/.prisma/client';

async function main() {
  const context = getContext(config, PrismaModule);
  console.log('✅ Conectado ao Keystone.');

  const targetEmail = 'clovis.melo@sad.pe.gov.br';
  const password = 'TempSenha@2026';
  const name = 'Clóvis Melo';

  // Busca por email (usar findMany para evitar WhereUniqueInput)
  const users = await context.sudo().db.User.findMany({ where: { email: { equals: targetEmail } } });
  const user = users && users.length ? users[0] : null;

  if (user) {
    console.log(`👤 Usuário encontrado (id=${user.id}). Atualizando senha e papel para admin...`);
    await context.sudo().db.User.updateOne({ where: { id: user.id }, data: { password, role: 'admin' } });
    console.log('✅ Usuário atualizado com nova senha e papel admin.');
  } else {
    console.log('📌 Usuário não encontrado. Criando novo usuário admin...');
    const created = await context.sudo().db.User.createOne({
      data: {
        name,
        email: targetEmail,
        password,
        role: 'admin',
      },
    });
    console.log(`✅ Usuário criado: ${created.email} (id=${created.id})`);
  }

  console.log('✅ Operação finalizada. Faça login com o email e a senha temporária.');
}

main()
  .catch((e) => console.error('❌ Falha:', e))
  .finally(() => process.exit(0));
