/**
 * 🛡️ Helpers de Permissão de Exclusão por Área
 *
 * Permite que operadores excluam itens apenas de suas próprias áreas,
 * enquanto admins podem excluir qualquer item.
 *
 * Como usar no Keystone 6:
 *
 *   access: {
 *     operation: {
 *       delete: canDeleteOperation,    // Permissão genérica para tentar excluir
 *     },
 *     filter: {
 *       delete: canDeleteFilter,       // Filtro para restringir quais itens podem ser excluídos
 *     },
 *   },
 *
 * O access.filter.delete retorna:
 *   - true → admin (pode ver/tudo)
 *   - { areaResponsavel: { id: { in: [...] } } } → operador (só itens de suas áreas)
 *
 * O access.operation.delete retorna:
 *   - true se o usuário está autenticado e tem áreas (ou é admin)
 *   - false se não tem áreas
 */
import { BaseListTypeInfo } from '@keystone-6/core/types';

/**
 * Verifica se o usuário pode tentar excluir algum item (permissão genérica).
 */
export function canDeleteOperation({ session }: { session?: any }): boolean {
  if (!session) return false;
  if (session.data?.role === 'admin') return true;

  // Operador precisa ter pelo menos uma área vinculada
  const userAreas = session.data?.areas;
  if (!userAreas || !Array.isArray(userAreas) || userAreas.length === 0) {
    return false;
  }

  return true;
}

/**
 * Filtro de exclusão: admin vê tudo, operador vê só itens de suas áreas.
 * Para schemas que têm areaResponsavel diretamente.
 */
export function canDeleteFilter({ session }: { session?: any }) {
  if (!session) return false;
  if (session.data?.role === 'admin') return true;

  const userAreas = session.data?.areas;
  if (!userAreas || !Array.isArray(userAreas) || userAreas.length === 0) {
    return false;
  }

  const userAreaIds = userAreas.map((a: any) => a.id).filter(Boolean);
  if (userAreaIds.length === 0) return false;

  // Filtra por areaResponsavel (campo direto na tabela)
  return {
    areaResponsavel: {
      id: { in: userAreaIds },
    },
  };
}

/**
 * Filtro de exclusão alternativo para schemas que usam subarea.area
 * como único campo de relação (ex: alguns schemas específicos).
 * Caso precise, use este filter.
 */
export function canDeleteFilterBySubarea({ session }: { session?: any }) {
  if (!session) return false;
  if (session.data?.role === 'admin') return true;

  const userAreas = session.data?.areas;
  if (!userAreas || !Array.isArray(userAreas) || userAreas.length === 0) {
    return false;
  }

  const userAreaIds = userAreas.map((a: any) => a.id).filter(Boolean);
  if (userAreaIds.length === 0) return false;

  return {
    subarea: {
      area: {
        id: { in: userAreaIds },
      },
    },
  };
}
