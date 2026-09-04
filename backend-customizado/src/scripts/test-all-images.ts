import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function testAllImages() {
  const servicos = await prisma.servico.findMany({
    where: { areaResponsavel: { nome: { equals: 'Serviços Corporativos' } } }
  });

  console.log(`Testando ${servicos.length} serviços de Serviços Corporativos:`);
  for (const s of servicos) {
    const url = `http://localhost:3001/images/${s.imagem_id}.${s.imagem_extension || 'jpg'}`;
    const res = await fetch(url);
    const text = await res.text();
    const isSvg = text.startsWith('<svg');
    console.log(` - ${s.titulo.padEnd(45)}: Status ${res.status} | Size ${(text.length/1024).toFixed(1)} KB | Real Image? ${!isSvg ? 'SIM' : 'FALLBACK SVG'}`);
  }

  const solucoes = await prisma.solucao.findMany({
    where: { areaResponsavel: { nome: { equals: 'Serviços Corporativos' } } }
  });

  console.log(`\nTestando ${solucoes.length} soluções de Serviços Corporativos:`);
  for (const s of solucoes) {
    const url = `http://localhost:3001/images/${s.imagem_id}.${s.imagem_extension || 'jpg'}`;
    const res = await fetch(url);
    const text = await res.text();
    const isSvg = text.startsWith('<svg');
    console.log(` - ${s.titulo.padEnd(45)}: Status ${res.status} | Size ${(text.length/1024).toFixed(1)} KB | Real Image? ${!isSvg ? 'SIM' : 'FALLBACK SVG'}`);
  }

  await prisma.$disconnect();
}

testAllImages().catch(console.error);

