const { spawn } = require('child_process');
const path = require('path');
const ROOT = __dirname;
const R = '\x1b[0m', B = '\x1b[1m', D = '\x1b[2m', RED = '\x1b[31m';
const os = require('os');
const HOSTNAME = os.hostname();

const services = [
  { n: 'BACKEND', l: 'Backend Customizado', port: 3001, u: `http://localhost:3001/api/graphql`, net: `http://${HOSTNAME}:3001/api/graphql`, c: path.join(ROOT, 'backend-customizado'), x: '\x1b[36m' },
  { n: 'GERENCIADOR', l: 'Gerenciador React', port: 5173, u: `http://localhost:5173`, net: `http://${HOSTNAME}:5173`, c: path.join(ROOT, 'gerenciador-react'), x: '\x1b[32m' },
  { n: 'PORTAL PATRIMONIO', l: 'Portal Patrimônio', port: 5174, u: `http://localhost:5174`, net: `http://${HOSTNAME}:5174`, c: path.join(ROOT, 'PortaisPE-main', 'portal_patrimonio_pe'), x: '\x1b[33m' },
  { n: 'PORTAL ENG/ARQ', l: 'Portal Engenharia e Arquitetura', port: 5175, u: `http://localhost:5175`, net: `http://${HOSTNAME}:5175`, c: path.join(ROOT, 'PortaisPE-main', 'portal_eng_arq_pe'), x: '\x1b[35m' },
  { n: 'PORTAL CONTRATOS', l: 'Portal Contratos Corp', port: 5176, u: `http://localhost:5176`, net: `http://${HOSTNAME}:5176`, c: path.join(ROOT, 'PortaisPE-main', 'portal_contratos_corp_pe'), x: '\x1b[34m' },
];
console.log('');
console.log(B + '='.repeat(75) + R);
console.log(B + '  PORTAIS PE — TODOS OS SERVIÇOS (DISPONÍVEIS NA REDE INTERNA)' + R);
console.log(B + '='.repeat(75) + R);
console.log('');
console.log(`  ${B}Nome do Desktop na Rede:${R} ${B}\x1b[32m${HOSTNAME}\x1b[0m`);
console.log('');
services.forEach((s, i) => {
  console.log(`  ${s.x}${B}[${i + 1}]${R} ${B}${s.l}${R}`);
  console.log(`      ${D}Local:${R}   ${s.x}${s.u}${R}`);
  console.log(`      ${D}Rede:${R}    ${B}${s.x}${s.net}${R}`);
});
console.log('');
console.log(`${D}  Pressione Ctrl+C para encerrar todos os serviços.${R}`);
console.log('');
console.log(`${B}${'='.repeat(75)}${R}`);
console.log('');
function startService(s) {
  const ch = spawn('npm', ['run', 'dev'], { cwd: s.c, shell: true, env: { ...process.env }, stdio: ['ignore', 'pipe', 'pipe'] });
  const p = `[${s.n}] `;
  ch.stdout.on('data', (d) => { d.toString().split('\n').forEach((l) => { if (l.trim()) console.log(`${s.x}${p}${R}${l}`); }); });
  ch.stderr.on('data', (d) => { d.toString().split('\n').forEach((l) => { if (l.trim()) console.log(`${RED}${p}${R}${l}`); }); });
  ch.on('exit', (c) => { if (c !== 0 && c !== null) console.log(`${RED}${p} Encerrou com código ${c}${R}`); });
  ch.on('error', (e) => console.log(`${RED}${p} Erro: ${e.message}${R}`));
  return ch;
}
services.forEach((s) => startService(s));
process.stdin.resume();
process.on('SIGINT', () => { console.log('\nEncerrando todos os serviços...'); process.exit(0); });