import { getContext } from '@keystone-6/core/context';
import config from '../keystone';
import * as PrismaModule from '../node_modules/.prisma/client';

async function main() {
  const context = getContext(config, PrismaModule);
  console.log('✅ Conectado ao Keystone.');

  const areaNames = [
    'Patrimônio',
    'Engenharia e Arquitetura',
    'Contratos Corporativos',
  ];

  for (const nome of areaNames) {
    const found = await context.sudo().db.AreaResponsavel.findMany({ where: { nome: { equals: nome } } });
    const existing = found && found.length ? found[0] : null;
    if (existing) {
      console.log(`ℹ️ Área já existe: ${nome} (id=${existing.id})`);
      continue;
    }

    const created = await context.sudo().db.AreaResponsavel.createOne({
      data: { nome },
    });

    console.log(`✅ Área criada: ${nome} (id=${created.id})`);
  }

  // --- OPÇÃO: associar usuários por e-mail ---
  // Para ativar, defina `autoAssign = true` e preencha `assignments`.
  const autoAssign = false;
  const assignments: { email: string; areaNome: string }[] = [
    // { email: 'usuario1@exemplo.com', areaNome: 'Patrimônio' },
  ];

  if (autoAssign && assignments.length) {
    for (const a of assignments) {
      const user = await context.sudo().db.User.findOne({ where: { email: a.email } });
      const areaFound = await context.sudo().db.AreaResponsavel.findMany({ where: { nome: { equals: a.areaNome } } });
      const area = areaFound && areaFound.length ? areaFound[0] : null;
      if (!user) {
        console.log(`❌ Usuário não encontrado: ${a.email}`);
        continue;
      }
      if (!area) {
        console.log(`❌ Área não encontrada: ${a.areaNome}`);
        continue;
      }

      await context.sudo().db.User.updateOne({ where: { id: user.id }, data: { areas: { connect: { id: area.id } } } });
      console.log(`🔗 Associado ${user.email} -> ${area.nome}`);
    }
  }

  console.log('✅ Operação finalizada.');
}

main()
  .catch(e => console.error('❌ Falha:', e))
  .finally(() => process.exit(0));

// Execução: npx ts-node-dev admin_config/seed-areas.ts
