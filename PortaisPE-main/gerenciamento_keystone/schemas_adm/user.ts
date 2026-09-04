// schemas_adm/user.ts
import { list } from '@keystone-6/core';
import { text, password, select, relationship, timestamp } from '@keystone-6/core/fields';

export const User = list({
   access: {
     operation: {
       query: () => true,
       create: () => true,
       update: () => true,
       delete: () => true,
     },
   },

   graphql: {
     plural: 'users',
   },

   hooks: {
     validateInput: async ({ resolvedData, addValidationError, operation, context }) => {
       if (operation === 'create') {
         const role = resolvedData.role || 'operator';
         const areas = resolvedData.areas;
 
         // Exigir associação apenas para operadores (role === 'operator')
         if (role === 'operator') {
           // Extrai ids possíveis do resolvedData (suporta { connect: [{ id }] } ou array)
           let areaIds: string[] = [];
           if (!areas) {
             areaIds = [];
           } else if (Array.isArray(areas)) {
             areaIds = areas.map((a: any) => (typeof a === 'string' ? a : a?.id != null ? String(a.id) : a)).filter(Boolean);
           } else if (areas.connect && Array.isArray(areas.connect)) {
             areaIds = areas.connect.map((c: any) => (c?.id != null ? String(c.id) : c)).filter(Boolean);
           } else if (areas.connect && typeof areas.connect === 'object' && areas.connect.id) {
             areaIds = [String(areas.connect.id)];
           }
 
           if (areaIds.length === 0) {
             addValidationError('Usuários com função "Operador" devem ter ao menos uma área atribuída.');
             return;
           }
 
           // Verifica se as áreas existem e pertencem ao conjunto permitido
           const allowed = [
             'Patrimônio',
             'Engenharia e Arquitetura',
             'Serviços Corporativos',
           ];
 
           const found = await context.sudo().db.AreaResponsavel.findMany({ where: { id: { in: areaIds } } });
           const notFoundIds = areaIds.filter((id) => !found.find((f: any) => f.id === id));
           if (notFoundIds.length) {
             addValidationError(`Áreas não encontradas: ${notFoundIds.join(', ')}`);
             return;
           }
 
           const invalidNames = found.filter((f: any) => !allowed.includes(f.nome)).map((f: any) => f.nome);
           if (invalidNames.length) {
             addValidationError(`Apenas as áreas permitidas podem ser atribuídas a operadores: ${allowed.join(' | ')}. Encontrado: ${invalidNames.join(', ')}`);
             return;
           }
         }
       }
     },
   },
   ui: {
     label: 'Usuarios',
     singular: 'Usuario',
     plural: 'Usuarios',
     labelField: 'name',
     listView: {
       initialColumns: ['name', 'email', 'role', 'areas'],
       initialSort: { field: 'name', direction: 'ASC' },
     },
   },
   fields: {
    name: text({ validation: { isRequired: true } }),
    email: text({ validation: { isRequired: true }, isIndexed: 'unique' }),
    password: password({ validation: { isRequired: true } }),
    role: select({
      options: [
        { label: 'Administrador', value: 'admin' },
        { label: 'Operador', value: 'operator' },
      ],
      defaultValue: 'operator',
    }),
    resetCode: text(),
    passwordResetToken: text(),
    passwordResetIssuedAt: timestamp(),
    passwordResetRedeemedAt: timestamp(),
    createdAt: timestamp(),
    noticias: relationship({ ref: 'Noticia.autor', many: true }),
    areas: relationship({ ref: 'AreaResponsavel', many: true }),
  },
});
