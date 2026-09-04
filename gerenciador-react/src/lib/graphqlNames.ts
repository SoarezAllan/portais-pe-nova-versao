export interface GraphQLName {
  /** Plural field name as exposed by Keystone (e.g. `servicos`) */
  list: string;
  /** Singular type name (e.g. `Servico`) */
  type: string;
  /** Singular field for `where: { id }` (e.g. `servico`) */
  item: string;
  /** Plural field that returns count (e.g. `servicosCount`) */
  count: string;
  /** Mutation prefix (e.g. `createServico`) */
  create: string;
  update: string;
  /** Base path used by router */
  path: string;
}

// IMPORTANT: These names MUST match the actual Keystone schema (schemas/*.ts).
// Keystone exposes:
//   list:  <graphql.plural>        e.g. servicos, noticias, legislacoes, cursos, paginasQuemSomos
//   item:  <typeCamel>             e.g. servico, noticia, legislacao, curso, paginaQuemSomos
//   count: <graphql.plural>Count   e.g. servicosCount
//   create:<type>Create            e.g. createServico  (mutation returns Servico)
//   update:<type>Update            e.g. updateServico
//   delete:<type>Delete            e.g. deleteServico
export const GRAPHQL_NAMES: Record<string, GraphQLName> = {
  servicos: {
    list: 'servicos',
    type: 'Servico',
    item: 'servico',
    count: 'servicosCount',
    create: 'createServico',
    update: 'updateServico',
    path: '/servicos',
  },
  noticias: {
    list: 'noticias',
    type: 'Noticia',
    item: 'noticia',
    count: 'noticiasCount',
    create: 'createNoticia',
    update: 'updateNoticia',
    path: '/noticias',
  },
  legislacoes: {
    list: 'legislacoes',
    type: 'Legislacao',
    item: 'legislacao',
    count: 'legislacoesCount',
    create: 'createLegislacao',
    update: 'updateLegislacao',
    path: '/legislacao',
  },
  cursos: {
    list: 'cursos',
    type: 'Curso',
    item: 'curso',
    count: 'cursosCount',
    create: 'createCurso',
    update: 'updateCurso',
    path: '/cursos',
  },
  linksUteis: {
    list: 'cursos',
    type: 'Curso',
    item: 'curso',
    count: 'cursosCount',
    create: 'createCurso',
    update: 'updateCurso',
    path: '/links-uteis',
  },
  solucoes: {
    list: 'solucoes',
    type: 'Solucao',
    item: 'solucao',
    count: 'solucoesCount',
    create: 'createSolucao',
    update: 'updateSolucao',
    path: '/solucoes',
  },
  tags: {
    list: 'tags',
    type: 'Tag',
    item: 'tag',
    count: 'tagsCount',
    create: 'createTag',
    update: 'updateTag',
    path: '/tags',
  },
  areas: {
    list: 'areas',
    type: 'AreaResponsavel',
    item: 'areaResponsavel',
    count: 'areasCount',
    create: 'createAreaResponsavel',
    update: 'updateAreaResponsavel',
    path: '/areas',
  },
  gerencias: {
    list: 'gerencias',
    type: 'Gerencia',
    item: 'gerencia',
    count: 'gerenciasCount',
    create: 'createGerencia',
    update: 'updateGerencia',
    path: '/gerencias',
  },
  subareas: {
    list: 'subareas',
    type: 'Subarea',
    item: 'subarea',
    count: 'subareasCount',
    create: 'createSubarea',
    update: 'updateSubarea',
    path: '/subareas',
  },
  setores: {
    list: 'setores',
    type: 'Setor',
    item: 'setor',
    count: 'setoresCount',
    create: 'createSetor',
    update: 'updateSetor',
    path: '/setores',
  },
  gestores: {
    list: 'gestores',
    type: 'Gestores',
    item: 'gestores',
    count: 'gestoresCount',
    create: 'createGestores',
    update: 'updateGestores',
    path: '/equipe',
  },
  equipe: {
    list: 'gestores',
    type: 'Gestores',
    item: 'gestores',
    count: 'gestoresCount',
    create: 'createGestores',
    update: 'updateGestores',
    path: '/equipe',
  },
  usuarios: {
    list: 'users',
    type: 'User',
    item: 'user',
    count: 'usersCount',
    create: 'createUser',
    update: 'updateUser',
    path: '/usuarios',
  },
  auditLogs: {
    list: 'auditLogs',
    type: 'AuditLog',
    item: 'auditLog',
    count: 'auditLogsCount',
    create: 'createAuditLog',
    update: 'updateAuditLog',
    path: '/audit-log',
  },
  portfolios: {
    list: 'portfolios',
    type: 'Portfolio',
    item: 'portfolio',
    count: 'portfoliosCount',
    create: 'createPortfolio',
    update: 'updatePortfolio',
    path: '/portfolio',
  },
  // "Quem Somos" é uma página única armazenada em `PaginaQuemSomos`
  quemSomos: {
    list: 'paginasQuemSomos',
    type: 'PaginaQuemSomos',
    item: 'paginaQuemSomos',
    count: 'paginasQuemSomosCount',
    create: 'createPaginaQuemSomos',
    update: 'updatePaginaQuemSomos',
    path: '/quem-somos',
  },
  acessos: {
    list: 'acessos',
    type: 'Acesso',
    item: 'acesso',
    count: 'acessosCount',
    create: 'createAcesso',
    update: 'updateAcesso',
    path: '/indicadores',
  },
  indicadores: {
    list: 'acessos',
    type: 'Acesso',
    item: 'acesso',
    count: 'acessosCount',
    create: 'createAcesso',
    update: 'updateAcesso',
    path: '/indicadores',
  },
};

