/**
 * Converte filtros GraphQL (estilo Keystone) em cláusulas Prisma `where`.
 * Ex.: `{ areaResponsavel: { id: { in: [...] } } }` já é válido para Prisma.
 * Convertemos comparadores de igualdade/negativo para o formato Prisma.
 */
export function convertFilter(input: Record<string, any> | null | undefined): Record<string, any> {
  if (!input) return {};
  const out: Record<string, any> = {};

  for (const [key, value] of Object.entries(input)) {
    if (value === null || value === undefined) continue;

    // Operadores lógicos
    if (key === 'AND' && Array.isArray(value)) {
      out['AND'] = value.map((v) => convertFilter(v));
      continue;
    }
    if (key === 'OR' && Array.isArray(value)) {
      out['OR'] = value.map((v) => convertFilter(v));
      continue;
    }
    if (key === 'NOT' && Array.isArray(value)) {
      out['NOT'] = value.map((v) => convertFilter(v));
      continue;
    }

    // Campos de relação aninhados: valor é um objeto where
    if (isNonPrimitive(value) && !isFilterOperator(value)) {
      out[key] = convertFilter(value);
      continue;
    }

    // Filtros de campo (operadores)
    if (isFilterOperator(value)) {
      out[key] = convertOperators(value);
      continue;
    }

    // Valor direto (ex.: boolean)
    out[key] = value;
  }

  return out;
}

function isNonPrimitive(v: any): boolean {
  return typeof v === 'object' && v !== null && !Array.isArray(v);
}

function isFilterOperator(v: any): boolean {
  if (typeof v !== 'object' || v === null) return false;
  const keys = Object.keys(v);
  return keys.some(
    (k) =>
      ['equals', 'not', 'in', 'notIn', 'lt', 'lte', 'gt', 'gte', 'contains', 'startsWith', 'endsWith', 'mode'].includes(
        k
      )
  );
}

function convertOperators(op: Record<string, any>): Record<string, any> {
  const out: Record<string, any> = {};
  for (const [k, v] of Object.entries(op)) {
    if (k === 'mode') continue; // Prisma mode é 'insensitive' como string, ignorar
    if (k === 'not') {
      out['not'] = isNonPrimitive(v) ? convertFilter(v) : v;
    } else {
      out[k] = v;
    }
  }
  return out;
}
