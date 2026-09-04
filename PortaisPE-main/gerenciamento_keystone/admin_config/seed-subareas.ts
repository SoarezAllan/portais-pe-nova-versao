import { getContext } from '@keystone-6/core/context';
import config from '../keystone';
import * as PrismaModule from '../node_modules/.prisma/client';

async function main() {
  const context = getContext(config, PrismaModule);
  console.log('✅ Conectado ao Keystone (seed-subareas).');

  const mapping: Record<string, string[]> = {
    'Patrimônio': ['Patrimônio Imobiliário', 'Patrimônio Móvel'],
    'Engenharia e Arquitetura': ['Engenharia e Arquitetura'],
    'Contratos Corporativos': ['Frota', 'Água e Energia'],
  };

  for (const areaNome of Object.keys(mapping)) {
    const areas = await context.sudo().db.AreaResponsavel.findMany({ where: { nome: { equals: areaNome } } });
    const area = areas && areas.length ? areas[0] : null;
    if (!area) {
      console.log(`⚠️ Área não encontrada: ${areaNome} — criando a área primeiro.`);
      const createdArea = await context.sudo().db.AreaResponsavel.createOne({ data: { nome: areaNome } });
      console.log(`✅ Área criada: ${createdArea.nome} (id=${createdArea.id})`);
      // refresh reference
      const areas2 = await context.sudo().db.AreaResponsavel.findMany({ where: { nome: { equals: areaNome } } });
      if (areas2 && areas2.length) {
        // @ts-ignore
        // eslint-disable-next-line
        (area as any) = areas2[0];
      }
    }

    const areaFinal = await context.sudo().db.AreaResponsavel.findMany({ where: { nome: { equals: areaNome } } });
    const areaObj = areaFinal && areaFinal.length ? areaFinal[0] : null;
    if (!areaObj) {
      console.log(`❌ Não foi possível obter a área final para: ${areaNome}`);
      continue;
    }

    const subnames = mapping[areaNome];
    for (const s of subnames) {
      const found = await context.sudo().db.Subarea.findMany({ where: { nome: { equals: s }, area: { id: { equals: areaObj.id } } } });
      if (found && found.length) {
        console.log(`ℹ️ Subárea já existe: ${s} (área: ${areaNome})`);
        continue;
      }

      const created = await context.sudo().db.Subarea.createOne({ data: { nome: s, area: { connect: { id: areaObj.id } } } });
      console.log(`✅ Subárea criada: ${s} (área: ${areaNome}, id=${created.id})`);
    }
  }

  console.log('✅ seed-subareas finalizado.');
}

main()
  .catch(e => console.error('❌ Falha seed-subareas:', e))
  .finally(() => process.exit(0));
