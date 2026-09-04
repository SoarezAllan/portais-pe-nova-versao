#!/usr/bin/env node
const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

function readViteConfig() {
  try {
    const cfg = fs.readFileSync(path.resolve(__dirname, '../vite.config.js'), 'utf8');
    const portMatch = cfg.match(/port:\s*(\d+)/);
    const hostMatch = cfg.match(/host:\s*['"]([^'"]+)['"]/);
    return {
      port: portMatch ? Number(portMatch[1]) : 5175,
      host: hostMatch ? hostMatch[1] : 'localhost',
    };
  } catch (e) {
    return { port: 5175, host: 'localhost' };
  }
}

const { port, host } = readViteConfig();
const local = `http://localhost:${port}`;
const network = `http://${host}:${port}`;
console.log('Starting dev server — available at:');
console.log(`- Local:   ${local}`);
console.log(`- Network: ${network}`);
console.log('Press Ctrl+C to stop.\n');

const child = spawn('npx', ['vite', '--host'], { stdio: 'inherit', shell: true, cwd: path.resolve(__dirname, '..') });
child.on('exit', (code) => process.exit(code));
