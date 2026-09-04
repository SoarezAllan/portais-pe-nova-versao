import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function inspectAcessos() {
  const acessos = await prisma.acesso.findMany();
  console.log(`Total de registros de acesso: ${acessos.length}`);

  const portals: Record<string, number> = {};
  const areas: Record<string, number> = {};
  const tipos: Record<string, number> = {};

  acessos.forEach(a => {
    portals[a.portal] = (portals[a.portal] || 0) + 1;
    areas[a.area] = (areas[a.area] || 0) + 1;
    tipos[a.tipo] = (tipos[a.tipo] || 0) + 1;
  });

  console.log('\n--- PORTAIS REGISTRADOS ---');
  console.log(portals);

  console.log('\n--- ÁREAS REGISTRADAS ---');
  console.log(areas);

  console.log('\n--- TIPOS REGISTRADOS ---');
  console.log(tipos);

  await prisma.$disconnect();
}

inspectAcessos().catch(console.error);
