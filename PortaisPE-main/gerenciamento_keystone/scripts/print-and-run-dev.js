#!/usr/bin/env node
const { spawn } = require('child_process');
const path = require('path');

const BACKEND_PORT = process.env.BACKEND_PORT || process.env.PORT || '3001';
const host = '172.31.104.30';
const local = `http://localhost:${BACKEND_PORT}`;
const network = `http://${host}:${BACKEND_PORT}`;
console.log('Starting Keystone dev — available at:');
console.log(`- Local:   ${local}`);
console.log(`- Network: ${network}`);
console.log(`- GraphQL: ${network}/api/graphql`);
console.log(`- Admin UI: ${network}/admin`);
console.log('Running prisma generate and keystone dev...\n');

const cmd = `set BACKEND_PORT=${BACKEND_PORT}&& npx prisma generate && keystone dev`;
const child = spawn(cmd, { stdio: 'inherit', shell: true, cwd: path.resolve(__dirname, '..') });
child.on('exit', (code) => process.exit(code));
