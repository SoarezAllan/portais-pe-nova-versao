async function testUrlWithVersion() {
  const query = `
    query {
      noticia(where: { id: "cmrxwuxoa000iw8inyqh968qv" }) {
        id
        titulo
        imagemPrincipal {
          id
          url
        }
      }
    }
  `;

  const res = await fetch('http://localhost:3001/api/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ query })
  });

  const data = await res.json();
  console.log('Noticia GraphQL Result:');
  console.log(JSON.stringify(data, null, 2));

  const imgUrl = data.data.noticia.imagemPrincipal.url;
  console.log('\nFetching imgUrl from Port 5174 (Portal Patrimonio):', `http://localhost:5174${imgUrl}`);
  const fetch5174 = await fetch(`http://localhost:5174${imgUrl}`);
  const text5174 = await fetch5174.text();
  console.log('Status 5174:', fetch5174.status);
  console.log('Content-Type:', fetch5174.headers.get('content-type'));
  console.log('Length:', text5174.length);
  console.log('Is Real JPEG?', !text5174.startsWith('<svg'));
}

testUrlWithVersion().catch(console.error);
