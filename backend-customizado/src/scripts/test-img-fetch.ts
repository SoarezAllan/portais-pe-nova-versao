async function testImageFetch() {
  const url5174 = 'http://localhost:5174/images/x_O2IBwkNbEw7S_BgdH9dA.jpg';
  const url3001 = 'http://localhost:3001/images/x_O2IBwkNbEw7S_BgdH9dA.jpg';

  const res5174 = await fetch(url5174);
  const text5174 = await res5174.text();
  console.log('Port 5174 fetch:');
  console.log(' Status:', res5174.status);
  console.log(' Content-Type:', res5174.headers.get('content-type'));
  console.log(' Length:', text5174.length);
  console.log(' Is SVG?', text5174.startsWith('<svg'));

  const res3001 = await fetch(url3001);
  const text3001 = await res3001.text();
  console.log('\nPort 3001 fetch:');
  console.log(' Status:', res3001.status);
  console.log(' Content-Type:', res3001.headers.get('content-type'));
  console.log(' Length:', text3001.length);
  console.log(' Is SVG?', text3001.startsWith('<svg'));
}

testImageFetch().catch(console.error);

