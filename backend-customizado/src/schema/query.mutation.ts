import { gql } from 'graphql-tag';

export const queryMutationTypeDefs = gql`
  type Query {
    user(where: UserWhereUniqueInput!): User
    users(where: UserWhereInput! = {}, orderBy: [UserOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: UserWhereUniqueInput): [User!]
    usersCount(where: UserWhereInput! = {}): Int
    auditLog(where: AuditLogWhereUniqueInput!): AuditLog
    auditLogs(where: AuditLogWhereInput! = {}, orderBy: [AuditLogOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: AuditLogWhereUniqueInput): [AuditLog!]
    auditLogsCount(where: AuditLogWhereInput! = {}): Int
    servico(where: ServicoWhereUniqueInput!): Servico
    servicos(where: ServicoWhereInput! = {}, orderBy: [ServicoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: ServicoWhereUniqueInput): [Servico!]
    servicosCount(where: ServicoWhereInput! = {}): Int
    solucao(where: SolucaoWhereUniqueInput!): Solucao
    solucoes(where: SolucaoWhereInput! = {}, orderBy: [SolucaoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SolucaoWhereUniqueInput): [Solucao!]
    solucoesCount(where: SolucaoWhereInput! = {}): Int
    noticia(where: NoticiaWhereUniqueInput!): Noticia
    noticias(where: NoticiaWhereInput! = {}, orderBy: [NoticiaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: NoticiaWhereUniqueInput): [Noticia!]
    noticiasCount(where: NoticiaWhereInput! = {}): Int
    legislacao(where: LegislacaoWhereUniqueInput!): Legislacao
    legislacoes(where: LegislacaoWhereInput! = {}, orderBy: [LegislacaoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: LegislacaoWhereUniqueInput): [Legislacao!]
    legislacoesCount(where: LegislacaoWhereInput! = {}): Int
    curso(where: CursoWhereUniqueInput!): Curso
    cursos(where: CursoWhereInput! = {}, orderBy: [CursoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: CursoWhereUniqueInput): [Curso!]
    cursosCount(where: CursoWhereInput! = {}): Int
    tag(where: TagWhereUniqueInput!): Tag
    tags(where: TagWhereInput! = {}, orderBy: [TagOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: TagWhereUniqueInput): [Tag!]
    tagsCount(where: TagWhereInput! = {}): Int
    areaResponsavel(where: AreaResponsavelWhereUniqueInput!): AreaResponsavel
    areas(where: AreaResponsavelWhereInput! = {}, orderBy: [AreaResponsavelOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: AreaResponsavelWhereUniqueInput): [AreaResponsavel!]
    areasCount(where: AreaResponsavelWhereInput! = {}): Int
    gerencia(where: GerenciaWhereUniqueInput!): Gerencia
    gerencias(where: GerenciaWhereInput! = {}, orderBy: [GerenciaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: GerenciaWhereUniqueInput): [Gerencia!]
    gerenciasCount(where: GerenciaWhereInput! = {}): Int
    setor(where: SetorWhereUniqueInput!): Setor
    setores(where: SetorWhereInput! = {}, orderBy: [SetorOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SetorWhereUniqueInput): [Setor!]
    setoresCount(where: SetorWhereInput! = {}): Int
    subarea(where: SubareaWhereUniqueInput!): Subarea
    subareas(where: SubareaWhereInput! = {}, orderBy: [SubareaOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: SubareaWhereUniqueInput): [Subarea!]
    subareasCount(where: SubareaWhereInput! = {}): Int
    gestor(where: GestoresWhereUniqueInput!): Gestores
    gestores(where: GestoresWhereInput! = {}, orderBy: [GestoresOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: GestoresWhereUniqueInput): [Gestores!]
    gestoresCount(where: GestoresWhereInput! = {}): Int
    paginaQuemSomos(where: PaginaQuemSomosWhereUniqueInput!): PaginaQuemSomos
    paginasQuemSomos(where: PaginaQuemSomosWhereInput! = {}, orderBy: [PaginaQuemSomosOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: PaginaQuemSomosWhereUniqueInput): [PaginaQuemSomos!]
    paginasQuemSomosCount(where: PaginaQuemSomosWhereInput! = {}): Int
    quemSomosMuralItem(where: QuemSomosMuralItemWhereUniqueInput!): QuemSomosMuralItem
    quemSomosMuralItens(where: QuemSomosMuralItemWhereInput! = {}, orderBy: [QuemSomosMuralItemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: QuemSomosMuralItemWhereUniqueInput): [QuemSomosMuralItem!]
    quemSomosMuralItensCount(where: QuemSomosMuralItemWhereInput! = {}): Int
    quemSomosTimeItem(where: QuemSomosTimeItemWhereUniqueInput!): QuemSomosTimeItem
    quemSomosTimeItens(where: QuemSomosTimeItemWhereInput! = {}, orderBy: [QuemSomosTimeItemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: QuemSomosTimeItemWhereUniqueInput): [QuemSomosTimeItem!]
    quemSomosTimeItensCount(where: QuemSomosTimeItemWhereInput! = {}): Int
    quemSomosSubareaItem(where: QuemSomosSubareaItemWhereUniqueInput!): QuemSomosSubareaItem
    quemSomosSubareaItens(where: QuemSomosSubareaItemWhereInput! = {}, orderBy: [QuemSomosSubareaItemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: QuemSomosSubareaItemWhereUniqueInput): [QuemSomosSubareaItem!]
    quemSomosSubareaItensCount(where: QuemSomosSubareaItemWhereInput! = {}): Int
    portfolio(where: PortfolioWhereUniqueInput!): Portfolio
    portfolios(where: PortfolioWhereInput! = {}, orderBy: [PortfolioOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: PortfolioWhereUniqueInput): [Portfolio!]
    portfoliosCount(where: PortfolioWhereInput! = {}): Int
    portfolioImagem(where: PortfolioImagemWhereUniqueInput!): PortfolioImagem
    portfolioImagens(where: PortfolioImagemWhereInput! = {}, orderBy: [PortfolioImagemOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: PortfolioImagemWhereUniqueInput): [PortfolioImagem!]
    portfolioImagensCount(where: PortfolioImagemWhereInput! = {}): Int
    acesso(where: AcessoWhereUniqueInput!): Acesso
    acessos(where: AcessoWhereInput! = {}, orderBy: [AcessoOrderByInput!]! = [], take: Int, skip: Int! = 0, cursor: AcessoWhereUniqueInput): [Acesso!]
    acessosCount(where: AcessoWhereInput! = {}): Int
    authenticatedItem: AuthenticatedItem
  }

  union AuthenticatedItem = User

  type Mutation {
    createUser(data: UserCreateInput!): User
    createusers(data: [UserCreateInput!]!): [User]
    updateUser(where: UserWhereUniqueInput!, data: UserUpdateInput!): User
    updateusers(data: [UserUpdateArgs!]!): [User]
    deleteUser(where: UserWhereUniqueInput!): User
    deleteusers(where: [UserWhereUniqueInput!]!): [User]
    createAuditLog(data: AuditLogCreateInput!): AuditLog
    createauditLogs(data: [AuditLogCreateInput!]!): [AuditLog]
    updateAuditLog(where: AuditLogWhereUniqueInput!, data: AuditLogUpdateInput!): AuditLog
    updateauditLogs(data: [AuditLogUpdateArgs!]!): [AuditLog]
    deleteAuditLog(where: AuditLogWhereUniqueInput!): AuditLog
    deleteauditLogs(where: [AuditLogWhereUniqueInput!]!): [AuditLog]
    createServico(data: ServicoCreateInput!): Servico
    createservicos(data: [ServicoCreateInput!]!): [Servico]
    updateServico(where: ServicoWhereUniqueInput!, data: ServicoUpdateInput!): Servico
    updateservicos(data: [ServicoUpdateArgs!]!): [Servico]
    deleteServico(where: ServicoWhereUniqueInput!): Servico
    deleteservicos(where: [ServicoWhereUniqueInput!]!): [Servico]
    createSolucao(data: SolucaoCreateInput!): Solucao
    createsolucoes(data: [SolucaoCreateInput!]!): [Solucao]
    updateSolucao(where: SolucaoWhereUniqueInput!, data: SolucaoUpdateInput!): Solucao
    updatesolucoes(data: [SolucaoUpdateArgs!]!): [Solucao]
    deleteSolucao(where: SolucaoWhereUniqueInput!): Solucao
    deletesolucoes(where: [SolucaoWhereUniqueInput!]!): [Solucao]
    createNoticia(data: NoticiaCreateInput!): Noticia
    createnoticias(data: [NoticiaCreateInput!]!): [Noticia]
    updateNoticia(where: NoticiaWhereUniqueInput!, data: NoticiaUpdateInput!): Noticia
    updatenoticias(data: [NoticiaUpdateArgs!]!): [Noticia]
    deleteNoticia(where: NoticiaWhereUniqueInput!): Noticia
    deletenoticias(where: [NoticiaWhereUniqueInput!]!): [Noticia]
    createLegislacao(data: LegislacaoCreateInput!): Legislacao
    createlegislacoes(data: [LegislacaoCreateInput!]!): [Legislacao]
    updateLegislacao(where: LegislacaoWhereUniqueInput!, data: LegislacaoUpdateInput!): Legislacao
    updatelegislacoes(data: [LegislacaoUpdateArgs!]!): [Legislacao]
    deleteLegislacao(where: LegislacaoWhereUniqueInput!): Legislacao
    deletelegislacoes(where: [LegislacaoWhereUniqueInput!]!): [Legislacao]
    createCurso(data: CursoCreateInput!): Curso
    createcursos(data: [CursoCreateInput!]!): [Curso]
    updateCurso(where: CursoWhereUniqueInput!, data: CursoUpdateInput!): Curso
    updatecursos(data: [CursoUpdateArgs!]!): [Curso]
    deleteCurso(where: CursoWhereUniqueInput!): Curso
    deletecursos(where: [CursoWhereUniqueInput!]!): [Curso]
    createTag(data: TagCreateInput!): Tag
    createTags(data: [TagCreateInput!]!): [Tag]
    updateTag(where: TagWhereUniqueInput!, data: TagUpdateInput!): Tag
    updateTags(data: [TagUpdateArgs!]!): [Tag]
    deleteTag(where: TagWhereUniqueInput!): Tag
    deleteTags(where: [TagWhereUniqueInput!]!): [Tag]
    createAreaResponsavel(data: AreaResponsavelCreateInput!): AreaResponsavel
    createareas(data: [AreaResponsavelCreateInput!]!): [AreaResponsavel]
    updateAreaResponsavel(where: AreaResponsavelWhereUniqueInput!, data: AreaResponsavelUpdateInput!): AreaResponsavel
    updateareas(data: [AreaResponsavelUpdateArgs!]!): [AreaResponsavel]
    deleteAreaResponsavel(where: AreaResponsavelWhereUniqueInput!): AreaResponsavel
    deleteareas(where: [AreaResponsavelWhereUniqueInput!]!): [AreaResponsavel]
    createGerencia(data: GerenciaCreateInput!): Gerencia
    creategerencias(data: [GerenciaCreateInput!]!): [Gerencia]
    updateGerencia(where: GerenciaWhereUniqueInput!, data: GerenciaUpdateInput!): Gerencia
    updategerencias(data: [GerenciaUpdateArgs!]!): [Gerencia]
    deleteGerencia(where: GerenciaWhereUniqueInput!): Gerencia
    deletegerencias(where: [GerenciaWhereUniqueInput!]!): [Gerencia]
    createSetor(data: SetorCreateInput!): Setor
    createsetores(data: [SetorCreateInput!]!): [Setor]
    updateSetor(where: SetorWhereUniqueInput!, data: SetorUpdateInput!): Setor
    updatesetores(data: [SetorUpdateArgs!]!): [Setor]
    deleteSetor(where: SetorWhereUniqueInput!): Setor
    deletesetores(where: [SetorWhereUniqueInput!]!): [Setor]
    createSubarea(data: SubareaCreateInput!): Subarea
    createsubareas(data: [SubareaCreateInput!]!): [Subarea]
    updateSubarea(where: SubareaWhereUniqueInput!, data: SubareaUpdateInput!): Subarea
    updatesubareas(data: [SubareaUpdateArgs!]!): [Subarea]
    deleteSubarea(where: SubareaWhereUniqueInput!): Subarea
    deletesubareas(where: [SubareaWhereUniqueInput!]!): [Subarea]
    createGestores(data: GestoresCreateInput!): Gestores
    creategestores(data: [GestoresCreateInput!]!): [Gestores]
    updateGestores(where: GestoresWhereUniqueInput!, data: GestoresUpdateInput!): Gestores
    updategestores(data: [GestoresUpdateArgs!]!): [Gestores]
    deleteGestores(where: GestoresWhereUniqueInput!): Gestores
    deletegestores(where: [GestoresWhereUniqueInput!]!): [Gestores]
    createPaginaQuemSomos(data: PaginaQuemSomosCreateInput!): PaginaQuemSomos
    createpaginasQuemSomos(data: [PaginaQuemSomosCreateInput!]!): [PaginaQuemSomos]
    updatePaginaQuemSomos(where: PaginaQuemSomosWhereUniqueInput!, data: PaginaQuemSomosUpdateInput!): PaginaQuemSomos
    updatepaginasQuemSomos(data: [PaginaQuemSomosUpdateArgs!]!): [PaginaQuemSomos]
    deletePaginaQuemSomos(where: PaginaQuemSomosWhereUniqueInput!): PaginaQuemSomos
    deletepaginasQuemSomos(where: [PaginaQuemSomosWhereUniqueInput!]!): [PaginaQuemSomos]
    createQuemSomosMuralItem(data: QuemSomosMuralItemCreateInput!): QuemSomosMuralItem
    createquemSomosMuralItens(data: [QuemSomosMuralItemCreateInput!]!): [QuemSomosMuralItem]
    updateQuemSomosMuralItem(where: QuemSomosMuralItemWhereUniqueInput!, data: QuemSomosMuralItemUpdateInput!): QuemSomosMuralItem
    updatequemSomosMuralItens(data: [QuemSomosMuralItemUpdateArgs!]!): [QuemSomosMuralItem]
    deleteQuemSomosMuralItem(where: QuemSomosMuralItemWhereUniqueInput!): QuemSomosMuralItem
    deletequemSomosMuralItens(where: [QuemSomosMuralItemWhereUniqueInput!]!): [QuemSomosMuralItem]
    createQuemSomosTimeItem(data: QuemSomosTimeItemCreateInput!): QuemSomosTimeItem
    createquemSomosTimeItens(data: [QuemSomosTimeItemCreateInput!]!): [QuemSomosTimeItem]
    updateQuemSomosTimeItem(where: QuemSomosTimeItemWhereUniqueInput!, data: QuemSomosTimeItemUpdateInput!): QuemSomosTimeItem
    updatequemSomosTimeItens(data: [QuemSomosTimeItemUpdateArgs!]!): [QuemSomosTimeItem]
    deleteQuemSomosTimeItem(where: QuemSomosTimeItemWhereUniqueInput!): QuemSomosTimeItem
    deletequemSomosTimeItens(where: [QuemSomosTimeItemWhereUniqueInput!]!): [QuemSomosTimeItem]
    createQuemSomosSubareaItem(data: QuemSomosSubareaItemCreateInput!): QuemSomosSubareaItem
    createquemSomosSubareaItens(data: [QuemSomosSubareaItemCreateInput!]!): [QuemSomosSubareaItem]
    updateQuemSomosSubareaItem(where: QuemSomosSubareaItemWhereUniqueInput!, data: QuemSomosSubareaItemUpdateInput!): QuemSomosSubareaItem
    updatequemSomosSubareaItens(data: [QuemSomosSubareaItemUpdateArgs!]!): [QuemSomosSubareaItem]
    deleteQuemSomosSubareaItem(where: QuemSomosSubareaItemWhereUniqueInput!): QuemSomosSubareaItem
    deletequemSomosSubareaItens(where: [QuemSomosSubareaItemWhereUniqueInput!]!): [QuemSomosSubareaItem]
    createPortfolio(data: PortfolioCreateInput!): Portfolio
    createportfolios(data: [PortfolioCreateInput!]!): [Portfolio]
    updatePortfolio(where: PortfolioWhereUniqueInput!, data: PortfolioUpdateInput!): Portfolio
    updateportfolios(data: [PortfolioUpdateArgs!]!): [Portfolio]
    deletePortfolio(where: PortfolioWhereUniqueInput!): Portfolio
    deleteportfolios(where: [PortfolioWhereUniqueInput!]!): [Portfolio]
    createPortfolioImagem(data: PortfolioImagemCreateInput!): PortfolioImagem
    createportfolioImagens(data: [PortfolioImagemCreateInput!]!): [PortfolioImagem]
    updatePortfolioImagem(where: PortfolioImagemWhereUniqueInput!, data: PortfolioImagemUpdateInput!): PortfolioImagem
    updateportfolioImagens(data: [PortfolioImagemUpdateArgs!]!): [PortfolioImagem]
    deletePortfolioImagem(where: PortfolioImagemWhereUniqueInput!): PortfolioImagem
    deleteportfolioImagens(where: [PortfolioImagemWhereUniqueInput!]!): [PortfolioImagem]
    createAcesso(data: AcessoCreateInput!): Acesso
    createacessos(data: [AcessoCreateInput!]!): [Acesso]
    updateAcesso(where: AcessoWhereUniqueInput!, data: AcessoUpdateInput!): Acesso
    updateacessos(data: [AcessoUpdateArgs!]!): [Acesso]
    deleteAcesso(where: AcessoWhereUniqueInput!): Acesso
    deleteacessos(where: [AcessoWhereUniqueInput!]!): [Acesso]
    endSession: Boolean!
    authenticateUserWithPassword(email: String!, password: String!): UserAuthenticationWithPasswordResult
    sendUserPasswordResetLink(email: String!): Boolean!
    redeemUserPasswordResetToken(email: String!, token: String!, password: String!): RedeemUserPasswordResetTokenResult
    forgotPassword(email: String!): Boolean
    resetPassword(email: String!, tempPassword: String!, newPassword: String!): Boolean
    uploadImage(file: Upload!): ImageFieldOutput
  }

  union UserAuthenticationWithPasswordResult = UserAuthenticationWithPasswordSuccess | UserAuthenticationWithPasswordFailure

  type UserAuthenticationWithPasswordSuccess {
    sessionToken: String!
    item: User!
  }

  type UserAuthenticationWithPasswordFailure {
    message: String!
  }

  type RedeemUserPasswordResetTokenResult {
    code: PasswordResetRedemptionErrorCode!
    message: String!
  }

  enum PasswordResetRedemptionErrorCode {
    FAILURE
    TOKEN_EXPIRED
    TOKEN_REDEEMED
  }
`;
