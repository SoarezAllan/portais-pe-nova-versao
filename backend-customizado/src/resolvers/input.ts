/**
 * Converte os inputs Keystone (Create/Update) para o formato Prisma.
 * - RelateToOne: `{ connect: { id } }` -> `{ <field>Id: id }`
 * - RelateToMany: `{ connect: [{ id }] }` -> campos de relação do Prisma
 * - Document (JSON): passa direto
 * - Imagem: `{ upload }` precisa ser resolvido antes (após upload)
 */
export function convertInputData(data: Record<string, any>, listConfig: any): Record<string, any> {
  if (!data) return {};
  const out: Record<string, any> = {};

  const relationToOne = new Set(Object.values(listConfig.relations || {}));
  const imageFields = listConfig.imageFields || {};

  for (const [key, value] of Object.entries(data)) {
    // Pula campos de relação que serão tratados separadamente
    if (relationToOne.has(key)) {
      // Keystone: { connect: { id } } ou { disconnect: true }
      if (value && typeof value === 'object') {
        if (value.connect?.id) {
          out[`${key}Id`] = value.connect.id;
        } else if (value.disconnect === true) {
          out[`${key}Id`] = null;
        }
      }
      continue;
    }

    // Campos de imagem: `imagem: { id: ... }` ou `{ upload: ... }`
    if (imageFields[key]) {
      if (value && typeof value === 'object') {
        if (value.id || value.upload) {
          out[`${key}_id`] = value.id || value.upload;
          out[`${key}_filesize`] = value.filesize ?? value._filesize ?? 0;
          out[`${key}_width`] = value.width ?? value._width ?? 0;
          out[`${key}_height`] = value.height ?? value._height ?? 0;
          out[`${key}_extension`] = value.extension ?? value._extension ?? 'png';
        }
      } else if (typeof value === 'string') {
        out[`${key}_id`] = value;
      } else if (value === null) {
        out[`${key}_id`] = null;
      }
      continue;
    }

    // To-many connect/disconnect (ex.: tags)
    if (value && typeof value === 'object' && (value.connect || value.disconnect || value.set)) {
      const relatedField = key;
      const op = value;
      if (op.connect?.length) {
        out[relatedField] = { connect: op.connect.map((c: any) => ({ id: c.id })) };
      }
      if (op.disconnect?.length) {
        out[relatedField] = { ...out[relatedField], disconnect: op.disconnect.map((c: any) => ({ id: c.id })) };
      }
      if (op.set?.length) {
        out[relatedField] = { ...out[relatedField], set: op.set.map((c: any) => ({ id: c.id })) };
      }
      continue;
    }

    // Campos regulares
    out[key] = value;
  }

  return out;
}

/**
 * Normaliza o campo de relação to-many para Prisma no create/update.
 */
export function handleRelateToMany(data: Record<string, any>, field: string, value: any) {
  if (!value || typeof value !== 'object') return data;
  const ops: any = {};
  if (Array.isArray(value.connect)) ops.connect = value.connect.map((c: any) => ({ id: c.id }));
  if (Array.isArray(value.disconnect)) ops.disconnect = value.disconnect.map((c: any) => ({ id: c.id }));
  if (Array.isArray(value.set)) ops.set = value.set.map((c: any) => ({ id: c.id }));
  if (Array.isArray(value.create)) ops.create = value.create;
  data[field] = ops;
  return data;
}
