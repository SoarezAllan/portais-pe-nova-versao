import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function fixSchemaColumns() {
  console.log('=== VERIFICANDO E CORRIGINDO COLUNAS FALTANTES NO BANCO ===\n');

  // 1. Add timeDescricao to PaginaQuemSomos
  await prisma.$executeRawUnsafe(`
    ALTER TABLE "PaginaQuemSomos" 
    ADD COLUMN IF NOT EXISTS "timeDescricao" text DEFAULT '' NOT NULL;
  `);
  console.log(' - Coluna "timeDescricao" adicionada em "PaginaQuemSomos".');

  // Test query on PaginaQuemSomos
  const paginas = await prisma.paginaQuemSomos.findMany({
    include: {
      muralItens: true,
      time: true,
      conteudosPorSubarea: true,
      areaResponsavel: true,
      subarea: true
    }
  });

  console.log(`\nConsulta de teste bem-sucedida! ${paginas.length} páginas encontradas:`);
  paginas.forEach(p => {
    console.log(` - ID: ${p.id} | Titulo: ${p.tituloDaPagina} | Area: ${p.areaResponsavel?.nome} | Mural: ${p.muralItens.length} itens | Time: ${p.time.length} membros`);
  });

  // Test GraphQL query for PaginaQuemSomos
  const gqlQuery = `
    query {
      paginaQuemSomoses {
        id
        tituloDaPagina
        muralTextoIntrodutorio
        timeTitulo
        timeDescricao
        muralItens { id titulo valor descricao }
        time { id nome cargo descricao foto { url } }
        conteudosPorSubarea { id conteudo subarea { id nome } }
      }
    }
  `;

  const res = await fetch('http://localhost:3001/api/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ query: gqlQuery })
  });

  const gqlData = await res.json();
  if (gqlData.errors) {
    console.error('Erros no GraphQL:', gqlData.errors);
  } else {
    console.log('\nGraphQL PaginaQuemSomos retornou 100% OK:', gqlData.data.paginaQuemSomoses.length, 'páginas!');
  }

  await prisma.$disconnect();
}

fixSchemaColumns().catch(console.error);
