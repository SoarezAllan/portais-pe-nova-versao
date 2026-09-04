import { getContext } from '@keystone-6/core/context';
import config from '../keystone';
import * as PrismaModule from '../node_modules/.prisma/client';

async function main() {
  const context = getContext(config, PrismaModule);
  console.log('✅ Conectado ao Keystone.');

  // --- O ALVO ---
  // Email do usuário que você quer modificar.
  const targetEmail = 'clovis.melo@sad.pe.gov.br';

  // --- A AÇÃO ---
  // Preencha APENAS o que você quer alterar. Comente o resto.
  const dataToUpdate = {
    // Para resetar a senha do usuário alvo (senha temporária):
    password: 'TempSenha@2026',

    // OBS: não alterei o `role`. Caso queira tornar admin, descomente a linha abaixo.
    // role: 'admin',
  };

  console.log(`🔎 Procurando por: ${targetEmail}...`);
  const user = await context.sudo().db.User.findOne({
    where: { email: targetEmail },
  });

  if (!user) {
    return console.error(`❌ Usuário não encontrado.`);
  }

  console.log(`👤 Usuário "${user.name}" encontrado. Aplicando alterações...`);
  await context.sudo().db.User.updateOne({
    where: { id: user.id },
    data: dataToUpdate,
  });

  console.log('✅ Operação concluída com sucesso!');
}

main()
  .catch(e => console.error('❌ Falha na operação:', e))
  .finally(() => process.exit(0));

  // code reinicialização: npx ts-node-dev admin_config/manage-user.ts
  // alterar user admin: "const targetEmail"
  // alterar senha: "const newPassword"     