import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function testPaginasGql() {
  const gqlQuery = `
    query {
      paginasQuemSomos {
        id
        tituloDaPagina
        muralTextoIntrodutorio
        timeTitulo
        timeDescricao
        areaResponsavel { id nome }
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
    console.log('GraphQL paginasQuemSomos retornou com sucesso:');
    gqlData.data.paginasQuemSomos.forEach((p: any) => {
      console.log(` - [${p.areaResponsavel?.nome}] ${p.tituloDaPagina} (Mural: ${p.muralItens?.length}, Time: ${p.time?.length} membros)`);
      p.time?.forEach((m: any) => {
        console.log(`     * ${m.nome} (${m.cargo}) -> Foto: ${m.foto?.url || 'SEM FOTO'}`);
      });
    });
  }

  await prisma.$disconnect();
}

testPaginasGql().catch(console.error);

