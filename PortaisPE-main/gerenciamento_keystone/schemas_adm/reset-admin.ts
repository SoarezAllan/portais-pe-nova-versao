const { PrismaClient } = require('.prisma/client');
const bcrypt = require('bcryptjs');

async function main() {
  const prisma = new PrismaClient();

  const email = 'clovis.melo@sad.pe.gov.br';
  const novaSenha = 'novaSenha123'; // 👈 substitua pela senha que quiser

  const hash = await bcrypt.hash(novaSenha, 10);

  await prisma.user.update({
    where: { email },
    data: { password: hash },
  });

  console.log(`✅ Senha do usuário ${email} redefinida com sucesso!`);
  await prisma.$disconnect();
}

main().catch((err) => {
  console.error('❌ Erro:', err);
  process.exit(1);
});