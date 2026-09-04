import { text } from '@keystone-6/core/fields';
import { BaseListTypeInfo } from '@keystone-6/core/types';
import slugify from 'slugify';

/**
 * Função helper para gerar a string do slug.
 * "Meu Post Incrível" -> "meu-post-incrivel"
 */
const generateSlug = (input: string): string => {
  return slugify(input, {
    lower: true,      // Converte para minúsculas
    strict: true,     // Remove caracteres especiais
    remove: /[*+~.()'"!:@]/g, // Regex para remover outros caracteres indesejados
  });
};

/**
 * Esta é a nossa função reutilizável que cria um campo de slug customizado.
 * Ela recebe o nome do campo que servirá de origem (ex: 'title' ou 'name').
 */
export const slugField = (
  sourceField: string
) => {
  // Retornamos um campo 'text' configurado
  return text<BaseListTypeInfo>({
    // Requisito: Ser único no banco de dados
    isIndexed: 'unique',

    // Requisito: Configuração da UI Admin
    ui: {
      // Escondido ao criar (será gerado)
      createView: { fieldMode: 'hidden' },
      // Apenas leitura ao editar (não pode ser alterado manualmente)
      itemView: { fieldMode: 'read' },
    },

    // Requisito: Geração automática via hook
    hooks: {
      /**
       * O resolveInput é executado ANTES que os dados sejam
       * salvos no banco de dados (create ou update).
       */
      resolveInput: ({ resolvedData, operation }) => {
        // 1. Pegamos os dados do campo de origem (ex: o 'title')
        const source = resolvedData[sourceField];

        // 2. Verificamos se o campo de origem foi fornecido ou alterado.
        //    (Em um 'update' onde o 'title' não é mudado, 'source' será undefined)
        if (typeof source === 'string') {
          // 3. Se temos um 'title' novo (no create ou update), geramos um novo slug
          if (operation === 'create' || operation === 'update') {
            return generateSlug(source);
          }
        }

        // 4. Se o 'title' não mudou, retornamos 'undefined'
        //    para dizer ao Keystone: "não altere este campo".
        return undefined;
      },
    },
  });
};