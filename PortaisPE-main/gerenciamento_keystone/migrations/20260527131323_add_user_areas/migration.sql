-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL DEFAULT '',
    "email" TEXT NOT NULL DEFAULT '',
    "password" TEXT NOT NULL,
    "role" TEXT DEFAULT 'operator',
    "resetCode" TEXT NOT NULL DEFAULT '',
    "passwordResetToken" TEXT,
    "passwordResetIssuedAt" TIMESTAMP(3),
    "passwordResetRedeemedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3),
    "gerencia" TEXT,
    "setor" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLogs" (
    "id" TEXT NOT NULL,
    "dataAcao" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "usuario" TEXT NOT NULL DEFAULT '',
    "operacao" TEXT,
    "tabela" TEXT NOT NULL DEFAULT '',
    "itemId" TEXT NOT NULL DEFAULT '',
    "itemTitulo" TEXT NOT NULL DEFAULT '',
    "mudancas" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "AuditLogs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Servicos" (
    "id" TEXT NOT NULL,
    "titulo" TEXT NOT NULL DEFAULT '',
    "slug" TEXT NOT NULL DEFAULT '',
    "categoria" TEXT NOT NULL,
    "imagem_id" TEXT,
    "imagem_filesize" INTEGER,
    "imagem_width" INTEGER,
    "imagem_height" INTEGER,
    "imagem_extension" TEXT,
    "imagemAlt" TEXT NOT NULL DEFAULT '',
    "resumo" TEXT NOT NULL DEFAULT '',
    "oQueE" JSONB NOT NULL DEFAULT '[{"type":"paragraph","children":[{"text":""}]}]',
    "quemPrecisa" JSONB NOT NULL DEFAULT '[{"type":"paragraph","children":[{"text":""}]}]',
    "baseNormativa" JSONB NOT NULL DEFAULT '[{"type":"paragraph","children":[{"text":""}]}]',
    "comoSolicitar" JSONB NOT NULL DEFAULT '[{"type":"paragraph","children":[{"text":""}]}]',
    "areaResponsavel" TEXT,
    "createdAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL DEFAULT '',
    "updatedAt" TIMESTAMP(3),
    "updatedBy" TEXT NOT NULL DEFAULT '',
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Servicos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Solucoes" (
    "id" TEXT NOT NULL,
    "titulo" TEXT NOT NULL DEFAULT '',
    "slug" TEXT NOT NULL DEFAULT '',
    "categoria" TEXT NOT NULL,
    "imagem_id" TEXT,
    "imagem_filesize" INTEGER,
    "imagem_width" INTEGER,
    "imagem_height" INTEGER,
    "imagem_extension" TEXT,
    "imagemAlt" TEXT NOT NULL DEFAULT '',
    "resumo" TEXT NOT NULL DEFAULT '',
    "corpo" JSONB NOT NULL DEFAULT '[{"type":"paragraph","children":[{"text":""}]}]',
    "linkExterno" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Solucoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Noticia" (
    "id" TEXT NOT NULL,
    "titulo" TEXT NOT NULL DEFAULT '',
    "subtitulo" TEXT NOT NULL DEFAULT '',
    "autor" TEXT,
    "dataPublicacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imagemPrincipal_id" TEXT,
    "imagemPrincipal_filesize" INTEGER,
    "imagemPrincipal_width" INTEGER,
    "imagemPrincipal_height" INTEGER,
    "imagemPrincipal_extension" TEXT,
    "imagemPrincipalAlt" TEXT NOT NULL DEFAULT '',
    "corpo" JSONB NOT NULL DEFAULT '[{"type":"paragraph","children":[{"text":""}]}]',
    "categoria" TEXT NOT NULL,
    "destaque" BOOLEAN NOT NULL DEFAULT false,
    "resumo" TEXT NOT NULL DEFAULT '',
    "etiqueta" TEXT NOT NULL DEFAULT 'INFORMAÇÕES',
    "slug" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Noticia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Legislacoes" (
    "id" TEXT NOT NULL,
    "titulo" TEXT NOT NULL DEFAULT '',
    "linkExterno" TEXT NOT NULL DEFAULT '',
    "area" TEXT NOT NULL,
    "categoria" TEXT NOT NULL,
    "resumo" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Legislacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cursos" (
    "id" TEXT NOT NULL,
    "titulo" TEXT NOT NULL DEFAULT '',
    "slug" TEXT NOT NULL DEFAULT '',
    "resumo" TEXT NOT NULL DEFAULT '',
    "linkExterno" TEXT NOT NULL DEFAULT '',
    "categoria" TEXT NOT NULL DEFAULT 'outros',
    "dataDoCurso" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Cursos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaginaQuemSomos" (
    "id" INTEGER NOT NULL,
    "tituloDaPagina" TEXT NOT NULL DEFAULT 'Quem Somos',
    "muralTextoIntrodutorio" TEXT NOT NULL DEFAULT '',
    "organogramaTitulo" TEXT NOT NULL DEFAULT 'Organograma',
    "organogramaImagem_id" TEXT,
    "organogramaImagem_filesize" INTEGER,
    "organogramaImagem_width" INTEGER,
    "organogramaImagem_height" INTEGER,
    "organogramaImagem_extension" TEXT,
    "organogramaImagemAlt" TEXT NOT NULL DEFAULT '',
    "patrimonioImobiliario" TEXT NOT NULL DEFAULT '',
    "patrimonioMovel" TEXT NOT NULL DEFAULT '',
    "engenhariaArquitetura" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "PaginaQuemSomos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MuralItem" (
    "id" TEXT NOT NULL,
    "valor" TEXT NOT NULL DEFAULT '',
    "titulo" TEXT NOT NULL DEFAULT '',
    "descricao" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "MuralItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gerencia" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Gerencia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AreasResponsaveis" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL DEFAULT '',
    "telefone1" TEXT NOT NULL DEFAULT '',
    "telefone2" TEXT NOT NULL DEFAULT '',
    "responsavel" TEXT NOT NULL DEFAULT '',
    "email" TEXT NOT NULL DEFAULT '',
    "createdAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL DEFAULT '',
    "updatedAt" TIMESTAMP(3),
    "updatedBy" TEXT NOT NULL DEFAULT '',
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "AreasResponsaveis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Setor" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL DEFAULT '',
    "gerencia" TEXT,

    CONSTRAINT "Setor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gestores" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL DEFAULT '',
    "cargo" TEXT NOT NULL DEFAULT '',
    "descricao" TEXT NOT NULL DEFAULT '',
    "email" TEXT NOT NULL DEFAULT '',
    "telefone" TEXT NOT NULL DEFAULT '',
    "foto_id" TEXT,
    "foto_filesize" INTEGER,
    "foto_width" INTEGER,
    "foto_height" INTEGER,
    "foto_extension" TEXT,

    CONSTRAINT "Gestores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_Noticia_tags" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_PaginaQuemSomos_muralItens" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_AreaResponsavel_gestores" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_User_areas" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_gerencia_idx" ON "User"("gerencia");

-- CreateIndex
CREATE INDEX "User_setor_idx" ON "User"("setor");

-- CreateIndex
CREATE UNIQUE INDEX "Servicos_slug_key" ON "Servicos"("slug");

-- CreateIndex
CREATE INDEX "Servicos_areaResponsavel_idx" ON "Servicos"("areaResponsavel");

-- CreateIndex
CREATE UNIQUE INDEX "Solucoes_slug_key" ON "Solucoes"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Noticia_slug_key" ON "Noticia"("slug");

-- CreateIndex
CREATE INDEX "Noticia_autor_idx" ON "Noticia"("autor");

-- CreateIndex
CREATE UNIQUE INDEX "Cursos_slug_key" ON "Cursos"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Gerencia_nome_key" ON "Gerencia"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_nome_key" ON "Tag"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "Setor_nome_key" ON "Setor"("nome");

-- CreateIndex
CREATE INDEX "Setor_gerencia_idx" ON "Setor"("gerencia");

-- CreateIndex
CREATE UNIQUE INDEX "_Noticia_tags_AB_unique" ON "_Noticia_tags"("A", "B");

-- CreateIndex
CREATE INDEX "_Noticia_tags_B_index" ON "_Noticia_tags"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_PaginaQuemSomos_muralItens_AB_unique" ON "_PaginaQuemSomos_muralItens"("A", "B");

-- CreateIndex
CREATE INDEX "_PaginaQuemSomos_muralItens_B_index" ON "_PaginaQuemSomos_muralItens"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AreaResponsavel_gestores_AB_unique" ON "_AreaResponsavel_gestores"("A", "B");

-- CreateIndex
CREATE INDEX "_AreaResponsavel_gestores_B_index" ON "_AreaResponsavel_gestores"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_User_areas_AB_unique" ON "_User_areas"("A", "B");

-- CreateIndex
CREATE INDEX "_User_areas_B_index" ON "_User_areas"("B");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_gerencia_fkey" FOREIGN KEY ("gerencia") REFERENCES "Gerencia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_setor_fkey" FOREIGN KEY ("setor") REFERENCES "Setor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Servicos" ADD CONSTRAINT "Servicos_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES "AreasResponsaveis"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Noticia" ADD CONSTRAINT "Noticia_autor_fkey" FOREIGN KEY ("autor") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Setor" ADD CONSTRAINT "Setor_gerencia_fkey" FOREIGN KEY ("gerencia") REFERENCES "Gerencia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Noticia_tags" ADD CONSTRAINT "_Noticia_tags_A_fkey" FOREIGN KEY ("A") REFERENCES "Noticia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Noticia_tags" ADD CONSTRAINT "_Noticia_tags_B_fkey" FOREIGN KEY ("B") REFERENCES "Tag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PaginaQuemSomos_muralItens" ADD CONSTRAINT "_PaginaQuemSomos_muralItens_A_fkey" FOREIGN KEY ("A") REFERENCES "MuralItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PaginaQuemSomos_muralItens" ADD CONSTRAINT "_PaginaQuemSomos_muralItens_B_fkey" FOREIGN KEY ("B") REFERENCES "PaginaQuemSomos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AreaResponsavel_gestores" ADD CONSTRAINT "_AreaResponsavel_gestores_A_fkey" FOREIGN KEY ("A") REFERENCES "AreasResponsaveis"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AreaResponsavel_gestores" ADD CONSTRAINT "_AreaResponsavel_gestores_B_fkey" FOREIGN KEY ("B") REFERENCES "Gestores"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_User_areas" ADD CONSTRAINT "_User_areas_A_fkey" FOREIGN KEY ("A") REFERENCES "AreasResponsaveis"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_User_areas" ADD CONSTRAINT "_User_areas_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
