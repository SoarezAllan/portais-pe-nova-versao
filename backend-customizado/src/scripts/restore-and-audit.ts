import fs from 'fs';
import { execSync } from 'child_process';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const sqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\database_edicao.sql';

async function restoreDatabase() {
  console.log('=== RESTAURANDO BANCO DE DADOS A PARTIR DO NOVO BACKUP ===');
  
  const envUrl = process.env.DATABASE_URL || 'postgresql://postgres:Nipa32025%23@localhost:5432/portal_patrimonio_dev';
  console.log('Target DB URL:', envUrl);

  // Use psql to execute the SQL file
  const psqlCmd = `"C:\\Program Files\\PostgreSQL\\18\\bin\\psql.exe" "${envUrl}" -f "${sqlPath}"`;
  console.log('Executando psql...');
  try {
    execSync(psqlCmd, { stdio: 'inherit' });
    console.log('Restauração SQL concluída com sucesso!');
  } catch (e: any) {
    console.log('PSQL retornou avisos ou concluído:', e.message);
  }

  // Connect via Prisma
  const prisma = new PrismaClient();

  // 1. Ensure admin@admin.com exists with password Admin123@
  const adminHash = await bcrypt.hash('Admin123@', 10);
  const adminUser = await prisma.user.findFirst({
    where: { email: { equals: 'admin@admin.com', mode: 'insensitive' } }
  });

  if (adminUser) {
    await prisma.user.update({
      where: { id: adminUser.id },
      data: {
        password: adminHash,
        role: 'admin',
        name: 'Administrador'
      }
    });
    console.log('Usuário admin@admin.com atualizado com senha Admin123@ e role admin.');
  } else {
    await prisma.user.create({
      data: {
        name: 'Administrador',
        email: 'admin@admin.com',
        password: adminHash,
        role: 'admin'
      }
    });
    console.log('Usuário admin@admin.com criado com sucesso!');
  }

  // 2. Ensure all PaginaQuemSomos have tituloDaPagina = 'Sobre'
  await prisma.paginaQuemSomos.updateMany({
    data: { tituloDaPagina: 'Sobre' }
  });
  console.log('Páginas "Quem Somos" padronizadas para "Sobre".');

  // 3. Audit all images across all tables
  const diskFiles = new Set(fs.readdirSync('c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\backend-customizado\\public\\images'));
  console.log(`Total de arquivos de imagem em disco: ${diskFiles.size}`);

  const noticias = await prisma.noticia.findMany();
  const servicos = await prisma.servico.findMany();
  const solucoes = await prisma.solucao.findMany();
  const portfolios = await prisma.portfolio.findMany();
  const portImagens = await prisma.portfolioImagem.findMany();
  const time = await prisma.quemSomosTimeItem.findMany();

  function checkImg(id?: string | null, ext?: string | null) {
    if (!id) return false;
    const filename = id + (ext ? `.${ext}` : '.jpg');
    return diskFiles.has(filename) || diskFiles.has(id) || diskFiles.has(`${id}.jpg`) || diskFiles.has(`${id}.png`);
  }

  console.log('\n--- AUDITORIA DE IMAGENS DO BANCO RESTAURADO ---');
  let totalImgs = 0;
  let okImgs = 0;

  noticias.forEach(n => {
    if (n.imagemPrincipal_id) {
      totalImgs++;
      if (checkImg(n.imagemPrincipal_id, n.imagemPrincipal_extension)) okImgs++;
      else console.log(` [FALTA] Noticia: ${n.titulo} -> ${n.imagemPrincipal_id}`);
    }
  });

  servicos.forEach(s => {
    if (s.imagem_id) {
      totalImgs++;
      if (checkImg(s.imagem_id, s.imagem_extension)) okImgs++;
      else console.log(` [FALTA] Servico: ${s.titulo} -> ${s.imagem_id}`);
    }
  });

  solucoes.forEach(s => {
    if (s.imagem_id) {
      totalImgs++;
      if (checkImg(s.imagem_id, s.imagem_extension)) okImgs++;
      else console.log(` [FALTA] Solucao: ${s.titulo} -> ${s.imagem_id}`);
    }
  });

  portfolios.forEach(p => {
    if (p.imagem_id) {
      totalImgs++;
      if (checkImg(p.imagem_id, p.imagem_extension)) okImgs++;
      else console.log(` [FALTA] Portfolio: ${p.titulo} -> ${p.imagem_id}`);
    }
  });

  portImagens.forEach(pi => {
    if (pi.imagem_id) {
      totalImgs++;
      if (checkImg(pi.imagem_id, pi.imagem_extension)) okImgs++;
      else console.log(` [FALTA] PortfolioImagem: ${pi.titulo} -> ${pi.imagem_id}`);
    }
  });

  time.forEach(t => {
    if (t.foto_id) {
      totalImgs++;
      if (checkImg(t.foto_id, t.foto_extension)) okImgs++;
      else console.log(` [FALTA] Time: ${t.nome} -> ${t.foto_id}`);
    }
  });

  console.log(`\nResultado Auditoria: ${okImgs} / ${totalImgs} imagens presentes no disco (${((okImgs/totalImgs)*100).toFixed(1)}%)!`);

  await prisma.$disconnect();
}

restoreDatabase().catch(console.error);
