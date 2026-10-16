import { PrismaClient } from './node_modules/@prisma/client/index.js';
const p = new PrismaClient();

// 1. Renomear "Água e Energia" -> "Água"
const updated = await p.subarea.update({
  where: { id: 'cmrtn35yi0002bqr5ck780vyc' },
  data: { nome: 'Água' }
});
console.log('Atualizado:', updated.nome);

// 2. Criar nova subárea "Energia" para a mesma área
const created = await p.subarea.create({
  data: {
    nome: 'Energia',
    areaId: 'cmq81pvoq0003j9azcu4vg0ws'
  }
});
console.log('Criado:', created.nome);

p.$disconnect();
console.log('Concluído!');
