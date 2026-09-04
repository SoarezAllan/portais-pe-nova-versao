import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const sqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\database_edicao.sql';
const psqlExe = 'C:\\Program Files\\PostgreSQL\\18\\bin\\psql.exe';
const dbUrl = 'postgresql://postgres:Nipa32025%23@localhost:5432/portal_patrimonio_dev';

async function fullCleanRestore() {
  console.log('=== INICIANDO RESTAURAÇÃO TOTAL E LIMPA DO BACKUP (04/09/2026) ===\n');

  // 1. Drop public schema and recreate it cleanly
  console.log('1. Limpando schema público do PostgreSQL...');
  const cleanSql = `
    DROP SCHEMA public CASCADE;
    CREATE SCHEMA public;
    GRANT ALL ON SCHEMA public TO postgres;
    GRANT ALL ON SCHEMA public TO public;
  `;
  execSync(`"${psqlExe}" "${dbUrl}" -c "${cleanSql.replace(/\n/g, ' ')}"`, { stdio: 'inherit' });
  console.log('Schema public limpo com sucesso!\n');

  // 2. Execute the complete database_edicao.sql
  console.log('2. Executando database_edicao.sql completo...');
  execSync(`"${psqlExe}" "${dbUrl}" -f "${sqlPath}"`, { stdio: 'inherit' });
  console.log('SQL do backup executado com sucesso!\n');

  // 3. Connect via Prisma to verify and adjust
  const prisma = new PrismaClient();

  // 4. Update/Ensure admin user
  console.log('3. Configurando usuário administrador...');
  const adminHash = await bcrypt.hash('Admin123@', 10);
  const existingAdmin = await prisma.user.findFirst({
    where: { email: { equals: 'admin@admin.com', mode: 'insensitive' } }
  });

  if (existingAdmin) {
    await prisma.user.update({
      where: { id: existingAdmin.id },
      data: {
        name: 'Administrador',
        password: adminHash,
        role: 'admin'
      }
    });
    console.log(' - Administrador (admin@admin.com) atualizado com senha Admin123@.');
  } else {
    await prisma.user.create({
      data: {
        name: 'Administrador',
        email: 'admin@admin.com',
        password: adminHash,
        role: 'admin'
      }
    });
    console.log(' - Administrador (admin@admin.com) criado.');
  }

  // Also ensure clovis.melo user has operator/admin password if needed
  const clovis = await prisma.user.findFirst({
    where: { email: { equals: 'clovis.melo@sad.pe.gov.br', mode: 'insensitive' } }
  });
  if (clovis) {
    await prisma.user.update({
      where: { id: clovis.id },
      data: { password: adminHash }
    });
    console.log(' - Usuário clovis.melo@sad.pe.gov.br configurado com senha padrão.');
  }

  // 5. Standardize PaginaQuemSomos -> 'Sobre'
  console.log('4. Padronizando títulos das páginas para "Sobre"...');
  await prisma.paginaQuemSomos.updateMany({
    data: { tituloDaPagina: 'Sobre' }
  });

  // 6. Ensure Area "Contratos Corporativos" and "Serviços Corporativos" mappings
  const areas = await prisma.areaResponsavel.findMany();
  console.log(`\n5. Áreas Responsáveis cadastradas (${areas.length}):`);
  areas.forEach(a => console.log(` - ${a.nome} (ID: ${a.id})`));

  // 7. Verify all table counts
  console.log('\n=== CONTAGEM FINAL DE REGISTROS NO BANCO DE DADOS ===');
  console.log(`- Usuários:           ${await prisma.user.count()}`);
  console.log(`- Notícias:           ${await prisma.noticia.count()}`);
  console.log(`- Serviços:           ${await prisma.servico.count()}`);
  console.log(`- Soluções/Projetos:  ${await prisma.solucao.count()}`);
  console.log(`- Cursos:             ${await prisma.curso.count()}`);
  console.log(`- Legislações:        ${await prisma.legislacao.count()}`);
  console.log(`- Portfólios:         ${await prisma.portfolio.count()}`);
  console.log(`- Imagens Portfólio:  ${await prisma.portfolioImagem.count()}`);
  console.log(`- Mural Sobre:        ${await prisma.quemSomosMuralItem.count()}`);
  console.log(`- Time Sobre:         ${await prisma.quemSomosTimeItem.count()}`);
  console.log(`- Subáreas Sobre:     ${await prisma.quemSomosSubareaItem.count()}`);
  console.log(`- Subáreas cadastradas:${await prisma.subarea.count()}`);
  console.log(`- Logs de Acesso:     ${await prisma.acesso.count()}`);
  console.log(`- Logs de Auditoria:  ${await prisma.auditLog.count()}`);

  // 8. Copy all images to ALL portal public/images folders as well!
  console.log('\n6. Sincronizando imagens em todos os portais e backend...');
  const srcImgDir = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\images';
  const targetDirs = [
    'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\backend-customizado\\public\\images',
    'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\gerenciamento_keystone\\public\\images',
    'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_contratos_corp_pe\\public\\images',
    'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_eng_arq_pe\\public\\images',
    'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_patrimonio_pe\\public\\images'
  ];

  const files = fs.readdirSync(srcImgDir);
  targetDirs.forEach(td => {
    if (!fs.existsSync(td)) fs.mkdirSync(td, { recursive: true });
    files.forEach(f => {
      fs.copyFileSync(path.join(srcImgDir, f), path.join(td, f));
    });
    console.log(` - Sincronizado ${files.length} imagens para ${path.basename(path.dirname(td))}/${path.basename(td)}`);
  });

  await prisma.$disconnect();
  console.log('\n=== RESTAURAÇÃO TOTAL E LIMPA FINALIZADA COM SUCESSO! ===');
}

fullCleanRestore().catch(console.error);
