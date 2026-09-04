import fs from 'fs';
import path from 'path';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const sqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\database_edicao.sql';
const extractedImagesDir = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\images';

async function main() {
  console.log('=== ANALISANDO NOVO BACKUP COMPLETO (04-09-2026) ===');
  
  // 1. Check images
  const images = fs.readdirSync(extractedImagesDir);
  console.log(`Total de arquivos de imagem no zip: ${images.length}`);
  let totalImgSize = 0;
  images.forEach(img => {
    totalImgSize += fs.statSync(path.join(extractedImagesDir, img)).size;
  });
  console.log(`Tamanho total das imagens: ${(totalImgSize / 1024 / 1024).toFixed(2)} MB`);

  // 2. Check SQL file format
  const content = fs.readFileSync(sqlPath, 'utf8');
  console.log(`Tamanho do SQL: ${(content.length / 1024 / 1024).toFixed(2)} MB`);
  const lines = content.split('\n');
  console.log(`Total de linhas no SQL: ${lines.length}`);
  console.log('Primeiras 15 linhas:');
  console.log(lines.slice(0, 15).join('\n'));

  // Parse COPY / INSERT blocks in database_edicao.sql
  const copyBlocks = content.split('COPY public.');
  const sqlStats: Record<string, { count: number; columns: string[]; rows: string[] }> = {};

  for (let i = 1; i < copyBlocks.length; i++) {
    const block = copyBlocks[i];
    const match = block.match(/^"?([a-zA-Z0-9_]+)"?\s*\(([^)]+)\)\s+FROM stdin;\n([\s\S]*?)\n\\\./);
    if (match) {
      const tableName = match[1];
      const columns = match[2].split(',').map(c => c.trim().replace(/"/g, ''));
      const rows = match[3].split('\n').filter(r => r.trim().length > 0);
      sqlStats[tableName] = {
        count: rows.length,
        columns: columns,
        rows: rows
      };
    }
  }

  console.log('\n--- TABELAS E REGISTROS NO database_edicao.sql ---');
  for (const [table, info] of Object.entries(sqlStats)) {
    console.log(` - ${table.padEnd(25)}: ${info.count} registros`);
  }

  // Count current database records via Prisma
  const prismaModels: Record<string, any> = {
    User: prisma.user,
    Noticia: prisma.noticia,
    Servicos: prisma.servico,
    Solucoes: prisma.solucao,
    Cursos: prisma.curso,
    Legislacoes: prisma.legislacao,
    Tag: prisma.tag,
    Portfolios: prisma.portfolio,
    PortfolioImagens: prisma.portfolioImagem,
    PaginaQuemSomos: prisma.paginaQuemSomos,
    QuemSomosMuralItem: prisma.quemSomosMuralItem,
    QuemSomosTimeItem: prisma.quemSomosTimeItem,
    QuemSomosSubareaItem: prisma.quemSomosSubareaItem,
    AreasResponsaveis: prisma.areaResponsavel,
    Subareas: prisma.subarea,
    Gerencias: prisma.gerencia,
    Setores: prisma.setor,
    Gestores: prisma.gestores,
    AuditLogs: prisma.auditLog,
    Acesso: prisma.acesso
  };

  console.log('\n=== COMPARAÇÃO: NOVO BACKUP (04/09/2026) vs BANCO ATUAL EM EXECUÇÃO ===');
  console.log('Tabela'.padEnd(25) + ' | Novo Backup | Banco Atual | Diferença');
  console.log('-'.repeat(60));

  for (const [table, model] of Object.entries(prismaModels)) {
    try {
      const countCurrent = await model.count();
      const countBackup = sqlStats[table]?.count || 0;
      const diff = countBackup - countCurrent;
      const diffStr = diff > 0 ? `+${diff} no backup` : diff < 0 ? `${diff} no atual` : '= iguais';
      console.log(`${table.padEnd(25)} | ${String(countBackup).padStart(11)} | ${String(countCurrent).padStart(11)} | ${diffStr}`);
    } catch (e: any) {
      console.log(`${table.padEnd(25)} | Erro: ${e.message}`);
    }
  }

  await prisma.$disconnect();
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});

