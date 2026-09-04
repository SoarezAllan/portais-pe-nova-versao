import fs from 'fs';
import path from 'path';

const srcDir = 'C:\\Users\\clovis.melo.GGPAE-027\\.gemini\\antigravity\\brain\\151ec099-5402-4c7f-96d8-2d041ebe4275\\scratch\\backup_unpacked\\images';
const destDir1 = 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\backend-customizado\\public\\images';
const destDir2 = 'c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\PortaisPE-main\\gerenciamento_keystone\\public\\images';

async function copyImages() {
  const files = fs.readdirSync(srcDir);
  console.log(`Copiando ${files.length} imagens para os diretórios públicos...`);
  
  if (!fs.existsSync(destDir1)) fs.mkdirSync(destDir1, { recursive: true });
  if (!fs.existsSync(destDir2)) fs.mkdirSync(destDir2, { recursive: true });

  let copiedCount = 0;
  for (const file of files) {
    const srcFile = path.join(srcDir, file);
    const destFile1 = path.join(destDir1, file);
    const destFile2 = path.join(destDir2, file);
    
    fs.copyFileSync(srcFile, destFile1);
    fs.copyFileSync(srcFile, destFile2);
    copiedCount++;
  }

  console.log(`Sucesso: ${copiedCount} imagens copiadas!`);
  const finalCount1 = fs.readdirSync(destDir1).length;
  console.log(`Total de arquivos agora em backend-customizado/public/images: ${finalCount1}`);
}

copyImages().catch(console.error);
