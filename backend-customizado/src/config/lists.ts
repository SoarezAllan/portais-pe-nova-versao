import { prisma } from '../prisma.js';

/**
 * Mapeia cada lista GraphQL (Keystone) para o delegate Prisma correspondente.
 * Lista as chaves de relação (para resolver campos aninhados) e campos de imagem.
 * `prismaDelegate` é tipado como any para flexibilidade com o client gerado.
 */
export interface ListConfig {
  /** Nome do tipo GraphQL (ex.: Servico) */
  type: string;
  /** Nome do campo query singular (ex.: servico) */
  item: string;
  /** Nome do campo query plural (ex.: servicos) */
  list: string;
  /** Nome do campo de contagem (ex.: servicosCount) */
  count: string;
  /** Nome do delegate Prisma (ex.: servico) */
  prisma: string;
  /** Campos de relação "to-one" resolvidos automaticamente */
  relations: Record<string, string>;
  /** Campos muitos-para-muitos / to-many (campo GraphQL -> modelo Prisma) */
  manyRelations: Record<string, string>;
  /** Campos de imagem (campo GraphQL -> colunas _id do Prisma) */
  imageFields: Record<string, string>;
  /** Campos Document (JSON) que retornam objeto com .document() */
  documentFields: string[];
}

const lists: Record<string, ListConfig> = {
  user: {
    type: 'User',
    item: 'user',
    list: 'users',
    count: 'usersCount',
    prisma: 'user',
    relations: {},
    manyRelations: { noticias: 'noticia', areas: 'areaResponsavel' },
    imageFields: {},
    documentFields: [],
  },
  auditLog: {
    type: 'AuditLog',
    item: 'auditLog',
    list: 'auditLogs',
    count: 'auditLogsCount',
    prisma: 'auditLog',
    relations: {},
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
  servico: {
    type: 'Servico',
    item: 'servico',
    list: 'servicos',
    count: 'servicosCount',
    prisma: 'servico',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: {},
    imageFields: { imagem: 'imagem' },
    documentFields: ['oQueE', 'quemPrecisa', 'comoSolicitar', 'maisInformacoes'],
  },
  solucao: {
    type: 'Solucao',
    item: 'solucao',
    list: 'solucoes',
    count: 'solucoesCount',
    prisma: 'solucao',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: {},
    imageFields: { imagem: 'imagem' },
    documentFields: ['corpo'],
  },
  noticia: {
    type: 'Noticia',
    item: 'noticia',
    list: 'noticias',
    count: 'noticiasCount',
    prisma: 'noticia',
    relations: { autor: 'autor', areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: { tags: 'tag' },
    imageFields: { imagemPrincipal: 'imagemPrincipal' },
    documentFields: ['corpo'],
  },
  legislacao: {
    type: 'Legislacao',
    item: 'legislacao',
    list: 'legislacoes',
    count: 'legislacoesCount',
    prisma: 'legislacao',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
  curso: {
    type: 'Curso',
    item: 'curso',
    list: 'cursos',
    count: 'cursosCount',
    prisma: 'curso',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
  tag: {
    type: 'Tag',
    item: 'tag',
    list: 'tags',
    count: 'tagsCount',
    prisma: 'tag',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: { noticias: 'noticia' },
    imageFields: {},
    documentFields: [],
  },
  areaResponsavel: {
    type: 'AreaResponsavel',
    item: 'areaResponsavel',
    list: 'areas',
    count: 'areasCount',
    prisma: 'areaResponsavel',
    relations: {},
    manyRelations: {
      subareas: 'subarea',
      gerencias: 'gerencia',
      servicos: 'servico',
      cursos: 'curso',
      solucoes: 'solucao',
      noticias: 'noticia',
      tags: 'tag',
      legislacoes: 'legislacao',
      gestores: 'gestores',
      paginasQuemSomos: 'paginaQuemSomos',
    },
    imageFields: {},
    documentFields: [],
  },
  gerencia: {
    type: 'Gerencia',
    item: 'gerencia',
    list: 'gerencias',
    count: 'gerenciasCount',
    prisma: 'gerencia',
    relations: { area: 'area' },
    manyRelations: { setores: 'setor' },
    imageFields: {},
    documentFields: [],
  },
  setor: {
    type: 'Setor',
    item: 'setor',
    list: 'setores',
    count: 'setoresCount',
    prisma: 'setor',
    relations: { gerencia: 'gerencia' },
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
  subarea: {
    type: 'Subarea',
    item: 'subarea',
    list: 'subareas',
    count: 'subareasCount',
    prisma: 'subarea',
    relations: { area: 'area' },
    manyRelations: {
      servicos: 'servico',
      cursos: 'curso',
      noticias: 'noticia',
      legislacoes: 'legislacao',
      solucoes: 'solucao',
      tags: 'tag',
    },
    imageFields: {},
    documentFields: [],
  },
  gestores: {
    type: 'Gestores',
    item: 'gestores',
    list: 'gestores',
    count: 'gestoresCount',
    prisma: 'gestores',
    relations: { areaResponsavel: 'areaResponsavel' },
    manyRelations: {},
    imageFields: { foto: 'foto' },
    documentFields: [],
  },
  paginaQuemSomos: {
    type: 'PaginaQuemSomos',
    item: 'paginaQuemSomos',
    list: 'paginasQuemSomos',
    count: 'paginasQuemSomosCount',
    prisma: 'paginaQuemSomos',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: {
      muralItens: 'quemSomosMuralItem',
      conteudosPorSubarea: 'quemSomosSubareaItem',
      time: 'quemSomosTimeItem',
    },
    imageFields: {},
    documentFields: [],
  },
  quemSomosMuralItem: {
    type: 'QuemSomosMuralItem',
    item: 'quemSomosMuralItem',
    list: 'quemSomosMuralItens',
    count: 'quemSomosMuralItensCount',
    prisma: 'quemSomosMuralItem',
    relations: { pagina: 'pagina' },
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
  quemSomosTimeItem: {
    type: 'QuemSomosTimeItem',
    item: 'quemSomosTimeItem',
    list: 'quemSomosTimeItens',
    count: 'quemSomosTimeItensCount',
    prisma: 'quemSomosTimeItem',
    relations: { pagina: 'pagina' },
    manyRelations: {},
    imageFields: { foto: 'foto' },
    documentFields: [],
  },
  quemSomosSubareaItem: {
    type: 'QuemSomosSubareaItem',
    item: 'quemSomosSubareaItem',
    list: 'quemSomosSubareaItens',
    count: 'quemSomosSubareaItensCount',
    prisma: 'quemSomosSubareaItem',
    relations: { subarea: 'subarea', pagina: 'pagina' },
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
  portfolio: {
    type: 'Portfolio',
    item: 'portfolio',
    list: 'portfolios',
    count: 'portfoliosCount',
    prisma: 'portfolio',
    relations: { areaResponsavel: 'areaResponsavel', subarea: 'subarea' },
    manyRelations: { galeria: 'portfolioImagem' },
    imageFields: { imagem: 'imagem' },
    documentFields: ['corpo'],
  },
  portfolioImagem: {
    type: 'PortfolioImagem',
    item: 'portfolioImagem',
    list: 'portfolioImagens',
    count: 'portfolioImagensCount',
    prisma: 'portfolioImagem',
    relations: { portfolio: 'portfolio' },
    manyRelations: {},
    imageFields: { imagem: 'imagem' },
    documentFields: [],
  },
  acesso: {
    type: 'Acesso',
    item: 'acesso',
    list: 'acessos',
    count: 'acessosCount',
    prisma: 'acesso',
    relations: {},
    manyRelations: {},
    imageFields: {},
    documentFields: [],
  },
};

export function getListConfig(listKey: string): ListConfig | undefined {
  return lists[listKey];
}

export function getDelegate(delegateName: string): any {
  return (prisma as any)[delegateName];
}

export default lists;
