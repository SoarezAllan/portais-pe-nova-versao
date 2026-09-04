async function testGql() {
  const res = await fetch('http://localhost:3001/api/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      query: `query {
        noticias(where: { destaque: { equals: true } }) {
          id
          titulo
          destaque
          imagemPrincipal {
            id
            url
            extension
          }
          areaResponsavel {
            nome
          }
        }
      }`
    })
  });
  const data = await res.json();
  console.log(JSON.stringify(data, null, 2));
}

testGql().catch(console.error);

