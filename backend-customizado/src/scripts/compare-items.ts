import fs from 'fs';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const plainSqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup24072026_plain.sql';

async function main() {
  const content = fs.readFileSync(plainSqlPath, 'utf8');

  // Compare Solucoes
  const solucoesBackupMatch = content.match(/COPY public\."?Solucoes"?\s*\(([^)]+)\)\s+FROM stdin;\n([\s\S]*?)\n\\\./i);
  const currentSolucoes = await prisma.solucao.findMany();
  console.log('--- SOLUÇÕES NO BANCO ATUAL ---');
  currentSolucoes.forEach(s => console.log(` - ${s.titulo} (slug: ${s.slug})`));

  if (solucoesBackupMatch) {
    console.log('\n--- SOLUÇÕES NO BACKUP (24/07/2026) ---');
    const cols = solucoesBackupMatch[1].split(',').map(c => c.trim().replace(/"/g, ''));
    const tIdx = cols.indexOf('titulo');
    const sIdx = cols.indexOf('slug');
    solucoesBackupMatch[2].split('\n').filter(r => r.trim()).forEach(r => {
      const p = r.split('\t');
      console.log(` - ${p[tIdx]} (slug: ${p[sIdx]})`);
    });
  }

  // Also compare Noticias
  const currentNoticias = await prisma.noticia.findMany();
  console.log('\n--- NOTÍCIAS NO BANCO ATUAL ---');
  currentNoticias.forEach(n => console.log(` - [${n.dataPublicacao?.toISOString().slice(0,10)}] ${n.titulo}`));

  await prisma.$disconnect();
}

main().catch(console.error);

