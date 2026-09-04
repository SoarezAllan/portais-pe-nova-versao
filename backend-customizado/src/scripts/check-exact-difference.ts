import fs from 'fs';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const sqlPath = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\database_edicao.sql';

async function checkExactDifference() {
  const content = fs.readFileSync(sqlPath, 'utf8');

  // Let's check servicos in SQL vs database
  const servicoBlock = content.match(/COPY public\."?Servicos"?\s*\(([^)]+)\)\s+FROM stdin;\n([\s\S]*?)\n\\\./i);
  if (servicoBlock) {
    const cols = servicoBlock[1].split(',').map(c => c.trim().replace(/"/g, ''));
    const rows = servicoBlock[2].split('\n').filter(r => r.trim().length > 0).map(r => r.split('\t'));
    console.log(`Servicos no SQL do Backup: ${rows.length}`);
    
    const dbServicos = await prisma.servico.findMany();
    console.log(`Servicos no Banco Atual: ${dbServicos.length}`);

    const idColIdx = cols.indexOf('id');
    const titleColIdx = cols.indexOf('titulo');
    const imgColIdx = cols.indexOf('imagem_id');
    const areaColIdx = cols.indexOf('areaResponsavel');

    console.log('\nComparando cada serviço do backup com o banco:');
    rows.forEach(r => {
      const id = r[idColIdx];
      const title = r[titleColIdx];
      const imgId = r[imgColIdx];
      const area = r[areaColIdx];
      const inDb = dbServicos.find(s => s.id === id);
      if (!inDb) {
        console.log(` [FALTA NO BANCO] ID: ${id} | Titulo: ${title} | Area: ${area} | Img: ${imgId}`);
      } else if (inDb.imagem_id !== imgId) {
        console.log(` [IMAGEM DIFERENTE] ID: ${id} | DB Img: ${inDb.imagem_id} vs Backup Img: ${imgId}`);
      }
    });
  }

  // Let's check Noticia
  const noticiaBlock = content.match(/COPY public\."?Noticia"?\s*\(([^)]+)\)\s+FROM stdin;\n([\s\S]*?)\n\\\./i);
  if (noticiaBlock) {
    const cols = noticiaBlock[1].split(',').map(c => c.trim().replace(/"/g, ''));
    const rows = noticiaBlock[2].split('\n').filter(r => r.trim().length > 0).map(r => r.split('\t'));
    console.log(`\nNoticias no SQL do Backup: ${rows.length}`);
    const dbNoticias = await prisma.noticia.findMany();
    console.log(`Noticias no Banco Atual: ${dbNoticias.length}`);
    const idColIdx = cols.indexOf('id');
    const titleColIdx = cols.indexOf('titulo');
    const imgColIdx = cols.indexOf('imagemPrincipal_id');
    rows.forEach(r => {
      const id = r[idColIdx];
      const title = r[titleColIdx];
      const imgId = r[imgColIdx];
      const inDb = dbNoticias.find(n => n.id === id);
      if (!inDb) {
        console.log(` [FALTA NO BANCO] Noticia: ${title} (Img: ${imgId})`);
      } else if (inDb.imagemPrincipal_id !== imgId) {
        console.log(` [IMAGEM DIFERENTE] Noticia: ${title} | DB: ${inDb.imagemPrincipal_id} vs Backup: ${imgId}`);
      }
    });
  }

  await prisma.$disconnect();
}

checkExactDifference().catch(console.error);
