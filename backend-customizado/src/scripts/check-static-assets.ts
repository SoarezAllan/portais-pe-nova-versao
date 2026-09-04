import fs from 'fs';
import path from 'path';

const portals = [
  { name: 'portal_contratos_corp_pe', dir: 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_contratos_corp_pe' },
  { name: 'portal_eng_arq_pe', dir: 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_eng_arq_pe' },
  { name: 'portal_patrimonio_pe', dir: 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\portal_patrimonio_pe' },
  { name: 'gerenciador-react', dir: 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\gerenciador-react' }
];

function checkFiles() {
  console.log('=== VERIFICAÇÃO DE ARQUIVOS ESTÁTICOS E IMAGENS EM CADA PORTAL ===\n');

  for (const portal of portals) {
    console.log(`Verificando: ${portal.name}`);
    const publicDir = path.join(portal.dir, 'public');
    const srcDir = path.join(portal.dir, 'src');

    const publicFiles = fs.existsSync(publicDir) ? new Set(fs.readdirSync(publicDir)) : new Set();
    console.log(` - Arquivos em public/: ${Array.from(publicFiles).join(', ')}`);

    // Scan all .jsx, .tsx, .css files in src
    function scanDir(dir: string, fileList: string[] = []) {
      if (!fs.existsSync(dir)) return fileList;
      const entries = fs.readdirSync(dir, { withFileTypes: true });
      for (const entry of entries) {
        const full = path.join(dir, entry.name);
        if (entry.isDirectory()) {
          scanDir(full, fileList);
        } else if (entry.name.endsWith('.jsx') || entry.name.endsWith('.tsx') || entry.name.endsWith('.css') || entry.name.endsWith('.js')) {
          fileList.push(full);
        }
      }
      return fileList;
    }

    const files = scanDir(srcDir);
    const missing: { file: string; match: string }[] = [];

    files.forEach(f => {
      const content = fs.readFileSync(f, 'utf8');
      // Match src="/something" or url('/something')
      const imgMatches = content.matchAll(/(?:src|url)\s*[:=]\s*["'](\/[a-zA-Z0-9_\-./]+\.(?:png|jpg|jpeg|svg|webp|gif))["']/g);
      for (const m of imgMatches) {
        const relPath = m[1];
        const targetPath = path.join(publicDir, relPath.replace(/^\//, ''));
        if (!fs.existsSync(targetPath)) {
          missing.push({ file: path.relative(portal.dir, f), match: relPath });
        }
      }
    });

    if (missing.length === 0) {
      console.log(` [OK] Todos os arquivos estáticos referenciados em ${portal.name} existem!`);
    } else {
      console.log(` [AVISO] Arquivos estáticos ausentes em ${portal.name}:`);
      missing.forEach(m => console.log(`   -> ${m.match} (em ${m.file})`));
    }
    console.log('');
  }
}

checkFiles();
