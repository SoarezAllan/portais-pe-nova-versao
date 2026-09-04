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
  console.log('=== TESTANDO SERVIÇOS E PORTAIS ===');
  await checkUrl('http://localhost:3001/health', 'Backend Health');
  await checkUrl('http://localhost:5173', 'Gerenciador Admin');
  await checkUrl('http://localhost:5174', 'Portal Patrimônio');
  await checkUrl('http://localhost:5175', 'Portal Engenharia e Arquitetura');
  await checkUrl('http://localhost:5176', 'Portal Contratos Corporativos');
  
  // Test images route
  await checkUrl('http://localhost:3001/images/CNe5SHQWt-f1NoggHf5qmQ.jpg', 'Imagem Noticia Diario');
  await checkUrl('http://localhost:3001/images/UzRyZclZdaA_EwrVpB1V8A.png', 'Imagem Servico');
  await checkUrl('http://localhost:3001/images/DRIQLcH4MML450BOZvjNDg.png', 'Imagem Frota');
}

testAll();
