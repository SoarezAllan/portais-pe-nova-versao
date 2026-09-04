import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function checkColumns() {
  const result: any[] = await prisma.$queryRaw`
    SELECT column_name, data_type 
    FROM information_schema.columns 
    WHERE table_name = 'PaginaQuemSomos'
  `;
  console.log('Columns in PaginaQuemSomos:');
  result.forEach(r => console.log(` - ${r.column_name} (${r.data_type})`));

  // Also check all other tables to ensure all schema columns match!
  const tables = ['User', 'Noticia', 'Servicos', 'Solucoes', 'Cursos', 'Legislacoes', 'Portfolios', 'PortfolioImagens', 'QuemSomosMuralItem', 'QuemSomosTimeItem', 'QuemSomosSubareaItem', 'AreasResponsaveis', 'Subareas'];
  for (const t of tables) {
    const cols: any[] = await prisma.$queryRawUnsafe(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = '${t}'
    `);
    console.log(`\nColumns in ${t}:`);
    cols.forEach(c => console.log(` - ${c.column_name} (${c.data_type})`));
  }

  await prisma.$disconnect();
}

checkColumns().catch(console.error);

