import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function verifyEverything() {
  console.log('=== VERIFICAÇÃO COMPLETA DE IMAGENS E DADOS ===');

  // Test GraphQL query for all portals
  const query = `
    query {
      servicos { id titulo areaResponsavel { nome } imagem { url } }
      noticias { id titulo areaResponsavel { nome } imagemPrincipal { url } }
      solucoes { id titulo areaResponsavel { nome } imagem { url } }
    }
  `;

  const res = await fetch('http://localhost:3001/api/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ query })
  });

  const data = await res.json();
  const servicos = data.data.servicos;
  const noticias = data.data.noticias;
  const solucoes = data.data.solucoes;

  console.log(`\nServicos retornados pelo GraphQL: ${servicos.length}`);
  for (const s of servicos) {
    if (s.imagem?.url) {
      const imgRes = await fetch(`http://localhost:3001${s.imagem.url}`);
      const text = await imgRes.text();
      const isReal = !text.startsWith('<svg');
      console.log(` - [${s.areaResponsavel?.nome || 'Geral'}] ${s.titulo.padEnd(45)} -> ${s.imagem.url} [Status: ${imgRes.status}, Real: ${isReal ? 'SIM' : 'FALLBACK'}]`);
    } else {
      console.log(` - [${s.areaResponsavel?.nome || 'Geral'}] ${s.titulo.padEnd(45)} -> SEM IMAGEM`);
    }
  }

  console.log(`\nNoticias retornadas pelo GraphQL: ${noticias.length}`);
  for (const n of noticias) {
    if (n.imagemPrincipal?.url) {
      const imgRes = await fetch(`http://localhost:3001${n.imagemPrincipal.url}`);
      const text = await imgRes.text();
      const isReal = !text.startsWith('<svg');
      console.log(` - [${n.areaResponsavel?.nome || 'Geral'}] ${n.titulo.padEnd(50)} -> ${n.imagemPrincipal.url} [Status: ${imgRes.status}, Real: ${isReal ? 'SIM' : 'FALLBACK'}]`);
    }
  }

  console.log(`\nSoluções retornadas pelo GraphQL: ${solucoes.length}`);
  for (const sol of solucoes) {
    if (sol.imagem?.url) {
      const imgRes = await fetch(`http://localhost:3001${sol.imagem.url}`);
      const text = await imgRes.text();
      const isReal = !text.startsWith('<svg');
      console.log(` - [${sol.areaResponsavel?.nome || 'Geral'}] ${sol.titulo.padEnd(45)} -> ${sol.imagem.url} [Status: ${imgRes.status}, Real: ${isReal ? 'SIM' : 'FALLBACK'}]`);
    }
  }

  await prisma.$disconnect();
}

verifyEverything().catch(console.error);
