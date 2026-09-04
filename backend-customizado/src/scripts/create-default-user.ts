import fs from 'fs';
import path from 'path';

// Clean SVG default avatar
const defaultUserSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200">
  <rect width="200" height="200" fill="#e2e8f0"/>
  <circle cx="100" cy="75" r="40" fill="#94a3b8"/>
  <path d="M30 180 C30 135, 70 130, 100 130 C130 130, 170 135, 170 180 Z" fill="#94a3b8"/>
</svg>`;

const dirs = [
  'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_contratos_corp_pe\\public',
  'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_eng_arq_pe\\public',
  'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_patrimonio_pe\\public'
];

dirs.forEach(d => {
  if (fs.existsSync(d)) {
    fs.writeFileSync(path.join(d, 'default-user.png'), defaultUserSvg);
    fs.writeFileSync(path.join(d, 'default-user.svg'), defaultUserSvg);
  }
});

console.log('default-user.png and default-user.svg created in all portal public folders.');
