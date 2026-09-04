import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const prisma = new PrismaClient();
const imagesDir = 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\backend-customizado\\public\\images';
const diskFiles = new Set(fs.readdirSync(imagesDir));

async function inspectAllItems() {
  console.log('=== VERIFICAÇÃO COMPLETA DE SERVIÇOS E SOLUÇÕES ===\n');

  const servicos = await prisma.servico.findMany({
    include: { areaResponsavel: true, subarea: true }
  });

  console.log(`Total de Serviços: ${servicos.length}`);
  servicos.forEach(s => {
    const hasImg = !!s.imagem_id;
    let foundOnDisk = false;
    let fileTried = '';
    if (s.imagem_id) {
      const ext = s.imagem_extension || 'jpg';
      fileTried = `${s.imagem_id}.${ext}`;
      foundOnDisk = diskFiles.has(fileTried) || diskFiles.has(s.imagem_id) || diskFiles.has(`${s.imagem_id}.jpg`) || diskFiles.has(`${s.imagem_id}.png`);
    }
    console.log(`- [${s.areaResponsavel?.nome || 'Sem Área'}] [${s.subarea?.nome || 'Sem Subárea'}] ${s.titulo}`);
    console.log(`    imagem_id: ${s.imagem_id || 'NULL'} | ext: ${s.imagem_extension || 'NULL'} | em disco: ${foundOnDisk ? 'SIM [OK]' : 'NÃO [FALLBACK]'}`);
  });

  const solucoes = await prisma.solucao.findMany({
    include: { areaResponsavel: true, subarea: true }
  });

  console.log(`\nTotal de Soluções/Projetos: ${solucoes.length}`);
  solucoes.forEach(s => {
    const hasImg = !!s.imagem_id;
    let foundOnDisk = false;
    if (s.imagem_id) {
      const ext = s.imagem_extension || 'jpg';
      const fileTried = `${s.imagem_id}.${ext}`;
      foundOnDisk = diskFiles.has(fileTried) || diskFiles.has(s.imagem_id) || diskFiles.has(`${s.imagem_id}.jpg`) || diskFiles.has(`${s.imagem_id}.png`);
    }
    console.log(`- [${s.areaResponsavel?.nome || 'Sem Área'}] [${s.subarea?.nome || 'Sem Subárea'}] ${s.titulo}`);
    console.log(`    imagem_id: ${s.imagem_id || 'NULL'} | ext: ${s.imagem_extension || 'NULL'} | em disco: ${foundOnDisk ? 'SIM [OK]' : 'NÃO [FALLBACK]'}`);
  });

  const noticias = await prisma.noticia.findMany({
    include: { areaResponsavel: true }
  });

  console.log(`\nTotal de Notícias: ${noticias.length}`);
  noticias.forEach(n => {
    let foundOnDisk = false;
    if (n.imagemPrincipal_id) {
      const ext = n.imagemPrincipal_extension || 'jpg';
      const fileTried = `${n.imagemPrincipal_id}.${ext}`;
      foundOnDisk = diskFiles.has(fileTried) || diskFiles.has(n.imagemPrincipal_id) || diskFiles.has(`${n.imagemPrincipal_id}.jpg`) || diskFiles.has(`${n.imagemPrincipal_id}.png`);
    }
    console.log(`- [${n.areaResponsavel?.nome || 'Sem Área'}] ${n.titulo}`);
    console.log(`    imagemPrincipal_id: ${n.imagemPrincipal_id || 'NULL'} | em disco: ${foundOnDisk ? 'SIM [OK]' : 'NÃO [FALLBACK]'}`);
  });

  await prisma.$disconnect();
}

inspectAllItems().catch(console.error);
