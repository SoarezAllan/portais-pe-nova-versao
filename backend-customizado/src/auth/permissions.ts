import type { SessionData } from './session.js';

/**
 * Porta do controle de acesso do Keystone (schemas_adm/user.ts + schema.ts).
 * Comporta Admin (acesso total) e Operador (filtrado por areaResponsavel).
 */

export function isAdmin(session: SessionData | null): boolean {
  return session?.data?.role === 'admin';
}

export function isOperator(session: SessionData | null): boolean {
  return session?.data?.role === 'operator';
}

export function isOperatorOrAdmin(session: SessionData | null): boolean {
  return isAdmin(session) || isOperator(session);
}

export function getAreaIds(session: SessionData | null): string[] {
  if (!session) return [];
  const areas = session.data?.areas || [];
  return areas.map((a) => a?.id).filter(Boolean) as string[];
}

/** Listas que o operador pode acessar (criar/editar/apagar). */
const operatorAllowedLists = [
  'Servico',
  'Legislacao',
  'Curso',
  'Noticia',
  'Solucao',
  'PaginaQuemSomos',
  'Acesso',
];

/** Listas que são filtradas por área para operadores. */
const areaFilteredLists = [
  'AreaResponsavel',
  'Servico',
  'Noticia',
  'Legislacao',
  'Curso',
  'Solucao',
  'Gerencia',
  'Setor',
  'Subarea',
  'Gestores',
  'PaginaQuemSomos',
  'Acesso',
];

/** Listas com soft-delete (deletedAt). */
const listsWithDeletedAt = ['Servico', 'AreaResponsavel'];

/** Listas restritas a Engenharia e Arquitetura. */
const engenhariaOnlyLists = ['Portfolio', 'PortfolioImagem'];

/** Listas ocultas mas vinculáveis para operadores. */
const hiddenButLinkableLists = [
  'QuemSomosMuralItem',
  'QuemSomosTimeItem',
  'QuemSomosSubareaItem',
];

export function operatorHasEngenharia(session: SessionData | null): boolean {
  const areas = session?.data?.areas || [];
  return areas.some((a) => a?.nome === 'Engenharia e Arquitetura');
}

export function canAccessList(listKey: string, session: SessionData | null): boolean {
  if (isAdmin(session)) return true;
  if (!isOperator(session)) return false;

  if (engenhariaOnlyLists.includes(listKey)) {
    return operatorHasEngenharia(session);
  }
  if (hiddenButLinkableLists.includes(listKey)) {
    return false;
  }
  return operatorAllowedLists.includes(listKey);
}

export function canCreateUpdate(listKey: string, session: SessionData | null): boolean {
  if (listKey === 'Acesso') return true; // Permite registro de visualização por portais
  if (isAdmin(session)) return true;
  if (!isOperator(session)) return false;

  if (engenhariaOnlyLists.includes(listKey)) {
    return operatorHasEngenharia(session);
  }
  if (hiddenButLinkableLists.includes(listKey)) {
    return false;
  }
  return operatorAllowedLists.includes(listKey);
}

export function canDelete(listKey: string, session: SessionData | null): boolean {
  if (isAdmin(session)) return true;
  if (!isOperator(session)) return false;
  if (engenhariaOnlyLists.includes(listKey)) {
    return operatorHasEngenharia(session);
  }
  if (hiddenButLinkableLists.includes(listKey)) {
    return false;
  }
  return operatorAllowedLists.includes(listKey);
}

/**
 * Retorna o filtro Prisma (where) que deve ser aplicado a uma query de listagem
 * para respeitar o perfil do usuário. Admin => {} (sem filtro). Operador => filtro por área.
 */
export function buildListFilter(
  listKey: string,
  session: SessionData | null,
  isFrontendRequest = false
): Record<string, any> {
  if (isAdmin(session)) return {};

  if (!session) {
    // Listas públicas acessadas pelos portais e selects de formulários públicos
    const publicLists = [
      'AreaResponsavel',
      'Subarea',
      'Servico',
      'Noticia',
      'Legislacao',
      'Curso',
      'Solucao',
      'Tag',
      'Gestores',
      'PaginaQuemSomos',
      'QuemSomosMuralItem',
      'QuemSomosTimeItem',
      'QuemSomosSubareaItem',
      'Portfolio',
      'PortfolioImagem',
      'Acesso',
    ];
    if (publicLists.includes(listKey)) {
      return {};
    }
    return { id: { in: [] } };
  }

  if (isOperator(session) && isFrontendRequest) return {};

  if (!isOperator(session)) return { id: { in: [] } };

  if (listKey === 'User') {
    return { id: { equals: session.data.id } };
  }

  if (engenhariaOnlyLists.includes(listKey)) {
    return operatorHasEngenharia(session) ? {} : { id: { in: [] } };
  }

  if (hiddenButLinkableLists.includes(listKey)) {
    return {};
  }

  const areaIds = getAreaIds(session);
  if (!areaFilteredLists.includes(listKey)) {
    return canAccessList(listKey, session) ? {} : { id: { in: [] } };
  }

  const filters: any[] = [];

  if (areaIds.length) {
    if (listKey === 'AreaResponsavel') {
      filters.push({ id: { in: areaIds } });
    }
    if (
      ['Servico', 'Noticia', 'Legislacao', 'Curso', 'Solucao', 'PaginaQuemSomos'].includes(
        listKey
      )
    ) {
      filters.push({ areaResponsavel: { id: { in: areaIds } } });
    }
    if (listKey === 'Acesso') {
      const areaNames = (session.data?.areas || []).map((a) => a?.nome).filter(Boolean);
      filters.push({
        OR: [
          { area: { in: [...areaIds, ...areaNames] } },
          { portal: { in: [...areaIds, ...areaNames] } },
        ],
      });
    }
    if (['Gerencia', 'Subarea'].includes(listKey)) {
      filters.push({ area: { id: { in: areaIds } } });
    }
    if (['Setor', 'Gestores'].includes(listKey)) {
      filters.push({ gerencia: { area: { id: { in: areaIds } } } });
      filters.push({ subarea: { area: { id: { in: areaIds } } } });
    }
  }

  if (filters.length) {
    const base = { OR: filters };
    return listsWithDeletedAt.includes(listKey)
      ? { AND: [{ deletedAt: { equals: null } }, base] }
      : base;
  }

  return { id: { in: [] } };
}

/**
 * Filtro de exclusão: admin vê tudo, operador vê só itens de suas áreas.
 */
export function buildDeleteFilter(
  listKey: string,
  session: SessionData | null
): Record<string, any> | true {
  if (isAdmin(session)) return true;
  const areaIds = getAreaIds(session);
  if (!areaIds.length) return { id: { in: [] } };

if (listKey === 'Servico') {
    return { areaResponsavel: { id: { in: areaIds } } };
  }
  return { id: { in: [] } };
}
