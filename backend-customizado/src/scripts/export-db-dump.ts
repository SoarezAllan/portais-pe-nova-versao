import { execSync } from 'child_process';
import path from 'path';

const dumpCmd = `"C:\\Program Files\\PostgreSQL\\18\\bin\\pg_dump.exe" --clean --if-exists -d postgresql://postgres:Nipa32025%23@localhost:5432/portal_patrimonio_dev -f "c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\database_backups\\backup_portal_patrimonio.sql"`;
const dumpCmd2 = `"C:\\Program Files\\PostgreSQL\\18\\bin\\pg_dump.exe" --clean --if-exists -d postgresql://postgres:Nipa32025%23@localhost:5432/portal_patrimonio_dev -f "c:\\Users\\clovis.melo.GGPAE-027\\Documents\\PortaisPE-main\\database_backups\\backup_producao_portal_pat.sql"`;

console.log('Gerando novo dump do banco atualizado para versionamento no Git...');
execSync(dumpCmd, { stdio: 'inherit' });
execSync(dumpCmd2, { stdio: 'inherit' });
console.log('Dumps gerados com sucesso em database_backups/!');

