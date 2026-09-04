import { list } from '@keystone-6/core';
import { text, timestamp, select, json } from '@keystone-6/core/fields';

/**
 * FUNÇÃO GLOBAL DE AUDITORIA
 * Esta função deve ser importada e chamada nos hooks (afterOperation) 
 * de todas as listas que você deseja monitorar.
 */
export const logAction = async ({
  context,
  listKey,
  operation,
  item,
  originalItem,
}: any) => {
  if (listKey === 'AuditLog') return;

  const session = context.session;
  if (!session) return;

  let mudancasFormatadas = '';

  if (operation === 'update' && originalItem && item) {
    const alteracoes: string[] = [];

    for (const campo of Object.keys(item)) {
      const antes = originalItem[campo];
      const depois = item[campo];

      if (JSON.stringify(antes) !== JSON.stringify(depois)) {
        alteracoes.push(
          `${campo}:\n  De: ${formatarValor(antes)}\n  Para: ${formatarValor(depois)}`
        );
      }
    }

    mudancasFormatadas =
      alteracoes.length > 0
        ? alteracoes.join('\n\n')
        : 'Nenhuma alteração detectada.';
  }

  if (operation === 'create') {
    mudancasFormatadas = 'Registro criado.';
  }

  if (operation === 'delete') {
    mudancasFormatadas = 'Registro excluído.';
  }

  try {
    // Tenta extrair nome da área (quando presente como relation ou id)
    let areaName = '';
    try {
      const areaRel = item?.areaResponsavel || originalItem?.areaResponsavel;
      if (areaRel) {
        if (typeof areaRel === 'object' && areaRel?.nome) {
          areaName = areaRel.nome;
        } else if (typeof areaRel === 'object' && areaRel?.id) {
          const fetched = await context.sudo().db.AreaResponsavel.findOne({ where: { id: areaRel.id } });
          if (fetched?.nome) areaName = fetched.nome;
        }
      }
    } catch (e) {
      // ignore fetch errors
    }

    await context.sudo().db.AuditLog.createOne({
      data: {
        usuario:
          session.data.email ||
          session.data.name ||
          'Usuário Desconhecido',
        operacao: operation.toUpperCase(),
        tabela: listKey,
        itemId: item?.id?.toString() || originalItem?.id?.toString(),
        itemTitulo:
          (item?.titulo || item?.name || originalItem?.titulo || originalItem?.name || 'Sem título') +
          (areaName ? ` (Área: ${areaName})` : ''),
        mudancas: areaName ? `${mudancasFormatadas}\nÁrea: ${areaName}` : mudancasFormatadas,
      },
    });
  } catch (error) {
    console.error(`[AUDIT ERROR] Falha ao gravar log para ${listKey}:`, error);
  }
};

// 🔹 Função auxiliar para deixar valores legíveis
function formatarValor(valor: any) {
  if (valor === null || valor === undefined) return 'vazio';

  // 🔹 Campo Document do Keystone
  if (Array.isArray(valor) && valor[0]?.type) {
    return extrairTextoDocument(valor);
  }

  // 🔹 Relationship
  if (typeof valor === 'object') {
    if (valor?.id) return `ID: ${valor.id}`;
    return '[objeto]';
  }

  return valor.toString();
}

// 🔥 Extrai texto real do campo document
function extrairTextoDocument(nodes: any[]): string {
  let texto = '';

  for (const node of nodes) {
    if (node.children) {
      for (const child of node.children) {
        if (child.text) {
          texto += child.text + ' ';
        }
      }
    }
  }

  return texto.trim() || '[sem texto]';
}

/**
 * DEFINIÇÃO DA LISTA DE AUDITORIA
 */
export const AuditLog = list({
   db: { map: 'AuditLogs' },

   graphql: {
     plural: 'auditLogs',
   },

   // Controle de Acesso: Apenas Administradores veem e deletam logs
   access: {
     operation: {
       query: ({ session }) => session?.data?.role === 'admin',
       create: () => true, // Permitido para o sistema gravar os logs
       update: () => false, // Logs nunca devem ser editados
       delete: ({ session }) => session?.data?.role === 'admin',
     },
   },
 
   ui: {
     label: 'Logs de Auditoria',
     singular: 'Log de Auditoria',
     plural: 'Logs de Auditoria',
     // Esconde do menu lateral para quem não é Admin
     labelField: 'itemTitulo',
     isHidden: ({ session }) => session?.data?.role !== 'admin',
     listView: {
       initialColumns: [
         'dataAcao',
         'usuario',
         'operacao',
         'tabela',
         'itemTitulo'
       ],
       initialSort: { field: 'dataAcao', direction: 'DESC' },
     },
   },
 
   fields: {
    dataAcao: timestamp({
      label: 'Data e Hora',
      defaultValue: { kind: 'now' },
      ui: {
        createView: { fieldMode: 'hidden' },
        itemView: { fieldMode: 'read' },
      },
    }),

    usuario: text({
      label: 'Usuário (E-mail)',
      ui: { itemView: { fieldMode: 'read' } },
    }),

    operacao: select({
      label: 'Operação',
      options: [
        { label: 'Criação', value: 'CREATE' },
        { label: 'Atualização', value: 'UPDATE' },
        { label: 'Exclusão', value: 'DELETE' },
      ],
      ui: { itemView: { fieldMode: 'read' } },
    }),

    tabela: text({
      label: 'Tabela/Schema',
      ui: { itemView: { fieldMode: 'read' } },
    }),

    itemId: text({
      label: 'ID do Item',
      ui: { itemView: { fieldMode: 'read' } },
    }),

    itemTitulo: text({
      label: 'Título do Item',
      ui: { itemView: { fieldMode: 'read' } },
    }),

    mudancas: text({
        label: 'O que foi alterado (De -> Para)',
        ui: {
          displayMode: 'textarea',
          itemView: { fieldMode: 'read' },
        },
      }),
  },
});
