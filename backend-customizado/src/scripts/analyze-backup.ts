import fs from 'fs';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const plainSqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup24072026_plain.sql';

async function main() {
  const content = fs.readFileSync(plainSqlPath, 'utf8');

  // Parse COPY blocks
  const copyBlocks = content.split('COPY public.');
  const backupStats: Record<string, { count: number; columns: string[]; rows: string[] }> = {};

  for (let i = 1; i < copyBlocks.length; i++) {
    const block = copyBlocks[i];
    const match = block.match(/^"?([a-zA-Z0-9_]+)"?\s*\(([^)]+)\)\s+FROM stdin;\n([\s\S]*?)\n\\\./);
    if (match) {
      const tableName = match[1];
      const columns = match[2].split(',').map(c => c.trim().replace(/"/g, ''));
      const rows = match[3].split('\n').filter(r => r.trim().length > 0);
      backupStats[tableName] = {
        count: rows.length,
        columns: columns,
        rows: rows
      };
    }
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

  console.log('=== COMPARAÇÃO DETALHADA: BACKUP (24/07/2026) vs BANCO ATUAL ===\n');
  console.log('Tabela'.padEnd(25) + ' | Backup | Atual | Diferença');
  console.log('-'.repeat(55));

  for (const [table, model] of Object.entries(prismaModels)) {
    try {
      const countCurrent = await model.count();
      const countBackup = backupStats[table]?.count || 0;
      const diff = countCurrent - countBackup;
      const diffStr = diff > 0 ? `+${diff} (mais recente)` : diff < 0 ? `${diff}` : '= igual';
      console.log(`${table.padEnd(25)} | ${String(countBackup).padStart(6)} | ${String(countCurrent).padStart(5)} | ${diffStr}`);
    } catch (e: any) {
      console.log(`${table.padEnd(25)} | Erro: ${e.message}`);
    }
  }

  console.log('\n--- DETALHES DOS DADOS DO BACKUP (24/07/2026) ---');
  console.log(`- Usuários cadastrados: ${backupStats['User']?.count}`);
  console.log(`- Notícias cadastradas: ${backupStats['Noticia']?.count}`);
  console.log(`- Serviços cadastrados: ${backupStats['Servicos']?.count}`);
  console.log(`- Soluções cadastradas: ${backupStats['Solucoes']?.count}`);
  console.log(`- Legislações cadastradas: ${backupStats['Legislacoes']?.count}`);
  console.log(`- Cursos cadastrados: ${backupStats['Cursos']?.count}`);
  console.log(`- Portfólios cadastrados: ${backupStats['Portfolios']?.count}`);
  console.log(`- Itens de Quem Somos (Sobre): Mural (${backupStats['QuemSomosMuralItem']?.count}), Time (${backupStats['QuemSomosTimeItem']?.count}), Subáreas (${backupStats['QuemSomosSubareaItem']?.count})`);
  console.log(`- Áreas responsáveis: ${backupStats['AreasResponsaveis']?.count}, Subáreas: ${backupStats['Subareas']?.count}, Gerências: ${backupStats['Gerencias']?.count}, Setores: ${backupStats['Setores']?.count}`);

  await prisma.$disconnect();
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});

