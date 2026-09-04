import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function normalizeAcessoRecords() {
  console.log('Normalizando nomes nos registros históricos de Acesso...');

  await prisma.$executeRawUnsafe(`
    UPDATE "Acesso" 
    SET portal = 'Engenharia e Arquitetura', area = 'Engenharia e Arquitetura' 
    WHERE portal ILIKE '%engenharia%' OR area ILIKE '%engenharia%';
  `);

  await prisma.$executeRawUnsafe(`
    UPDATE "Acesso" 
    SET portal = 'Patrimônio', area = 'Patrimônio' 
    WHERE portal ILIKE '%patrim%' OR area ILIKE '%patrim%';
  `);

  await prisma.$executeRawUnsafe(`
    UPDATE "Acesso" 
    SET portal = 'Serviços Corporativos', area = 'Serviços Corporativos' 
    WHERE portal ILIKE '%servi%' OR portal ILIKE '%contrat%' OR area ILIKE '%servi%' OR area ILIKE '%contrat%';
  `);

  const acessos = await prisma.acesso.findMany();
  const portals: Record<string, number> = {};
  acessos.forEach(a => {
    portals[a.portal] = (portals[a.portal] || 0) + 1;
  });

  console.log('\n--- PORTAIS APÓS NORMALIZAÇÃO ---');
  console.log(portals);

  await prisma.$disconnect();
}

normalizeAcessoRecords().catch(console.error);
