import http from 'http';

function checkUrl(url: string, name: string): Promise<void> {
  return new Promise((resolve) => {
    http.get(url, (res) => {
      console.log(`[${res.statusCode === 200 ? 'OK 200' : 'STATUS ' + res.statusCode}] ${name}: ${url}`);
      resolve();
    }).on('error', (err) => {
      console.log(`[ERRO] ${name}: ${url} -> ${err.message}`);
      resolve();
    });
  });
}

async function testAll() {
  console.log('=== TESTANDO PÁGINAS SOBRE E IMAGENS DO TIME ===');
  await checkUrl('http://localhost:5174/sobre', 'Portal Patrimônio - Sobre');
  await checkUrl('http://localhost:5175/sobre', 'Portal Eng/Arq - Sobre');
  await checkUrl('http://localhost:5176/sobre', 'Portal Contratos - Sobre');
  
  // Test team images
  await checkUrl('http://localhost:3001/images/YersnPT2Il8q_P-yslo2yA.png', 'Foto Fabiana Ramalho');
  await checkUrl('http://localhost:3001/images/2iCSbl6fFBBEdwDmt3M_Kg.png', 'Foto Adauto Nunes');
  await checkUrl('http://localhost:3001/images/r5k4HcRIeax-fzaFAVntcg.png', 'Foto Adriana Cardoso');
}

testAll();

