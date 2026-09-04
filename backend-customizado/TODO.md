# TODO — Migração Keystone 6 → Backend Customizado

## Etapa 1 — Infraestrutura
- [x] Criar `package.json` (Fastify, graphql-yoga, prisma, etc.)
- [x] Criar `tsconfig.json`
- [x] Criar `.env.example`
- [ ] Criar `src/server.ts` (bootstrap)
- [x] Criar `.gitignore`

## Etapa 2 — Prisma
- [x] Reutilizar `schema.prisma`
- [x] Manter migrations existentes

## Etapa 3 — Contexto e Autenticação
- [ ] `src/context.ts`
- [x] `src/auth/session.ts` (cookie JWT HTTP-only)
- [x] `src/auth/password.ts` (bcrypt)
- [x] `src/auth/permissions.ts` (controle de acesso por área)

## Etapa 4 — Schema GraphQL
- [ ] `src/schema/typeDefs.ts`
- [ ] `src/schema/scalars.ts`

## Etapa 5 — Resolvers (CRUD Servico completo)
- [ ] `src/resolvers/servico.ts`
- [ ] `src/resolvers/query.ts`
- [ ] `src/resolvers/mutation.ts`
- [ ] `src/resolvers/index.ts`

## Etapa 6 — Upload de imagens
- [ ] `src/upload.ts`

## Etapa 7 — AuditLog
- [ ] `src/audit/log.ts`

## Etapa 8 — Auth mutations
- [ ] `authenticateUserWithPassword`
- [ ] `endSession`
- [ ] `authenticatedItem`
- [ ] `forgotPassword` / `resetPassword`

## Etapa 9 — Teste e validação
- [ ] `npm install`
- [ ] `prisma generate` + `prisma migrate deploy`
- [ ] Testar servidor na 3001
- [ ] Validar com frontend
</content>

