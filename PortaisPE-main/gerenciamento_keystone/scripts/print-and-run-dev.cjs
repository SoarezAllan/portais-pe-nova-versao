#!/usr/bin/env node
const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

const BACKEND_PORT = process.env.BACKEND_PORT || process.env.PORT || '3001';
const host = process.env.DEV_HOST || '172.31.104.30';
const local = `http://localhost:${BACKEND_PORT}`;
const network = `http://${host}:${BACKEND_PORT}`;

console.log('Starting Keystone dev — available at:');
console.log(`- Local:   ${local}`);
console.log(`- Network: ${network}`);
console.log(`- GraphQL: ${network}/api/graphql`);
console.log(`- Admin UI: ${network}/admin`);
console.log('Running prisma generate and keystone dev...\n');

const projectRoot = path.resolve(__dirname, '..');

// Remove arquivos temporários do Prisma que podem travar rename no Windows
try {
  const prismaClientDir = path.resolve(__dirname, '..', 'node_modules', '.prisma', 'client');
  if (fs.existsSync(prismaClientDir)) {
    const files = fs.readdirSync(prismaClientDir);
    for (const f of files) {
      if (f.includes('.tmp') || f.endsWith('.tmp')) {
        const p = path.join(prismaClientDir, f);
        try { fs.unlinkSync(p); console.log('[prisma-cleanup] removed', p); } catch (e) { /* ignore */ }
      }
    }
  }
} catch (e) {
  // ignore cleanup errors
}

// Localiza node.exe e npm-cli.js sem depender de cmd.exe
const NODE_EXE = process.execPath;
const npmCliPath = path.join(path.dirname(NODE_EXE), 'node_modules', 'npm', 'bin', 'npm-cli.js');

/**
 * Monta o PATH incluindo diretórios node_modules/.bin da árvore de diretórios
 */
function buildEnvWithLocalBin(cwd) {
  try {
    const binPaths = [];
    let dir = cwd;
    while (true) {
      const binPath = path.join(dir, 'node_modules', '.bin');
      if (fs.existsSync(binPath)) {
        binPaths.push(binPath);
      }
      const parent = path.dirname(dir);
      if (parent === dir) break;
      dir = parent;
    }
    return {
      ...process.env,
      BACKEND_PORT,
      PATH: [...binPaths, process.env.PATH].join(path.delimiter),
    };
  } catch (e) {
    console.warn('[buildEnvWithLocalBin] Erro ao montar PATH:', e.message);
    return { ...process.env, BACKEND_PORT };
  }
}

const childEnv = buildEnvWithLocalBin(projectRoot);

/**
 * Descobre dinamicamente o entry point JS do CLI do Keystone
 * Lê o package.json do @keystone-6/core para encontrar o binário real
 */
function findKeystoneCliJs(projectRoot) {
  const pkgPath = path.join(projectRoot, 'node_modules', '@keystone-6', 'core', 'package.json');
  if (!fs.existsSync(pkgPath)) {
    throw new Error('@keystone-6/core não encontrado. Execute "npm install" em ' + projectRoot);
  }
  const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
  
  // Tenta resolver via "bin.keystone" no package.json
  if (pkg.bin && pkg.bin.keystone) {
    const absPath = path.resolve(path.dirname(pkgPath), pkg.bin.keystone);
    if (fs.existsSync(absPath)) return absPath;
  }
  
  // Fallback: bin/cli.js (comum em versões do Keystone)
  const fallback = path.join(path.dirname(pkgPath), 'bin', 'cli.js');
  if (fs.existsSync(fallback)) return fallback;
  
  throw new Error(
    'Não foi possível encontrar o entry point do keystone CLI.\n' +
    'O binário declarado no package.json é: ' + JSON.stringify(pkg.bin)
  );
}

function runStep(command, args, label) {
  return new Promise((resolve, reject) => {
    console.log(`\n[${label}] Executando: ${command} ${args.join(' ')}`);
    const child = spawn(command, args, {
      cwd: projectRoot,
      stdio: 'inherit',
      env: childEnv,
      windowsHide: true,
    });

    child.on('error', (err) => {
      reject(new Error(`[${label}] Falha ao iniciar: ${err.message}`));
    });

    child.on('exit', (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`[${label}] Encerrou com código ${code}`));
      }
    });
  });
}

async function main() {
  try {
    // Passo 1: prisma generate (via node + npm-cli.js, sem shell/cmd.exe)
    await runStep(NODE_EXE, [npmCliPath, 'exec', 'prisma', 'generate'], 'prisma generate');

    // Passo 2: keystone dev (binário resolvido dinamicamente)
    const keystoneCliJs = findKeystoneCliJs(projectRoot);
    console.log(`[keystone] CLI encontrado em: ${keystoneCliJs}`);
    await runStep(NODE_EXE, [keystoneCliJs, 'dev'], 'keystone dev');
  } catch (err) {
    console.error('\n' + err.message);
    process.exit(1);
  }
}

main();

