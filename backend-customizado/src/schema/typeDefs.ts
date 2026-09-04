import { gql } from 'graphql-tag';

export const typeDefs = gql`
  scalar DateTime
  scalar JSON
  scalar Upload

  type User {
    id: ID!
    name: String
    email: String
    password: PasswordState
    role: String
    resetCode: String
    passwordResetToken: PasswordState
    passwordResetIssuedAt: DateTime
    passwordResetRedeemedAt: DateTime
    createdAt: DateTime
    noticias(where: NoticiaWhereInput! = {}, orderBy: [NoticiaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: NoticiaWhereUniqueInput): [Noticia!]
    noticiasCount(where: NoticiaWhereInput! = {}): Int
    areas(where: AreaResponsavelWhereInput! = {}, orderBy: [AreaResponsavelOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: AreaResponsavelWhereUniqueInput): [AreaResponsavel!]
    areasCount(where: AreaResponsavelWhereInput! = {}): Int
  }

  type PasswordState {
    isSet: Boolean!
  }

  type ImageFieldOutput {
    id: ID!
    filesize: Int!
    width: Int!
    height: Int!
    extension: ImageExtension!
    url: String!
  }

  enum ImageExtension {
    jpg
    png
    webp
    gif
  }

  type AuditLog {
    id: ID!
    dataAcao: DateTime
    usuario: String
    operacao: String
    tabela: String
    itemId: String
    itemTitulo: String
    mudancas: String
  }

  type Servico {
    id: ID!
    titulo: String
    slug: String
    imagem: ImageFieldOutput
    imagemAlt: String
    resumo: String
    oQueE: Servico_oQueE_Document
    quemPrecisa: Servico_quemPrecisa_Document
    comoSolicitar: Servico_comoSolicitar_Document
    maisInformacoes: Servico_maisInformacoes_Document
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
    deletedAt: DateTime
    deletedBy: String
  }

  type Servico_oQueE_Document { document(hydrateRelationships: Boolean! = false): JSON! }
  type Servico_quemPrecisa_Document { document(hydrateRelationships: Boolean! = false): JSON! }
  type Servico_comoSolicitar_Document { document(hydrateRelationships: Boolean! = false): JSON! }
  type Servico_maisInformacoes_Document { document(hydrateRelationships: Boolean! = false): JSON! }

  type Solucao {
    id: ID!
    titulo: String
    slug: String
    categoria: String
    imagem: ImageFieldOutput
    imagemAlt: String
    resumo: String
    corpo: Solucao_corpo_Document
    linkExterno: String
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Solucao_corpo_Document { document(hydrateRelationships: Boolean! = false): JSON! }

  type Noticia {
    id: ID!
    titulo: String
    subtitulo: String
    autor: User
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    dataPublicacao: DateTime
    imagemPrincipal: ImageFieldOutput
    imagemPrincipalAlt: String
    corpo: Noticia_corpo_Document
    tags(where: TagWhereInput! = {}, orderBy: [TagOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: TagWhereUniqueInput): [Tag!]
    tagsCount(where: TagWhereInput! = {}): Int
    destaque: Boolean
    resumo: String
    slug: String
  }

  type Noticia_corpo_Document { document(hydrateRelationships: Boolean! = false): JSON! }

  type Legislacao {
    id: ID!
    titulo: String
    linkExterno: String
    categoria: String
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    resumo: String
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Curso {
    id: ID!
    titulo: String
    status: String
    resumo: String
    linkExterno: String
    dataDoCurso: DateTime
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    modalidade: String
    local: String
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Tag {
    id: ID!
    nome: String
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    noticias(where: NoticiaWhereInput! = {}, orderBy: [NoticiaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: NoticiaWhereUniqueInput): [Noticia!]
    noticiasCount(where: NoticiaWhereInput! = {}): Int
  }

  type AreaResponsavel {
    id: ID!
    nome: String
    subareas(where: SubareaWhereInput! = {}, orderBy: [SubareaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SubareaWhereUniqueInput): [Subarea!]
    subareasCount(where: SubareaWhereInput! = {}): Int
    gerencias(where: GerenciaWhereInput! = {}, orderBy: [GerenciaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: GerenciaWhereUniqueInput): [Gerencia!]
    gerenciasCount(where: GerenciaWhereInput! = {}): Int
    servicos(where: ServicoWhereInput! = {}, orderBy: [ServicoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: ServicoWhereUniqueInput): [Servico!]
    servicosCount(where: ServicoWhereInput! = {}): Int
    cursos(where: CursoWhereInput! = {}, orderBy: [CursoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: CursoWhereUniqueInput): [Curso!]
    cursosCount(where: CursoWhereInput! = {}): Int
    solucoes(where: SolucaoWhereInput! = {}, orderBy: [SolucaoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SolucaoWhereUniqueInput): [Solucao!]
    solucoesCount(where: SolucaoWhereInput! = {}): Int
    noticias(where: NoticiaWhereInput! = {}, orderBy: [NoticiaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: NoticiaWhereUniqueInput): [Noticia!]
    noticiasCount(where: NoticiaWhereInput! = {}): Int
    tags(where: TagWhereInput! = {}, orderBy: [TagOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: TagWhereUniqueInput): [Tag!]
    tagsCount(where: TagWhereInput! = {}): Int
    legislacoes(where: LegislacaoWhereInput! = {}, orderBy: [LegislacaoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: LegislacaoWhereUniqueInput): [Legislacao!]
    legislacoesCount(where: LegislacaoWhereInput! = {}): Int
    gestores(where: GestoresWhereInput! = {}, orderBy: [GestoresOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: GestoresWhereUniqueInput): [Gestores!]
    gestoresCount(where: GestoresWhereInput! = {}): Int
    paginasQuemSomos(where: PaginaQuemSomosWhereInput! = {}, orderBy: [PaginaQuemSomosOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: PaginaQuemSomosWhereUniqueInput): [PaginaQuemSomos!]
    paginasQuemSomosCount(where: PaginaQuemSomosWhereInput! = {}): Int
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
    deletedAt: DateTime
    deletedBy: String
  }

  type Gerencia {
    id: ID!
    nome: String
    responsavel: String
    telefone1: String
    telefone2: String
    email: String
    area: AreaResponsavel
    setores(where: SetorWhereInput! = {}, orderBy: [SetorOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SetorWhereUniqueInput): [Setor!]
    setoresCount(where: SetorWhereInput! = {}): Int
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Setor {
    id: ID!
    nome: String
    gerencia: Gerencia
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Subarea {
    id: ID!
    nome: String
    area: AreaResponsavel
    servicos(where: ServicoWhereInput! = {}, orderBy: [ServicoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: ServicoWhereUniqueInput): [Servico!]
    servicosCount(where: ServicoWhereInput! = {}): Int
    cursos(where: CursoWhereInput! = {}, orderBy: [CursoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: CursoWhereUniqueInput): [Curso!]
    cursosCount(where: CursoWhereInput! = {}): Int
    noticias(where: NoticiaWhereInput! = {}, orderBy: [NoticiaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: NoticiaWhereUniqueInput): [Noticia!]
    noticiasCount(where: NoticiaWhereInput! = {}): Int
    legislacoes(where: LegislacaoWhereInput! = {}, orderBy: [LegislacaoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: LegislacaoWhereUniqueInput): [Legislacao!]
    legislacoesCount(where: LegislacaoWhereInput! = {}): Int
    solucoes(where: SolucaoWhereInput! = {}, orderBy: [SolucaoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SolucaoWhereUniqueInput): [Solucao!]
    solucoesCount(where: SolucaoWhereInput! = {}): Int
    tags(where: TagWhereInput! = {}, orderBy: [TagOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: TagWhereUniqueInput): [Tag!]
    tagsCount(where: TagWhereInput! = {}): Int
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Gestores {
    id: ID!
    nome: String
    cargo: String
    descricao: String
    foto: ImageFieldOutput
    areaResponsavel: AreaResponsavel
  }

  type PaginaQuemSomos {
    id: ID!
    tituloDaPagina: String
    muralTextoIntrodutorio: String
    timeTitulo: String
    timeDescricao: String
    muralItens(where: QuemSomosMuralItemWhereInput! = {}, orderBy: [QuemSomosMuralItemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: QuemSomosMuralItemWhereUniqueInput): [QuemSomosMuralItem!]
    muralItensCount(where: QuemSomosMuralItemWhereInput! = {}): Int
    conteudosPorSubarea(where: QuemSomosSubareaItemWhereInput! = {}, orderBy: [QuemSomosSubareaItemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: QuemSomosSubareaItemWhereUniqueInput): [QuemSomosSubareaItem!]
    conteudosPorSubareaCount(where: QuemSomosSubareaItemWhereInput! = {}): Int
    time(where: QuemSomosTimeItemWhereInput! = {}, orderBy: [QuemSomosTimeItemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: QuemSomosTimeItemWhereUniqueInput): [QuemSomosTimeItem!]
    timeCount(where: QuemSomosTimeItemWhereInput! = {}): Int
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    createdAt: DateTime
    createdBy: String
  }

  type QuemSomosMuralItem {
    id: ID!
    valor: String
    titulo: String
    descricao: String
    pagina: PaginaQuemSomos
    ativo: Boolean
    createdAt: DateTime
  }

  type QuemSomosTimeItem {
    id: ID!
    nome: String
    cargo: String
    descricao: String
    foto: ImageFieldOutput
    pagina: PaginaQuemSomos
    ativo: Boolean
    createdAt: DateTime
  }

  type QuemSomosSubareaItem {
    id: ID!
    subarea: Subarea
    conteudo: String
    pagina: PaginaQuemSomos
    ativo: Boolean
    createdAt: DateTime
  }

  type Portfolio {
    id: ID!
    titulo: String
    slug: String
    resumo: String
    imagem: ImageFieldOutput
    imagemAlt: String
    galeria(where: PortfolioImagemWhereInput! = {}, orderBy: [PortfolioImagemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: PortfolioImagemWhereUniqueInput): [PortfolioImagem!]
    galeriaCount(where: PortfolioImagemWhereInput! = {}): Int
    corpo: Portfolio_corpo_Document
    areaResponsavel: AreaResponsavel
    subarea: Subarea
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  type Portfolio_corpo_Document { document(hydrateRelationships: Boolean! = false): JSON! }

  type PortfolioImagem {
    id: ID!
    titulo: String
    imagem: ImageFieldOutput
    portfolio: Portfolio
    ativo: Boolean
  }

  type Acesso {
    id: ID!
    portal: String
    tipo: String
    area: String
    usuario: String
    ip: String
    dataAcesso: DateTime
  }
`;

