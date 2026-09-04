import fs from 'fs';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const sqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\database_edicao.sql';

async function inspectSql() {
  const content = fs.readFileSync(sqlPath, 'utf8');

  function getCopyRows(tableName: string) {
    const match = content.match(new RegExp(`COPY public\\."?${tableName}"?\\s*\\(([^)]+)\\)\\s+FROM stdin;\\n([\\s\\S]*?)\\n\\\\\\.`, 'i'));
    if (!match) return { cols: [], rows: [] };
    const cols = match[1].split(',').map(c => c.trim().replace(/"/g, ''));
    const rows = match[2].split('\n').filter(r => r.trim().length > 0).map(r => r.split('\t'));
    return { cols, rows };
  }

  console.log('=== ÁREAS RESPONSÁVEIS NO SQL ===');
  const areas = getCopyRows('AreasResponsaveis');
  areas.rows.forEach(r => console.log(` - ID: ${r[0]}, Nome: ${r[1]}`));

  console.log('\n=== SUBÁREAS NO SQL ===');
  const subareas = getCopyRows('Subareas');
  subareas.rows.forEach(r => console.log(` - ID: ${r[0]}, Nome: ${r[1]}, AreaID: ${r[2]}`));

  console.log('\n=== USUÁRIOS NO SQL ===');
  const users = getCopyRows('User');
  users.rows.forEach(r => {
    const nameIdx = users.cols.indexOf('name');
    const emailIdx = users.cols.indexOf('email');
    const roleIdx = users.cols.indexOf('role');
    console.log(` - ${r[nameIdx]} (${r[emailIdx]}) [Role: ${r[roleIdx]}]`);
  });

  console.log('\n=== PÁGINAS QUEM SOMOS NO SQL ===');
  const paginas = getCopyRows('PaginaQuemSomos');
  paginas.rows.forEach(r => {
    const tituloIdx = paginas.cols.indexOf('tituloDaPagina');
    const areaIdx = paginas.cols.indexOf('areaResponsavel');
    console.log(` - ID: ${r[0]}, Titulo: ${r[tituloIdx]}, Area: ${r[areaIdx]}`);
  });

  console.log('\n=== NOTÍCIAS NO SQL ===');
  const noticias = getCopyRows('Noticia');
  const nTitleIdx = noticias.cols.indexOf('titulo');
  const nDateIdx = noticias.cols.indexOf('dataPublicacao');
  const nImgIdx = noticias.cols.indexOf('imagemPrincipal_id');
  noticias.rows.forEach(r => {
    console.log(` - [${r[nDateIdx]}] ${r[nTitleIdx]} (Img: ${r[nImgIdx]})`);
  });

  await prisma.$disconnect();
}

inspectSql().catch(console.error);

