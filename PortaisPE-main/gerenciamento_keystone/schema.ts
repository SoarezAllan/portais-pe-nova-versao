import type { Lists } from '.keystone/types';

import { User } from './schemas_adm/user';
import { AuditLog } from './schemas_adm/AuditLog';

import { Servico } from './schemas/servico';
import { Solucao } from './schemas/solucao';
import { Noticia } from './schemas/noticia';
import { Legislacao } from './schemas/legislacao';
import { Curso } from './schemas/curso';

import { Tag } from './schemas/tag';
import { AreaResponsavel } from './schemas/areaResponsavel';
import { Gerencia } from './schemas/gerencia';
import { Setor } from './schemas/setor';

import { Gestores } from './schemas/gestores';

import {
  PaginaQuemSomos,
  QuemSomosMuralItem,
  QuemSomosTimeItem,
  QuemSomosSubareaItem,
} from './schemas/quem_somos';

import { Subarea } from './schemas/subarea';
import { Portfolio } from './schemas/portifolio';
import { PortfolioImagem } from './schemas/portfolioImagem';
import { Acesso } from './schemas/acesso';

// ==============================
// ACESSO
// ==============================

const isAdmin = ({ session }: any) =>
  session?.data?.role === 'admin';

const isOperator = ({ session }: any) =>
  session?.data?.role === 'operator';

const isOperatorOrAdmin = ({ session }: any) =>
  isAdmin({ session }) || isOperator({ session });

const operatorAllowedLists = [
  'Servico',
  'Legislacao',
  'Curso',
  'Noticia',
  'Solucao',
  'PaginaQuemSomos',
];

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
];

const listsWithDeletedAt = ['Servico', 'AreaResponsavel'];

// ==============================
function getAreaFilters(listKey: string, areaIds: string[]) {
  const filters: any[] = [];

  if (areaIds.length) {
    if (listKey === 'AreaResponsavel') {
      filters.push({ id: { in: areaIds } });
    }

    if (
      [
        'Servico',
        'Noticia',
        'Legislacao',
        'Curso',
        'Solucao',
        'PaginaQuemSomos',
      ].includes(listKey)
    ) {
      filters.push({
        areaResponsavel: { id: { in: areaIds } },
      });
    }

    if (['Gerencia', 'Subarea'].includes(listKey)) {
      filters.push({ area: { id: { in: areaIds } } });
    }

    if (['Setor', 'Gestores'].includes(listKey)) {
      filters.push({
        gerencia: { area: { id: { in: areaIds } } },
      });

      filters.push({
        subarea: { area: { id: { in: areaIds } } },
      });
    }
  }

  return filters;
}

function coerceIdsInFilter(obj: any): any {
  if (obj == null) return obj;
  if (Array.isArray(obj)) return obj.map(coerceIdsInFilter);
  if (typeof obj !== 'object') return obj;

  const out: any = {};

  for (const [k, v] of Object.entries(obj)) {
    if (v == null) {
      out[k] = v;
      continue;
    }

    if (k === 'equals' && (typeof v === 'number' || typeof v === 'bigint')) {
      out[k] = String(v);
    } else if (k === 'in' && Array.isArray(v)) {
      out[k] = v.map((x) => (x == null ? x : String(x)));
    } else if (typeof v === 'object') {
      out[k] = coerceIdsInFilter(v);
    } else {
      out[k] = v;
    }
  }

  return out;
}

// Listas que, para operadores, só ficam visíveis/acessíveis quando o
// operador pertence à área "Engenharia e Arquitetura".
const engenhariaOnlyLists = ['Portfolio', 'PortfolioImagem'];

// Listas ocultas do menu lateral para operadores (não gerenciam como lista
// própria), mas que continuam com LEITURA liberada, pois são vinculadas via
// campos de relacionamento em PaginaQuemSomos (ex: selecionar um item de
// Mural já cadastrado). Operador não pode criar/editar/apagar itens dessas
// listas diretamente - isso fica restrito a admin.
const hiddenButLinkableLists = [
  'QuemSomosMuralItem',
  'QuemSomosTimeItem',
  'QuemSomosSubareaItem',
];

function operatorHasEngenharia(session: any) {
  const areas = session?.data?.areas || [];
  return areas.some((a: any) => a?.nome === 'Engenharia e Arquitetura');
}

function applyAccessControl(listKey: string, listConfig: any) {
  const operatorCanAccess = operatorAllowedLists.includes(listKey);
  const isEngenhariaOnlyList = engenhariaOnlyLists.includes(listKey);

  const existingAccess = listConfig.access || {};
  const existingOperation = existingAccess.operation || {};
  const existingFilter = existingAccess.filter || {};

  // Para as listas restritas a Engenharia e Arquitetura, o operador só
  // pode criar/editar/apagar quando pertence a essa área; caso contrário,
  // somente admin.
  const engenhariaAwareOperatorCheck = ({ session }: any) => {
    if (isAdmin({ session })) return true;
    if (isOperator({ session })) return operatorHasEngenharia(session);
    return false;
  };

  const isHiddenButLinkableList = hiddenButLinkableLists.includes(listKey);

  const operation = {
    query: existingOperation.query ?? (() => true),
    create:
      existingOperation.create ??
      (isEngenhariaOnlyList
        ? engenhariaAwareOperatorCheck
        : isHiddenButLinkableList
        ? isAdmin
        : operatorCanAccess
        ? isOperatorOrAdmin
        : isAdmin),
    update:
      existingOperation.update ??
      (isEngenhariaOnlyList
        ? engenhariaAwareOperatorCheck
        : isHiddenButLinkableList
        ? isAdmin
        : operatorCanAccess
        ? isOperatorOrAdmin
        : isAdmin),
    delete:
      existingOperation.delete ??
      (isEngenhariaOnlyList
        ? engenhariaAwareOperatorCheck
        : isHiddenButLinkableList
        ? isAdmin
        : operatorCanAccess
        ? isOperatorOrAdmin
        : isAdmin),
  };

  const baseFilter =
    existingFilter.query ??
    ((ctx: any) => {
      const session = ctx?.session;

      const req = ctx?.req || ctx?.request;
      const isFrontendRequest = !!(
        req?.headers?.['x-site-area'] ||
        req?.headers?.['x-site-area'.toLowerCase()]
      );

      if (!session) return {};

      if (isAdmin({ session })) return {};

      if (isOperator({ session }) && isFrontendRequest) return {};

      if (!isOperator({ session })) return { id: { in: [] } };

      if (listKey === 'User') {
        const userId = session.itemId || session.data?.id;
        return userId ? { id: { equals: String(userId) } } : {};
      }

      if (isEngenhariaOnlyList) {
        return operatorHasEngenharia(session) ? {} : { id: { in: [] } };
      }

      if (isHiddenButLinkableList) {
        return {};
      }

      const areas = session.data?.areas || [];
      const areaIds = areas
        .map((a: any) => (a?.id != null ? String(a.id) : null))
        .filter(Boolean);

      if (!areaFilteredLists.includes(listKey)) {
        return operatorCanAccess ? {} : { id: { in: [] } };
      }

      const hasDeletedAt = listsWithDeletedAt.includes(listKey);
      const orFilters = getAreaFilters(listKey, areaIds);

      if (orFilters.length) {
        const base = { OR: orFilters };
        return hasDeletedAt
          ? { AND: [{ deletedAt: { equals: null } }, base] }
          : base;
      }

      return { id: { in: [] } };
    });

  const filterQuery = (ctx: any) => {
    try {
      return coerceIdsInFilter(baseFilter(ctx));
    } catch {
      return baseFilter(ctx);
    }
  };

  return {
    ...listConfig,
    access: {
      operation,
      filter: { query: filterQuery },
    },
    ui: {
      ...listConfig.ui,
      isHidden: ({ session }: any) => {
        if (!session) return true;
        if (isAdmin({ session })) return false;
        if (isOperator({ session })) {
          if (isEngenhariaOnlyList) {
            return !operatorHasEngenharia(session);
          }
          if (isHiddenButLinkableList) {
            return true;
          }
          return !operatorCanAccess;
        }
        return true;
      },
    },
  };
}

// ==============================
// LISTS REAIS
// ==============================
const rawLists = {
  User,
  AuditLog,

  Servico,
  Solucao,
  Noticia,
  Legislacao,
  Curso,

  Tag,
  AreaResponsavel,
  Gerencia,
  Setor,
  Subarea,

  Gestores,

  PaginaQuemSomos,
  QuemSomosMuralItem,
  QuemSomosTimeItem,
  QuemSomosSubareaItem,

  Portfolio,
  PortfolioImagem,

  Acesso,

};


// ==============================
export const lists: Lists = Object.fromEntries(
  Object.entries(rawLists).map(([key, value]) => [
    key,
    applyAccessControl(key, value),
  ])
) as Lists;