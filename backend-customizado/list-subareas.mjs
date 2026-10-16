import { PrismaClient } from './node_modules/@prisma/client/index.js';
const p = new PrismaClient();
const subareas = await p.subarea.findMany({ include: { area: true }, orderBy: { nome: 'asc' } });
console.log(JSON.stringify(subareas, null, 2));
p.$disconnect();
