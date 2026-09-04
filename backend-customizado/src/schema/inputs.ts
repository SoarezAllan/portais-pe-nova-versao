import { gql } from 'graphql-tag';

/**
 * Inputs, filtros, enums e ordenações replicados do schema Keystone.
 * Mantém compatibilidade exata com o GraphQL consumido pelos frontends.
 */
export const inputTypeDefs = gql`
  enum QueryMode {
    default
    insensitive
  }

  enum OrderDirection {
    asc
    desc
  }

  input IDFilter {
    equals: ID
    in: [ID!]
    notIn: [ID!]
    lt: ID
    lte: ID
    gt: ID
    gte: ID
    not: IDFilter
  }

  input StringFilter {
    equals: String
    in: [String!]
    notIn: [String!]
    lt: String
    lte: String
    gt: String
    gte: String
    contains: String
    startsWith: String
    endsWith: String
    mode: QueryMode
    not: NestedStringFilter
  }

  input NestedStringFilter {
    equals: String
    in: [String!]
    notIn: [String!]
    lt: String
    lte: String
    gt: String
    gte: String
    contains: String
    startsWith: String
    endsWith: String
    not: NestedStringFilter
  }

  input StringNullableFilter {
    equals: String
    in: [String!]
    notIn: [String!]
    lt: String
    lte: String
    gt: String
    gte: String
    contains: String
    startsWith: String
    endsWith: String
    mode: QueryMode
    not: StringNullableFilter
  }

  input BooleanFilter {
    equals: Boolean
    not: BooleanFilter
  }

  input DateTimeNullableFilter {
    equals: DateTime
    in: [DateTime!]
    notIn: [DateTime!]
    lt: DateTime
    lte: DateTime
    gt: DateTime
    gte: DateTime
    not: DateTimeNullableFilter
  }

  input DateTimeFilter {
    equals: DateTime
    in: [DateTime!]
    notIn: [DateTime!]
    lt: DateTime
    lte: DateTime
    gt: DateTime
    gte: DateTime
    not: DateTimeFilter
  }

  input PasswordFilter {
    isSet: Boolean!
  }

  input ImageFieldInput {
    upload: Upload
    ref: String
    id: String
    filesize: Int
    width: Int
    height: Int
    extension: String
    url: String
  }

  # ---------- User ----------
  input UserWhereUniqueInput {
    id: ID
    email: String
  }
  input UserWhereInput {
    AND: [UserWhereInput!]
    OR: [UserWhereInput!]
    NOT: [UserWhereInput!]
    id: IDFilter
    name: StringFilter
    email: StringFilter
    role: StringNullableFilter
    resetCode: StringFilter
    passwordResetToken: PasswordFilter
    passwordResetIssuedAt: DateTimeNullableFilter
    passwordResetRedeemedAt: DateTimeNullableFilter
    createdAt: DateTimeNullableFilter
    noticias: NoticiaManyRelationFilter
    areas: AreaResponsavelManyRelationFilter
  }
  input UserOrderByInput {
    id: OrderDirection
    name: OrderDirection
    email: OrderDirection
    role: OrderDirection
    resetCode: OrderDirection
    passwordResetIssuedAt: OrderDirection
    passwordResetRedeemedAt: OrderDirection
    createdAt: OrderDirection
  }
  input UserUpdateInput {
    name: String
    email: String
    password: String
    role: String
    resetCode: String
    passwordResetToken: String
    passwordResetIssuedAt: DateTime
    passwordResetRedeemedAt: DateTime
    createdAt: DateTime
    noticias: NoticiaRelateToManyForUpdateInput
    areas: AreaResponsavelRelateToManyForUpdateInput
  }
  input UserCreateInput {
    name: String
    email: String
    password: String
    role: String
    resetCode: String
    passwordResetToken: String
    passwordResetIssuedAt: DateTime
    passwordResetRedeemedAt: DateTime
    createdAt: DateTime
    noticias: NoticiaRelateToManyForCreateInput
    areas: AreaResponsavelRelateToManyForCreateInput
  }
  input UserUpdateArgs {
    where: UserWhereUniqueInput!
    data: UserUpdateInput!
  }

  # ---------- AuditLog ----------
  input AuditLogWhereUniqueInput {
    id: ID
  }
  input AuditLogWhereInput {
    AND: [AuditLogWhereInput!]
    OR: [AuditLogWhereInput!]
    NOT: [AuditLogWhereInput!]
    id: IDFilter
    dataAcao: DateTimeNullableFilter
    usuario: StringFilter
    operacao: StringNullableFilter
    tabela: StringFilter
    itemId: StringFilter
    itemTitulo: StringFilter
    mudancas: StringFilter
  }
  input AuditLogOrderByInput {
    id: OrderDirection
    dataAcao: OrderDirection
    usuario: OrderDirection
    operacao: OrderDirection
    tabela: OrderDirection
    itemId: OrderDirection
    itemTitulo: OrderDirection
    mudancas: OrderDirection
  }
  input AuditLogUpdateInput {
    dataAcao: DateTime
    usuario: String
    operacao: String
    tabela: String
    itemId: String
    itemTitulo: String
    mudancas: String
  }
  input AuditLogCreateInput {
    dataAcao: DateTime
    usuario: String
    operacao: String
    tabela: String
    itemId: String
    itemTitulo: String
    mudancas: String
  }
  input AuditLogUpdateArgs {
    where: AuditLogWhereUniqueInput!
    data: AuditLogUpdateInput!
  }

  # ---------- Servico ----------
  input ServicoWhereUniqueInput {
    id: ID
    slug: String
  }
  input ServicoWhereInput {
    AND: [ServicoWhereInput!]
    OR: [ServicoWhereInput!]
    NOT: [ServicoWhereInput!]
    id: IDFilter
    titulo: StringFilter
    slug: StringFilter
    imagemAlt: StringFilter
    resumo: StringFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
    deletedAt: DateTimeNullableFilter
    deletedBy: StringFilter
  }
  input ServicoOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    slug: OrderDirection
    imagemAlt: OrderDirection
    resumo: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
    deletedAt: OrderDirection
    deletedBy: OrderDirection
  }
  input ServicoUpdateInput {
    titulo: String
    slug: String
    imagem: ImageFieldInput
    imagemAlt: String
    resumo: String
    oQueE: JSON
    quemPrecisa: JSON
    comoSolicitar: JSON
    maisInformacoes: JSON
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
    deletedAt: DateTime
    deletedBy: String
  }
  input ServicoCreateInput {
    titulo: String
    slug: String
    imagem: ImageFieldInput
    imagemAlt: String
    resumo: String
    oQueE: JSON
    quemPrecisa: JSON
    comoSolicitar: JSON
    maisInformacoes: JSON
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
    deletedAt: DateTime
    deletedBy: String
  }

  # ---------- Solucao ----------
  input SolucaoWhereUniqueInput {
    id: ID
    slug: String
  }
  input SolucaoWhereInput {
    AND: [SolucaoWhereInput!]
    OR: [SolucaoWhereInput!]
    NOT: [SolucaoWhereInput!]
    id: IDFilter
    titulo: StringFilter
    slug: StringFilter
    categoria: StringFilter
    imagemAlt: StringFilter
    resumo: StringFilter
    linkExterno: StringFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input SolucaoOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    slug: OrderDirection
    categoria: OrderDirection
    imagemAlt: OrderDirection
    resumo: OrderDirection
    linkExterno: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input SolucaoUpdateInput {
    titulo: String
    slug: String
    categoria: String
    imagem: ImageFieldInput
    imagemAlt: String
    resumo: String
    corpo: JSON
    linkExterno: String
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input SolucaoCreateInput {
    titulo: String
    slug: String
    categoria: String
    imagem: ImageFieldInput
    imagemAlt: String
    resumo: String
    corpo: JSON
    linkExterno: String
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- Noticia ----------
  input NoticiaWhereUniqueInput {
    id: ID
    slug: String
  }
  input NoticiaWhereInput {
    AND: [NoticiaWhereInput!]
    OR: [NoticiaWhereInput!]
    NOT: [NoticiaWhereInput!]
    id: IDFilter
    titulo: StringFilter
    subtitulo: StringFilter
    autor: UserWhereInput
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    dataPublicacao: DateTimeFilter
    imagemPrincipalAlt: StringFilter
    tags: TagManyRelationFilter
    destaque: BooleanFilter
    resumo: StringFilter
    slug: StringFilter
  }
  input NoticiaOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    subtitulo: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    dataPublicacao: OrderDirection
    imagemPrincipalAlt: OrderDirection
    destaque: OrderDirection
    resumo: OrderDirection
    slug: OrderDirection
  }
  input NoticiaUpdateInput {
    titulo: String
    subtitulo: String
    autor: UserRelateToOneForUpdateInput
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    dataPublicacao: DateTime
    imagemPrincipal: ImageFieldInput
    imagemPrincipalAlt: String
    corpo: JSON
    tags: TagRelateToManyForUpdateInput
    destaque: Boolean
    resumo: String
    slug: String
  }
  input NoticiaCreateInput {
    titulo: String
    subtitulo: String
    autor: UserRelateToOneForCreateInput
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    dataPublicacao: DateTime
    imagemPrincipal: ImageFieldInput
    imagemPrincipalAlt: String
    corpo: JSON
    tags: TagRelateToManyForCreateInput
    destaque: Boolean
    resumo: String
    slug: String
  }

  # ---------- Legislacao ----------
  input LegislacaoWhereUniqueInput {
    id: ID
  }
  input LegislacaoWhereInput {
    AND: [LegislacaoWhereInput!]
    OR: [LegislacaoWhereInput!]
    NOT: [LegislacaoWhereInput!]
    id: IDFilter
    titulo: StringFilter
    linkExterno: StringFilter
    categoria: StringFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    resumo: StringFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input LegislacaoOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    linkExterno: OrderDirection
    categoria: OrderDirection
    resumo: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input LegislacaoUpdateInput {
    titulo: String
    linkExterno: String
    categoria: String
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    resumo: String
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input LegislacaoCreateInput {
    titulo: String
    linkExterno: String
    categoria: String
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    resumo: String
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- Curso ----------
  input CursoWhereUniqueInput {
    id: ID
  }
  input CursoWhereInput {
    AND: [CursoWhereInput!]
    OR: [CursoWhereInput!]
    NOT: [CursoWhereInput!]
    id: IDFilter
    titulo: StringFilter
    status: StringFilter
    resumo: StringFilter
    linkExterno: StringFilter
    dataDoCurso: DateTimeFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    modalidade: StringFilter
    local: StringFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input CursoOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    status: OrderDirection
    resumo: OrderDirection
    linkExterno: OrderDirection
    dataDoCurso: OrderDirection
    modalidade: OrderDirection
    local: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input CursoUpdateInput {
    titulo: String
    status: String
    resumo: String
    linkExterno: String
    dataDoCurso: DateTime
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    modalidade: String
    local: String
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input CursoCreateInput {
    titulo: String
    status: String
    resumo: String
    linkExterno: String
    dataDoCurso: DateTime
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    modalidade: String
    local: String
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- Tag ----------
  input TagWhereUniqueInput {
    id: ID
    nome: String
  }
  input TagWhereInput {
    AND: [TagWhereInput!]
    OR: [TagWhereInput!]
    NOT: [TagWhereInput!]
    id: IDFilter
    nome: StringFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    noticias: NoticiaManyRelationFilter
  }
  input TagOrderByInput {
    id: OrderDirection
    nome: OrderDirection
  }
  input TagUpdateInput {
    nome: String
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    noticias: NoticiaRelateToManyForUpdateInput
  }
  input TagCreateInput {
    nome: String
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    noticias: NoticiaRelateToManyForCreateInput
  }

  # ---------- AreaResponsavel ----------
  input AreaResponsavelWhereUniqueInput {
    id: ID
  }
  input AreaResponsavelWhereInput {
    AND: [AreaResponsavelWhereInput!]
    OR: [AreaResponsavelWhereInput!]
    NOT: [AreaResponsavelWhereInput!]
    id: IDFilter
    nome: StringFilter
    subareas: SubareaManyRelationFilter
    gerencias: GerenciaManyRelationFilter
    servicos: ServicoManyRelationFilter
    cursos: CursoManyRelationFilter
    solucoes: SolucaoManyRelationFilter
    noticias: NoticiaManyRelationFilter
    tags: TagManyRelationFilter
    legislacoes: LegislacaoManyRelationFilter
    gestores: GestoresManyRelationFilter
    paginasQuemSomos: PaginaQuemSomosManyRelationFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
    deletedAt: DateTimeNullableFilter
    deletedBy: StringFilter
  }
  input AreaResponsavelOrderByInput {
    id: OrderDirection
    nome: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
    deletedAt: OrderDirection
    deletedBy: OrderDirection
  }
  input AreaResponsavelUpdateInput {
    nome: String
    subareas: SubareaRelateToManyForUpdateInput
    gerencias: GerenciaRelateToManyForUpdateInput
    servicos: ServicoRelateToManyForUpdateInput
    cursos: CursoRelateToManyForUpdateInput
    solucoes: SolucaoRelateToManyForUpdateInput
    noticias: NoticiaRelateToManyForUpdateInput
    tags: TagRelateToManyForUpdateInput
    legislacoes: LegislacaoRelateToManyForUpdateInput
    gestores: GestoresRelateToManyForUpdateInput
    paginasQuemSomos: PaginaQuemSomosRelateToManyForUpdateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
    deletedAt: DateTime
    deletedBy: String
  }
  input AreaResponsavelCreateInput {
    nome: String
    subareas: SubareaRelateToManyForCreateInput
    gerencias: GerenciaRelateToManyForCreateInput
    servicos: ServicoRelateToManyForCreateInput
    cursos: CursoRelateToManyForCreateInput
    solucoes: SolucaoRelateToManyForCreateInput
    noticias: NoticiaRelateToManyForCreateInput
    tags: TagRelateToManyForCreateInput
    legislacoes: LegislacaoRelateToManyForCreateInput
    gestores: GestoresRelateToManyForCreateInput
    paginasQuemSomos: PaginaQuemSomosRelateToManyForCreateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
    deletedAt: DateTime
    deletedBy: String
  }

  # ---------- Gerencia ----------
  input GerenciaWhereUniqueInput {
    id: ID
  }
  input GerenciaWhereInput {
    AND: [GerenciaWhereInput!]
    OR: [GerenciaWhereInput!]
    NOT: [GerenciaWhereInput!]
    id: IDFilter
    nome: StringFilter
    responsavel: StringFilter
    telefone1: StringFilter
    telefone2: StringFilter
    email: StringFilter
    area: AreaResponsavelWhereInput
    setores: SetorManyRelationFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input GerenciaOrderByInput {
    id: OrderDirection
    nome: OrderDirection
    responsavel: OrderDirection
    telefone1: OrderDirection
    telefone2: OrderDirection
    email: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input GerenciaUpdateInput {
    nome: String
    responsavel: String
    telefone1: String
    telefone2: String
    email: String
    area: AreaResponsavelRelateToOneForUpdateInput
    setores: SetorRelateToManyForUpdateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input GerenciaCreateInput {
    nome: String
    responsavel: String
    telefone1: String
    telefone2: String
    email: String
    area: AreaResponsavelRelateToOneForCreateInput
    setores: SetorRelateToManyForCreateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- Setor ----------
  input SetorWhereUniqueInput {
    id: ID
  }
  input SetorWhereInput {
    AND: [SetorWhereInput!]
    OR: [SetorWhereInput!]
    NOT: [SetorWhereInput!]
    id: IDFilter
    nome: StringFilter
    gerencia: GerenciaWhereInput
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input SetorOrderByInput {
    id: OrderDirection
    nome: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input SetorUpdateInput {
    nome: String
    gerencia: GerenciaRelateToOneForUpdateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input SetorCreateInput {
    nome: String
    gerencia: GerenciaRelateToOneForCreateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- Subarea ----------
  input SubareaWhereUniqueInput {
    id: ID
  }
  input SubareaWhereInput {
    AND: [SubareaWhereInput!]
    OR: [SubareaWhereInput!]
    NOT: [SubareaWhereInput!]
    id: IDFilter
    nome: StringFilter
    area: AreaResponsavelWhereInput
    servicos: ServicoManyRelationFilter
    cursos: CursoManyRelationFilter
    noticias: NoticiaManyRelationFilter
    legislacoes: LegislacaoManyRelationFilter
    solucoes: SolucaoManyRelationFilter
    tags: TagManyRelationFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input SubareaOrderByInput {
    id: OrderDirection
    nome: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input SubareaUpdateInput {
    nome: String
    area: AreaResponsavelRelateToOneForUpdateInput
    servicos: ServicoRelateToManyForUpdateInput
    cursos: CursoRelateToManyForUpdateInput
    noticias: NoticiaRelateToManyForUpdateInput
    legislacoes: LegislacaoRelateToManyForUpdateInput
    solucoes: SolucaoRelateToManyForUpdateInput
    tags: TagRelateToManyForUpdateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input SubareaCreateInput {
    nome: String
    area: AreaResponsavelRelateToOneForCreateInput
    servicos: ServicoRelateToManyForCreateInput
    cursos: CursoRelateToManyForCreateInput
    noticias: NoticiaRelateToManyForCreateInput
    legislacoes: LegislacaoRelateToManyForCreateInput
    solucoes: SolucaoRelateToManyForCreateInput
    tags: TagRelateToManyForCreateInput
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- Gestores ----------
  input GestoresWhereUniqueInput {
    id: ID
  }
  input GestoresWhereInput {
    AND: [GestoresWhereInput!]
    OR: [GestoresWhereInput!]
    NOT: [GestoresWhereInput!]
    id: IDFilter
    nome: StringFilter
    cargo: StringFilter
    descricao: StringFilter
    areaResponsavel: AreaResponsavelWhereInput
  }
  input GestoresOrderByInput {
    id: OrderDirection
    nome: OrderDirection
    cargo: OrderDirection
    descricao: OrderDirection
  }
  input GestoresUpdateInput {
    nome: String
    cargo: String
    descricao: String
    foto: ImageFieldInput
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
  }
  input GestoresCreateInput {
    nome: String
    cargo: String
    descricao: String
    foto: ImageFieldInput
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
  }

  # ---------- PaginaQuemSomos ----------
  input PaginaQuemSomosWhereUniqueInput {
    id: ID
  }
  input PaginaQuemSomosWhereInput {
    AND: [PaginaQuemSomosWhereInput!]
    OR: [PaginaQuemSomosWhereInput!]
    NOT: [PaginaQuemSomosWhereInput!]
    id: IDFilter
    tituloDaPagina: StringFilter
    muralTextoIntrodutorio: StringFilter
    timeTitulo: StringFilter
    timeDescricao: StringFilter
    muralItens: QuemSomosMuralItemManyRelationFilter
    conteudosPorSubarea: QuemSomosSubareaItemManyRelationFilter
    time: QuemSomosTimeItemManyRelationFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
  }
  input PaginaQuemSomosOrderByInput {
    id: OrderDirection
    tituloDaPagina: OrderDirection
    muralTextoIntrodutorio: OrderDirection
    timeTitulo: OrderDirection
    timeDescricao: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
  }
  input PaginaQuemSomosUpdateInput {
    tituloDaPagina: String
    muralTextoIntrodutorio: String
    timeTitulo: String
    timeDescricao: String
    muralItens: QuemSomosMuralItemRelateToManyForUpdateInput
    conteudosPorSubarea: QuemSomosSubareaItemRelateToManyForUpdateInput
    time: QuemSomosTimeItemRelateToManyForUpdateInput
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    createdAt: DateTime
    createdBy: String
  }
  input PaginaQuemSomosCreateInput {
    tituloDaPagina: String
    muralTextoIntrodutorio: String
    timeTitulo: String
    timeDescricao: String
    muralItens: QuemSomosMuralItemRelateToManyForCreateInput
    conteudosPorSubarea: QuemSomosSubareaItemRelateToManyForCreateInput
    time: QuemSomosTimeItemRelateToManyForCreateInput
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    createdAt: DateTime
    createdBy: String
  }

  # ---------- QuemSomosMuralItem ----------
  input QuemSomosMuralItemWhereUniqueInput {
    id: ID
  }
  input QuemSomosMuralItemWhereInput {
    AND: [QuemSomosMuralItemWhereInput!]
    OR: [QuemSomosMuralItemWhereInput!]
    NOT: [QuemSomosMuralItemWhereInput!]
    id: IDFilter
    valor: StringFilter
    titulo: StringFilter
    descricao: StringFilter
    pagina: PaginaQuemSomosWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
  }
  input QuemSomosMuralItemOrderByInput {
    id: OrderDirection
    valor: OrderDirection
    titulo: OrderDirection
    descricao: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
  }
  input QuemSomosMuralItemUpdateInput {
    valor: String
    titulo: String
    descricao: String
    pagina: PaginaQuemSomosRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
  }
  input QuemSomosMuralItemCreateInput {
    valor: String
    titulo: String
    descricao: String
    pagina: PaginaQuemSomosRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
  }

  # ---------- QuemSomosTimeItem ----------
  input QuemSomosTimeItemWhereUniqueInput {
    id: ID
  }
  input QuemSomosTimeItemWhereInput {
    AND: [QuemSomosTimeItemWhereInput!]
    OR: [QuemSomosTimeItemWhereInput!]
    NOT: [QuemSomosTimeItemWhereInput!]
    id: IDFilter
    nome: StringFilter
    cargo: StringFilter
    descricao: StringFilter
    pagina: PaginaQuemSomosWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
  }
  input QuemSomosTimeItemOrderByInput {
    id: OrderDirection
    nome: OrderDirection
    cargo: OrderDirection
    descricao: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
  }
  input QuemSomosTimeItemUpdateInput {
    nome: String
    cargo: String
    descricao: String
    foto: ImageFieldInput
    pagina: PaginaQuemSomosRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
  }
  input QuemSomosTimeItemCreateInput {
    nome: String
    cargo: String
    descricao: String
    foto: ImageFieldInput
    pagina: PaginaQuemSomosRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
  }

  # ---------- QuemSomosSubareaItem ----------
  input QuemSomosSubareaItemWhereUniqueInput {
    id: ID
  }
  input QuemSomosSubareaItemWhereInput {
    AND: [QuemSomosSubareaItemWhereInput!]
    OR: [QuemSomosSubareaItemWhereInput!]
    NOT: [QuemSomosSubareaItemWhereInput!]
    id: IDFilter
    subarea: SubareaWhereInput
    conteudo: StringFilter
    pagina: PaginaQuemSomosWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
  }
  input QuemSomosSubareaItemOrderByInput {
    id: OrderDirection
    conteudo: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
  }
  input QuemSomosSubareaItemUpdateInput {
    subarea: SubareaRelateToOneForUpdateInput
    conteudo: String
    pagina: PaginaQuemSomosRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
  }
  input QuemSomosSubareaItemCreateInput {
    subarea: SubareaRelateToOneForCreateInput
    conteudo: String
    pagina: PaginaQuemSomosRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
  }

  # ---------- Portfolio ----------
  input PortfolioWhereUniqueInput {
    id: ID
    slug: String
  }
  input PortfolioWhereInput {
    AND: [PortfolioWhereInput!]
    OR: [PortfolioWhereInput!]
    NOT: [PortfolioWhereInput!]
    id: IDFilter
    titulo: StringFilter
    slug: StringFilter
    resumo: StringFilter
    imagemAlt: StringFilter
    galeria: PortfolioImagemManyRelationFilter
    areaResponsavel: AreaResponsavelWhereInput
    subarea: SubareaWhereInput
    ativo: BooleanFilter
    createdAt: DateTimeNullableFilter
    createdBy: StringFilter
    updatedAt: DateTimeNullableFilter
    updatedBy: StringFilter
  }
  input PortfolioOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    slug: OrderDirection
    resumo: OrderDirection
    imagemAlt: OrderDirection
    ativo: OrderDirection
    createdAt: OrderDirection
    createdBy: OrderDirection
    updatedAt: OrderDirection
    updatedBy: OrderDirection
  }
  input PortfolioUpdateInput {
    titulo: String
    slug: String
    resumo: String
    imagem: ImageFieldInput
    imagemAlt: String
    galeria: PortfolioImagemRelateToManyForUpdateInput
    corpo: JSON
    areaResponsavel: AreaResponsavelRelateToOneForUpdateInput
    subarea: SubareaRelateToOneForUpdateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }
  input PortfolioCreateInput {
    titulo: String
    slug: String
    resumo: String
    imagem: ImageFieldInput
    imagemAlt: String
    galeria: PortfolioImagemRelateToManyForCreateInput
    corpo: JSON
    areaResponsavel: AreaResponsavelRelateToOneForCreateInput
    subarea: SubareaRelateToOneForCreateInput
    ativo: Boolean
    createdAt: DateTime
    createdBy: String
    updatedAt: DateTime
    updatedBy: String
  }

  # ---------- PortfolioImagem ----------
  input PortfolioImagemWhereUniqueInput {
    id: ID
  }
  input PortfolioImagemWhereInput {
    AND: [PortfolioImagemWhereInput!]
    OR: [PortfolioImagemWhereInput!]
    NOT: [PortfolioImagemWhereInput!]
    id: IDFilter
    titulo: StringFilter
    portfolio: PortfolioWhereInput
    ativo: BooleanFilter
  }
  input PortfolioImagemOrderByInput {
    id: OrderDirection
    titulo: OrderDirection
    ativo: OrderDirection
  }
  input PortfolioImagemUpdateInput {
    titulo: String
    imagem: ImageFieldInput
    portfolio: PortfolioRelateToOneForUpdateInput
    ativo: Boolean
  }
  input PortfolioImagemCreateInput {
    titulo: String
    imagem: ImageFieldInput
    portfolio: PortfolioRelateToOneForCreateInput
    ativo: Boolean
  }

  # ---------- Acesso ----------
  input AcessoWhereUniqueInput {
    id: ID
  }
  input AcessoWhereInput {
    AND: [AcessoWhereInput!]
    OR: [AcessoWhereInput!]
    NOT: [AcessoWhereInput!]
    id: IDFilter
    portal: StringFilter
    tipo: StringFilter
    area: StringFilter
    usuario: StringFilter
    ip: StringFilter
    dataAcesso: DateTimeNullableFilter
  }
  input AcessoOrderByInput {
    id: OrderDirection
    portal: OrderDirection
    tipo: OrderDirection
    area: OrderDirection
    usuario: OrderDirection
    ip: OrderDirection
    dataAcesso: OrderDirection
  }
  input AcessoUpdateInput {
    portal: String
    tipo: String
    area: String
    usuario: String
    ip: String
    dataAcesso: DateTime
  }
  input AcessoCreateInput {
    portal: String
    tipo: String
    area: String
    usuario: String
    ip: String
    dataAcesso: DateTime
  }

  # ---------- Relation filters (muitos) ----------
  input NoticiaManyRelationFilter {
    every: NoticiaWhereInput
    some: NoticiaWhereInput
    none: NoticiaWhereInput
  }
  input AreaResponsavelManyRelationFilter {
    every: AreaResponsavelWhereInput
    some: AreaResponsavelWhereInput
    none: AreaResponsavelWhereInput
  }
  input SubareaManyRelationFilter {
    every: SubareaWhereInput
    some: SubareaWhereInput
    none: SubareaWhereInput
  }
  input GerenciaManyRelationFilter {
    every: GerenciaWhereInput
    some: GerenciaWhereInput
    none: GerenciaWhereInput
  }
  input ServicoManyRelationFilter {
    every: ServicoWhereInput
    some: ServicoWhereInput
    none: ServicoWhereInput
  }
  input CursoManyRelationFilter {
    every: CursoWhereInput
    some: CursoWhereInput
    none: CursoWhereInput
  }
  input SolucaoManyRelationFilter {
    every: SolucaoWhereInput
    some: SolucaoWhereInput
    none: SolucaoWhereInput
  }
  input LegislacaoManyRelationFilter {
    every: LegislacaoWhereInput
    some: LegislacaoWhereInput
    none: LegislacaoWhereInput
  }
  input GestoresManyRelationFilter {
    every: GestoresWhereInput
    some: GestoresWhereInput
    none: GestoresWhereInput
  }
  input PaginaQuemSomosManyRelationFilter {
    every: PaginaQuemSomosWhereInput
    some: PaginaQuemSomosWhereInput
    none: PaginaQuemSomosWhereInput
  }
  input SetorManyRelationFilter {
    every: SetorWhereInput
    some: SetorWhereInput
    none: SetorWhereInput
  }
  input TagManyRelationFilter {
    every: TagWhereInput
    some: TagWhereInput
    none: TagWhereInput
  }
  input QuemSomosMuralItemManyRelationFilter {
    every: QuemSomosMuralItemWhereInput
    some: QuemSomosMuralItemWhereInput
    none: QuemSomosMuralItemWhereInput
  }
  input QuemSomosSubareaItemManyRelationFilter {
    every: QuemSomosSubareaItemWhereInput
    some: QuemSomosSubareaItemWhereInput
    none: QuemSomosSubareaItemWhereInput
  }
  input QuemSomosTimeItemManyRelationFilter {
    every: QuemSomosTimeItemWhereInput
    some: QuemSomosTimeItemWhereInput
    none: QuemSomosTimeItemWhereInput
  }
  input PortfolioImagemManyRelationFilter {
    every: PortfolioImagemWhereInput
    some: PortfolioImagemWhereInput
    none: PortfolioImagemWhereInput
  }

  # ---------- RelateToMany (create/update) ----------
  input NoticiaRelateToManyForCreateInput {
    create: [NoticiaCreateInput!]
    connect: [NoticiaWhereUniqueInput!]
  }
  input NoticiaRelateToManyForUpdateInput {
    disconnect: [NoticiaWhereUniqueInput!]
    set: [NoticiaWhereUniqueInput!]
    create: [NoticiaCreateInput!]
    connect: [NoticiaWhereUniqueInput!]
  }
  input AreaResponsavelRelateToManyForCreateInput {
    create: [AreaResponsavelCreateInput!]
    connect: [AreaResponsavelWhereUniqueInput!]
  }
  input AreaResponsavelRelateToManyForUpdateInput {
    disconnect: [AreaResponsavelWhereUniqueInput!]
    set: [AreaResponsavelWhereUniqueInput!]
    create: [AreaResponsavelCreateInput!]
    connect: [AreaResponsavelWhereUniqueInput!]
  }
  input SubareaRelateToManyForCreateInput {
    create: [SubareaCreateInput!]
    connect: [SubareaWhereUniqueInput!]
  }
  input SubareaRelateToManyForUpdateInput {
    disconnect: [SubareaWhereUniqueInput!]
    set: [SubareaWhereUniqueInput!]
    create: [SubareaCreateInput!]
    connect: [SubareaWhereUniqueInput!]
  }
  input GerenciaRelateToManyForCreateInput {
    create: [GerenciaCreateInput!]
    connect: [GerenciaWhereUniqueInput!]
  }
  input GerenciaRelateToManyForUpdateInput {
    disconnect: [GerenciaWhereUniqueInput!]
    set: [GerenciaWhereUniqueInput!]
    create: [GerenciaCreateInput!]
    connect: [GerenciaWhereUniqueInput!]
  }
  input ServicoRelateToManyForCreateInput {
    create: [ServicoCreateInput!]
    connect: [ServicoWhereUniqueInput!]
  }
  input ServicoRelateToManyForUpdateInput {
    disconnect: [ServicoWhereUniqueInput!]
    set: [ServicoWhereUniqueInput!]
    create: [ServicoCreateInput!]
    connect: [ServicoWhereUniqueInput!]
  }
  input CursoRelateToManyForCreateInput {
    create: [CursoCreateInput!]
    connect: [CursoWhereUniqueInput!]
  }
  input CursoRelateToManyForUpdateInput {
    disconnect: [CursoWhereUniqueInput!]
    set: [CursoWhereUniqueInput!]
    create: [CursoCreateInput!]
    connect: [CursoWhereUniqueInput!]
  }
  input SolucaoRelateToManyForCreateInput {
    create: [SolucaoCreateInput!]
    connect: [SolucaoWhereUniqueInput!]
  }
  input SolucaoRelateToManyForUpdateInput {
    disconnect: [SolucaoWhereUniqueInput!]
    set: [SolucaoWhereUniqueInput!]
    create: [SolucaoCreateInput!]
    connect: [SolucaoWhereUniqueInput!]
  }
  input LegislacaoRelateToManyForCreateInput {
    create: [LegislacaoCreateInput!]
    connect: [LegislacaoWhereUniqueInput!]
  }
  input LegislacaoRelateToManyForUpdateInput {
    disconnect: [LegislacaoWhereUniqueInput!]
    set: [LegislacaoWhereUniqueInput!]
    create: [LegislacaoCreateInput!]
    connect: [LegislacaoWhereUniqueInput!]
  }
  input GestoresRelateToManyForCreateInput {
    create: [GestoresCreateInput!]
    connect: [GestoresWhereUniqueInput!]
  }
  input GestoresRelateToManyForUpdateInput {
    disconnect: [GestoresWhereUniqueInput!]
    set: [GestoresWhereUniqueInput!]
    create: [GestoresCreateInput!]
    connect: [GestoresWhereUniqueInput!]
  }
  input PaginaQuemSomosRelateToManyForCreateInput {
    create: [PaginaQuemSomosCreateInput!]
    connect: [PaginaQuemSomosWhereUniqueInput!]
  }
  input PaginaQuemSomosRelateToManyForUpdateInput {
    disconnect: [PaginaQuemSomosWhereUniqueInput!]
    set: [PaginaQuemSomosWhereUniqueInput!]
    create: [PaginaQuemSomosCreateInput!]
    connect: [PaginaQuemSomosWhereUniqueInput!]
  }
  input SetorRelateToManyForCreateInput {
    create: [SetorCreateInput!]
    connect: [SetorWhereUniqueInput!]
  }
  input SetorRelateToManyForUpdateInput {
    disconnect: [SetorWhereUniqueInput!]
    set: [SetorWhereUniqueInput!]
    create: [SetorCreateInput!]
    connect: [SetorWhereUniqueInput!]
  }
  input TagRelateToManyForCreateInput {
    create: [TagCreateInput!]
    connect: [TagWhereUniqueInput!]
  }
  input TagRelateToManyForUpdateInput {
    disconnect: [TagWhereUniqueInput!]
    set: [TagWhereUniqueInput!]
    create: [TagCreateInput!]
    connect: [TagWhereUniqueInput!]
  }
  input QuemSomosMuralItemRelateToManyForCreateInput {
    create: [QuemSomosMuralItemCreateInput!]
    connect: [QuemSomosMuralItemWhereUniqueInput!]
  }
  input QuemSomosMuralItemRelateToManyForUpdateInput {
    disconnect: [QuemSomosMuralItemWhereUniqueInput!]
    set: [QuemSomosMuralItemWhereUniqueInput!]
    create: [QuemSomosMuralItemCreateInput!]
    connect: [QuemSomosMuralItemWhereUniqueInput!]
  }
  input QuemSomosSubareaItemRelateToManyForCreateInput {
    create: [QuemSomosSubareaItemCreateInput!]
    connect: [QuemSomosSubareaItemWhereUniqueInput!]
  }
  input QuemSomosSubareaItemRelateToManyForUpdateInput {
    disconnect: [QuemSomosSubareaItemWhereUniqueInput!]
    set: [QuemSomosSubareaItemWhereUniqueInput!]
    create: [QuemSomosSubareaItemCreateInput!]
    connect: [QuemSomosSubareaItemWhereUniqueInput!]
  }
  input QuemSomosTimeItemRelateToManyForCreateInput {
    create: [QuemSomosTimeItemCreateInput!]
    connect: [QuemSomosTimeItemWhereUniqueInput!]
  }
  input QuemSomosTimeItemRelateToManyForUpdateInput {
    disconnect: [QuemSomosTimeItemWhereUniqueInput!]
    set: [QuemSomosTimeItemWhereUniqueInput!]
    create: [QuemSomosTimeItemCreateInput!]
    connect: [QuemSomosTimeItemWhereUniqueInput!]
  }
  input PortfolioImagemRelateToManyForCreateInput {
    create: [PortfolioImagemCreateInput!]
    connect: [PortfolioImagemWhereUniqueInput!]
  }
  input PortfolioImagemRelateToManyForUpdateInput {
    disconnect: [PortfolioImagemWhereUniqueInput!]
    set: [PortfolioImagemWhereUniqueInput!]
    create: [PortfolioImagemCreateInput!]
    connect: [PortfolioImagemWhereUniqueInput!]
  }

  # ---------- RelateToOne (create/update) ----------
  input AreaResponsavelRelateToOneForCreateInput {
    create: AreaResponsavelCreateInput
    connect: AreaResponsavelWhereUniqueInput
  }
  input AreaResponsavelRelateToOneForUpdateInput {
    create: AreaResponsavelCreateInput
    connect: AreaResponsavelWhereUniqueInput
    disconnect: Boolean
  }
  input SubareaRelateToOneForCreateInput {
    create: SubareaCreateInput
    connect: SubareaWhereUniqueInput
  }
  input SubareaRelateToOneForUpdateInput {
    create: SubareaCreateInput
    connect: SubareaWhereUniqueInput
    disconnect: Boolean
  }
  input UserRelateToOneForCreateInput {
    create: UserCreateInput
    connect: UserWhereUniqueInput
  }
  input UserRelateToOneForUpdateInput {
    create: UserCreateInput
    connect: UserWhereUniqueInput
    disconnect: Boolean
  }
  input GerenciaRelateToOneForCreateInput {
    create: GerenciaCreateInput
    connect: GerenciaWhereUniqueInput
  }
  input GerenciaRelateToOneForUpdateInput {
    create: GerenciaCreateInput
    connect: GerenciaWhereUniqueInput
    disconnect: Boolean
  }
  input PaginaQuemSomosRelateToOneForCreateInput {
    create: PaginaQuemSomosCreateInput
    connect: PaginaQuemSomosWhereUniqueInput
  }
  input PaginaQuemSomosRelateToOneForUpdateInput {
    create: PaginaQuemSomosCreateInput
    connect: PaginaQuemSomosWhereUniqueInput
    disconnect: Boolean
  }
input PortfolioRelateToOneForCreateInput {
    create: PortfolioCreateInput
    connect: PortfolioWhereUniqueInput
  }
  input PortfolioRelateToOneForUpdateInput {
    create: PortfolioCreateInput
    connect: PortfolioWhereUniqueInput
    disconnect: Boolean
  }

  # ---------- UpdateArgs (usados nas mutations update<plural>) ----------
  input ServicoUpdateArgs {
    where: ServicoWhereUniqueInput!
    data: ServicoUpdateInput!
  }
  input SolucaoUpdateArgs {
    where: SolucaoWhereUniqueInput!
    data: SolucaoUpdateInput!
  }
  input NoticiaUpdateArgs {
    where: NoticiaWhereUniqueInput!
    data: NoticiaUpdateInput!
  }
  input LegislacaoUpdateArgs {
    where: LegislacaoWhereUniqueInput!
    data: LegislacaoUpdateInput!
  }
  input CursoUpdateArgs {
    where: CursoWhereUniqueInput!
    data: CursoUpdateInput!
  }
  input TagUpdateArgs {
    where: TagWhereUniqueInput!
    data: TagUpdateInput!
  }
  input AreaResponsavelUpdateArgs {
    where: AreaResponsavelWhereUniqueInput!
    data: AreaResponsavelUpdateInput!
  }
  input GerenciaUpdateArgs {
    where: GerenciaWhereUniqueInput!
    data: GerenciaUpdateInput!
  }
  input SetorUpdateArgs {
    where: SetorWhereUniqueInput!
    data: SetorUpdateInput!
  }
  input SubareaUpdateArgs {
    where: SubareaWhereUniqueInput!
    data: SubareaUpdateInput!
  }
  input GestoresUpdateArgs {
    where: GestoresWhereUniqueInput!
    data: GestoresUpdateInput!
  }
  input PaginaQuemSomosUpdateArgs {
    where: PaginaQuemSomosWhereUniqueInput!
    data: PaginaQuemSomosUpdateInput!
  }
  input QuemSomosMuralItemUpdateArgs {
    where: QuemSomosMuralItemWhereUniqueInput!
    data: QuemSomosMuralItemUpdateInput!
  }
  input QuemSomosTimeItemUpdateArgs {
    where: QuemSomosTimeItemWhereUniqueInput!
    data: QuemSomosTimeItemUpdateInput!
  }
  input QuemSomosSubareaItemUpdateArgs {
    where: QuemSomosSubareaItemWhereUniqueInput!
    data: QuemSomosSubareaItemUpdateInput!
  }
  input PortfolioUpdateArgs {
    where: PortfolioWhereUniqueInput!
    data: PortfolioUpdateInput!
  }
  input PortfolioImagemUpdateArgs {
    where: PortfolioImagemWhereUniqueInput!
    data: PortfolioImagemUpdateInput!
  }
  input AcessoUpdateArgs {
    where: AcessoWhereUniqueInput!
    data: AcessoUpdateInput!
  }
`;
