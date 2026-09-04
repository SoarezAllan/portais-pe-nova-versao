--
-- PostgreSQL database dump
--

\restrict QAEwDa6guV0bxXux6654XvIxqJflaoF5mKd0KbkcVupMeqFMgnDfbCrpVnGbCba

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public."_User_areas" DROP CONSTRAINT IF EXISTS "_User_areas_B_fkey";
ALTER TABLE IF EXISTS ONLY public."_User_areas" DROP CONSTRAINT IF EXISTS "_User_areas_A_fkey";
ALTER TABLE IF EXISTS ONLY public."_Noticia_tags" DROP CONSTRAINT IF EXISTS "_Noticia_tags_B_fkey";
ALTER TABLE IF EXISTS ONLY public."_Noticia_tags" DROP CONSTRAINT IF EXISTS "_Noticia_tags_A_fkey";
ALTER TABLE IF EXISTS ONLY public."Tag" DROP CONSTRAINT IF EXISTS "Tag_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Tag" DROP CONSTRAINT IF EXISTS "Tag_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."Subareas" DROP CONSTRAINT IF EXISTS "Subareas_area_fkey";
ALTER TABLE IF EXISTS ONLY public."Solucoes" DROP CONSTRAINT IF EXISTS "Solucoes_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Solucoes" DROP CONSTRAINT IF EXISTS "Solucoes_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."Setores" DROP CONSTRAINT IF EXISTS "Setores_gerencia_fkey";
ALTER TABLE IF EXISTS ONLY public."Servicos" DROP CONSTRAINT IF EXISTS "Servicos_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Servicos" DROP CONSTRAINT IF EXISTS "Servicos_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosTimeItem" DROP CONSTRAINT IF EXISTS "QuemSomosTimeItem_pagina_fkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosSubareaItem" DROP CONSTRAINT IF EXISTS "QuemSomosSubareaItem_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosSubareaItem" DROP CONSTRAINT IF EXISTS "QuemSomosSubareaItem_pagina_fkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosMuralItem" DROP CONSTRAINT IF EXISTS "QuemSomosMuralItem_pagina_fkey";
ALTER TABLE IF EXISTS ONLY public."Portfolios" DROP CONSTRAINT IF EXISTS "Portfolios_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Portfolios" DROP CONSTRAINT IF EXISTS "Portfolios_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."PortfolioImagens" DROP CONSTRAINT IF EXISTS "PortfolioImagens_portfolio_fkey";
ALTER TABLE IF EXISTS ONLY public."PaginaQuemSomos" DROP CONSTRAINT IF EXISTS "PaginaQuemSomos_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."PaginaQuemSomos" DROP CONSTRAINT IF EXISTS "PaginaQuemSomos_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."Noticia" DROP CONSTRAINT IF EXISTS "Noticia_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Noticia" DROP CONSTRAINT IF EXISTS "Noticia_autor_fkey";
ALTER TABLE IF EXISTS ONLY public."Noticia" DROP CONSTRAINT IF EXISTS "Noticia_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."Legislacoes" DROP CONSTRAINT IF EXISTS "Legislacoes_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Legislacoes" DROP CONSTRAINT IF EXISTS "Legislacoes_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."Gestores" DROP CONSTRAINT IF EXISTS "Gestores_areaResponsavel_fkey";
ALTER TABLE IF EXISTS ONLY public."Gerencias" DROP CONSTRAINT IF EXISTS "Gerencias_area_fkey";
ALTER TABLE IF EXISTS ONLY public."Cursos" DROP CONSTRAINT IF EXISTS "Cursos_subarea_fkey";
ALTER TABLE IF EXISTS ONLY public."Cursos" DROP CONSTRAINT IF EXISTS "Cursos_areaResponsavel_fkey";
DROP INDEX IF EXISTS public."_User_areas_B_index";
DROP INDEX IF EXISTS public."_User_areas_AB_unique";
DROP INDEX IF EXISTS public."_Noticia_tags_B_index";
DROP INDEX IF EXISTS public."_Noticia_tags_AB_unique";
DROP INDEX IF EXISTS public."User_email_key";
DROP INDEX IF EXISTS public."Tag_subarea_idx";
DROP INDEX IF EXISTS public."Tag_nome_key";
DROP INDEX IF EXISTS public."Tag_areaResponsavel_idx";
DROP INDEX IF EXISTS public."Subareas_area_idx";
DROP INDEX IF EXISTS public."Solucoes_subarea_idx";
DROP INDEX IF EXISTS public."Solucoes_slug_key";
DROP INDEX IF EXISTS public."Solucoes_areaResponsavel_idx";
DROP INDEX IF EXISTS public."Setores_gerencia_idx";
DROP INDEX IF EXISTS public."Servicos_subarea_idx";
DROP INDEX IF EXISTS public."Servicos_slug_key";
DROP INDEX IF EXISTS public."Servicos_areaResponsavel_idx";
DROP INDEX IF EXISTS public."QuemSomosTimeItem_pagina_idx";
DROP INDEX IF EXISTS public."QuemSomosSubareaItem_subarea_idx";
DROP INDEX IF EXISTS public."QuemSomosSubareaItem_pagina_idx";
DROP INDEX IF EXISTS public."QuemSomosMuralItem_pagina_idx";
DROP INDEX IF EXISTS public."Portfolios_subarea_idx";
DROP INDEX IF EXISTS public."Portfolios_slug_key";
DROP INDEX IF EXISTS public."Portfolios_areaResponsavel_idx";
DROP INDEX IF EXISTS public."PortfolioImagens_portfolio_idx";
DROP INDEX IF EXISTS public."PaginaQuemSomos_subarea_idx";
DROP INDEX IF EXISTS public."PaginaQuemSomos_areaResponsavel_idx";
DROP INDEX IF EXISTS public."Noticia_subarea_idx";
DROP INDEX IF EXISTS public."Noticia_slug_key";
DROP INDEX IF EXISTS public."Noticia_autor_idx";
DROP INDEX IF EXISTS public."Noticia_areaResponsavel_idx";
DROP INDEX IF EXISTS public."Legislacoes_subarea_idx";
DROP INDEX IF EXISTS public."Legislacoes_areaResponsavel_idx";
DROP INDEX IF EXISTS public."Gestores_areaResponsavel_idx";
DROP INDEX IF EXISTS public."Gerencias_area_idx";
DROP INDEX IF EXISTS public."Cursos_subarea_idx";
DROP INDEX IF EXISTS public."Cursos_areaResponsavel_idx";
ALTER TABLE IF EXISTS ONLY public._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_pkey";
ALTER TABLE IF EXISTS ONLY public."Tag" DROP CONSTRAINT IF EXISTS "Tag_pkey";
ALTER TABLE IF EXISTS ONLY public."Subareas" DROP CONSTRAINT IF EXISTS "Subareas_pkey";
ALTER TABLE IF EXISTS ONLY public."Solucoes" DROP CONSTRAINT IF EXISTS "Solucoes_pkey";
ALTER TABLE IF EXISTS ONLY public."Setores" DROP CONSTRAINT IF EXISTS "Setores_pkey";
ALTER TABLE IF EXISTS ONLY public."Servicos" DROP CONSTRAINT IF EXISTS "Servicos_pkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosTimeItem" DROP CONSTRAINT IF EXISTS "QuemSomosTimeItem_pkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosSubareaItem" DROP CONSTRAINT IF EXISTS "QuemSomosSubareaItem_pkey";
ALTER TABLE IF EXISTS ONLY public."QuemSomosMuralItem" DROP CONSTRAINT IF EXISTS "QuemSomosMuralItem_pkey";
ALTER TABLE IF EXISTS ONLY public."Portfolios" DROP CONSTRAINT IF EXISTS "Portfolios_pkey";
ALTER TABLE IF EXISTS ONLY public."PortfolioImagens" DROP CONSTRAINT IF EXISTS "PortfolioImagens_pkey";
ALTER TABLE IF EXISTS ONLY public."PaginaQuemSomos" DROP CONSTRAINT IF EXISTS "PaginaQuemSomos_pkey";
ALTER TABLE IF EXISTS ONLY public."Noticia" DROP CONSTRAINT IF EXISTS "Noticia_pkey";
ALTER TABLE IF EXISTS ONLY public."Legislacoes" DROP CONSTRAINT IF EXISTS "Legislacoes_pkey";
ALTER TABLE IF EXISTS ONLY public."Gestores" DROP CONSTRAINT IF EXISTS "Gestores_pkey";
ALTER TABLE IF EXISTS ONLY public."Gerencias" DROP CONSTRAINT IF EXISTS "Gerencias_pkey";
ALTER TABLE IF EXISTS ONLY public."Cursos" DROP CONSTRAINT IF EXISTS "Cursos_pkey";
ALTER TABLE IF EXISTS ONLY public."AuditLogs" DROP CONSTRAINT IF EXISTS "AuditLogs_pkey";
ALTER TABLE IF EXISTS ONLY public."AreasResponsaveis" DROP CONSTRAINT IF EXISTS "AreasResponsaveis_pkey";
ALTER TABLE IF EXISTS ONLY public."Acesso" DROP CONSTRAINT IF EXISTS "Acesso_pkey";
DROP TABLE IF EXISTS public._prisma_migrations;
DROP TABLE IF EXISTS public."_User_areas";
DROP TABLE IF EXISTS public."_Noticia_tags";
DROP TABLE IF EXISTS public."User";
DROP TABLE IF EXISTS public."Tag";
DROP TABLE IF EXISTS public."Subareas";
DROP TABLE IF EXISTS public."Solucoes";
DROP TABLE IF EXISTS public."Setores";
DROP TABLE IF EXISTS public."Servicos";
DROP TABLE IF EXISTS public."QuemSomosTimeItem";
DROP TABLE IF EXISTS public."QuemSomosSubareaItem";
DROP TABLE IF EXISTS public."QuemSomosMuralItem";
DROP TABLE IF EXISTS public."Portfolios";
DROP TABLE IF EXISTS public."PortfolioImagens";
DROP TABLE IF EXISTS public."PaginaQuemSomos";
DROP TABLE IF EXISTS public."Noticia";
DROP TABLE IF EXISTS public."Legislacoes";
DROP TABLE IF EXISTS public."Gestores";
DROP TABLE IF EXISTS public."Gerencias";
DROP TABLE IF EXISTS public."Cursos";
DROP TABLE IF EXISTS public."AuditLogs";
DROP TABLE IF EXISTS public."AreasResponsaveis";
DROP TABLE IF EXISTS public."Acesso";
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: patrimonio_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO patrimonio_user;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: patrimonio_user
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Acesso" (
    id text NOT NULL,
    portal text DEFAULT ''::text NOT NULL,
    area text DEFAULT ''::text NOT NULL,
    usuario text DEFAULT ''::text NOT NULL,
    ip text DEFAULT ''::text NOT NULL,
    "dataAcesso" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    tipo text DEFAULT 'PORTAL_VIEW'::text NOT NULL
);


ALTER TABLE public."Acesso" OWNER TO postgres;

--
-- Name: AreasResponsaveis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AreasResponsaveis" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL,
    "deletedAt" timestamp(3) without time zone,
    "deletedBy" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."AreasResponsaveis" OWNER TO postgres;

--
-- Name: AuditLogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AuditLogs" (
    id text NOT NULL,
    "dataAcao" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    usuario text DEFAULT ''::text NOT NULL,
    operacao text,
    tabela text DEFAULT ''::text NOT NULL,
    "itemId" text DEFAULT ''::text NOT NULL,
    "itemTitulo" text DEFAULT ''::text NOT NULL,
    mudancas text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."AuditLogs" OWNER TO postgres;

--
-- Name: Cursos; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Cursos" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    "linkExterno" text DEFAULT ''::text NOT NULL,
    "dataDoCurso" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "areaResponsavel" text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    subarea text,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL,
    status text DEFAULT 'PROGRAMADO'::text NOT NULL,
    local text DEFAULT ''::text NOT NULL,
    modalidade text DEFAULT 'PRESENCIAL'::text NOT NULL
);


ALTER TABLE public."Cursos" OWNER TO patrimonio_user;

--
-- Name: Gerencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Gerencias" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    responsavel text DEFAULT ''::text NOT NULL,
    telefone1 text DEFAULT ''::text NOT NULL,
    telefone2 text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    area text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Gerencias" OWNER TO postgres;

--
-- Name: Gestores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Gestores" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    cargo text DEFAULT ''::text NOT NULL,
    descricao text DEFAULT ''::text NOT NULL,
    foto_id text,
    foto_filesize integer,
    foto_width integer,
    foto_height integer,
    foto_extension text,
    "areaResponsavel" text
);


ALTER TABLE public."Gestores" OWNER TO postgres;

--
-- Name: Legislacoes; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Legislacoes" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    "linkExterno" text DEFAULT ''::text NOT NULL,
    categoria text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    "areaResponsavel" text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    subarea text,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Legislacoes" OWNER TO patrimonio_user;

--
-- Name: Noticia; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Noticia" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    subtitulo text DEFAULT ''::text NOT NULL,
    autor text,
    "dataPublicacao" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "imagemPrincipal_id" text,
    "imagemPrincipal_filesize" integer,
    "imagemPrincipal_width" integer,
    "imagemPrincipal_height" integer,
    "imagemPrincipal_extension" text,
    "imagemPrincipalAlt" text DEFAULT ''::text NOT NULL,
    corpo jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    destaque boolean DEFAULT false NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    slug text DEFAULT ''::text NOT NULL,
    "areaResponsavel" text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    subarea text,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Noticia" OWNER TO patrimonio_user;

--
-- Name: PaginaQuemSomos; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."PaginaQuemSomos" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    "areaResponsavel" text,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "muralTextoIntrodutorio" text DEFAULT ''::text NOT NULL,
    subarea text,
    "timeTitulo" text DEFAULT 'Nosso Time'::text NOT NULL,
    "tituloDaPagina" text DEFAULT 'Sobre'::text NOT NULL
);


ALTER TABLE public."PaginaQuemSomos" OWNER TO patrimonio_user;

--
-- Name: PortfolioImagens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PortfolioImagens" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    imagem_id text,
    imagem_filesize integer,
    imagem_width integer,
    imagem_height integer,
    imagem_extension text,
    portfolio text,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."PortfolioImagens" OWNER TO postgres;

--
-- Name: Portfolios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Portfolios" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    slug text DEFAULT ''::text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    imagem_id text,
    imagem_filesize integer,
    imagem_width integer,
    imagem_height integer,
    imagem_extension text,
    "imagemAlt" text DEFAULT ''::text NOT NULL,
    corpo jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "areaResponsavel" text,
    subarea text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Portfolios" OWNER TO postgres;

--
-- Name: QuemSomosMuralItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuemSomosMuralItem" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    descricao text DEFAULT ''::text NOT NULL,
    pagina text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    valor text DEFAULT ''::text NOT NULL,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."QuemSomosMuralItem" OWNER TO postgres;

--
-- Name: QuemSomosSubareaItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuemSomosSubareaItem" (
    id text NOT NULL,
    subarea text,
    pagina text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    conteudo text DEFAULT ''::text NOT NULL,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."QuemSomosSubareaItem" OWNER TO postgres;

--
-- Name: QuemSomosTimeItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuemSomosTimeItem" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    cargo text DEFAULT ''::text NOT NULL,
    descricao text DEFAULT ''::text NOT NULL,
    pagina text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    foto_extension text,
    foto_filesize integer,
    foto_height integer,
    foto_id text,
    foto_width integer,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."QuemSomosTimeItem" OWNER TO postgres;

--
-- Name: Servicos; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Servicos" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    slug text DEFAULT ''::text NOT NULL,
    imagem_id text,
    imagem_filesize integer,
    imagem_width integer,
    imagem_height integer,
    imagem_extension text,
    "imagemAlt" text DEFAULT ''::text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    "oQueE" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "quemPrecisa" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "comoSolicitar" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "areaResponsavel" text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL,
    "deletedAt" timestamp(3) without time zone,
    "deletedBy" text DEFAULT ''::text NOT NULL,
    subarea text,
    "maisInformacoes" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Servicos" OWNER TO patrimonio_user;

--
-- Name: Setores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Setores" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    gerencia text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Setores" OWNER TO postgres;

--
-- Name: Solucoes; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Solucoes" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    slug text DEFAULT ''::text NOT NULL,
    categoria text NOT NULL,
    imagem_id text,
    imagem_filesize integer,
    imagem_width integer,
    imagem_height integer,
    imagem_extension text,
    "imagemAlt" text DEFAULT ''::text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    corpo jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "linkExterno" text DEFAULT ''::text NOT NULL,
    "areaResponsavel" text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    subarea text,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Solucoes" OWNER TO patrimonio_user;

--
-- Name: Subareas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Subareas" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    area text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Subareas" OWNER TO postgres;

--
-- Name: Tag; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Tag" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    "areaResponsavel" text,
    subarea text
);


ALTER TABLE public."Tag" OWNER TO patrimonio_user;

--
-- Name: User; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."User" (
    id text NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    password text NOT NULL,
    role text DEFAULT 'operator'::text,
    "resetCode" text DEFAULT ''::text NOT NULL,
    "passwordResetToken" text,
    "passwordResetIssuedAt" timestamp(3) without time zone,
    "passwordResetRedeemedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone
);


ALTER TABLE public."User" OWNER TO patrimonio_user;

--
-- Name: _Noticia_tags; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."_Noticia_tags" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_Noticia_tags" OWNER TO patrimonio_user;

--
-- Name: _User_areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_User_areas" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_User_areas" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Data for Name: Acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Acesso" (id, portal, area, usuario, ip, "dataAcesso", tipo) FROM stdin;
cmrt5y1ev0000xbme221orz56	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:50:38.494	PORTAL_VIEW
cmrt67jro0005xbmeg4y62wjo	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.92	2026-07-20 11:57:58.317	PORTAL_VIEW
cmrt8l6uu0004mdi1jt2b2pvw	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 13:04:37.874	SERVICO_VIEW
cmrtgh80k0008mdi1sfgkdl9q	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-20 16:45:25.779	PORTAL_VIEW
cmrtn51fp000bbqr5mj5q8ave	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-20 19:51:54.68	SERVICO_VIEW
cmruminut0007jzjxyyu06o7m	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-21 12:22:20.877	PORTAL_VIEW
cmrur6vut0000d883vckttk36	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-21 14:33:03.737	PORTAL_VIEW
cmruw8w7w0014d883499b8jxj	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-07-21 16:52:51.607	PORTAL_VIEW
cmruw8w8h0015d883f8fkql5z	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-07-21 16:52:52.21	SERVICO_VIEW
cmruz1d3k001hd883tt0ckkbb	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.148	2026-07-21 18:12:54.62	PORTAL_VIEW
cmrv1h818001ld883cd9oomis	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:21:27.638	PORTAL_VIEW
cmrv1h8nn001md883o4ueb8h9	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:21:28.62	PORTAL_VIEW
cmrv3z6mc001td88367gkhhni	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-21 20:31:04.919	PORTAL_VIEW
cmrv4a9l5000128k92kz0z3h8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:39:41.991	PORTAL_VIEW
cmrv4aez9000228k981hx2i3g	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:39:49.013	PORTAL_VIEW
cmrv4aeza000328k9f00djvdh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:39:49.016	PORTAL_VIEW
cmrv4k9ap000t28k9cnckmc3n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:47:28.262	PORTAL_VIEW
cmrvzy0ia000x28k9ldwo2v34	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:25:58.152	PORTAL_VIEW
cmrvzy8gq000y28k9rynmgvrf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:26:08.468	PORTAL_VIEW
cmrvzy8gr000z28k9mf4bw5dk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:26:08.468	PORTAL_VIEW
cmrvzy8lv001028k9tqc4qwpn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:26:08.65	PORTAL_VIEW
cmrvzy8me001128k96bxpp7wb	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:26:08.651	PORTAL_VIEW
cmrvzy8q7001228k9j29ygsal	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:26:08.812	PORTAL_VIEW
cmrw0nczl000u11htwurt27ic	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.734	PORTAL_VIEW
cmrw0tt38001011htm5kiv2yk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:41.476	PORTAL_VIEW
cmrw0ua11001b11htq56xozj8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:51:03.478	PORTAL_VIEW
cmrw0upcw001c11hteg9omsot	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:51:23.35	PORTAL_VIEW
cmrw0upcy001d11httvnizroh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:51:23.352	PORTAL_VIEW
cmrw0w8du001e11htfmugci0e	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:52:34.664	PORTAL_VIEW
cmrw0w9o5001h11hto3jb9usx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:52:36.339	PORTAL_VIEW
cmrw0waeq001i11htcie5wzq1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:52:37.295	PORTAL_VIEW
cmrw0waet001j11htk6jk0diq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:52:37.297	PORTAL_VIEW
cmrw0wwuo001k11hty5eq7w68	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:53:06.376	PORTAL_VIEW
cmrw0wxaw001n11htfg4zmjaf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:53:06.965	PORTAL_VIEW
cmrw0yh10001o11htzskof0ih	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:54:19.18	PORTAL_VIEW
cmrw0yl4q001r11ht3oa4gfnv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:54:24.502	PORTAL_VIEW
cmrw10c6d001x11ht5rh83wuj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:55:46.162	PORTAL_VIEW
cmrw13ss1001y11htmdtsndg7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:58:27.686	PORTAL_VIEW
cmrw1cagd002311htldn81mgc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 12:05:03.828	PORTAL_VIEW
cmrw1o72q002611htjrcx5gs8	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 12:14:13.037	SERVICO_VIEW
cmrw3hdoi0000jmlr5aq6j5vs	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 13:04:54.217	SERVICO_VIEW
cmrw3w5x2000051o3wf0981zy	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 13:16:23.954	SERVICO_VIEW
cmrw4w4g100016luz8th5bkin	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 13:44:28.028	SERVICO_VIEW
cmrw4waky00026luzhjpip11e	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-22 13:44:35.982	SERVICO_VIEW
cmrw5ne0y0000kwhyf8e9jfwt	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 14:05:33.835	SERVICO_VIEW
cmrwadxl50000kn2lbm98qo3d	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 16:18:16.968	SERVICO_VIEW
cmrwc30m1000214idcunp9ej6	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:05:46.964	SERVICO_VIEW
cmrwcbmsi000010wga17tjxuo	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:12:28.883	SERVICO_VIEW
cmrwd3iyt0002ezmc87rgh48u	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:34:10.37	SERVICO_VIEW
cmrwdpjl0000hezmcankc29a0	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:51:17.597	SERVICO_VIEW
cmrt5yqfr0001xbmej9ajfotj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:51:10.806	PORTAL_VIEW
cmrt73a1w0000mdi10b3bj1pz	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-20 12:22:42.586	SERVICO_VIEW
cmrt77wpy0003mdi1ajb1j1qc	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-20 12:26:18.595	SERVICO_VIEW
cmrtb889y0005mdi1l457qr6l	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-07-20 14:18:31.986	PORTAL_VIEW
cmrtma6e2000omdi1duxxzgvz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.92	2026-07-20 19:27:54.758	PORTAL_VIEW
cmrtncvmj0000b6em2f6poepc	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 19:58:04.306	NOTICIA_VIEW
cmrumwsay0008jzjx20gf2owt	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-21 12:33:13.899	PORTAL_VIEW
cmrushlb3000fd883zn2yfirw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-21 15:09:28.473	PORTAL_VIEW
cmruxeal4001dd88351eixfye	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-21 17:26:52.988	PORTAL_VIEW
cmruztka3001id8835v8tq8xy	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.132	2026-07-21 18:34:59.945	PORTAL_VIEW
cmrv1i3uo001nd883eorf7yop	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:22:09.087	SERVICO_VIEW
cmrv1iqjx001od883xfa8a1o6	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:22:38.507	SERVICO_VIEW
cmrv1ivk9001pd883cxsu9hp5	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:22:44.995	SERVICO_VIEW
cmrv1jg9b001rd8833mx1na70	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:23:11.821	SERVICO_VIEW
cmrv48run0000nm7h4bhl2oxz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 20:38:52.43	SERVICO_VIEW
cmrv4bccc000428k9bqxugnch	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:32.305	PORTAL_VIEW
cmrv4bds8000b28k9hvnv8qsi	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:34.18	PORTAL_VIEW
cmrv4c221000c28k9emhumss7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:41:05.63	PORTAL_VIEW
cmrv4c2ec000f28k9miumxyh8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:41:06.081	PORTAL_VIEW
cmrv4c7c0000g28k92ztt2j35	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:41:12.472	PORTAL_VIEW
cmrv4ft0s000j28k92kfwopz9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:00.546	PORTAL_VIEW
cmrv4fv9c000k28k91pjl99ix	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.452	PORTAL_VIEW
cmrv4fvht000p28k9mh28176h	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.758	PORTAL_VIEW
cmrv4fvm6000q28k9b8sggtnn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.913	PORTAL_VIEW
cmrv4fvmb000r28k953fkxa52	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.915	PORTAL_VIEW
cmrvzxrzv000u28k9y3zuxohx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:25:46.885	PORTAL_VIEW
cmrw0jy26000011htf44nvnus	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:43:01.359	PORTAL_VIEW
cmrw0ntc4000y11htiaf5wv8n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:46:01.916	PORTAL_VIEW
cmrw0tt3a001111htxlmt5iqm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:41.479	PORTAL_VIEW
cmrw0tvei001211htj4r7jgzr	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:44.534	PORTAL_VIEW
cmrw0tvej001311htth7c3sje	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:44.536	PORTAL_VIEW
cmrw0tvuj001411ht1bfza8zo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:45.109	PORTAL_VIEW
cmrw0tvuk001511htxck52np1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:45.11	PORTAL_VIEW
cmrw0tvyw001611htctrln7fs	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:45.269	PORTAL_VIEW
cmrw0tvyx001711htcxo42ruw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:45.27	PORTAL_VIEW
cmrw0tw4h001811htzr8yosua	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:45.469	PORTAL_VIEW
cmrw0tw4l001911ht61genfge	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:50:45.471	PORTAL_VIEW
cmrw0ua0y001a11ht7znlxxbl	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:51:03.468	PORTAL_VIEW
cmrw0w8dv001f11htfr90zv16	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:52:34.666	PORTAL_VIEW
cmrw0w9o4001g11htliidbqqr	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:52:36.338	PORTAL_VIEW
cmrw0wwuo001l11htw1o10q06	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:53:06.378	PORTAL_VIEW
cmrw0wxav001m11ht9tdwwctd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:53:06.963	PORTAL_VIEW
cmrw0yh11001p11htoypikzgq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:54:19.181	PORTAL_VIEW
cmrw0yl4p001q11htv52azce6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:54:24.501	PORTAL_VIEW
cmrw0ywmf001t11htoczzi8pe	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:54:39.391	PORTAL_VIEW
cmrw0zrz9001u11htohkqzltq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:55:20.03	PORTAL_VIEW
cmrw142v4002011htx4m4ygmk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:58:40.762	PORTAL_VIEW
cmrw18ky9002211htbdjcvfi4	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 12:02:10.828	PORTAL_VIEW
cmrw1cage002411ht4htatyh2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 12:05:03.83	PORTAL_VIEW
cmrw1pwcx002711ht2r7e7ai7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 12:15:32.463	SERVICO_VIEW
cmrt5zloo0002xbmeaxir016i	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:51:51.428	PORTAL_VIEW
cmrt60inh0003xbmeycpfzyba	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:52:34.152	PORTAL_VIEW
cmrt73emc0001mdi1j1adrj2f	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-20 12:22:48.509	SERVICO_VIEW
cmrtb8b4z0006mdi109n0nifh	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-20 14:18:35.775	PORTAL_VIEW
cmrtmiv35000pmdi1gxxminpm	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.92	2026-07-20 19:34:40.021	SERVICO_VIEW
cmrumcaqc0003jzjxnsctp9j3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-21 12:17:23.723	PORTAL_VIEW
cmrupiaur0002qshwrjc2v4j5	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-21 13:46:02.726	SERVICO_VIEW
cmrusy9x0000zd8834m8cio82	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-21 15:22:26.864	SERVICO_VIEW
cmruxi8dq001ed883w8imuxa5	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-21 17:29:50.855	SERVICO_VIEW
cmrv0ctk9001jd883i5oeqqcq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-21 18:49:42.819	PORTAL_VIEW
cmrv1j0v5001qd883irts5rxn	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:22:51.873	SERVICO_VIEW
cmrv49qsp0001nm7hjzuf0sh5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:39:17.727	PORTAL_VIEW
cmrv49qsu0002nm7h6ac0dq4l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:39:17.737	PORTAL_VIEW
cmrv4bcce000528k91c7rzng8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:32.306	PORTAL_VIEW
cmrv4bdl4000628k9tswcvst5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:33.923	PORTAL_VIEW
cmrv4bdl6000728k9k8yuqr6e	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:33.925	PORTAL_VIEW
cmrv4bdov000828k98kae5xci	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:34.057	PORTAL_VIEW
cmrv4bdox000928k9zberhhm4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:34.059	PORTAL_VIEW
cmrv4bds6000a28k9mouhgfqv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:40:34.178	PORTAL_VIEW
cmrv4c222000d28k9d33ux9p1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:41:05.633	PORTAL_VIEW
cmrv4c2eb000e28k9liyq6rnz	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:41:06.079	PORTAL_VIEW
cmrv4c7c0000h28k9pzx92jyu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:41:12.474	PORTAL_VIEW
cmrv4ft0r000i28k9kgb59p0a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:00.544	PORTAL_VIEW
cmrv4fv9d000l28k9k2loeurb	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.453	PORTAL_VIEW
cmrv4fveq000m28k91d3g3f2i	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.647	PORTAL_VIEW
cmrv4fveu000n28k94hd8rwue	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.648	PORTAL_VIEW
cmrv4fvhr000o28k9pdqlr6gc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:44:03.755	PORTAL_VIEW
cmrvzxs07000v28k9ctp6a4pk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:25:46.887	PORTAL_VIEW
cmrw0jy35000111ht2c6bs4hg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:43:01.358	PORTAL_VIEW
cmrw0kk59000211htgofg20ia	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:43:30.037	PORTAL_VIEW
cmrw0kk5a000311htnxb391dj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:43:30.038	PORTAL_VIEW
cmrw0l90f000411htkfmk9uln	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:44:02.263	PORTAL_VIEW
cmrw0l90i000511htgj9vzs1h	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:44:02.264	PORTAL_VIEW
cmrw0lreu000611htgkqys9vu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:44:26.11	PORTAL_VIEW
cmrw0lrew000711htkuax6a5a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:44:26.111	PORTAL_VIEW
cmrw0ltzl000811ht4xgqnej6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:44:29.453	PORTAL_VIEW
cmrw0ltzo000911htgoqgjicy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:44:29.454	PORTAL_VIEW
cmrw0mq1u000a11ht44t0v6ac	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:11.002	PORTAL_VIEW
cmrw0mq1v000b11ht3w9gyyr1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:11.004	PORTAL_VIEW
cmrw0mq68000c11htgsbb5pcp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:11.165	PORTAL_VIEW
cmrw0mq6a000d11ht1okkbbba	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:11.166	PORTAL_VIEW
cmrw0nab3000e11htlw1l8rlq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:37.246	PORTAL_VIEW
cmrw0nab7000f11hty5ntl6wm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:37.247	PORTAL_VIEW
cmrw0nbyv000g11htz3b0q4lk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:39.411	PORTAL_VIEW
cmrw0nbyw000h11htlnotk4f9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:39.412	PORTAL_VIEW
cmrw0nc6u000i11htcexx3lto	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:39.699	PORTAL_VIEW
cmrw0nc6z000j11htyluzy4y1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:39.701	PORTAL_VIEW
cmrw0ncbj000k11ht94yme9qt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:39.868	PORTAL_VIEW
cmrw0ncpy000r11htqyp2gp3p	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.388	PORTAL_VIEW
cmrw0ncuz000s11ht3pz81wkh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.568	PORTAL_VIEW
cmrw0ncv0000t11htv1rqvqkf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.569	PORTAL_VIEW
cmrt60srn0004xbmevm1s2125	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:52:47.263	PORTAL_VIEW
cmrt76gcj0002mdi1vghngqj7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-20 12:25:10.719	NOTICIA_VIEW
cmrtgdb9j0007mdi131cxx8s2	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-20 16:42:27.296	SERVICO_VIEW
cmrtn4rm2000abqr5ifbmxtbx	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-20 19:51:39.666	PORTAL_VIEW
cmrumectw0004jzjxdgvigb16	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-21 12:18:59.966	PORTAL_VIEW
cmrupibm90003qshwoc4i6rqb	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-21 13:46:03.726	SERVICO_VIEW
cmruvsipk0013d8832vj3if73	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-21 16:41:51.593	SERVICO_VIEW
cmruyq4cd001gd883r1riazyb	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-21 18:04:04.414	SERVICO_VIEW
cmrv0vqwo001kd883jxb3qcxw	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-07-21 19:04:25.073	PORTAL_VIEW
cmrv1qszr001sd883cw975cn9	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::9059:7586:6ed6:321d%21	2026-07-21 19:28:54.915	SERVICO_VIEW
cmrv4a9jv000028k9jscnrqq7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:39:41.989	PORTAL_VIEW
cmrv4k9ao000s28k940k5hqhp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-21 20:47:28.26	PORTAL_VIEW
cmrvzy0i9000w28k9geoofxil	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:25:58.15	PORTAL_VIEW
cmrvzy8q8001328k90zffr4tm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:26:08.813	PORTAL_VIEW
cmrw0nccr000l11ht580ahlma	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:39.87	PORTAL_VIEW
cmrw0ncgp000m11htnps9tzkv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.052	PORTAL_VIEW
cmrw0ncgs000n11ht7ivylt70	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.054	PORTAL_VIEW
cmrw0ncm1000o11ht6fllmkoh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.244	PORTAL_VIEW
cmrt5o6ih0008clahj14t9up5	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:42:58.547	PORTAL_VIEW
cmrt5o6ip0009clah435xbh92	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-20 11:42:58.558	PORTAL_VIEW
cmrw0ncm3000p11ht5mvaolou	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.246	PORTAL_VIEW
cmrw0ncpx000q11htrxk3vgvn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.386	PORTAL_VIEW
cmrw0nczn000v11htlmkg5g65	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.735	PORTAL_VIEW
cmrw0nd4e000w11ht5zrd93nk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.906	PORTAL_VIEW
cmrw0nd4j000x11htjqqx2lab	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:45:40.907	PORTAL_VIEW
cmrw0ntc5000z11ht5gti1lpv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:46:01.917	PORTAL_VIEW
cmrw0ywmd001s11htvfwug7js	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:54:39.389	PORTAL_VIEW
cmrw0zrza001v11htramywudx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:55:20.032	PORTAL_VIEW
cmrw10c56001w11ht5iwz3bu7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:55:46.16	PORTAL_VIEW
cmrw13ss1001z11htktcyi781	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:58:27.69	PORTAL_VIEW
cmrw142vh002111htq4anadsv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 11:58:40.764	PORTAL_VIEW
cmrw1ltmu002511ht9l0wv2kr	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 12:12:22.083	PORTAL_VIEW
cmrw258dn002811ht0rkh4hwb	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 12:27:27.88	SERVICO_VIEW
cmrw3pmei0000f6jczpjut95x	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 13:11:18.738	SERVICO_VIEW
cmrw4jm7n00006luzunf8oqi7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 13:34:44.523	SERVICO_VIEW
cmrw4x6cc00036luzjahl4eor	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 13:45:17.119	SERVICO_VIEW
cmrw7zx750000jpo74mux5d64	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 15:11:24.097	SERVICO_VIEW
cmrwbik10000031qzxsvpc6dj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 16:49:52.265	PORTAL_VIEW
cmrwbik1r000131qzaj4mnaq1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-22 16:49:52.266	PORTAL_VIEW
cmrwc37iu000314idt587hufd	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:05:55.922	SERVICO_VIEW
cmrwc3co3000414id3j7y387p	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:06:02.59	SERVICO_VIEW
cmrwc3ip9000514idnbk7sjdq	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:06:10.41	SERVICO_VIEW
cmrwd0yhi0000ezmcnis7r4gf	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 17:32:04.152	SERVICO_VIEW
cmrwdi2ol000aezmc6tw7fg3g	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:45:29.107	SERVICO_VIEW
cmrwe0qcu000324rvkywgpipl	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 17:59:59.592	SERVICO_VIEW
cmrwe34l0000524rv0w88halm	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:01:51.342	SERVICO_VIEW
cmrweaceb0000htwtd3lfhmwd	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:07:28.059	SERVICO_VIEW
cmrweec6r0001htwtgi7et8g3	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:10:34.412	SERVICO_VIEW
cmrweh1qi0002htwt81nu9jkx	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:12:40.839	SERVICO_VIEW
cmrwet7d40007htwte387g6z9	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:22:08.004	SERVICO_VIEW
cmrwf10mi000fhtwtwfdwn1x8	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:28:12.518	SERVICO_VIEW
cmrwf5yoe000lhtwtxdldyrml	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:32:03.273	SERVICO_VIEW
cmrwfdglr00048laws163i6ut	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:37:53.098	SERVICO_VIEW
cmrwfo6u000058lawxz0fgn4h	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:46:13.649	SERVICO_VIEW
cmrwfz8f00000x42imrt96sqh	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-22 18:54:42.547	SERVICO_VIEW
cmrwg09eo0001x42ii718xze0	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 18:55:36.859	SERVICO_VIEW
cmrwg78pe00036qu35yu6p9lm	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-22 19:01:02.54	SERVICO_VIEW
cmrxgdvjw0000a05rnyka0g7k	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-23 11:53:49.715	PORTAL_VIEW
cmrxhiwlr0001a05rumm7119t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 12:25:51.311	PORTAL_VIEW
cmrxi7kha0002a05rodiexcii	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 12:45:02.308	SERVICO_VIEW
cmrxn0pve0004a05rd87sg0ac	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 14:59:40.15	NOTICIA_VIEW
cmrxn1ena0005a05rox107b10	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 15:00:12.242	PORTAL_VIEW
cmrxn1hri0006a05rafsgv3kb	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 15:00:16.308	NOTICIA_VIEW
cmrxn2vxo0008a05rhyl4g4m4	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 15:01:21.322	NOTICIA_VIEW
cmrxoepie0009a05rjpyzx95g	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 15:38:32.2	PORTAL_VIEW
cmrxof2lu000aa05reu53poc7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 15:38:49.475	NOTICIA_VIEW
cmrxof4ym000ba05rmafqkl6v	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 15:38:52.535	NOTICIA_VIEW
cmrxpudop000ca05r1ms7pem8	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 16:18:43.283	PORTAL_VIEW
cmrxpudqy000da05rzczjr6pf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 16:18:43.285	PORTAL_VIEW
cmrxpudr2000ea05r3ns5bhht	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 16:18:43.287	PORTAL_VIEW
cmrxq0c5b000fa05re8ta602s	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-07-23 16:23:21.201	PORTAL_VIEW
cmrxr9xzs000ga05rju1mvj9x	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 16:58:50.558	PORTAL_VIEW
cmrxr9xzs000ha05r10li3u8h	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 16:58:50.559	PORTAL_VIEW
cmrxraixw000ia05rupro943v	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 16:59:17.75	PORTAL_VIEW
cmrxrd27g000ja05rgnmj4wvu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 17:01:15.997	PORTAL_VIEW
cmrxrd27h000ka05r3k1l6pe1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 17:01:15.998	PORTAL_VIEW
cmrxs6jr5000la05r61flqtun	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-07-23 17:24:11.771	SERVICO_VIEW
cmrxsh4ph000ma05rcodpsj14	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 17:32:25.534	NOTICIA_VIEW
cmrxsmpxr000na05rrh7t7mt1	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 17:36:46.317	PORTAL_VIEW
cmrxsmwu5000oa05rzijhdezs	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 17:36:55.272	NOTICIA_VIEW
cmrxsp2h5000pa05rp0j0yetq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 17:38:35.753	PORTAL_VIEW
cmrxsp2h7000qa05rjii4vb6y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 17:38:35.755	PORTAL_VIEW
cmrxsp7t1000ra05rs92yefp8	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 17:38:42.754	NOTICIA_VIEW
cmrxsvp7j000ta05rkxlolpd9	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 17:43:45.264	PORTAL_VIEW
cmrxsvvzl000ua05rxhrfalc9	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-07-23 17:43:54.072	PORTAL_VIEW
cmrxtihg70015a05r2rskvt0j	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:01:28.276	NOTICIA_VIEW
cmrxtjy1t0017a05rhsdkn2u3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:02:36.443	SERVICO_VIEW
cmrxtk4cl0018a05r8sc1py03	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:02:44.608	NOTICIA_VIEW
cmrxtrvl90000b70won1malof	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:08:46.454	NOTICIA_VIEW
cmrxtxmyk0001b70wno8pjtwj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:13:15.256	NOTICIA_VIEW
cmrxty3wp0002b70wzt2rcwwk	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:13:37.221	NOTICIA_VIEW
cmrxty4s40003b70w2gt2twjd	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:13:38.353	NOTICIA_VIEW
cmrxue5c40000uovf4flwlg7u	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-23 18:25:57.398	SERVICO_VIEW
cmrxukpe400003kynht2kt7jk	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:31:11.492	NOTICIA_VIEW
cmrxuuew60000v50tan0cf1ki	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:38:44.447	SERVICO_VIEW
cmrxv0iyg0003v50t6yy87jz8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 18:43:29.624	PORTAL_VIEW
cmrxv0iyi0004v50tu6quuwr9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 18:43:29.626	PORTAL_VIEW
cmrxv0k5t0005v50tunr52ryl	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 18:43:31.214	NOTICIA_VIEW
cmrxv0l1u0006v50tfi2vr3hi	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 18:43:32.368	NOTICIA_VIEW
cmrxv0lg20007v50tr9vcqtrn	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 18:43:32.88	NOTICIA_VIEW
cmrxv1bdh0008v50ttqs7ui3s	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:44:06.481	NOTICIA_VIEW
cmrxvb1oc0009v50tqicdcgrz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:51:40.472	NOTICIA_VIEW
cmrxvb5od000av50tprw1brnm	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 18:51:45.656	NOTICIA_VIEW
cmrxw8z5g0000fyqbam6st2b4	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 19:18:03.437	PORTAL_VIEW
cmrxw9b2s0001fyqbe4d8j0n7	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 19:18:19.051	PORTAL_VIEW
cmrxw9b400002fyqbxzgacav4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 19:18:19.053	PORTAL_VIEW
cmrxw9b430003fyqbuazmqvzi	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 19:18:19.054	PORTAL_VIEW
cmrxwb53l0000w8indj4of5sn	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 19:19:44.63	NOTICIA_VIEW
cmrxwermh0002w8in70vlsgvi	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:22:33.684	NOTICIA_VIEW
cmrxwew2j0003w8inq4c8qk5q	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 19:22:39.55	SERVICO_VIEW
cmrxwezwb0004w8in8ie4n8cl	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 19:22:44.52	SERVICO_VIEW
cmrxwfnml0005w8in6wt9tmxs	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:23:15.16	NOTICIA_VIEW
cmrxwh7d60006w8in7p7f46rq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-23 19:24:27.509	SERVICO_VIEW
cmrxwm2710007w8in7r8u7kca	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 19:28:13.918	PORTAL_VIEW
cmrxwm2720008w8ino35hktp5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-07-23 19:28:13.921	PORTAL_VIEW
cmrxwri31000fw8inuxrigb61	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:32:27.85	NOTICIA_VIEW
cmrxwvgvq000kw8inktvlkgj6	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:35:32.916	NOTICIA_VIEW
cmrxx17n8000nw8inrfym1bbe	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 19:40:00.985	PORTAL_VIEW
cmrxx17nm000ow8inii950d7y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-07-23 19:40:00.986	PORTAL_VIEW
cmrxxdax9000pw8infzfsc6i7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-23 19:49:16.417	PORTAL_VIEW
cmrxxdt0h0000113lxktnguz6	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-23 19:49:40.267	SERVICO_VIEW
cmrxxfpew00003oi2zvjc3alg	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:51:17.089	NOTICIA_VIEW
cmrxxfqav00013oi2e8plrlf7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:51:18.242	NOTICIA_VIEW
cmrxxfqmz00023oi2jakwta36	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:51:18.679	NOTICIA_VIEW
cmrxxfrg100033oi2xco4nm75	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:51:19.726	NOTICIA_VIEW
cmrxxlb43000011nr98dd86pc	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:38.488	SERVICO_VIEW
cmrxxlc2t000111nrvnn9kjjo	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:39.746	SERVICO_VIEW
cmrxxlccy000211nrn2cpwlsq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:40.11	SERVICO_VIEW
cmrxxlcom000311nre876dd4l	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:40.531	SERVICO_VIEW
cmrxxlcya000411nr741k8l30	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:40.879	SERVICO_VIEW
cmrxxldeg000511nr2eous938	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:41.461	SERVICO_VIEW
cmrxxldv7000611nr302tn56q	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-23 19:55:42.063	SERVICO_VIEW
cmryufphv000066t61impgja3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 11:15:04.123	PORTAL_VIEW
cmryugbr3000166t6fk880spq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 11:15:32.989	SERVICO_VIEW
cmryuocqm000366t6h7wejscs	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 11:21:47.519	SERVICO_VIEW
cmryv7ed1000566t6cp27vbru	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-07-24 11:36:36.466	NOTICIA_VIEW
cmryvmkqe000966t6k9iy51i4	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 11:48:24.198	SERVICO_VIEW
cmryvn3y9000a66t6x3ur9b8u	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 11:48:49.104	SERVICO_VIEW
cmryvuakg000e66t6ph39ikak	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 11:54:24.276	SERVICO_VIEW
cmryxc0km0001eveoyt0ubr3t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 12:36:10.757	PORTAL_VIEW
cmryxfsjy0002eveoxqy89gqu	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-24 12:39:07.399	PORTAL_VIEW
cmryxh52o0003eveokzofhjms	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-24 12:40:10.269	PORTAL_VIEW
cmryz60w1000geveo6mwm3z7v	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-24 13:27:30.913	SERVICO_VIEW
cmryza6tf000oeveoljpzbczu	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 13:30:44.8	SERVICO_VIEW
cmryzad7u000peveoqqdu7ust	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 13:30:53.095	SERVICO_VIEW
cmryzapej000qeveox25ye5it	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 13:31:08.892	SERVICO_VIEW
cmrz1qi55000reveopp6xrcuc	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-24 14:39:25.652	NOTICIA_VIEW
cmrz88p7w000seveo65s8snhh	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-24 17:41:32.294	SERVICO_VIEW
cmrz8yfor000teveo8es68338	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-07-24 18:01:32.863	SERVICO_VIEW
cmrzbadq5000ueveoitn16s89	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-07-24 19:06:48.824	PORTAL_VIEW
cms35b6t700002ggin3bp9x6m	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-07-27 11:30:34.231	PORTAL_VIEW
cms35b6tz00012ggitz9tlr8b	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-07-27 11:30:34.233	PORTAL_VIEW
cms35b6u000022ggifbd1encd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-07-27 11:30:34.234	PORTAL_VIEW
cms35b8gu00032ggichjohllj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-07-27 11:30:36.391	PORTAL_VIEW
cms35bcv700042ggij36vk17q	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-27 11:30:42.074	PORTAL_VIEW
cms35bncs00052ggiw7ppw4a6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-07-27 11:30:55.681	PORTAL_VIEW
cms35bruf00062ggiidbk9dng	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-27 11:31:01.502	SERVICO_VIEW
cms36i48n000j2ggir63y0bfo	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-27 12:03:57.103	NOTICIA_VIEW
cms36nve2000k2ggi5a41owr4	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-27 12:08:25.566	SERVICO_VIEW
cms36nwrc000l2ggivxa0f6e3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-27 12:08:27.352	SERVICO_VIEW
cms36w17l000q2ggioj9a93kh	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-27 12:14:46.367	NOTICIA_VIEW
cms3fgrt900102ggiuw74bsmo	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-27 16:14:50.338	PORTAL_VIEW
cms3fksl000112ggijggzn80u	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-27 16:17:58.399	SERVICO_VIEW
cms3fmnko00122ggikgg8m1n7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-27 16:19:25.217	SERVICO_VIEW
cms3jab0o00162ggicnxuu7qk	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-27 18:01:47.626	SERVICO_VIEW
cms4lgwtr00172ggifya5g6yw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-28 11:50:41.213	SERVICO_VIEW
cms4pbw5j00182ggir51qenn2	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.146	2026-07-28 13:34:52.481	PORTAL_VIEW
cms4pchd500192ggibq0kngoe	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.146	2026-07-28 13:35:22.607	SERVICO_VIEW
cms4pdlx4001a2ggio31eq7vu	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:15.104	PORTAL_VIEW
cms4pdlyo001b2ggicyqlk5g9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:15.107	PORTAL_VIEW
cms4pdlyq001c2gginavjedp9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:15.115	PORTAL_VIEW
cms4pe4h2001d2ggibgcogbgi	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:39.213	SERVICO_VIEW
cms4pe75z001e2ggiu6ok5fgi	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:42.603	PORTAL_VIEW
cms4pe764001f2ggin6cue4c2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:42.604	PORTAL_VIEW
cms4peg0p001g2ggi6hsp6lia	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:54.073	PORTAL_VIEW
cms4peg0t001h2ggim45n0eaw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:36:54.074	PORTAL_VIEW
cms4peqqa001i2ggi0mhv8ds1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.146	2026-07-28 13:37:08.025	PORTAL_VIEW
cms4petes001j2ggi2voyesf9	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.146	2026-07-28 13:37:11.536	SERVICO_VIEW
cms4pfg1o001k2ggiohqnmzz3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:37:40.784	PORTAL_VIEW
cms4pfg2a001l2ggikdrk0a68	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.146	2026-07-28 13:37:40.786	PORTAL_VIEW
cms4ruj8x001m2ggi3zs6yly5	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.146	2026-07-28 14:45:24.081	NOTICIA_VIEW
cms4t4q56001n2ggivxj9vjm5	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.59	2026-07-28 15:23:12.874	PORTAL_VIEW
cms4t4s29001o2ggighfpx0wg	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-07-28 15:23:15.919	PORTAL_VIEW
cms4taybt001p2ggir2drdv3o	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-07-28 15:28:01.656	PORTAL_VIEW
cms4tayce001q2ggics421c4h	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-07-28 15:28:04.021	SERVICO_VIEW
cms4x2mpi001r2ggispzr7kq0	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-28 17:15:27.819	PORTAL_VIEW
cms4x56t3001s2ggieo1kl6jg	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-28 17:17:27.567	SERVICO_VIEW
cms4x6x8p001u2ggibnx5jcde	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-28 17:18:50.679	SERVICO_VIEW
cms4x9657001v2ggin7mgljt3	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-28 17:20:33.33	SERVICO_VIEW
cms4z0639001x2ggiygza3l0h	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-07-28 18:09:32.576	SERVICO_VIEW
cms4zunz4001y2ggio1u2ge5t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 18:33:17.793	PORTAL_VIEW
cms500e6g001z2ggifv24zbep	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 18:37:45.052	SERVICO_VIEW
cms50v90u00202ggigml13rmj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 19:01:44.714	SERVICO_VIEW
cms50vcke00212ggign2aq7wv	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 19:01:49.321	SERVICO_VIEW
cms510jir00222ggimqnplqfo	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 19:05:51.609	SERVICO_VIEW
cms51872400232ggica748pbz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 19:11:48.715	SERVICO_VIEW
cms518oql00242ggib0npsof1	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-28 19:12:11.627	SERVICO_VIEW
cms7fr7ko00252gginhqr67ng	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-30 11:34:02.23	PORTAL_VIEW
cms7fraoc00262ggiuuzfpo9y	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-07-30 11:34:06.535	PORTAL_VIEW
cms7qhqo600272ggibcgn6tg2	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-30 16:34:36.364	PORTAL_VIEW
cms7qkqif00282ggiatc4ng9t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-30 16:36:56.396	SERVICO_VIEW
cms7qyunl00292ggiiecry329	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-30 16:47:54.934	SERVICO_VIEW
cms7tduh9002a2ggimrg96p1i	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-30 17:55:33.42	SERVICO_VIEW
cms90ax1d002b2ggix40vywnk	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-31 13:57:00.554	NOTICIA_VIEW
cms90ayae002c2ggi621kt9m7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-07-31 13:57:02.179	NOTICIA_VIEW
cmsd67xgs002d2ggisbexwg3n	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-08-03 11:51:41.106	SERVICO_VIEW
cmsd67xw7002e2ggirau6ovek	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-08-03 11:51:40.163	PORTAL_VIEW
cmsd7qfrr002f2ggixgs7qtzb	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-03 12:36:06.333	PORTAL_VIEW
cmsd7qo8k002g2ggiavtia2bn	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:17.575	PORTAL_VIEW
cmsd7qo9n002h2ggi6jx0qozi	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:17.578	PORTAL_VIEW
cmsd7qo9r002i2ggihudrb9ek	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:17.579	PORTAL_VIEW
cmsd7qt47002k2ggil03acuwl	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:23.892	PORTAL_VIEW
cmsd7qt46002j2ggiaayyxk2j	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:23.893	PORTAL_VIEW
cmsd7qttw002l2ggi7p5cdql2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:24.842	PORTAL_VIEW
cmsd7qttx002m2ggi6usstsd2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:24.841	PORTAL_VIEW
cmsd7qzv0002n2ggie8ecp4i1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:32.638	PORTAL_VIEW
cmsd7qzv1002o2ggirfmlwxvc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:32.638	PORTAL_VIEW
cmsd7r4jb002p2ggi88jatpt0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:38.712	PORTAL_VIEW
cmsd7r5bw002q2ggiasvog5ae	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:39.751	PORTAL_VIEW
cmsd7r6kf002r2ggi10bwrxyi	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:41.351	PORTAL_VIEW
cmsd7r6ki002s2ggitw6v1goe	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:41.352	PORTAL_VIEW
cmsd7rd63002t2ggipz570f1a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:49.897	PORTAL_VIEW
cmsd7rd6g002u2ggifa4apfez	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:49.898	PORTAL_VIEW
cmsd7rko3002v2ggiyba9tgi7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 12:36:59.615	PORTAL_VIEW
cmsd7xnsw002w2ggiou3o410o	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:41:43.555	PORTAL_VIEW
cmsd7xnun002x2ggiwts37qs6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:41:43.557	PORTAL_VIEW
cmsd7xnus002y2ggi35m01kf0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:41:43.559	PORTAL_VIEW
cmsd7xq41002z2ggi9dzclz2m	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:41:46.606	PORTAL_VIEW
cmsd7xq4g00302ggiyctwhvyo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:41:46.606	PORTAL_VIEW
cmsd8bipw00312ggi8p2xrsla	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-03 12:52:28.358	PORTAL_VIEW
cmsd8e1wy00322ggih05m9mio	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-03 12:54:26.792	PORTAL_VIEW
cmsd8id8k00332ggi4qnpyf7s	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:57:49.694	PORTAL_VIEW
cmsd8id8r00342ggi6xbsaf2i	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:57:49.694	PORTAL_VIEW
cmsd8izww00352ggilq3gflnp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:58:19.075	PORTAL_VIEW
cmsd8izwy00362ggi9b0jd5w7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-03 12:58:19.076	PORTAL_VIEW
cmsda120h00372ggig7nfracf	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-03 13:40:14.549	PORTAL_VIEW
cmsdb1m28003d2ggifq66hlxq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:08:46.818	PORTAL_VIEW
cmsdb1m29003e2gginmaipvge	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:08:46.819	PORTAL_VIEW
cmsdb2ugh003f2ggix496jzvd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:09:44.335	PORTAL_VIEW
cmsdb2ugj003g2ggizy5ajh45	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:09:44.335	PORTAL_VIEW
cmsdbgoam003h2ggiavnnfkmq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:20:29.497	PORTAL_VIEW
cmsdbgoan003i2ggiifru49tr	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:20:29.496	PORTAL_VIEW
cmsdbgobh003j2ggi5h0z0rfa	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:20:29.604	PORTAL_VIEW
cmsdbgobi003k2ggih6vilgd5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:20:29.605	PORTAL_VIEW
cmsdbnbho003l2ggiti8odsvt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:25:39.457	PORTAL_VIEW
cmsdbnbkp003m2gginzyvpj04	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:25:39.458	PORTAL_VIEW
cmsdbnboc003n2ggiuqg4oa7l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:25:39.796	PORTAL_VIEW
cmsdbnbod003o2ggice4hj0ct	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:25:39.795	PORTAL_VIEW
cmsdbwhgd003p2ggieguf4tyk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:32:46.908	PORTAL_VIEW
cmsdbwhge003q2ggi92a4t9w0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:32:46.907	PORTAL_VIEW
cmsdbyrtz003r2ggi349tsx3b	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:34:33.947	PORTAL_VIEW
cmsdbyru1003s2ggim6xmflzo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:34:33.946	PORTAL_VIEW
cmsdbytft003t2ggixk0pteyj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:34:36.044	PORTAL_VIEW
cmsdbytfu003u2ggi2jzitd1t	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:34:36.045	PORTAL_VIEW
cmsdc9sfi003v2ggiotko61rn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:07.879	PORTAL_VIEW
cmsdc9sfj003w2ggioi1l59om	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:07.88	PORTAL_VIEW
cmsdc9siv003x2ggic5he969y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.073	PORTAL_VIEW
cmsdc9six003y2ggituf8vgwt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.074	PORTAL_VIEW
cmsdc9slm003z2ggiahjg4198	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.169	PORTAL_VIEW
cmsdc9slm00402ggi1b5joqmv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.17	PORTAL_VIEW
cmsdc9sq500412ggi9r26ia0x	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.338	PORTAL_VIEW
cmsdc9sq800422ggi0t1v8jjj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.337	PORTAL_VIEW
cmsdc9sva00432ggixplch3x2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.52	PORTAL_VIEW
cmsdc9svc00442ggi4m2jcumy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.521	PORTAL_VIEW
cmsdc9szi00452ggiiux037ih	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.671	PORTAL_VIEW
cmsdc9szj00462ggiafrqp4vp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.672	PORTAL_VIEW
cmsdc9t4z00472ggihkpfjr52	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.868	PORTAL_VIEW
cmsdc9t5100482ggi17426rq8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:43:08.868	PORTAL_VIEW
cmsdcceto00492ggia7wafxu0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.245	PORTAL_VIEW
cmsdccetq004a2ggiuy0tahoh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.245	PORTAL_VIEW
cmsdccexx004b2ggix9vyujad	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.434	PORTAL_VIEW
cmsdccey3004c2ggish8b17ac	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.433	PORTAL_VIEW
cmsdccf1u004d2ggivf5f1fa3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.579	PORTAL_VIEW
cmsdccf1y004e2ggi217yoe44	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.58	PORTAL_VIEW
cmsdccf6h004f2ggiutpjhg51	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.748	PORTAL_VIEW
cmsdccf6j004g2ggimiktbpf9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.75	PORTAL_VIEW
cmsdccfbj004h2ggib5m66fuw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.93	PORTAL_VIEW
cmsdccfbl004i2ggiftsu3w80	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:10.931	PORTAL_VIEW
cmsdccfg7004j2ggizptv4emo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.097	PORTAL_VIEW
cmsdccfg9004k2ggigjqumz9j	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.098	PORTAL_VIEW
cmsdccfl9004l2ggiihuur2zw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.278	PORTAL_VIEW
cmsdccfl9004m2ggilo3qqr1r	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.279	PORTAL_VIEW
cmsdccfq8004n2ggic0vcnhok	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.459	PORTAL_VIEW
cmsdccfq9004o2ggi2hov8q6n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.46	PORTAL_VIEW
cmsdccfy8004p2ggi8g3ndom5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.745	PORTAL_VIEW
cmsdccfya004q2ggihrxozqgt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.744	PORTAL_VIEW
cmsdccg1z004r2ggin0swnkrx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.88	PORTAL_VIEW
cmsdccg20004s2ggisoo0vpa0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:11.881	PORTAL_VIEW
cmsdccgk0004u2ggiqvc02d3v	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:12.529	PORTAL_VIEW
cmsdccgk0004t2ggi44zweiw4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:12.528	PORTAL_VIEW
cmsdcch83004v2ggiscimydfk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:13.398	PORTAL_VIEW
cmsdcch84004w2ggiam7srr6h	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:13.397	PORTAL_VIEW
cmsdcchkp004x2ggi55jn2g09	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:13.851	PORTAL_VIEW
cmsdcchkr004y2ggidd274o3q	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:13.852	PORTAL_VIEW
cmsdcchsd004z2ggis4llyd10	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.129	PORTAL_VIEW
cmsdcchsd00502ggiveess36l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.13	PORTAL_VIEW
cmsdcchxs00512ggiz914ytlo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.321	PORTAL_VIEW
cmsdcci7h00562ggi69siqx41	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.668	PORTAL_VIEW
cmsdccidi00572ggikkj7t5zm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.889	PORTAL_VIEW
cmsdccj7w005a2ggi97juflvr	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:15.97	PORTAL_VIEW
cmsdccjcp005b2ggil1buqbs9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:16.155	PORTAL_VIEW
cmsdccjhx005e2ggipid93ybo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:16.343	PORTAL_VIEW
cmsdccjnd005f2ggiehz9vvur	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:16.54	PORTAL_VIEW
cmsdccjnf005g2ggicq323cbx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:16.541	PORTAL_VIEW
cmsdccm9f005h2ggi9u8657hn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:19.925	PORTAL_VIEW
cmsdccmeh005k2ggic37ap99z	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:20.104	PORTAL_VIEW
cmsdcdvi0005l2ggi39o65zjk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:18.519	PORTAL_VIEW
cmsdcdvi4005m2ggizwwd3imu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:18.52	PORTAL_VIEW
cmsdce2pe005n2ggimq7db613	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:27.864	PORTAL_VIEW
cmsdce2pq005o2ggie8r8bvs0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:27.863	PORTAL_VIEW
cmsdce2td005p2ggima6ipsju	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:28.035	PORTAL_VIEW
cmsdce2th005q2ggijs0txtza	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:28.036	PORTAL_VIEW
cmsdce2zx005r2ggie9psq483	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:28.271	PORTAL_VIEW
cmsdcchxt00522ggik7yf2955	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.321	PORTAL_VIEW
cmsdcci2k00532ggintfhv9c0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.495	PORTAL_VIEW
cmsdcci2o00542ggiz5cd6r8y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.495	PORTAL_VIEW
cmsdcci7f00552ggieztdjip4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.667	PORTAL_VIEW
cmsdccidl00582ggi0wgy60od	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:14.889	PORTAL_VIEW
cmsdccj7u00592ggip5ofuj71	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:15.969	PORTAL_VIEW
cmsdccjcs005c2ggidahv1w3a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:16.156	PORTAL_VIEW
cmsdccjhx005d2ggii2aovg4g	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:16.342	PORTAL_VIEW
cmsdccm9i005i2ggi8gdprw82	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:19.926	PORTAL_VIEW
cmsdccmeg005j2ggikwsa4go0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:45:20.105	PORTAL_VIEW
cmsdce2zz005s2ggirq7sdm0b	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:46:28.272	PORTAL_VIEW
cmsdcnebs005t2ggiego7mz8v	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:53:42.797	PORTAL_VIEW
cmsdcnebu005u2ggi5t4njn7c	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 14:53:42.798	PORTAL_VIEW
cmsdd46g6005v2ggivz93pm1c	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:45.703	PORTAL_VIEW
cmsdd46g7005w2ggikv6ji5li	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:45.701	PORTAL_VIEW
cmsdd46ls005x2ggiwtge2s6m	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:45.996	PORTAL_VIEW
cmsdd46lu005y2ggimuospiyp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:45.995	PORTAL_VIEW
cmsdd46qm005z2ggixkyfv6wy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.175	PORTAL_VIEW
cmsdd46qp00602ggil7releb5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.175	PORTAL_VIEW
cmsdd46u000612ggiv1znyw3c	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.296	PORTAL_VIEW
cmsdd46u000622ggiryumgl1e	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.297	PORTAL_VIEW
cmsdd46yq00632ggifudenwwk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.467	PORTAL_VIEW
cmsdd46ys00642ggiv4nkiooh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.468	PORTAL_VIEW
cmsdd473d00652ggizt0bp8zw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.63	PORTAL_VIEW
cmsdd473f00662ggi4xdyvoco	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.632	PORTAL_VIEW
cmsdd477800672ggi5h70a3ki	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.775	PORTAL_VIEW
cmsdd477b00682ggils265zo1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.775	PORTAL_VIEW
cmsdd47bw00692ggip9lapqjj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.944	PORTAL_VIEW
cmsdd47bx006a2gginobhetpv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:06:46.944	PORTAL_VIEW
cmsdd4ntb006b2ggi17knd6ft	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:07:08.291	PORTAL_VIEW
cmsdd4ntc006c2ggibjrap07x	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-03 15:07:08.29	PORTAL_VIEW
cmsdhr0gm006g2ggipwu4o3yt	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-03 17:16:23.201	NOTICIA_VIEW
cmselkezu006i2ggi5nw5esyq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-04 11:51:06.611	PORTAL_VIEW
cmsell1p4006j2ggic1gij1oa	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-04 11:51:36.251	SERVICO_VIEW
cmsempod0006k2ggi1cgwbgg3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.62	2026-08-04 12:23:11.185	PORTAL_VIEW
cmsemq7dm006l2ggigy27akw3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.62	2026-08-04 12:23:36.175	SERVICO_VIEW
cmsen0tk0006m2ggiugnlidke	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.62	2026-08-04 12:31:51.48	SERVICO_VIEW
cmsen0zut006n2ggig9h4j64n	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.62	2026-08-04 12:31:59.644	SERVICO_VIEW
cmsen161b006o2ggisnsl3pwo	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.62	2026-08-04 12:32:07.656	SERVICO_VIEW
cmsen3ctf006p2ggijfyttvtp	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.62	2026-08-04 12:33:49.757	SERVICO_VIEW
cmseph8wu006q2ggidaatamwo	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-04 13:40:36.478	PORTAL_VIEW
cmsephl5a006r2ggie0gtacfd	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-04 13:40:52.631	SERVICO_VIEW
cmsephpyx006s2ggi256c97qq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-04 13:40:58.878	SERVICO_VIEW
cmsephysc006t2ggirr2g9r6r	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-04 13:41:10.311	SERVICO_VIEW
cmseqosmr006u2ggijqc1kruj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-04 14:14:28.869	PORTAL_VIEW
cmseqove8006v2ggignbwz9dn	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-04 14:14:32.726	SERVICO_VIEW
cmsevkmla006w2ggipmvsxt0j	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-04 16:31:12.662	SERVICO_VIEW
cmsevms9t006x2ggi7e9i39i1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-04 16:32:52.746	PORTAL_VIEW
cmseyeg24006y2ggik10utld7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-04 17:50:22.581	SERVICO_VIEW
cmseygsxd006z2ggidgqmmprd	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-04 17:52:12.571	SERVICO_VIEW
cmseykt3k00702ggik318t5uc	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-04 17:55:16.294	PORTAL_VIEW
cmsezhhyj00712ggitfir8vb1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-04 18:20:44.133	SERVICO_VIEW
cmsezhpst00722ggiii7s8vzr	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-04 18:20:54.311	SERVICO_VIEW
cmsgbpyyw007b2ggi1saj8dxg	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-05 16:50:59.499	PORTAL_VIEW
cmsgbq2m7007c2ggi1smwje8e	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-05 16:51:04.506	SERVICO_VIEW
cmsgbqaf5007d2ggife8hyl7g	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-05 16:51:14.614	SERVICO_VIEW
cmsgez8yf007f2ggif3itd61a	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-05 18:22:11.469	SERVICO_VIEW
cmshgi6xs007i2ggi3v00g8m4	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-06 11:52:39.071	PORTAL_VIEW
cmshgjl6b007j2ggi95haqynj	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-06 11:53:44.601	NOTICIA_VIEW
cmshjwohm007k2ggihmtyd9zc	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-06 13:27:54.242	SERVICO_VIEW
cmshjx4na007l2ggiynykdrby	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-06 13:28:15.185	SERVICO_VIEW
cmshqeoxg007v2gginmrwv0t0	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-06 16:29:52.282	NOTICIA_VIEW
cmshrsdiu008a2ggi3frmwhix	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-06 17:08:30.294	NOTICIA_VIEW
cmshsjiei008b2ggiz3gcrhdj	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-06 17:29:40.072	SERVICO_VIEW
cmshx09g6008c2ggiwqafn297	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-06 19:34:39.329	PORTAL_VIEW
cmsiwvcuk008f2ggikv7qaw0w	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 12:18:37.044	PORTAL_VIEW
cmsj5wxim009z2ggio20g804l	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:31:47.168	SERVICO_VIEW
cmsj61zfq00a12ggimr1cp3ui	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:35:42.924	SERVICO_VIEW
cmsj65g6p00a22ggicbp9ijp4	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:38:24.603	SERVICO_VIEW
cmsj6bicj00a32ggi5n7ybhoj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:43:07.338	SERVICO_VIEW
cmsj6i5v600a42ggib97jbpls	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:48:17.751	SERVICO_VIEW
cmsj6mcug00a52ggixl403g1u	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:51:33.423	SERVICO_VIEW
cmsj6p3hq00a72ggi2ucbda1t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-07 16:53:41.258	SERVICO_VIEW
cmsj714lw00ab2ggij3vlnhop	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-07 17:03:09.997	PORTAL_VIEW
cmsn7atiq00ac2ggiz4vyurcm	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-10 12:21:39.391	PORTAL_VIEW
cmsn7axeq00ad2ggiz2go54ro	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-10 12:21:44.754	SERVICO_VIEW
cmsn7skyd00ae2ggiap38ks60	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-10 12:35:27.795	PORTAL_VIEW
cmsn82p6y00ah2ggi7amapsqy	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-10 12:43:20.486	SERVICO_VIEW
cmsn888k400ak2ggiw5fj6g24	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-10 12:47:38.859	SERVICO_VIEW
cmsn8cqa100an2ggimfc7nzm5	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-10 12:51:08.455	SERVICO_VIEW
cmsn9jhvf00as2ggib1jh0mh5	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-10 13:24:23.775	SERVICO_VIEW
cmsnb9x4a00b12ggixbfkrfgv	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-10 14:13:04.544	PORTAL_VIEW
cmsnbb43m00b22ggiicgt9bi2	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-10 14:14:00.541	SERVICO_VIEW
cmsnbbk7t00b32ggiw1bmyq4w	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-10 14:14:21.436	SERVICO_VIEW
cmsnbbptk00b42ggihlvnfk7e	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-10 14:14:28.687	SERVICO_VIEW
cmsnbc5ls00b52ggiawq2os6c	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-10 14:14:49.15	SERVICO_VIEW
cmsnbcrxr00b62ggiow8djf18	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.29	2026-08-10 14:15:18.094	SERVICO_VIEW
cmsnm3tcb00b92ggitg0jeimh	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-10 19:16:06.156	PORTAL_VIEW
cmsol3l1p00ba2ggim49v8c4f	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-11 11:35:42.558	PORTAL_VIEW
cmsol3l1z00bb2ggiyfkqnyet	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-11 11:35:42.56	PORTAL_VIEW
cmsol3l2n00bc2ggiah3gh2bv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-11 11:35:42.562	PORTAL_VIEW
cmsol3rzr00bd2gginwrroqmr	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-11 11:35:51.677	PORTAL_VIEW
cmsolticm00be2ggii5096v47	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 11:55:52.875	PORTAL_VIEW
cmsoniggi00bh2ggiipmkfzz0	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 12:43:16.39	SERVICO_VIEW
cmsoniqex00bi2ggioomi0cvx	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 12:43:29.294	SERVICO_VIEW
cmsonooua00bk2ggiu38z93ha	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 12:48:07.159	SERVICO_VIEW
cmsonp0h800bl2ggihivaihb4	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 12:48:22.239	SERVICO_VIEW
cmsoojha300bm2ggid35hx3dw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 13:12:03.563	SERVICO_VIEW
cmsookp6m00bn2ggivayhs6bp	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-11 13:13:00.455	SERVICO_VIEW
cmsoyjsaz00bp2ggi0i48p1bg	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-11 17:52:13.871	SERVICO_VIEW
cmssuzqge0001i6j3t2iifh1q	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-14 11:23:44.15	PORTAL_VIEW
cmssuzqgd0000i6j3bwvs4vob	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-14 11:23:44.15	PORTAL_VIEW
cmssv00820002i6j34gtomq2a	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-14 11:23:56.829	PORTAL_VIEW
cmssv00880003i6j3xyjt6vgm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-14 11:23:56.834	PORTAL_VIEW
cmssv00890004i6j3oanqpjlz	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-14 11:23:56.837	PORTAL_VIEW
cmssv1lhz0005i6j3bwvaa9b1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 11:25:11.058	PORTAL_VIEW
cmssx38fa0006i6j3n8c6bg2z	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 12:22:26.716	SERVICO_VIEW
cmssxr4ey0007i6j3ytd55bm1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 12:41:01.273	SERVICO_VIEW
cmsszm5200008i6j3l8pm93zl	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-14 13:33:07.665	PORTAL_VIEW
cmst13xtr0009i6j3slvpwx7t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-14 14:14:55.855	PORTAL_VIEW
cmst1444v000ai6j3t5sy77x3	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-14 14:15:04.191	PORTAL_VIEW
cmst14mei000bi6j35suaia0k	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-14 14:15:27.92	SERVICO_VIEW
cmst176ah000ci6j320ebt3cl	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-14 14:17:27.002	SERVICO_VIEW
cmst17ydg000di6j31a8f0qkn	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-14 14:18:03.404	SERVICO_VIEW
cmst1jzsg000ei6j3slpqdj3x	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-14 14:27:25.111	SERVICO_VIEW
cmst7ldb5000fi6j3wi1c0l31	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 17:16:29.067	NOTICIA_VIEW
cmst814r0000gi6j3t9opcp2s	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 17:28:44.47	NOTICIA_VIEW
cmstd0vd5000hi6j3x0m72exl	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 19:48:30.449	NOTICIA_VIEW
cmstd18ah000ii6j3zayl2vag	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-14 19:48:47.19	SERVICO_VIEW
cmsx5zb7q000013zxgcvjc5ee	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-17 11:42:24.594	PORTAL_VIEW
cmsx5zb9x000113zx4wricyav	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-17 11:42:24.595	PORTAL_VIEW
cmsx60u0a000213zxjdi6k245	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-17 11:43:36.396	PORTAL_VIEW
cmsx88mhy000313zxt9eq7w4b	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-17 12:45:38.981	PORTAL_VIEW
cmsxgvssf000413zxcgjcg85c	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-17 16:47:36.433	PORTAL_VIEW
cmsxicodb000513zxzuqva3pm	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-17 17:28:43.814	SERVICO_VIEW
cmsxidfrg000613zxha9lr0hs	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-17 17:29:19.31	SERVICO_VIEW
cmsxj4ayt000713zxviwf7n6v	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-17 17:50:13.125	SERVICO_VIEW
cmsxj4u28000813zx0so9tohb	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-17 17:50:37.874	SERVICO_VIEW
cmsylbstw000g13zxkp27sfez	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-18 11:39:47.76	PORTAL_VIEW
cmsyvqnjp000h13zxbhvotjfq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-18 16:31:17.687	PORTAL_VIEW
cmsywaqsz000i13zxg6xeia6b	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.42	2026-08-18 16:46:53.553	PORTAL_VIEW
cmsyxsplx000j13zx0am9u18n	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.42	2026-08-18 17:28:51.527	NOTICIA_VIEW
cmsyxu84n000k13zx9zle291y	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.42	2026-08-18 17:30:02.187	SERVICO_VIEW
cmsyxw4hq000l13zxcn06ld7t	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.42	2026-08-18 17:31:30.786	SERVICO_VIEW
cmsyy38qk000m13zxexof4yhd	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.42	2026-08-18 17:37:02.877	PORTAL_VIEW
cmsyy38rx000n13zx90guu31l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.42	2026-08-18 17:37:02.88	PORTAL_VIEW
cmsyy38sa000o13zx88o9c8ss	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.42	2026-08-18 17:37:02.882	PORTAL_VIEW
cmsyy3il8000p13zxm1clvdex	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.42	2026-08-18 17:37:15.644	PORTAL_VIEW
cmsyy4b5b000q13zxlelc1spq	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.42	2026-08-18 17:37:52.658	SERVICO_VIEW
cmsyy854j000r13zxjif3qa36	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.42	2026-08-18 17:40:51.482	SERVICO_VIEW
cmsz1dtko000s13zxdyrabx6m	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-18 19:09:15.998	PORTAL_VIEW
cmt048wjo000t13zx4ch2jof7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-19 13:17:11.395	PORTAL_VIEW
cmt048zyq000u13zxzrl23kj9	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-19 13:17:16.129	PORTAL_VIEW
cmt048zyt000v13zxxm3kvit3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-19 13:17:16.133	PORTAL_VIEW
cmt048zyu000w13zx32mynbyq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-19 13:17:16.136	PORTAL_VIEW
cmt04hzb2000x13zxus0729pl	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-19 13:24:14.521	PORTAL_VIEW
cmt05ctbt000z13zxjud7fx1j	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-19 13:48:13.378	SERVICO_VIEW
cmt1m0a97001013zx9vr66ygp	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-20 14:22:08.292	PORTAL_VIEW
cmt1mh8vi001113zxwocmp2kd	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-20 14:35:17.262	PORTAL_VIEW
cmt1mjeft001213zx0un0ndpt	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-20 14:36:58.23	SERVICO_VIEW
cmt1tcpwe001313zxklas3u51	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:47:44.98	PORTAL_VIEW
cmt1tcqnh001413zxc5upfxqx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:47:44.982	PORTAL_VIEW
cmt1tcqon001513zxowjhz8yf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:47:44.982	PORTAL_VIEW
cmt1tdtlm001613zxxasrzp9w	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:48:36.673	SERVICO_VIEW
cmt1tf6jq001713zxz0sz9ec8	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-20 17:49:40.071	PORTAL_VIEW
cmt1tfbpg001813zxbcrucady	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:49:46.787	PORTAL_VIEW
cmt1tfbq3001913zxxsbdgjrz	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:49:46.789	PORTAL_VIEW
cmt1tfbq8001a13zx2sadwye1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-20 17:49:46.79	PORTAL_VIEW
cmt1vdzm6001b13zxjado33u3	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.31	2026-08-20 18:44:44.061	PORTAL_VIEW
cmt1wrt0i001s13zx5e6r4qwg	Engenharia e Arquitetura	Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-08-20 19:23:27.173	PORTAL_VIEW
cmt1wrt5j001t13zxfihghz0h	Engenharia e Arquitetura	Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-08-20 19:23:27.172	PORTAL_VIEW
cmt2vhde8001u13zx0hgyw6d7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-21 11:35:08.531	PORTAL_VIEW
cmt2xc19z001v13zx3zr1df9g	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-21 12:26:58.389	PORTAL_VIEW
cmt2xcaf8001w13zxys0vo0s8	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.31	2026-08-21 12:27:10.504	PORTAL_VIEW
cmt2xf153001x13zxgbb4jrlt	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-21 12:29:18.683	PORTAL_VIEW
cmt2xf4uq001y13zxy9gotl3d	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-21 12:29:23.696	PORTAL_VIEW
cmt2zqd41001z13zxd5gmvrs5	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-21 13:34:06.836	PORTAL_VIEW
cmt2zt2np002013zxquqamc7n	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.66	2026-08-21 13:36:13.634	SERVICO_VIEW
cmt30f3u6002113zxryzv7gd8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 13:53:21.012	PORTAL_VIEW
cmt30f3u8002213zxuebve3ll	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 13:53:21.013	PORTAL_VIEW
cmt31y770002313zx3in6zh2p	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 14:36:11.677	PORTAL_VIEW
cmt31y772002413zxkv5u7h6j	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 14:36:11.676	PORTAL_VIEW
cmt328xpl002513zx1bcjccg7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 14:44:32.394	PORTAL_VIEW
cmt328xpn002613zxi7fu844a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 14:44:32.395	PORTAL_VIEW
cmt36i7fh002713zxx7mcemj0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 16:43:43.334	PORTAL_VIEW
cmt36i7fj002813zxirfcmxk5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 16:43:43.334	PORTAL_VIEW
cmt36t85o002913zxjucw10lt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 16:52:17.697	PORTAL_VIEW
cmt36t85q002a13zxsnydtjqk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 16:52:17.698	PORTAL_VIEW
cmt36yrlh002b13zx5pgxl1fm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 16:56:36.224	PORTAL_VIEW
cmt36yrlj002c13zxy5da2oug	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 16:56:36.223	PORTAL_VIEW
cmt38xjg2002d13zxs0c31xzr	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:51:37.952	PORTAL_VIEW
cmt38xjlk002e13zx4j14t6um	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:51:37.954	PORTAL_VIEW
cmt38xjqk002f13zxaz116df8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:51:38.65	PORTAL_VIEW
cmt38xk5m002g13zx1ykshpc0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:51:39.192	PORTAL_VIEW
cmt38xlg1002h13zxny2in72e	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:51:40.866	PORTAL_VIEW
cmt38xlhc002i13zxsdvk9tkc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:51:40.867	PORTAL_VIEW
cmt38ynbb002j13zxzzddetm2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:52:29.921	PORTAL_VIEW
cmt38ynbc002k13zxjo6xh8cz	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:52:29.922	PORTAL_VIEW
cmt38ynq0002l13zxktt852t2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:52:30.472	PORTAL_VIEW
cmt38ynq2002m13zxmqwy8lxg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:52:30.474	PORTAL_VIEW
cmt38ynzs002n13zxsljz9x8l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:52:30.825	PORTAL_VIEW
cmt38zl0l002o13zxgievoten	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:13.598	PORTAL_VIEW
cmt38zl0q002p13zx4s5vd412	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:13.599	PORTAL_VIEW
cmt390e9y002q13zxw8px46rm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:51.53	PORTAL_VIEW
cmt390e9z002r13zxmg4w8156	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:51.529	PORTAL_VIEW
cmt390g9y002s13zxq61f1cvv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:54.133	PORTAL_VIEW
cmt390gmc002u13zxi2g45j8o	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:54.584	PORTAL_VIEW
cmt390gz1002x13zxedpp3yyj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:55.036	PORTAL_VIEW
cmt390vtr002y13zxz6p21exy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:14.257	PORTAL_VIEW
cmt390vtv002z13zxyr4e41la	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:14.255	PORTAL_VIEW
cmt390wnc003013zx8dvfzczb	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:15.346	PORTAL_VIEW
cmt390wnh003113zxp1lskehn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:15.345	PORTAL_VIEW
cmt3917jl003213zxn1uj57on	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:29.464	PORTAL_VIEW
cmt391lwz003513zxxe5iou52	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:48.081	PORTAL_VIEW
cmt391m5k003613zxp5l9cs4c	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:48.408	PORTAL_VIEW
cmt391mhx003913zxhkl2li83	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:48.853	PORTAL_VIEW
cmt391wzd003a13zxcq3f0fb8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:55:02.431	PORTAL_VIEW
cmt390g9z002t13zx6eifbji9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:54.134	PORTAL_VIEW
cmt390gmd002v13zxqk7gbss2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:54.583	PORTAL_VIEW
cmt390gz0002w13zx9ioaoe9a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:53:55.035	PORTAL_VIEW
cmt3917jo003313zx2iu1022e	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:29.463	PORTAL_VIEW
cmt391lwz003413zxenl2sr7t	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:48.082	PORTAL_VIEW
cmt391m5l003713zxcdu2ibg1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:48.41	PORTAL_VIEW
cmt391mhs003813zxik1wpums	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:54:48.852	PORTAL_VIEW
cmt391wzf003b13zxhiuod6rc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-21 17:55:02.432	PORTAL_VIEW
cmt75l1zw0000d7vzdeey4nok	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-08-24 11:29:01.26	PORTAL_VIEW
cmt75l2180001d7vzlomvnntz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-08-24 11:29:01.462	PORTAL_VIEW
cmt75l5yu0002d7vzp9h7c5i2	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-08-24 11:29:06.674	PORTAL_VIEW
cmt75l6n30003d7vzjhxw4m7f	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-24 11:29:07.547	PORTAL_VIEW
cmt75l6nn0004d7vzf1db3p0x	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-24 11:29:07.551	PORTAL_VIEW
cmt75l6np0005d7vz4a56ib7j	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-24 11:29:07.569	PORTAL_VIEW
cmt75l9da0006d7vz58s8ixl6	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.27	2026-08-24 11:29:11.078	PORTAL_VIEW
cmt771lgf0007d7vz0v4xwi48	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 12:09:51.102	PORTAL_VIEW
cmt771lgf0008d7vz8g9rr1sa	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 12:09:51.103	PORTAL_VIEW
cmt771pwe0009d7vzlnwzgz4s	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 12:09:57.214	PORTAL_VIEW
cmt771pwf000ad7vz4gu94t6f	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 12:09:57.215	PORTAL_VIEW
cmt78z1mn000bd7vz0p97u9cd	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-24 13:03:51.4	PORTAL_VIEW
cmt790r4w000cd7vze031ei5y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 13:05:11.41	PORTAL_VIEW
cmt790r4x000dd7vzmdpz28qt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 13:05:11.411	PORTAL_VIEW
cmt79bh4q000ed7vzcd3ibfi9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 13:13:31.63	PORTAL_VIEW
cmt79bh4s000fd7vz6nx048zw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-24 13:13:31.632	PORTAL_VIEW
cmt7g49mb000gd7vzr5z42oow	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.98	2026-08-24 16:23:53.991	PORTAL_VIEW
cmt7g4ebj000hd7vzdgak0exq	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.98	2026-08-24 16:24:00.365	PORTAL_VIEW
cmt7g4ebq000id7vzsqbcbvzn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.98	2026-08-24 16:24:00.367	PORTAL_VIEW
cmt7g4ed1000jd7vzmd79xzdu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.98	2026-08-24 16:24:00.368	PORTAL_VIEW
cmt7g4ji8000kd7vzrn5ciqsv	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.98	2026-08-24 16:24:07.086	PORTAL_VIEW
cmt7ltu5a000md7vztz7zf0xv	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:45.113	PORTAL_VIEW
cmt7ltu59000ld7vzgr82qi2e	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:45.112	PORTAL_VIEW
cmt7ltun5000nd7vzljervdum	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:45.759	PORTAL_VIEW
cmt7ltun7000od7vzwv98d5fd	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:45.759	PORTAL_VIEW
cmt7ltuud000pd7vzh8dx84rr	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:46.018	PORTAL_VIEW
cmt7ltuur000qd7vziv74ioba	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:46.019	PORTAL_VIEW
cmt7ltv23000rd7vzlr5jjx0r	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:46.296	PORTAL_VIEW
cmt7ltv2b000sd7vzj05lbqj4	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:46.297	PORTAL_VIEW
cmt7ltv5z000td7vzxtrfl4ns	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:46.436	PORTAL_VIEW
cmt7ltv66000ud7vzesmu8ywp	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:03:46.437	PORTAL_VIEW
cmt7lwjnl000094za84wazoef	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::1	2026-08-24 19:05:51.276	PORTAL_VIEW
cmt7lwr5d000194zaqfjv0mp2	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:06:01.171	PORTAL_VIEW
cmt7lwr5e000294za6n9dwwel	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-24 19:06:01.172	PORTAL_VIEW
cmt7lx96i000394za8kr4p0wr	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::1	2026-08-24 19:06:24.562	PORTAL_VIEW
cmt7m2exg000694zay1is73t9	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::1	2026-08-24 19:10:25.297	SERVICO_VIEW
cmt8rirx5000894za7l8ilzvn	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-25 14:30:52.524	PORTAL_VIEW
cmt8wj8780001ocopy9mdw2ql	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-25 16:50:56.321	PORTAL_VIEW
cmt8wj8750000ocop9iy9a5m4	Engenharia e Arquitetura	Engenharia e Arquitetura		::1	2026-08-25 16:50:56.32	PORTAL_VIEW
cmt8wn7ab0002ocops1wnqw60	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::1	2026-08-25 16:54:17.502	NOTICIA_VIEW
cmt8wn9cj0003ocop75eronko	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::1	2026-08-25 16:54:20.175	SERVICO_VIEW
cmta59cdk0000qc8pxr0jjy61	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-26 13:43:04.43	PORTAL_VIEW
cmta59vei0001qc8pn1c01nni	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-08-26 13:43:29.577	SERVICO_VIEW
cmtahidye0000lvies8czdmzg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:10.945	PORTAL_VIEW
cmtahidyf0001lviegvgj49mi	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:10.946	PORTAL_VIEW
cmtahie4t0005lviebbuftjfh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:11.197	PORTAL_VIEW
cmtahie0w0002lvieik1145q1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:11.068	PORTAL_VIEW
cmtahie1e0003lviewgdibyi6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:11.069	PORTAL_VIEW
cmtahie4p0004lviemnx2fsg2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:11.196	PORTAL_VIEW
cmtahj6f50006lviej9atpb1n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:40.384	PORTAL_VIEW
cmtahj6fb0007lvie7jilffy8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:40.384	PORTAL_VIEW
cmtahj6gu0008lvie3hxtu2uo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:43.065	PORTAL_VIEW
cmtahj6gy0009lvie32cqpin3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-08-26 19:26:43.066	PORTAL_VIEW
cmtahlasp000alvieytxi54g3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.45	2026-08-26 19:28:26.043	PORTAL_VIEW
cmtahlsaf000blvie8zja25nr	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.45	2026-08-26 19:28:48.743	NOTICIA_VIEW
cmtahm06g000clviekrqi9mm7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.45	2026-08-26 19:28:58.967	SERVICO_VIEW
cmtahmkts000dlviey04ygm08	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.45	2026-08-26 19:29:25.728	SERVICO_VIEW
cmtbgg2jv000elvie92pvipvb	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 11:44:07.792	PORTAL_VIEW
cmtbgg2kg000flvie7uczoasu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 11:44:07.795	PORTAL_VIEW
cmtbgg3e0000glvies6bxlnc1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 11:44:07.796	PORTAL_VIEW
cmtbgu5bh000hlviedv9n26n7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 11:55:06.007	PORTAL_VIEW
cmtbgu5bj000ilviebuo6wiza	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 11:55:06.008	PORTAL_VIEW
cmtbgukcn000jlviexe1oyl4w	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 11:55:25.732	PORTAL_VIEW
cmtbi078s000klviebvp4wo7k	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:27:48.272	PORTAL_VIEW
cmtbi1s58000llvie3r17o9fq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:29:02.056	PORTAL_VIEW
cmtbi1s6d000mlviezmryfthv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:29:02.056	PORTAL_VIEW
cmtbiv2gi000nlviearmqktmv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:51:48.208	PORTAL_VIEW
cmtbiv2gk000olviedeu9scg7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:51:48.207	PORTAL_VIEW
cmtbiy7l4000plvieuiauukyy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:54:15.06	PORTAL_VIEW
cmtbiy7l6000qlvietr5sddtk	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:54:15.058	PORTAL_VIEW
cmtbiyym2000rlvierzz7e7jc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:54:50.103	PORTAL_VIEW
cmtbiyym7000slvie233zvlkf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 12:54:50.102	PORTAL_VIEW
cmtbj6qal000tlviez6123eyl	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 13:00:52.524	PORTAL_VIEW
cmtbj6qal000ulvie5w2kkcxt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 13:00:52.525	PORTAL_VIEW
cmtbj72oq000vlvierfqf5trg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-27 13:01:08.634	PORTAL_VIEW
cmtbrvt20000wlvie1po5j7i0	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:04:19.363	PORTAL_VIEW
cmtbrvt3j000xlvie9m3ufpnn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:04:19.365	PORTAL_VIEW
cmtbrvt40000ylviem16o3w7n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:04:19.367	PORTAL_VIEW
cmtbrvwlk000zlvie5zrk0twh	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:04:24.028	SERVICO_VIEW
cmtbry02k0010lvieb31qhjof	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:06:01.831	SERVICO_VIEW
cmtbry9f30011lviekr77yd7v	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:06:13.948	SERVICO_VIEW
cmtbt5kyc0012lvie72o3qimh	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.31	2026-08-27 17:39:54.595	PORTAL_VIEW
cmtbt7uem0013lviec1jxmuyo	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.31	2026-08-27 17:41:40.401	PORTAL_VIEW
cmtbtgxhk0015lviemqt9v02h	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:48:43.681	PORTAL_VIEW
cmtbtgxhm0016lviejh1nlez4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:48:43.683	PORTAL_VIEW
cmtbtgxib0017lvie98vjiznt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 17:48:43.684	PORTAL_VIEW
cmtbthq650018lviekpaz1357	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-27 17:49:20.957	PORTAL_VIEW
cmtbtji750019lviek6zzy891	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-27 17:50:43.939	PORTAL_VIEW
cmtbtxjiz001alviexwjc4qno	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 18:01:38.735	PORTAL_VIEW
cmtbtxjjk001blvieriyj38ur	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 18:01:38.738	PORTAL_VIEW
cmtbu63wp001clviemsst148f	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 18:08:18.476	PORTAL_VIEW
cmtbuplpi001dlviey147w6gi	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-27 18:23:28.055	SERVICO_VIEW
cmtbvxig2001elvief0qvhzhk	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 18:57:36.704	SERVICO_VIEW
cmtbvya0w001flviefeztihfj	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 18:58:12.443	SERVICO_VIEW
cmtbw0wy7001glvieoppns37s	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-27 19:00:15.469	SERVICO_VIEW
cmtbw3vsc001hlvie5c9hnlaj	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:02:33.926	SERVICO_VIEW
cmtbw6xxz001ilviez7pgz4nq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-27 19:04:56.694	SERVICO_VIEW
cmtbw8b6j001jlviegteuhlbz	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:06:00.503	SERVICO_VIEW
cmtbwq9a7001klviesew58ny3	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-08-27 19:19:58.13	PORTAL_VIEW
cmtbwqcg5001llviex63hj69e	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-08-27 19:20:02.239	PORTAL_VIEW
cmtbwqg77001mlvieychmt434	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:20:07.095	PORTAL_VIEW
cmtbwqg86001nlviebg7ujioh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:20:07.098	PORTAL_VIEW
cmtbwqg87001olvieliywf0ym	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:20:07.097	PORTAL_VIEW
cmtbwsbxe001plviefydpqdb7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:21:34.858	PORTAL_VIEW
cmtbwsbxw001qlvie22zalrt4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-27 19:21:34.857	PORTAL_VIEW
cmtd73wui001rlviej4tkruil	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 16:58:17.13	PORTAL_VIEW
cmtd73wuj001slvieecy42i1y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 16:58:17.131	PORTAL_VIEW
cmtd74l76001tlvier769pndy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 16:58:48.957	PORTAL_VIEW
cmtd74l77001ulvie1qs58ofp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 16:58:48.958	PORTAL_VIEW
cmtd75qrv001vlvie1sdal2ol	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-28 16:59:41.838	PORTAL_VIEW
cmtd75qvs001wlvie0lfz7v30	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-28 16:59:41.841	PORTAL_VIEW
cmtd75qvu001xlvie4u1i2q35	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-08-28 16:59:41.84	PORTAL_VIEW
cmtd76jw1001zlvie8t2vgcxp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:00:20.572	PORTAL_VIEW
cmtd76jw1001ylviecselgebu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:00:20.569	PORTAL_VIEW
cmtd77zz10020lviel64j0umn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:01:28.107	PORTAL_VIEW
cmtd79ypk0021lviemvwg60xt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:02:59.802	PORTAL_VIEW
cmtd79ypm0022lviek1xyj64s	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:02:59.801	PORTAL_VIEW
cmtd7ahcr0023lvieaoxfzapr	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:03:23.981	PORTAL_VIEW
cmtd7ahcr0024lvieswrnibwy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:03:23.98	PORTAL_VIEW
cmtd7hvsl0025lvie96s7rvkp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:09:09.286	PORTAL_VIEW
cmtd7hvsn0026lvie6r0sjk5q	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:09:09.285	PORTAL_VIEW
cmtd85uot0027lvie7fnrcko8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:27:47.758	PORTAL_VIEW
cmtd85url0028lviev8wodwnx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:27:47.758	PORTAL_VIEW
cmtd85v6u0029lvie02l7ijxp	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:27:48.472	PORTAL_VIEW
cmtd85v6w002alvie4ss5azpy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:27:48.475	PORTAL_VIEW
cmtd8b7r8002blviezaztrqo0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:31:58.053	PORTAL_VIEW
cmtd8b7ra002clvieg3oslac4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:31:58.054	PORTAL_VIEW
cmtd8e042002elviey0tc1bwj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:34:08.066	PORTAL_VIEW
cmtd8e040002dlviem16s8t2x	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:34:08.077	PORTAL_VIEW
cmtd8ibp4002flviekuxb8v02	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:37:29.795	PORTAL_VIEW
cmtd8ibp5002glvie8bj4izux	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:37:29.796	PORTAL_VIEW
cmtd9b82o002hlvien51ewkcc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:59:58.004	PORTAL_VIEW
cmtd9b85o002ilviek1tsiowq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:59:58.007	PORTAL_VIEW
cmtd9b8lq002jlvien5su1y4l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:59:58.934	PORTAL_VIEW
cmtd9b8ls002klviejhkka9u5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 17:59:58.938	PORTAL_VIEW
cmtd9by0p002llviebohqd2sl	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:31.864	PORTAL_VIEW
cmtd9by0t002mlviezvtxnra3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:31.865	PORTAL_VIEW
cmtd9byay002nlviefmro0t6h	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:32.246	PORTAL_VIEW
cmtd9byb2002olviemrqmj4gz	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:32.247	PORTAL_VIEW
cmtd9bykf002plvieq0emcirg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:32.59	PORTAL_VIEW
cmtd9bykg002qlvienxhwkfvt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:32.59	PORTAL_VIEW
cmtd9byxu002rlviecjzj3ao3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:00:33.072	PORTAL_VIEW
cmtd9jed8002slvieq3srucul	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:06:19.599	PORTAL_VIEW
cmtd9jeda002tlvieq5tg7mbn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:06:19.6	PORTAL_VIEW
cmtd9k8jx002ulvies24nqqt6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:06:58.753	PORTAL_VIEW
cmtd9k8jy002vlviea6jpg6ji	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 18:06:58.754	PORTAL_VIEW
cmtdbwa0d002wlvie4jmjlc4k	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 19:12:19.711	PORTAL_VIEW
cmtdbwa20002xlvie0quf89pg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-28 19:12:19.712	PORTAL_VIEW
cmthb7w5g002ylvieqkm11wpw	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:04:26.928	PORTAL_VIEW
cmthb8l49002zlvie65cojuak	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:04:59.551	SERVICO_VIEW
cmthba1ik0030lvie1r4j40us	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:06:07.461	SERVICO_VIEW
cmthbn1jr0031lvie05cb37vr	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:16:14.048	SERVICO_VIEW
cmthbn8t40032lvielfgb0nt7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:16:23.457	SERVICO_VIEW
cmthbo9vy0033lviempljrufx	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:17:11.516	SERVICO_VIEW
cmthbogeq0034lvieyldrjcyw	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:17:19.964	SERVICO_VIEW
cmthbp7mn0035lvieuipf6mah	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-08-31 14:17:55.242	SERVICO_VIEW
cmthg97d40036lvieprkoquz6	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-31 16:25:25.927	PORTAL_VIEW
cmthg99h10037lviebzv1ho21	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-31 16:25:28.933	PORTAL_VIEW
cmthg9br40038lvieie9hiou9	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-31 16:25:31.86	PORTAL_VIEW
cmthg9bse003alvieo0pdev7b	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-31 16:25:31.862	PORTAL_VIEW
cmthg9bsd0039lvieo3wo3s3m	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-31 16:25:31.863	PORTAL_VIEW
cmthg9ejb003blvie2xera073	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-08-31 16:25:35.489	PORTAL_VIEW
cmthg9idz003clvier0qecig7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-08-31 16:25:40.449	PORTAL_VIEW
cmthge64h003dlvie1t7xde92	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-31 16:29:17.847	PORTAL_VIEW
cmthge64v003elviebc1ijiwa	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-08-31 16:29:17.846	PORTAL_VIEW
cmtil1fey003hlvieknb4umjx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:27:07.492	PORTAL_VIEW
cmtil1fev003glviepvfcyzqv	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:27:07.49	PORTAL_VIEW
cmtilvad4003ilvie9wevj6l4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:50:20.651	PORTAL_VIEW
cmtilvad8003jlvie6tmvnfpd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:50:20.656	PORTAL_VIEW
cmtilvgy3003klviemk41rzfs	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:50:29.247	PORTAL_VIEW
cmtilzdn0003llviei4q6dp41	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:53:31.588	PORTAL_VIEW
cmtilzdn0003mlvied8woaznu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:53:31.592	PORTAL_VIEW
cmtim1k1c003nlvie6bwllump	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:55:13.185	PORTAL_VIEW
cmtim1k1f003olvieajcwxfxs	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 11:55:13.185	PORTAL_VIEW
cmtim2up3003plviehmgazjxj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-01 11:56:13.525	PORTAL_VIEW
cmtim4sk4003qlvien1eis2pz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-01 11:57:44.3	SERVICO_VIEW
cmtip0b07003rlviezjjgsf6c	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.42	2026-09-01 13:18:13.616	PORTAL_VIEW
cmtip8aqu003slvierphadpbx	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.42	2026-09-01 13:24:26.638	SERVICO_VIEW
cmtiq2d52003vlvie6y5a4pc4	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.119	2026-09-01 13:47:49.361	PORTAL_VIEW
cmtiq2r3g003wlviezqs7i21z	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.119	2026-09-01 13:48:07.453	PORTAL_VIEW
cmtiq4fnq003ylviejpf3gjvn	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.119	2026-09-01 13:49:25.936	PORTAL_VIEW
cmtiq4foy003zlvie0lho2rgb	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.119	2026-09-01 13:49:25.941	PORTAL_VIEW
cmtiq4fp00040lvie7wpspeaa	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.119	2026-09-01 13:49:25.939	PORTAL_VIEW
cmtiq4mw30041lviexljwhsh1	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-09-01 13:49:35.324	PORTAL_VIEW
cmtiq59wr0042lvie36rh29gj	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 13:50:05.142	PORTAL_VIEW
cmtiq59xc0043lvie05b373a2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 13:50:05.143	PORTAL_VIEW
cmtiq5vn20044lvienkppkf99	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-01 13:50:33.321	SERVICO_VIEW
cmtiq93xd0045lviee9yby6ko	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 13:53:04.282	PORTAL_VIEW
cmtiq93ys0046lviet2kqawvm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 13:53:04.289	PORTAL_VIEW
cmtiq93yw0047lvie7yowvmdn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 13:53:04.286	PORTAL_VIEW
cmtiqbk2n0048lviesmzh3176	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.155	2026-09-01 13:54:59.908	PORTAL_VIEW
cmtiqctvw0049lvieylae0st6	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 13:55:59.461	PORTAL_VIEW
cmtiqctx7004alvieayfii7hx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 13:55:59.47	PORTAL_VIEW
cmtiqctxb004blvieaxy878rg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 13:55:59.475	PORTAL_VIEW
cmtiqdot9004clvie0ymh6dha	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 13:56:39.588	SERVICO_VIEW
cmtmuduww00allvie95i8l385	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 10:59:50.612	PORTAL_VIEW
cmtis1wux004dlviewd8r6zia	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-09-01 14:43:27.511	PORTAL_VIEW
cmtivu65b004elvieq92v0ayb	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 16:29:26.767	PORTAL_VIEW
cmtivu66p004flvieold7bbiw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 16:29:26.768	PORTAL_VIEW
cmtivxybt004glvie4d1958gz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-09-01 16:32:21.393	PORTAL_VIEW
cmtivy17n004hlvieuy7cz3tk	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-09-01 16:32:25.293	PORTAL_VIEW
cmtivy4qx004ilviewcimmsh9	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-01 16:32:29.878	PORTAL_VIEW
cmtivy4r7004jlviedglfx65i	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-01 16:32:29.88	PORTAL_VIEW
cmtivy4sy004klviep7renyde	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-01 16:32:29.881	PORTAL_VIEW
cmtivys77004llviem18ocw8a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 16:33:02.13	PORTAL_VIEW
cmtivys78004mlvieoxd56ujm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 16:33:02.131	PORTAL_VIEW
cmtiw49i4004nlvieg8plnlbr	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-01 16:36:59.609	PORTAL_VIEW
cmtiwgba9004olvievmhy938e	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 16:46:40.173	SERVICO_VIEW
cmtiwo37i004plviezppea9la	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 16:52:40.983	PORTAL_VIEW
cmtiwo38i004qlvie0l0fx3mq	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 16:52:40.988	PORTAL_VIEW
cmtiwo3h5004rlvieiue0ao6v	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 16:52:40.99	PORTAL_VIEW
cmtiwucsb004slvievn0zuwmn	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-01 16:57:33.626	SERVICO_VIEW
cmtixbpeh004tlvie80h395yx	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-01 17:10:46.653	SERVICO_VIEW
cmtixf8zk004ulviet0zw0lq9	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-01 17:13:32.003	SERVICO_VIEW
cmtiynvs9004wlviei8qi1m9v	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::63bc:1e34:52f9:4365%21	2026-09-01 17:48:29.975	PORTAL_VIEW
cmtiytobx004ylviec516o6j5	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::63bc:1e34:52f9:4365%21	2026-09-01 17:53:00.478	PORTAL_VIEW
cmtiyvswv004zlvienaq5ercu	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::63bc:1e34:52f9:4365%21	2026-09-01 17:54:39.754	SERVICO_VIEW
cmtiz21al0050lviewa66yy2d	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-01 17:59:30.628	SERVICO_VIEW
cmtiz28kj0051lvielg5o306m	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-01 17:59:40.057	SERVICO_VIEW
cmtiz2e6y0052lvie4wu3mj5j	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-01 17:59:47.335	SERVICO_VIEW
cmtiz35340053lviefwxhdgtg	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-01 18:00:22.2	SERVICO_VIEW
cmtj1ahwo0054lvie58bp270p	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::63bc:1e34:52f9:4365%21	2026-09-01 19:02:04.51	PORTAL_VIEW
cmtj2q41r0055lviezleikyzy	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 19:42:15.406	SERVICO_VIEW
cmtj2qfqw0056lvieakbkh0bh	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-01 19:42:30.565	SERVICO_VIEW
cmtjzsgqn0057lviecscgy1j7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.155	2026-09-02 11:07:54.166	PORTAL_VIEW
cmtjzsgs30058lviez0rrueha	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-02 11:07:54.173	PORTAL_VIEW
cmtk04bbm0059lvietpsrihfi	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-02 11:17:07.327	SERVICO_VIEW
cmtk06qjf005alvie27wdpu44	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.155	2026-09-02 11:19:00.346	PORTAL_VIEW
cmtk1698u005blvieupgp4o5d	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.157	2026-09-02 11:46:33.024	PORTAL_VIEW
cmtk17716005clviebjh7dh4l	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-02 11:47:17.046	PORTAL_VIEW
cmtk1771b005dlvieiilmke2k	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-02 11:47:17.049	PORTAL_VIEW
cmtk1772o005elvie65uachhs	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-02 11:47:17.051	PORTAL_VIEW
cmtk19exx005flvie6uye2lla	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.157	2026-09-02 11:49:00.617	PORTAL_VIEW
cmtk1shro005glviedye60azn	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-02 12:03:49.291	PORTAL_VIEW
cmtk1xnjq005hlvie4736sfqw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-02 12:07:50.345	PORTAL_VIEW
cmtk2316u005ilviewwsk9qt6	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-02 12:12:01.311	SERVICO_VIEW
cmtk2gxju005jlviei0tc5z7d	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-02 12:22:51.31	SERVICO_VIEW
cmtk2kmio005klvieyiadnxtx	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-09-02 12:25:41.414	PORTAL_VIEW
cmtk2kwt6005llvie0peu5snl	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.69	2026-09-02 12:25:55.092	SERVICO_VIEW
cmtk2tb2n005mlviesi38m1qq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 12:32:27.845	PORTAL_VIEW
cmtk2u7hn005nlvie53iq99ze	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 12:33:10.099	PORTAL_VIEW
cmtk2v9yi005olvie8i2rklsm	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 12:33:59.987	SERVICO_VIEW
cmtk4fu9c005plview5qkmoot	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-02 13:17:58.079	SERVICO_VIEW
cmtkakbzh005qlvie9u79zc80	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-02 16:09:25.348	SERVICO_VIEW
cmtkaleah005rlviefdlg0nu0	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 16:10:16.337	SERVICO_VIEW
cmtkalpoy005slviezxznwld2	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 16:10:31.116	SERVICO_VIEW
cmtkam5u8005tlviegyldk4g2	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-02 16:10:50.696	SERVICO_VIEW
cmtkamfju005ulvie0ltk0iys	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 16:11:04.624	SERVICO_VIEW
cmtkcbae2005vlvieupupp3mu	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-02 16:58:24.043	SERVICO_VIEW
cmtkfjjbf005wlviefiml0dkd	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.69	2026-09-02 18:28:47.1	PORTAL_VIEW
cmtkfnvhz005xlviesayrnsd7	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:09.604	PORTAL_VIEW
cmtkfnvi1005ylviemndre6ay	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:09.607	PORTAL_VIEW
cmtkfnvi5005zlvie660c85ax	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:09.613	PORTAL_VIEW
cmtkfnzki0060lvie47np2mnl	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:14.875	PORTAL_VIEW
cmtkfnzlp0061lvieyqlz9az8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:14.876	PORTAL_VIEW
cmtkfo3ib0062lvielzpyj8ax	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:19.943	PORTAL_VIEW
cmtkfo3iy0063lvie2ax46n5d	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:19.945	PORTAL_VIEW
cmtkfo3j20064lviel3ovigo6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:19.944	PORTAL_VIEW
cmtkfoary0065lviepe9wr9e7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:29.365	PORTAL_VIEW
cmtkfoas10066lvieks4n636n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-02 18:32:29.366	PORTAL_VIEW
cmtkfovkw0067lviefjj04r44	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-09-02 18:32:55.673	PORTAL_VIEW
cmtkfp3jr0068lvie3qm2thr5	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-02 18:33:06.247	PORTAL_VIEW
cmtkfp3kt0069lvie78mlo50q	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-02 18:33:06.25	PORTAL_VIEW
cmtkfp3l4006alvieiihxcwi3	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-02 18:33:06.249	PORTAL_VIEW
cmtkfpags006blviejyloy9o4	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-09-02 18:33:15.202	PORTAL_VIEW
cmtkfrfon006clviectlrwxru	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-02 18:34:55.221	PORTAL_VIEW
cmtkfrfpd006dlvieeokpmh31	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-02 18:34:55.222	PORTAL_VIEW
cmtkfrfqe006elvie03rggvx5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-02 18:34:55.223	PORTAL_VIEW
cmtkfshrw006flvie8b3fajhd	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.64	2026-09-02 18:35:44.659	PORTAL_VIEW
cmtkftfep006glviepwa3karu	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-02 18:34:00.568	PORTAL_VIEW
cmtkfy402006hlviexda9zhut	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-02 18:37:39.258	SERVICO_VIEW
cmtkht4mc006ilvieuh6eh5rw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-02 19:29:46.046	SERVICO_VIEW
cmtkiagwn006jlvie71k3sgv8	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-02 19:43:15.127	SERVICO_VIEW
cmtlfj6vs006klviek01azrxt	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-03 11:16:17.786	PORTAL_VIEW
cmtlfj74g006llvielop0ji50	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.155	2026-09-03 11:16:18.425	PORTAL_VIEW
cmtlfl94a006mlviekkpn2zcq	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 11:17:53.205	PORTAL_VIEW
cmtlflqqj006nlvies5s2urd1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-09-03 11:15:46.801	PORTAL_VIEW
cmtlflqvw006olviestecnze9	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.59	2026-09-03 11:15:47.266	SERVICO_VIEW
cmtlfz36b006plvietrduwksp	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 11:28:38.91	SERVICO_VIEW
cmtlg4eo0006qlvief45fx2i2	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 11:32:47.093	SERVICO_VIEW
cmtlgb5kk006rlviev31ouj4e	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 11:38:01.909	SERVICO_VIEW
cmtlgc8r4006slvietldoozr8	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 11:38:52.69	SERVICO_VIEW
cmtlgj2ef006tlvievbn8orxl	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-03 11:41:41.76	PORTAL_VIEW
cmtlgkbok006ulvie9t1wjtt6	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-03 11:42:40.532	SERVICO_VIEW
cmtlglgi8006vlviey09ipimp	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-03 11:43:33.446	SERVICO_VIEW
cmtlgmusi006wlviejvyqhahd	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.131	2026-09-03 11:47:09.213	PORTAL_VIEW
cmtlgo2vm006xlvie9ptsjsuc	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.131	2026-09-03 11:48:06.551	SERVICO_VIEW
cmtlgol4w006ylviete0in5ac	Portal de Serviços Corporativos	Portal de Serviços Corporativos		fe80::960d:7fa3:9c61:cde9%21	2026-09-03 11:45:59.413	SERVICO_VIEW
cmtlgsuo7006zlvie7fbmboev	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 11:51:47.613	SERVICO_VIEW
cmtlgtcny0070lvie2ltvio6l	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-03 11:52:07.841	PORTAL_VIEW
cmtlgv2wm0071lviefoyxmurd	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 11:53:29.515	PORTAL_VIEW
cmtlh1wri0072lvie1vurysdh	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 11:58:48.337	SERVICO_VIEW
cmtlh3z7x0075lvieuwxauyxw	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 12:00:24.825	PORTAL_VIEW
cmtlh3z800076lvieoz14rae1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 12:00:24.828	PORTAL_VIEW
cmtlh3z9d0077lvie88efpgqf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 12:00:24.83	PORTAL_VIEW
cmtlh468m0078lvieyijzx4b6	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 12:00:33.933	SERVICO_VIEW
cmtlhf2dq007blvie6w9yf5ky	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 12:09:02.143	SERVICO_VIEW
cmtlhke9w007clvieqobb2zwt	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:13:12.067	PORTAL_VIEW
cmtlhkeb3007dlvie40p9q8j4	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:13:12.064	PORTAL_VIEW
cmtlhkec6007elvieaod7r075	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:13:12.066	PORTAL_VIEW
cmtlhnjf2007flviefok572mh	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 12:15:37.469	SERVICO_VIEW
cmtlho9j6007glviezalriq9y	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 12:16:11.289	PORTAL_VIEW
cmtlhoedh007hlviejmd1hljc	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 12:16:17.586	SERVICO_VIEW
cmtlhoro2007ilvien3v3qrxw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 12:16:34.81	SERVICO_VIEW
cmtlhouuv007jlvievooq7c2m	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-09-03 12:16:40.37	PORTAL_VIEW
cmtlhp2rr007klviernu8cn3x	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 12:16:49.203	SERVICO_VIEW
cmtlhqn34007llviepoj9s23d	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 12:18:02.188	SERVICO_VIEW
cmtlhupuz007mlviegs0b73tp	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 12:21:12.402	SERVICO_VIEW
cmtlhxa61007nlvienpanonpj	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 12:23:12.041	SERVICO_VIEW
cmtlhykp8007olviejzt78ram	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 12:24:12.341	SERVICO_VIEW
cmtlifxt4007tlvievs01stc2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:37:43.813	PORTAL_VIEW
cmtlifxt4007ulviez5suzrst	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:37:43.814	PORTAL_VIEW
cmtliqk39007xlviek4oudw0a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:45:59.335	PORTAL_VIEW
cmtliqk4d007ylvieagocckt2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:45:59.336	PORTAL_VIEW
cmtlirbow0080lviekodc3h16	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:46:35.118	PORTAL_VIEW
cmtlirbpf0081lvieji422emo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 12:46:35.119	PORTAL_VIEW
cmtlkb9ej0082lvied5e4r8t7	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 13:30:05.58	SERVICO_VIEW
cmtlked4z0083lvieszaa1tt4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 13:32:29.598	PORTAL_VIEW
cmtlked5n0084lviebdc0ysp2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 13:32:29.599	PORTAL_VIEW
cmtlkem9r0086lvie1ec64fz7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 13:32:41.406	PORTAL_VIEW
cmtlkem9q0085lvieym3lftep	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 13:32:41.406	PORTAL_VIEW
cmtlkiipm0087lvieaget1h53	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-03 13:35:43.893	PORTAL_VIEW
cmtlkmybo0088lviehuee7tlb	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.165	2026-09-03 13:39:11.073	SERVICO_VIEW
cmtlksr3c0089lvie8xu6flih	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 13:43:39.495	SERVICO_VIEW
cmtll008c008alviehh9p5e7l	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 13:49:17.925	SERVICO_VIEW
cmtll082o008blviebehynyb2	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.165	2026-09-03 13:49:30.223	PORTAL_VIEW
cmtll084p008clvievaujkbb4	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.165	2026-09-03 13:49:30.231	PORTAL_VIEW
cmtll086b008dlvietnlrzp7a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.165	2026-09-03 13:49:30.235	PORTAL_VIEW
cmtll0oxd008elvie76lyqter	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.165	2026-09-03 13:49:52.048	PORTAL_VIEW
cmtll1531008flvieikw4lnxl	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.165	2026-09-03 13:50:13.037	SERVICO_VIEW
cmtlloxxw008glvievig1vckb	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.65	2026-09-03 14:08:41.348	SERVICO_VIEW
cmtlm6nfs008hlviefxujm949	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 14:22:27.539	SERVICO_VIEW
cmtlma0cj008ilvie1rdu2kv8	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.39	2026-09-03 14:25:05.637	PORTAL_VIEW
cmtlmglfn008jlvieqfzx9kbk	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.39	2026-09-03 14:30:13.151	SERVICO_VIEW
cmtlmm4ec008klviewci8zw54	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 14:34:29.355	SERVICO_VIEW
cmtlmnn5z008llvieg7ffh4i3	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.159	2026-09-03 14:35:42.659	PORTAL_VIEW
cmtlmodff008mlviekdiiditu	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.159	2026-09-03 14:36:16.652	PORTAL_VIEW
cmtlmodgp008nlvie3laqx4nd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.159	2026-09-03 14:36:16.659	PORTAL_VIEW
cmtlmodgr008olvie41mwa7eo	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.159	2026-09-03 14:36:16.67	PORTAL_VIEW
cmtlmr4i9008plvieo0ttw5vt	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.139	2026-09-03 14:38:32.591	PORTAL_VIEW
cmtlmrnkp008qlviejrm3l8dj	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.139	2026-09-03 14:38:57.548	NOTICIA_VIEW
cmtlmujtc008slvie15w42jsh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-03 14:41:04.524	PORTAL_VIEW
cmtlmujte008tlviexwq56o2i	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-03 14:41:04.527	PORTAL_VIEW
cmtlmuw6h008ulviecjp8zcbe	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.139	2026-09-03 14:41:28.667	SERVICO_VIEW
cmtln9mrg008vlviesagzs59d	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.139	2026-09-03 14:52:56.3	SERVICO_VIEW
cmtlnnx2t008wlvier7ohh064	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.139	2026-09-03 15:04:02.849	SERVICO_VIEW
cmtlnxgp4008xlviesxkiguc1	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.139	2026-09-03 15:11:28.172	SERVICO_VIEW
cmtlr1mhh008ylviehu2mq1ti	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 16:38:30.977	PORTAL_VIEW
cmtlr1mhh008zlvieirhonbsy	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.65	2026-09-03 16:38:30.978	PORTAL_VIEW
cmtlr7al40090lvie4tvl190i	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.65	2026-09-03 16:42:55.57	SERVICO_VIEW
cmtlroy6z0091lviexrt42ija	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 16:56:40.903	PORTAL_VIEW
cmtlroy710092lviehypps1cm	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 16:56:40.901	PORTAL_VIEW
cmtlroy860093lvieth3y2wut	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 16:56:40.904	PORTAL_VIEW
cmtlrr9d20094lvievob9foyc	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-09-03 16:58:28.685	PORTAL_VIEW
cmtlrsgsb0095lviel5t87xxe	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 16:59:24.979	SERVICO_VIEW
cmtlrsnoo0096lviewloknxzd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 16:59:33.875	PORTAL_VIEW
cmtlrsnos0097lvieppfrfnxa	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 16:59:33.876	PORTAL_VIEW
cmtlsyf3x0098lvief4sast2s	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 17:32:02.403	PORTAL_VIEW
cmtlsyf4i0099lvier8v9oec5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 17:32:02.403	PORTAL_VIEW
cmtltbk34009alviemxndathn	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 17:42:15.476	PORTAL_VIEW
cmtltbk44009blviecgznsz5d	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 17:42:15.477	PORTAL_VIEW
cmtltdj25009clvie8s57p8gf	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 17:43:47.471	SERVICO_VIEW
cmtltsz9e009elvieq4c3w0kc	Engenharia e Arquitetura	Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 17:55:48.243	PORTAL_VIEW
cmtltsz9g009flvieuv0ld04i	Engenharia e Arquitetura	Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 17:55:48.247	PORTAL_VIEW
cmtltv79n009glvie0vlfl7xc	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-09-03 17:57:31.999	SERVICO_VIEW
cmtltvguo009hlviefehug2c5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 17:57:44.391	PORTAL_VIEW
cmtltvgup009ilvie2zphnoi7	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-03 17:57:44.391	PORTAL_VIEW
cmtltwyj6009jlvied8sodfug	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 17:58:53.991	NOTICIA_VIEW
cmtluai72009mlviexml1lkeb	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-03 18:09:27.405	PORTAL_VIEW
cmtluai7k009nlvieslzx7zmd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-03 18:09:27.408	PORTAL_VIEW
cmtluai7p009olvie7zajqe90	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-03 18:09:27.41	PORTAL_VIEW
cmtlub9bm009plvie6ypx2fhd	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.157	2026-09-03 18:10:02.58	SERVICO_VIEW
cmtlvoc7b009tlvieptseoxyw	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.131	2026-09-03 18:48:13.901	PORTAL_VIEW
cmtlvperw009ulviewcmrfdo7	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.131	2026-09-03 18:49:03.908	SERVICO_VIEW
cmtlvra11009vlvielc7rq997	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 18:50:29.215	PORTAL_VIEW
cmtlvrshb009wlvieskk59fdz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.159	2026-09-03 18:50:53.33	SERVICO_VIEW
cmtlx29fm00a4lvie170jkofz	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 19:26:59.583	PORTAL_VIEW
cmtlx29fw00a5lvie8cwat8ds	Engenharia e Arquitetura	Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 19:26:59.585	PORTAL_VIEW
cmtlx29gv00a6lvieesfoa0ds	Engenharia e Arquitetura	Engenharia e Arquitetura		fe80::f73b:f849:569b:4f35%21	2026-09-03 19:26:59.586	PORTAL_VIEW
cmtlx4ccr00aalvietjwmkmna	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::a56f:5e46:21ba:26da%21	2026-09-03 19:28:37.922	PORTAL_VIEW
cmtlx4m1i00ablvie5lks1nq6	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		fe80::a56f:5e46:21ba:26da%21	2026-09-03 19:28:50.678	SERVICO_VIEW
cmtlx4u2f00aclvieoomv2dwu	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-03 19:29:00.73	SERVICO_VIEW
cmtlx592e00adlviezqxtmo2u	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-03 19:29:20.168	SERVICO_VIEW
cmtly431b00aglvie7cyd3488	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.39	2026-09-03 19:56:24.717	PORTAL_VIEW
cmtly4g0i00ahlvie3ldl3qfw	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.39	2026-09-03 19:56:41.634	PORTAL_VIEW
cmtmu01zn00ajlvieu4koi232	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 10:49:06.411	PORTAL_VIEW
cmtmu02cb00aklviepbog1pbn	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.155	2026-09-04 10:49:07.122	PORTAL_VIEW
cmtmuduxr00amlviesgamx45p	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 10:59:50.614	PORTAL_VIEW
cmtmufzxe00anlvie6ed6jw8e	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 11:01:30.513	PORTAL_VIEW
cmtmufzyq00aolvie2gvgku9x	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 11:01:30.584	PORTAL_VIEW
cmtmugm6200aqlvie258dstrg	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 11:01:59.311	PORTAL_VIEW
cmtmugm6200aplviehibw3w4j	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 11:01:59.309	PORTAL_VIEW
cmtmugvsg00arlviee4b1kedf	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 11:02:11.818	PORTAL_VIEW
cmtmugxdg00aslvierug34hlu	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.155	2026-09-04 11:02:13.882	PORTAL_VIEW
cmtmvatnb00atlviek17lgc0t	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:25:25.453	PORTAL_VIEW
cmtmvatqw00aulvie96a4w7v9	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:25:25.45	PORTAL_VIEW
cmtmvatqy00avlvieo7ne5hfl	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:25:25.444	PORTAL_VIEW
cmtmvgbbn00azlvieiscjuwcd	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:29:42.04	PORTAL_VIEW
cmtmvgbbm00aylvie5hoc0huc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:29:42.043	PORTAL_VIEW
cmtmvgbca00b0lviemahkriby	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:29:42.044	PORTAL_VIEW
cmtmvge5600b1lvied4z8ix3r	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:29:45.714	PORTAL_VIEW
cmtmvge5a00b2lvie0h0azo0s	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:29:45.718	PORTAL_VIEW
cmtmvge5c00b3lviettopxu3n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:29:45.721	PORTAL_VIEW
cmtmvgijc00b4lvie7mk09lth	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.64	2026-09-04 11:29:51.41	PORTAL_VIEW
cmtmvk38t00b6lviewlmg9h54	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:32:38.203	PORTAL_VIEW
cmtmvk39l00b7lview168vul6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:32:38.203	PORTAL_VIEW
cmtmvrmni00b8lvievb2otnxd	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:38:29.949	PORTAL_VIEW
cmtmvrmpi00b9lvieagdgbi8b	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:38:29.951	PORTAL_VIEW
cmtmvrmpz00balvie7z4uc37z	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.64	2026-09-04 11:38:29.953	PORTAL_VIEW
cmtmvwj1700bblviex4pmkiyz	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.157	2026-09-04 11:42:19.425	PORTAL_VIEW
cmtmw2wm800bdlviemyi7w44o	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:47:17.001	PORTAL_VIEW
cmtmw2wmx00belviepg6hyyxh	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:47:17.003	PORTAL_VIEW
cmtmw3hb300bglviexzruegft	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:47:43.821	PORTAL_VIEW
cmtmw3hb200bflviefva74za6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:47:43.821	PORTAL_VIEW
cmtmw55xy00bilviepztco83v	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:02.403	PORTAL_VIEW
cmtmw55xx00bhlviety9u59c5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:02.403	PORTAL_VIEW
cmtmw560y00bjlviej5ygi96t	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:02.527	PORTAL_VIEW
cmtmw561800bklviejgnb8c0n	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:02.528	PORTAL_VIEW
cmtmw56a200bllvied5z5suq8	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:02.854	PORTAL_VIEW
cmtmw56an00bmlvie7u0z0vom	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:02.854	PORTAL_VIEW
cmtmw56e200bnlviewv86bo2m	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:03	PORTAL_VIEW
cmtmw56e800bolvie9glo9w05	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:03.001	PORTAL_VIEW
cmtmw56ml00bplvie7obh5ei2	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:03.305	PORTAL_VIEW
cmtmw56n000bqlview5rsd9qd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:03.306	PORTAL_VIEW
cmtmw56x500brlvievdnbdp2a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:03.687	PORTAL_VIEW
cmtmw56x700bslvie8ysmwojc	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.27	2026-09-04 11:49:03.687	PORTAL_VIEW
cmtmww5ee00004wlim6gftu3d	Portal do Patrimônio de Pernambuco	Portal do Patrimônio de Pernambuco		::ffff:172.31.104.27	2026-09-04 12:10:01.425	PORTAL_VIEW
cmtmx5d6s00014wliphup2zlg	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-04 12:17:07.749	SERVICO_VIEW
cmtmxew5o00024wliw42ixm15	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:24:34.991	PORTAL_VIEW
cmtmxew5w00034wlic2r4hivd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:24:34.947	PORTAL_VIEW
cmtmxewfv00044wli6yt98ztv	Portal de Engenharia e Arquitetura	Portal de Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:24:34.943	PORTAL_VIEW
cmtmxs8fq00054wliayxy96ga	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:34:57.706	PORTAL_VIEW
cmtmxs8fq00064wliopt6h36a	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:34:57.705	PORTAL_VIEW
cmtmy332h00074wli9z31qad1	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:43:23.937	PORTAL_VIEW
cmtmy332j00084wli658e0930	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:43:23.938	PORTAL_VIEW
cmtmy3w1v00094wlif1d7ikk6	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:44:01.604	PORTAL_VIEW
cmtmy3w1y000a4wliceflkgok	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:44:01.603	PORTAL_VIEW
cmtmy3w50000b4wli5d0dqpdm	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:44:01.729	PORTAL_VIEW
cmtmy3w52000c4wli2hj32dyl	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:44:01.729	PORTAL_VIEW
cmtmy3wa9000d4wlimoxrnktw	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:44:01.909	PORTAL_VIEW
cmtmy3waf000e4wliainypwc5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:44:01.91	PORTAL_VIEW
cmtmyaaah000f4wlirzdhxfr5	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:48:59.934	PORTAL_VIEW
cmtmyaaap000g4wligv5cnmhx	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:48:59.933	PORTAL_VIEW
cmtmyakd8000h4wliz1rc71si	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:49:13.057	PORTAL_VIEW
cmtmyakda000i4wlitwwxnf9l	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:49:13.056	PORTAL_VIEW
cmtmyam96000j4wlil104n52y	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:49:15.51	PORTAL_VIEW
cmtmyam99000k4wliwasassx0	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:49:15.51	PORTAL_VIEW
cmtmylbca000l4wliijaxn1sd	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:57:34.518	PORTAL_VIEW
cmtmylbcc000m4wlise2bgiva	Engenharia e Arquitetura	Engenharia e Arquitetura		::ffff:172.31.104.69	2026-09-04 12:57:34.518	PORTAL_VIEW
cmtmyune3000n4wlipwka2u16	Portal de Serviços Corporativos	Portal de Serviços Corporativos		::ffff:172.31.104.92	2026-09-04 13:04:46.982	SERVICO_VIEW
\.


--
-- Data for Name: AreasResponsaveis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AreasResponsaveis" (id, nome, "createdAt", "createdBy", "updatedAt", "updatedBy", "deletedAt", "deletedBy") FROM stdin;
cmq6yxa510000nh1tnduds1mc	Patrimônio	\N		\N		\N	
cmq81pn5v0001j9azrqcx4d99	Engenharia e Arquitetura	\N		\N		\N	
cmq81pvoq0003j9azcu4vg0ws	Serviços Corporativos	\N		\N		\N	
cmtimbobf0006and9f8buqgd7	Contratos Corporativos	\N		\N		\N	
\.


--
-- Data for Name: AuditLogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AuditLogs" (id, "dataAcao", usuario, operacao, tabela, "itemId", "itemTitulo", mudancas) FROM stdin;
cmn3aive80000e3mtjm6512kx	2026-03-23 14:37:59.023	clovis.melo@sad.pe.gov.br	UPDATE	AreaResponsavel	cmm9d7djb0000zolqpm53460w	GDEST	nome: De: CDEST Para: GDEST
cmn3b4sc60001e3mtzmuot2pr	2026-03-23 14:55:01.493	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	muralTextoIntrodutorio:\n  De: O patrimônio de Pernambuco é vasto e complexo. Gerenciá-lo exige dados precisos, tecnologia e integração entre as áresa técnicas e as áreas de negócio. Nossos números refletem o compromisso diário com a organização e o cuidado do que é público.\n  Para: O patrimônio de Pernambuco é vasto e complexo. Gerenciá-lo exige dados precisos, tecnologia e integração entre as área técnicas e as áreas de negócio. Nossos números refletem o compromisso diário com a organização e o cuidado do que é público.
cmn4tgugi0000qaxkb7bzemax	2026-03-24 16:16:03.377	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	muralTextoIntrodutorio:\n  De: O patrimônio de Pernambuco é vasto e complexo. Gerenciá-lo exige dados precisos, tecnologia e integração entre as área técnicas e as áreas de negócio. Nossos números refletem o compromisso diário com a organização e o cuidado do que é público.\n  Para: Desde a maca do hospital à viatura policial. Da escola ao palácio do governo.\nTudo isso faz parte do patrimônio do Estado. E para dar conta de tudo é preciso uma equipe técnica capacitada e uma gestão eficiente. \nUma boa administração patrimonial leva a melhores políticas públicas e a um Estado mais próximo do cidadão. Esse é nosso propósito.\n\npatrimonioImobiliario:\n  De: \n  Para: De forma simples podemos dizer que o “Patrimônio Imóvel” público corresponde aos prédios pertencentes ao Estado. Mas, ainda assim, é preciso fazer uma diferenciação.\nNormalmente, cada órgão ou entidade do Estado é responsável pelos seus próprios prédios e instalações, no entanto, há órgãos que não dispõem de equipe técnica especializada ou muitas edificações já não tem alguém que olhe por elas ou já não têm uso. São desses imóveis que tomamos conta por aqui.\n\npatrimonioMovel:\n  De: \n  Para: Se quando tratamos de “Patrimônio Imóvel” é fácil lembrarmos dos prédios públicos, talvez ao falarmos de “Patrimônio Móvel” as coisas não fiquem tão claras assim. Mas é simples.\nEsse patrimônio corresponde a todo bem e equipamento de propriedade do Estado. Seja aquele bem utilizado em atividades administrativas - uma cadeira ou um computador, por exemplo - como também a carteira da escola, a máquina de ressonância do hospital e até o helicóptero dos bombeiros.\n\nengenhariaArquitetura:\n  De: \n  Para: Para além da gestão do próprio imóvel, muitos órgãos e entidades não dispõem de equipe técnica especializada de arquitetura ou de engenharia. Também estamos aqui para ajudá-los.\nNossa equipe é composta por um grande número de arquitetos e engenheiros, das mais diversas formações, que atuam desde a análise técnica à elaboração de layouts e projetos arquitetônicos e de engenharia. Auxiliando nas pequenas manutenções e reformas, e também nos grandes projetos de transformação.
cmn4v9lcx0002qaxkc53868uf	2026-03-24 17:06:24.225	fabioo.silva@sad.pe.gov.br	CREATE	AreaResponsavel	cmn4v9lci0001qaxktu3i2xrl	UCPAM	Área criada: UCPAM
cmn4v9w6r0003qaxklcfk421k	2026-03-24 17:06:38.256	fabioo.silva@sad.pe.gov.br	UPDATE	Servico	cmmw3fu3a000kui04n93be0fp	Desfazimento de Bens Móveis	areaResponsavelId:\n  De: vazio\n  Para: cmn4v9lci0001qaxktu3i2xrl
cmn4vcj9k0004qaxkkb78u7lf	2026-03-24 17:08:41.472	fabioo.silva@sad.pe.gov.br	UPDATE	Servico	cmmw3fu3a000kui04n93be0fp	Desfazimento de Bens Móveis	comoSolicitar:\n  De: A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações: 1- Ofício da Autoridade máxima do órgão solicitando à SEADP/SAD  a inclusão dos bens inservíveis para leilão; 2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD Obs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017. 3- Laudo de Risco Biológico / Ambiental, quando aplicável. Para dúvidas ou maiores esclarecimentos entrar em contato: UCPAM - Unidade Central de Patrimônio Móveis e Materiais Fone: (81) 3183-7785 E-mail: bensmoveis@sad.pe.gov.br\n  Para: A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações: 1- Ofício da Autoridade máxima do órgão solicitando à SEADP/SAD  a inclusão dos bens inservíveis para leilão; 2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD Obs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017. 3- Laudo de Risco Biológico / Ambiental, quando aplicável.
cmn50xcuz0006qaxko3k7dvgm	2026-03-24 19:44:51.033	clovis.melo@sad.pe.gov.br	CREATE	MuralItem	cmn50xcur0005qaxkkhtg6ri2	teste	Registro criado.
cmn50xs2y0008qaxkxvdwedwo	2026-03-24 19:45:10.76	clovis.melo@sad.pe.gov.br	CREATE	MuralItem	cmn50xs2m0007qaxk927skmrw	teste	Registro criado.
cmn50xsrf0009qaxkfpakikfr	2026-03-24 19:45:11.641	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmn50yiuo000aqaxk2ifagv2z	2026-03-24 19:45:45.455	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmn63yu8i000bqaxk6vj2oqci	2026-03-25 13:57:45.229	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi34ocqx0006pu9zizgkeauw	Imóveis Cadastrados	valor:\n  De: Cerca de 3500\n  Para: Cerca de 3600\n\ndescricao:\n  De:  O acervo imobiliário estadual consta com cerca de 3500 imóveis cadastrados em sua base.\n  Para:  O acervo imobiliário estadual consta com cerca de 3600 imóveis cadastrados em sua base.
cmn63z8fn000cqaxkkcbg08hg	2026-03-25 13:58:03.63	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi4l8mis0002wugdn3oz9hvc	Em valor estimado	valor:\n  De: 11 Bilhões\n  Para: 12 Bilhões\n\ndescricao:\n  De: O valor total do acervo imobiliário de Pernambuco chega a ultrapassar 11 bilhões de reais.\n  Para: O valor total do acervo imobiliário de Pernambuco chega a ultrapassar 12 bilhões de reais.
cmn6415z0000dqaxkmziu614o	2026-03-25 13:59:33.752	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi4lbl3p0003wugdnpr0n4nf	Bens Móveis Cadastrados	valor:\n  De: 400 Mil\n  Para: Cerca de 1 Milhão\n\ndescricao:\n  De: O acervo mobiliário estadual consta com mais de 400.000 imóveis cadastrados em sua base.\n  Para: O acervo mobiliário estadual consta com mais de 900 mil imóveis cadastrados em sua base.
cmn64255k000eqaxkqe52kja3	2026-03-25 14:00:19.349	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi4ldcmg0004wugdvkxw24vx	Em valor estimado	valor:\n  De: 500 Milhões\n  Para: 1 Bilhão\n\ndescricao:\n  De: O valor total do acervo mobiliário de Pernambuco chega a ultrapassar 500 milhões de reais.\n  Para: O valor total do acervo mobiliário de Pernambuco chega a ultrapassar 1Bilhão de reais.
cmn642pty000fqaxk6snr919w	2026-03-25 14:00:46.148	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi4ldcmg0004wugdvkxw24vx	Em valor estimado	descricao:\n  De: O valor total do acervo mobiliário de Pernambuco chega a ultrapassar 1Bilhão de reais.\n  Para: O valor total do acervo mobiliário de Pernambuco chega a ultrapassar 1 Bilhão de reais.
cmnn5m6fz00011026ad0zhk8q	2026-04-06 12:15:58.749	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi34ocqx0006pu9zizgkeauw	Imóveis Cadastrados	valor:\n  De: Cerca de 3600\n  Para: 3600
cmnn5mj0w00021026islov7dq	2026-04-06 12:16:15.054	clovis.melo@sad.pe.gov.br	UPDATE	MuralItem	cmi4lbl3p0003wugdnpr0n4nf	Bens Móveis Cadastrados	valor:\n  De: Cerca de 1 Milhão\n  Para: 1 Milhão
cmq6yxa590001nh1t0g7u9qe1	2026-06-09 18:23:27.643	admin@admin.com	CREATE	AreaResponsavel	cmq6yxa510000nh1tnduds1mc	Patrimônio	Area criada: Patrimônio
cmq6yxdj70002nh1t49dteaml	2026-06-09 18:23:32.034	admin@admin.com	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	GESTÃO E FISCALIZAÇÃO DE CONTRATOS ADMINISTRATIVOS SOB A ÓTICA DA NOVA LEI DE LICITAÇÕES E CONTRATOS (LEI FEDERAL Nº 14.133/2021) - 20 h/a	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq6zikhy0000sg4aelmo1gvl	2026-06-09 18:40:00.835	admin@admin.com	UPDATE	Solucao	cmi6a9j8g00041b0b0fqqwtwq	Acervo Móvel	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq6zxhgx0000sk5hxrk6poi4	2026-06-09 18:51:36.749	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc
cmq81pn690002j9azesgb1rbr	2026-06-10 12:29:16.304	admin@admin.com	CREATE	AreaResponsavel	cmq81pn5v0001j9azrqcx4d99	Engenharia e Arquitetura	Area criada: Engenharia e Arquitetura
cmq81pvov0004j9azo094tzn8	2026-06-10 12:29:27.342	admin@admin.com	CREATE	AreaResponsavel	cmq81pvoq0003j9azcu4vg0ws	Serviços Corporativos	Area criada: Serviços Corporativos
cmq9j1ft30001boamvyaap4gk	2026-06-11 13:22:06.274	admin@admin.com	CREATE	Subarea	cmq9j1frn0000boamvyqh9qnc	Sem título	Registro criado.
cmq9j1sbi0003boamq8iaeqe3	2026-06-11 13:22:22.493	admin@admin.com	CREATE	Setor	cmq9j1sbd0002boam73vjfct4	Sem título	Registro criado.
cmq9j1tgm0005boam58u1rlzx	2026-06-11 13:22:23.973	admin@admin.com	CREATE	Servico	cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	Registro criado.
cmq9j4mmc0007boamb4c5uq7l	2026-06-11 13:24:35.075	admin@admin.com	CREATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	Registro criado.
cmq9j6qp00008boambwz0vt1j	2026-06-11 13:26:13.667	admin@admin.com	DELETE	Solucao	cmi6a9j8g00041b0b0fqqwtwq	Acervo Móvel	Registro excluído.
cmq9jaya6000aboamtbnaghk9	2026-06-11 13:29:30.125	admin@admin.com	CREATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	Registro criado.
cmq9jbeb8000cboamhnuvlqkn	2026-06-11 13:29:50.899	admin@admin.com	CREATE	Subarea	cmq9jbeb6000bboam2q6ep8nd	Sem título	Registro criado.
cmq9jbg59000dboamne21yvdk	2026-06-11 13:29:53.276	admin@admin.com	UPDATE	Servico	cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmq9jbeb6000bboam2q6ep8nd\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jc3ob000eboamr93hjskt	2026-06-11 13:30:23.77	admin@admin.com	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmq9jbeb6000bboam2q6ep8nd\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jchxx000fboamergsseri	2026-06-11 13:30:42.26	admin@admin.com	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	setorId:\n  De: cmq9j1sbd0002boam73vjfct4\n  Para: vazio\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jevtt000hboamj8dg482q	2026-06-11 13:32:33.569	admin@admin.com	CREATE	Setor	cmq9jevto000gboam7zrq5u0p	Sem título	Registro criado.
cmq9jf5vs000jboamnjfn0r3z	2026-06-11 13:32:46.599	admin@admin.com	CREATE	Servico	cmq9jf5vi000iboam6yi59usu	Pagamento de Tributos e Taxas de Imóveis Estaduais	Registro criado.
cmq9jh5pb000lboamvrue9eoy	2026-06-11 13:34:19.677	admin@admin.com	CREATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	Registro criado.
cmq9ji5tk000mboam14avbm10	2026-06-11 13:35:06.486	admin@admin.com	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	imagem_id:\n  De: vazio\n  Para: nuT2GZEwe36KQ0OG7Keuqg\n\nimagem_filesize:\n  De: vazio\n  Para: 18277\n\nimagem_width:\n  De: vazio\n  Para: 431\n\nimagem_height:\n  De: vazio\n  Para: 431\n\nimagem_extension:\n  De: vazio\n  Para: png\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jk3sa000oboamf4y8lqab	2026-06-11 13:36:37.16	admin@admin.com	CREATE	Servico	cmq9jk3re000nboamth81iigz	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	Registro criado.
cmq9jlsak000qboamkfhu0zzq	2026-06-11 13:37:55.579	admin@admin.com	CREATE	Servico	cmq9jlsab000pboamrkpkptas	Vistorias nos Imóveis Públicos	Registro criado.
cmq9jn6sy000rboamvn2wpw46	2026-06-11 13:39:01.041	admin@admin.com	UPDATE	Servico	cmq9jk3re000nboamth81iigz	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	imagem_id:\n  De: vazio\n  Para: UzRyZclZdaA_EwrVpB1V8A\n\nimagem_filesize:\n  De: vazio\n  Para: 264293\n\nimagem_width:\n  De: vazio\n  Para: 640\n\nimagem_height:\n  De: vazio\n  Para: 320\n\nimagem_extension:\n  De: vazio\n  Para: png\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jo9ka000sboamoru0s2t3	2026-06-11 13:39:51.272	admin@admin.com	UPDATE	Servico	cmq9jlsab000pboamrkpkptas	Vistorias nos Imóveis Públicos	imagem_id:\n  De: vazio\n  Para: iEsc35rmmFE7ALYDZNqVYw\n\nimagem_filesize:\n  De: vazio\n  Para: 8017\n\nimagem_width:\n  De: vazio\n  Para: 250\n\nimagem_height:\n  De: vazio\n  Para: 200\n\nimagem_extension:\n  De: vazio\n  Para: jpg\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jpp27000tboamo38mzibt	2026-06-11 13:40:58.013	admin@admin.com	UPDATE	Solucao	cmi4krlpf0000wugdaippzc92	Dashboard de Patrimônio Imobiliário	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc\n\nsubareaId:\n  De: vazio\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jpvtb000uboam3ueuby6k	2026-06-11 13:41:06.766	admin@admin.com	UPDATE	Solucao	cmid6qe0u0000tmuv7ype3ong	Dashboard de Patrimônio Móvel	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc\n\nsubareaId:\n  De: vazio\n  Para: cmq9jbeb6000bboam2q6ep8nd\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jq950000vboamjp4ttwpm	2026-06-11 13:41:24.034	admin@admin.com	UPDATE	Solucao	cmi3h5i7b0005vwpm6wngrtl4	GeoPE	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc\n\nsubareaId:\n  De: vazio\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9jw609000xboaml4zqqox2	2026-06-11 13:45:59.911	admin@admin.com	CREATE	Noticia	cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24	Registro criado.
cmq9jxx7n000yboamd3ahk5cx	2026-06-11 13:47:21.826	admin@admin.com	UPDATE	Noticia	cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24	imagemPrincipal_id:\n  De: vazio\n  Para: -oYEnjMnzxLTLbzn9d1pKA\n\nimagemPrincipal_filesize:\n  De: vazio\n  Para: 1397165\n\nimagemPrincipal_width:\n  De: vazio\n  Para: 5472\n\nimagemPrincipal_height:\n  De: vazio\n  Para: 3648\n\nimagemPrincipal_extension:\n  De: vazio\n  Para: jpg
cmq9jzq8v0010boamujgaysc0	2026-06-11 13:48:46.11	admin@admin.com	CREATE	Noticia	cmq9jzq8i000zboam9nk4qe3h	Governo de Pernambuco injeta cerca de R$ 5 bilhões aquecendo a economia do Estado	Registro criado.
cmq9k07xq0011boam7yu5rfds	2026-06-11 13:49:09.037	admin@admin.com	UPDATE	Noticia	cmq9jzq8i000zboam9nk4qe3h	Governo de Pernambuco injeta cerca de R$ 5 bilhões aquecendo a economia do Estado	imagemPrincipal_id:\n  De: vazio\n  Para: 0RFoOEnkY7hW-GE4MZFLnA\n\nimagemPrincipal_filesize:\n  De: vazio\n  Para: 9874328\n\nimagemPrincipal_width:\n  De: vazio\n  Para: 5516\n\nimagemPrincipal_height:\n  De: vazio\n  Para: 3677\n\nimagemPrincipal_extension:\n  De: vazio\n  Para: jpg
cmq9k32ml0013boamyui3uvg8	2026-06-11 13:51:22.123	admin@admin.com	CREATE	Noticia	cmq9k32m60012boamq05d5shl	Evolução do Ecossistema de Contratações Públicas de Pernambuco é tema da nova edição da Maratona Compras Públicas	Registro criado.
cmq9k3kv60014boama74qheyk	2026-06-11 13:51:45.761	admin@admin.com	UPDATE	Noticia	cmq9k32m60012boamq05d5shl	Evolução do Ecossistema de Contratações Públicas de Pernambuco é tema da nova edição da Maratona Compras Públicas	imagemPrincipal_id:\n  De: vazio\n  Para: H3UpMtV-1Awtbfm2yax9sg\n\nimagemPrincipal_filesize:\n  De: vazio\n  Para: 1032968\n\nimagemPrincipal_width:\n  De: vazio\n  Para: 5628\n\nimagemPrincipal_height:\n  De: vazio\n  Para: 3752\n\nimagemPrincipal_extension:\n  De: vazio\n  Para: jpg
cmq9kax0f0016boam1flxjgr4	2026-06-11 13:57:28.094	admin@admin.com	CREATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	Registro criado.
cmq9kbg050017boamfpgjmcop	2026-06-11 13:57:52.707	admin@admin.com	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	imagem_id:\n  De: vazio\n  Para: GYQDRafGH4JfAC_YRLc_Ng\n\nimagem_filesize:\n  De: vazio\n  Para: 605334\n\nimagem_width:\n  De: vazio\n  Para: 4016\n\nimagem_height:\n  De: vazio\n  Para: 6016\n\nimagem_extension:\n  De: vazio\n  Para: jpg\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9kgbul0019boamr3lz1s7w	2026-06-11 14:01:40.604	admin@admin.com	CREATE	Legislacao	cmq9kgbu30018boam5e1gfz73	Decreto nº 55.946/2023	Registro criado.
cmq9kh3ys001bboaml096kooo	2026-06-11 14:02:17.042	admin@admin.com	CREATE	Legislacao	cmq9kh3yo001aboam1wwjq7hc	Lei nº 11.781/2000	Registro criado.
cmq9kj661001dboamwfw6kyjk	2026-06-11 14:03:53.209	admin@admin.com	CREATE	Legislacao	cmq9kj65x001cboampp9wylsb	Lei nº 13.105/2015	Registro criado.
cmq9koeep001eboamz9hsz76a	2026-06-11 14:07:57.168	admin@admin.com	DELETE	Legislacao	cmq9kgbu30018boam5e1gfz73	Decreto nº 55.946/2023	Registro excluído.
cmq9kp6zp001gboam8ombj2pg	2026-06-11 14:08:34.211	admin@admin.com	CREATE	Legislacao	cmq9kp6za001fboamhnrookeb	Decreto nº 12.785/2025	Registro criado.
cmq9kps41001iboam36b8kpt6	2026-06-11 14:09:01.583	admin@admin.com	CREATE	Legislacao	cmq9kps3w001hboamjv1y4016	Decreto nº 35.706/2010	Registro criado.
cmq9kqgn5001kboamxi58wvvm	2026-06-11 14:09:33.374	admin@admin.com	CREATE	Legislacao	cmq9kqgmk001jboamm9004ifs	Decreto nº 39.335/2013	Registro criado.
cmq9krawi001mboam8cbopz7n	2026-06-11 14:10:12.593	admin@admin.com	CREATE	Legislacao	cmq9kraw1001lboams03lnty6	Decreto nº 39.639/2013	Registro criado.
cmq9ks1hr001oboamew2mdh0o	2026-06-11 14:10:47.054	admin@admin.com	CREATE	Legislacao	cmq9ks1hn001nboamqrhnmg1t	Decreto nº 40.222/2013	Registro criado.
cmq9ksujd001qboamvg01vsr5	2026-06-11 14:11:24.696	admin@admin.com	CREATE	Legislacao	cmq9ksuj8001pboam9mvluk8c	Decreto nº 42.589/2016	Registro criado.
cmq9ktgu2001sboamrx6weszo	2026-06-11 14:11:53.593	admin@admin.com	CREATE	Legislacao	cmq9ktgtq001rboamr6wk0amx	Decreto nº 55.946/2023	Registro criado.
cmq9ku5kf001uboam3jvt96ow	2026-06-11 14:12:25.646	admin@admin.com	CREATE	Legislacao	cmq9ku5ka001tboamjxo18q4a	Lei Complementar nº 141/2009	Registro criado.
cmq9kuv8y001wboam3lwgg1gu	2026-06-11 14:12:58.929	admin@admin.com	CREATE	Legislacao	cmq9kuv8q001vboam7tzkulpa	Lei nº 11.781/2000	Registro criado.
cmq9kvisf001yboamm02d7ux5	2026-06-11 14:13:29.438	admin@admin.com	CREATE	Legislacao	cmq9kvis7001xboam7x6cwok8	Lei nº 13.105/2015	Registro criado.
cmq9kwa0g0020boamhs7l0dhk	2026-06-11 14:14:04.718	admin@admin.com	CREATE	Legislacao	cmq9kw9zw001zboamxypxte3a	Lei nº 14.236/2010	Registro criado.
cmq9kxomc0022boam6uqhzfza	2026-06-11 14:15:10.307	admin@admin.com	CREATE	Legislacao	cmq9kxolx0021boami5dd6wn2	Lei nº 14.680/2012	Registro criado.
cmq9kyn0k0024boamo7trnr2o	2026-06-11 14:15:54.883	admin@admin.com	CREATE	Legislacao	cmq9kyn0g0023boamj4a9n422	Lei nº 6.015/1973	Registro criado.
cmq9kz8ai0026boampuluizho	2026-06-11 14:16:22.455	admin@admin.com	CREATE	Legislacao	cmq9kz89z0025boammah0dmzn	Lei nº 7.741/1978	Registro criado.
cmq9kzt7u0028boamex14v7n6	2026-06-11 14:16:49.576	admin@admin.com	CREATE	Legislacao	cmq9kzt7d0027boambu1eqi6a	Lei nº 9.504/1997	Registro criado.
cmq9l0meu002aboam5pm7v6jf	2026-06-11 14:17:27.413	admin@admin.com	CREATE	Legislacao	cmq9l0meg0029boame3wzch02	Lei nº 9.784/1999	Registro criado.
cmq9l186w002cboamrjkkspx5	2026-06-11 14:17:55.639	admin@admin.com	CREATE	Legislacao	cmq9l186h002bboamnudi7v6w	Portaria Conjunta SAD/SDS nº 035/2017	Registro criado.
cmq9l21b6002eboam6bd8jlb3	2026-06-11 14:18:33.377	admin@admin.com	CREATE	Legislacao	cmq9l21al002dboam2m9k5hki	Desfazimento de Semoventes Inservíveis	Registro criado.
cmq9l2q0o002gboampm9dik8o	2026-06-11 14:19:05.398	admin@admin.com	CREATE	Legislacao	cmq9l2q09002fboamw6bfwo4w	Provimento nº 11/2023 – CGJ/PE	Registro criado.
cmq9lapp4002hboammroiw5op	2026-06-11 14:25:18.231	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	conteudo:\n  De: [sem texto]\n  Para: Lorem ipsum dolor sit amet. A commodi autem id quia aliquid aut dolores quos? Et dicta deserunt quo natus aperiam est deleniti eius. 33 optio tenetur hic sequi rerum hic corrupti dolorem qui voluptatem voluptas sed nostrum blanditiis.
cmq9lbzcb002iboamlalvf91w	2026-06-11 14:26:17.385	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	conteudo:\n  De: Lorem ipsum dolor sit amet. A commodi autem id quia aliquid aut dolores quos? Et dicta deserunt quo natus aperiam est deleniti eius. 33 optio tenetur hic sequi rerum hic corrupti dolorem qui voluptatem voluptas sed nostrum blanditiis.\n  Para: Lorem ipsum dolor sit amet. A commodi autem id quia aliquid aut dolores quos? Et dicta deserunt quo natus aperiam est deleniti eius. 33 optio tenetur hic sequi rerum hic corrupti dolorem qui voluptatem voluptas sed nostrum blanditiis. Sit Quis deserunt et maiores doloribus non enim ullam aut aperiam excepturi aut veniam facere. Aut internos vero sit distinctio praesentium At enim voluptatem nam molestiae natus qui minus adipisci. Et deleniti nostrum sed soluta ipsum eum porro aliquid ut rerum voluptas vel voluptas sequi ea aspernatur ratione eum ipsam exercitationem. Eos placeat dolorem non voluptas voluptas eos deleniti galisum?
cmq9ld614002nboam6vugbrkx	2026-06-11 14:27:12.711	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmq9qw2e70000g5ah43cq7fzg	2026-06-11 17:01:52.54	admin@admin.com	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmq9qw8350001g5ah0w4fe251	2026-06-11 17:01:59.92	admin@admin.com	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmq9jbeb6000bboam2q6ep8nd\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmq9qwh4w0003g5ahjfkg3jks	2026-06-11 17:02:11.646	admin@admin.com	CREATE	Subarea	cmq9qwh4p0002g5ah899xzmv3	Sem título	Registro criado.
cmq9qwkt40004g5ahdyo6fp2x	2026-06-11 17:02:16.408	admin@admin.com	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmq9qwh4p0002g5ah899xzmv3\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmq9qx6pd0005g5ahhinyxx9g	2026-06-11 17:02:44.784	admin@admin.com	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	subareaId:\n  De: cmq9qwh4p0002g5ah899xzmv3\n  Para: cmq9jbeb6000bboam2q6ep8nd\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmq9qxn3l0006g5ahf6qefwfq	2026-06-11 17:03:06.031	admin@admin.com	DELETE	Subarea	cmq9qwh4p0002g5ah899xzmv3	Sem título	Registro excluído.
cmq9rfbpp000ag5ah467nopjr	2026-06-11 17:16:51.083	admin@admin.com	CREATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	Registro criado.
cmq9rha96000cg5ahatkooquu	2026-06-11 17:18:22.505	admin@admin.com	CREATE	Subarea	cmq9rha92000bg5ah7gkhkjyd	Sem título	Registro criado.
cmq9rhpc4000eg5ah9o6ucapd	2026-06-11 17:18:42.051	admin@admin.com	CREATE	Subarea	cmq9rhpc1000dg5ah7p97x6qj	Sem título	Registro criado.
cmq9rkwjd000gg5ahd6aiiytk	2026-06-11 17:21:11.352	admin@admin.com	CREATE	Noticia	cmq9rkwj7000fg5ahnyowdrmz	Lorem ipsum	Registro criado.
cmq9rsnxz000ig5ahrcr1fi6r	2026-06-11 17:27:13.461	admin@admin.com	CREATE	Servico	cmq9rsnxp000hg5ah3lhqu1un	Avaliação de Imóveis	Registro criado.
cmq9rvmrj000kg5ah5rkbiw9q	2026-06-11 17:29:31.902	admin@admin.com	CREATE	Servico	cmq9rvmr1000jg5ahyl18tc2d	Levantamentos topográficos georreferenciados	Registro criado.
cmq9rxjky000mg5ahhq6amf5p	2026-06-11 17:31:01.088	admin@admin.com	CREATE	Servico	cmq9rxjkk000lg5ahorb2k5lt	Projetos de engenharia	Registro criado.
cmq9rzu7j000og5ahxxgiwg35	2026-06-11 17:32:48.174	admin@admin.com	CREATE	Solucao	cmq9rzu75000ng5ahwwwkegmh	Lorem	Registro criado.
cmq9s0k7p000pg5ahkg710zj6	2026-06-11 17:33:21.877	admin@admin.com	UPDATE	Solucao	cmq9rzu75000ng5ahwwwkegmh	Lorem	areaResponsavelId:\n  De: vazio\n  Para: cmq81pn5v0001j9azrqcx4d99\n\nsubareaId:\n  De: vazio\n  Para: cmq9rha92000bg5ah7gkhkjyd\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9sorje000rg5aheqsrl6mk	2026-06-11 17:52:11.112	admin@admin.com	CREATE	Servico	cmq9sorix000qg5ahfulm0bn6	Lorem ipsum	Registro criado.
cmq9sphii000tg5ahe1ypq0g4	2026-06-11 17:52:44.777	admin@admin.com	CREATE	Subarea	cmq9sphie000sg5ah1lnqkut5	Sem título	Registro criado.
cmq9spitv000ug5ahh1c3s5gi	2026-06-11 17:52:46.481	admin@admin.com	UPDATE	Servico	cmq9sorix000qg5ahfulm0bn6	Lorem ipsum	subareaId:\n  De: vazio\n  Para: cmq9sphie000sg5ah1lnqkut5\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9sv8w2000wg5ahjov6265d	2026-06-11 17:57:13.537	admin@admin.com	CREATE	Legislacao	cmq9sv8vo000vg5ah3julaleh	LEI Nº 5.194/1996	Registro criado.
cmq9sw2on000yg5ah112qr5ki	2026-06-11 17:57:52.15	admin@admin.com	CREATE	Legislacao	cmq9sw2oj000xg5ah6tx0gdlq	NBR 14.653	Registro criado.
cmq9sxcv00010g5ahse41r0wc	2026-06-11 17:58:51.994	admin@admin.com	CREATE	Legislacao	cmq9sxcuu000zg5ah8lb9q2yr	Portaria SAD nº 2.679/2024	Registro criado.
cmq9sy8s60012g5aho1qsuoir	2026-06-11 17:59:33.364	admin@admin.com	CREATE	Legislacao	cmq9sy8rq0011g5ahrzjc0tve	RESOLUÇÃO N° 1.073/2016	Registro criado.
cmq9sz9ty0014g5ahutdz7n86	2026-06-11 18:00:21.381	admin@admin.com	CREATE	Legislacao	cmq9sz9ta0013g5ah2fgd16zm	RESOLUÇÃO Nº 1.137/2023	Registro criado.
cmq9t01os0016g5ahbs3lq3t2	2026-06-11 18:00:57.483	admin@admin.com	CREATE	Legislacao	cmq9t01on0015g5ah9wd7l4cq	RESOLUÇÃO Nº 218/1973	Registro criado.
cmq9t18w20018g5ahc9abs18h	2026-06-11 18:01:53.473	admin@admin.com	CREATE	Legislacao	cmq9t18vv0017g5ah33e77vmd	RESOLUÇÃO Nº 345/1990.	Registro criado.
cmq9t34ic001ag5ahgrahyxuc	2026-06-11 18:03:21.107	admin@admin.com	CREATE	Legislacao	cmq9t34i00019g5ahl0keyhk6	LEI Nº 10.098/2000	Registro criado.
cmq9t3t35001cg5ahg5icpeqi	2026-06-11 18:03:52.959	admin@admin.com	CREATE	Legislacao	cmq9t3t2o001bg5ah06xmhdzn	LEI Nº12.378/2010	Registro criado.
cmq9t4bsp001eg5ahdlhsf0db	2026-06-11 18:04:17.207	admin@admin.com	CREATE	Legislacao	cmq9t4bsb001dg5ahphwdu4hj	RESOLUÇÃO N°184/2019	Registro criado.
cmq9t4zuf001gg5ahis0f8tkm	2026-06-11 18:04:48.373	admin@admin.com	CREATE	Legislacao	cmq9t4zu8001fg5ahp5twdwy6	RESOLUÇÃO Nº177/2019	Registro criado.
cmq9t5o2i001ig5ahgx4wb76o	2026-06-11 18:05:19.769	admin@admin.com	CREATE	Legislacao	cmq9t5o22001hg5ahgkpiaobj	RESOLUÇÃO Nº75/2014	Registro criado.
cmq9t6i0y001kg5ahw4pfw46h	2026-06-11 18:05:58.592	admin@admin.com	CREATE	Legislacao	cmq9t6i0l001jg5ah0m4ok9kl	RESOLUÇÃO Nº91/2014	Registro criado.
cmq9t9rka001mg5ahcsfirtlk	2026-06-11 18:08:30.921	admin@admin.com	CREATE	Servico	cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	Registro criado.
cmq9tbnd6001ng5ahqoub5nni	2026-06-11 18:09:58.794	admin@admin.com	UPDATE	Servico	cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	imagem_id:\n  De: vazio\n  Para: uUltbFVqhllgP969gdhBVQ\n\nimagem_filesize:\n  De: vazio\n  Para: 2383059\n\nimagem_width:\n  De: vazio\n  Para: 1536\n\nimagem_height:\n  De: vazio\n  Para: 1024\n\nimagem_extension:\n  De: vazio\n  Para: png\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9tecrh001og5ahzg8ve8d4	2026-06-11 18:12:05.019	admin@admin.com	UPDATE	Servico	cmq9rxjkk000lg5ahorb2k5lt	Projetos de engenharia	imagem_id:\n  De: vazio\n  Para: qFLWrfBaLKnNbzZdBwyOCQ\n\nimagem_filesize:\n  De: vazio\n  Para: 2080182\n\nimagem_width:\n  De: vazio\n  Para: 1536\n\nimagem_height:\n  De: vazio\n  Para: 1024\n\nimagem_extension:\n  De: vazio\n  Para: png\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmq9thd1m001qg5ahpus8zepe	2026-06-11 18:14:25.353	admin@admin.com	CREATE	Noticia		GraphQLError	Registro criado.
cmq9thhuj001sg5ahr71qytag	2026-06-11 18:14:31.578	admin@admin.com	CREATE	Noticia	cmq9thhu6001rg5ahvty8whzn	Lorem	Registro criado.
cmqaxqami000112bq1w8int31	2026-06-12 13:01:06.761	admin@admin.com	CREATE	Solucao	cmqaxqam4000012bq6kh4olp6	Lorem	Registro criado.
cmqb1j1qu00011waiqj79uupg	2026-06-12 14:47:27.124	admin@admin.com	CREATE	Portfolio	cmqb1j1qg00001wainiagjo70	Lorem	Registro criado.
cmqb7pds90002tazhlvn14au8	2026-06-12 17:40:20.36	admin@admin.com	UPDATE	Portfolio	cmqb1j1qg00001wainiagjo70	Lorem	updatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmqb8tn82000085sr8rzcot4f	2026-06-12 18:11:38.833	admin@admin.com	UPDATE	Portfolio	cmqb1j1qg00001wainiagjo70	Lorem	resumo:\n  De: lorem\n  Para: Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus.\n\n\ncorpo:\n  De: lorem\n  Para: StartFragment Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus. Quo fugit consequatur et soluta accusamus ad sunt blanditiis est quibusdam internos. A expedita sint et cupiditate assumenda sit assumenda voluptate. Et deserunt laborum et unde autem id sunt aliquid aut magni velit ut veritatis cupiditate. Et voluptatem earum eos ipsam error ut molestiae quae et totam deleniti. EndFragment\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqb8vtrl000385srnf4bnksr	2026-06-12 18:13:20.624	admin@admin.com	CREATE	Portfolio	cmqb8vtrh000285sry6i1c7m6	Lorem	Registro criado.
cmrurip450006d883tqnzc7u1	2026-07-21 14:42:20.452	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmqb8w0ts000485srdjyq4b3o	2026-06-12 18:13:29.775	admin@admin.com	UPDATE	Portfolio	cmqb8vtrh000285sry6i1c7m6	Lorem 3	titulo:\n  De: Lorem\n  Para: Lorem 3\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmqb8w44l000585srnpjw3f2p	2026-06-12 18:13:34.052	admin@admin.com	UPDATE	Portfolio	cmqb8vtrh000285sry6i1c7m6	Lorem 2	titulo:\n  De: Lorem 3\n  Para: Lorem 2\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqb8y7qb000a85srf7a26cyl	2026-06-12 18:15:12.034	admin@admin.com	UPDATE	Portfolio	cmqb8vtrh000285sry6i1c7m6	Lorem 2	updatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqbajgmf000b85srkdidjr50	2026-06-12 18:59:42.948	admin@admin.com	UPDATE	Portfolio	cmqb8vtrh000285sry6i1c7m6	Lorem 2	corpo:\n  De: StartFragment Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus. Quo fugit consequatur et soluta accusamus ad sunt blanditiis est quibusdam internos. A expedita sint et cupiditate assumenda sit assumenda voluptate. Et deserunt laborum et unde autem id sunt aliquid aut magni velit ut veritatis cupiditate. Et voluptatem earum eos ipsam error ut molestiae quae et totam deleniti. EndFragment\n  Para: Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus. Quo fugit consequatur et soluta accusamus ad sunt blanditiis est quibusdam internos. A expedita sint et cupiditate assumenda sit assumenda voluptate. Et deserunt laborum et unde autem id sunt aliquid aut magni velit ut veritatis cupiditate. Et voluptatem earum eos ipsam error ut molestiae quae et totam deleniti.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqgnv5yf00013adnmrn57y62	2026-06-16 13:11:34.884	allan.soares.sad@gmail.com	CREATE	Subarea	cmqgnv5xk00003adnqj7bkkdv	Sem título	Registro criado.
cmqgnv7yg00023adnneagyevx	2026-06-16 13:11:37.48	allan.soares.sad@gmail.com	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Allan Soares
cmqgq8389000146yhtbfu4vi2	2026-06-16 14:17:37.112	allan.soares.sad@gmail.com	CREATE	Curso	cmqgq837u000046yhbe9456a6	Teste	Registro criado.
cmqgqrqvx00004n0h2u49nwmc	2026-06-16 14:32:54.236	allan.soares.sad@gmail.com	UPDATE	Curso	cmqgq837u000046yhbe9456a6	Teste	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqgr89we000111bmjqo1zki9	2026-06-16 14:45:45.372	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	Registro criado.
cmqgrcg8h000211bms3b1ym9x	2026-06-16 14:49:00.209	admin@admin.com	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	GESTÃO E FISCALIZAÇÃO DE CONTRATOS ADMINISTRATIVOS SOB A ÓTICA DA NOVA LEI DE LICITAÇÕES E CONTRATOS (LEI FEDERAL Nº 14.133/2021) - 20 h/a	subareaId:\n  De: vazio\n  Para: cmq9jbeb6000bboam2q6ep8nd\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqgvjboq000411bmwu8mojck	2026-06-16 16:46:19.364	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel- uso do Pe Integrado	Registro criado.
cmqgvk7i1000511bmcp02a4v8	2026-06-16 16:47:00.6	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	titulo:\n  De: Gestor de Patrimônio Imóvel- uso do Pe Integrado\n  Para: Gestor de Patrimônio Imóvel - uso do Pe Integrado\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmqgvkz7i000611bm5kzjauei	2026-06-16 16:47:36.509	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	resumo:\n  De: Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n  Para:            Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n           Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqgvpevn000711bmbqjlzpna	2026-06-16 16:51:03.442	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kp6za001fboamhnrookeb	Decreto nº 12.785/2025	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqgvpp4g000811bmrt3faj5y	2026-06-16 16:51:16.718	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kps3w001hboamjv1y4016	Decreto nº 35.706/2010	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqgvpw63000911bmwofggerb	2026-06-16 16:51:25.85	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kqgmk001jboamm9004ifs	Decreto nº 39.335/2013	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqgvq3lg000a11bm4lq9bo7m	2026-06-16 16:51:35.475	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kraw1001lboams03lnty6	Decreto nº 39.639/2013	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1kmr00000wzj83y69ow46	2026-06-17 12:23:04.234	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9ks1hn001nboamqrhnmg1t	Decreto nº 40.222/2013	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1ktnq0001wzj8l8237ir1	2026-06-17 12:23:13.189	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9ksuj8001pboam9mvluk8c	Decreto nº 42.589/2016	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1l5580002wzj83oailp7b	2026-06-17 12:23:28.076	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9l21al002dboam2m9k5hki	Desfazimento de Semoventes Inservíveis	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1la4j0003wzj8uae937xl	2026-06-17 12:23:34.531	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9ku5ka001tboamjxo18q4a	Lei Complementar nº 141/2009	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmrupfnbb0000qshw6yj021m5	2026-07-21 13:43:58.916	admin@admin.com	DELETE	PaginaQuemSomos	cmrup6xub0000vrbs5m2rw1sl	Sem título	Registro excluído.
cmqi1lgkf0004wzj8dyhdhi3m	2026-06-17 12:23:42.879	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kw9zw001zboamxypxte3a	Lei nº 14.236/2010	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1lvlx0006wzj8wppkwsnd	2026-06-17 12:24:02.371	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kz89z0025boammah0dmzn	Lei nº 7.741/1978	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1lpb20005wzj8sfvhjesn	2026-06-17 12:23:54.204	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kxolx0021boami5dd6wn2	Lei nº 14.680/2012	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1m2k90007wzj88wukhj2k	2026-06-17 12:24:11.383	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9kzt7d0027boambu1eqi6a	Lei nº 9.504/1997	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1mbhx0008wzj8f9jqxy63	2026-06-17 12:24:22.963	allan.soares.sad@gmail.com	UPDATE	Legislacao	cmq9l186h002bboamnudi7v6w	Portaria Conjunta SAD/SDS nº 035/2017	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1palt0009wzj8u2yq92sa	2026-06-17 12:26:41.776	allan.soares.sad@gmail.com	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Allan Soares
cmqi1ud4y0000gi8kv9zszto5	2026-06-17 12:30:38.336	allan.soares.sad@gmail.com	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	subareaId:\n  De: cmqgnv5xk00003adnqj7bkkdv\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqi1uhei0001gi8ktptir7rp	2026-06-17 12:30:43.865	allan.soares.sad@gmail.com	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqi2ohik0000cj9turianfcx	2026-06-17 12:54:03.691	allan.soares.sad@gmail.com	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	subareaId:\n  De: cmqgnv5xk00003adnqj7bkkdv\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqi2owzk0001cj9ti32s9sxo	2026-06-17 12:54:23.742	allan.soares.sad@gmail.com	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	GESTÃO E FISCALIZAÇÃO DE CONTRATOS ADMINISTRATIVOS SOB A ÓTICA DA NOVA LEI DE LICITAÇÕES E CONTRATOS (LEI FEDERAL Nº 14.133/2021) - 20 h/a	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Allan Soares
cmqiev0tx0000km6lnlycmyyd	2026-06-17 18:35:04.051	admin@admin.com	UPDATE	Servico	cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqievpst0001km6lby4xp2hv	2026-06-17 18:35:36.412	admin@admin.com	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqievv6h0002km6lum7ica1l	2026-06-17 18:35:43.384	admin@admin.com	UPDATE	Solucao	cmid6qe0u0000tmuv7ype3ong	Dashboard de Patrimônio Móvel	subareaId:\n  De: cmq9jbeb6000bboam2q6ep8nd\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqiew4qh0003km6lnnt3n9dc	2026-06-17 18:35:55.768	admin@admin.com	DELETE	Subarea	cmq9jbeb6000bboam2q6ep8nd	Sem título	Registro excluído.
cmqife5ii0004km6laicsdng5	2026-06-17 18:49:56.585	agelson.santana@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De: Quem Somos\n  Para: Quem Somos 01
cmqigbzny0007km6l6lwc4zvz	2026-06-17 19:16:15.308	agelson.santana@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De: Quem Somos 01\n  Para: NOSSOS NÚMEROS\n\norganogramaImagem_id:\n  De: StRCKrMKfniIU9KDCndnPg\n  Para: ZUlolkJYMm3Wpad6UB9Ygg\n\norganogramaImagem_filesize:\n  De: 1971089\n  Para: 24654\n\norganogramaImagem_width:\n  De: 6000\n  Para: 551\n\norganogramaImagem_height:\n  De: 4004\n  Para: 520\n\norganogramaImagemAlt:\n  De: rwer\n  Para: Adauto Nunes
cmqigdcyt0008km6li6amrav3	2026-06-17 19:17:19.204	agelson.santana@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	organogramaTitulo:\n  De: Organograma\n  Para: Gerente Geral de Patrimônio do Estado
cmqigzr6a0000mw2bx552acqb	2026-06-17 19:34:44.049	agelson.santana@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	organogramaImagem_id:\n  De: ZUlolkJYMm3Wpad6UB9Ygg\n  Para: fcOH4SSlgwGDBlS_p2vWmg\n\norganogramaImagem_filesize:\n  De: 24654\n  Para: 53859\n\norganogramaImagem_width:\n  De: 551\n  Para: 612\n\norganogramaImagem_height:\n  De: 520\n  Para: 408
cmqjh72hc0002mw2bhkxo9j66	2026-06-18 12:28:11.471	agelson.santana@sad.pe.gov.br	CREATE	Noticia	cmqjh72gq0001mw2bhdl87tz9	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	Registro criado.
cmqjheoob0003mw2btz8dw2py	2026-06-18 12:34:06.826	agelson.santana@sad.pe.gov.br	UPDATE	Noticia	cmqjh72gq0001mw2bhdl87tz9	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	corpo:\n  De: StartFragment A capital pernambucana ganhou uma nova representação visual que exalta a riqueza de sua história urbana e arquitetônica. Uma ilustração detalhada destaca o  Patrimônio Imóvel  da cidade, reunindo em um único cenário alguns dos marcos mais emblemáticos que moldaram a identidade recifense ao longo dos séculos. O painel, que traz a assinatura  "Recife • Pernambuco: Preservação da Memória Arquitetônica" , funciona como uma linha do tempo visual, conectando o passado colonial, o classicismo imperial e a modernidade da cidade. Um Passeio pela História de Recife A composição artística recria a atmosfera vibrante das ruas recifenses, mostrando cidadãos e turistas caminhando e pedalando entre monumentos históricos. Entre os grandes destaques da ilustração estão: Ao fundo, elementos como o icônico  Farol de Olinda/Recife , as pontes e os arrecifes completam a cena, emoldurados pelas bandeiras de Pernambuco e do Brasil. O Valor da Preservação Especialistas apontam que iniciativas visuais como esta são fundamentais para conscientizar a população sobre a importância da salvaguarda do patrimônio edificado. Mais do que cartões-postais, esses prédios contam a história do desenvolvimento econômico, político e cultural do estado. O painel reforça a mensagem de que preservar o Patrimônio Imóvel é garantir que as futuras gerações possam continuar caminhando pela história viva de Recife. EndFragment\n  Para: A capital pernambucana ganhou uma nova representação visual que exalta a riqueza de sua história urbana e arquitetônica. Uma ilustração detalhada destaca o  Patrimônio Imóvel  da cidade, reunindo em um único cenário alguns dos marcos mais emblemáticos que moldaram a identidade recifense ao longo dos séculos. O painel, que traz a assinatura  "Recife • Pernambuco: Preservação da Memória Arquitetônica" , funciona como uma linha do tempo visual, conectando o passado colonial, o classicismo imperial e a modernidade da cidade. Um Passeio pela História de Recife A composição artística recria a atmosfera vibrante das ruas recifenses, mostrando cidadãos e turistas caminhando e pedalando entre monumentos históricos. Entre os grandes destaques da ilustração estão: Ao fundo, elementos como o icônico  Farol de Olinda/Recife , as pontes e os arrecifes completam a cena, emoldurados pelas bandeiras de Pernambuco e do Brasil. O Valor da Preservação Especialistas apontam que iniciativas visuais como esta são fundamentais para conscientizar a população sobre a importância da salvaguarda do patrimônio edificado. Mais do que cartões-postais, esses prédios contam a história do desenvolvimento econômico, político e cultural do estado. O painel reforça a mensagem de que preservar o Patrimônio Imóvel é garantir que as futuras gerações possam continuar caminhando pela história viva de Recife.
cmqjhjtph0004mw2bbggp7m2o	2026-06-18 12:38:06.625	agelson.santana@sad.pe.gov.br	UPDATE	Noticia	cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	titulo:\n  De: 5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24\n  Para: 5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês
cmqji11ps0006mw2bmba00jt7	2026-06-18 12:51:30.16	agelson.santana@sad.pe.gov.br	CREATE	Noticia	cmqji11p70005mw2bsma7e9ov	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	Registro criado.
cmqji5o4y0007mw2b6j5yxj2o	2026-06-18 12:55:05.841	agelson.santana@sad.pe.gov.br	UPDATE	Noticia	cmqji11p70005mw2bsma7e9ov	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmqgnv5xk00003adnqj7bkkdv
cmqjioi3p0009mw2buod7tabw	2026-06-18 13:09:44.484	agelson.santana@sad.pe.gov.br	CREATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	Registro criado.
cmqjirdrr000amw2bx22b35fw	2026-06-18 13:11:58.838	agelson.santana@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	slug:\n  De: https://atlas.pe.gov.br/login\n  Para: Atlas.PE\n\nlinkExterno:\n  De: Atlas.PE\n  Para: https://atlas.pe.gov.br/login\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmr50n4ee0007vw8zjwadaezf	2026-07-03 14:15:42.852	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jk3re000nboamth81iigz	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	ativo:\n  De: true\n  Para: false\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqjiufwu000bmw2bngz27gg2	2026-06-18 13:14:21.581	agelson.santana@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	corpo:\n  De: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis.\n  Para: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis. Compartilhamento Compartilhe a visualização atual por link para reproduzir a mesma consulta em outro acesso. Filtros salvos Reaproveite cenários recorrentes de busca sem precisar remontar a consulta a cada acesso.\n Integração com o GeoPE Quando a leitura territorial é necessária, a consulta patrimonial pode ser conectada ao GeoPE para aprofundar o entendimento espacial do imóvel. Consulta patrimonial conectada ao território Essa integração amplia a compreensão do imóvel ao relacionar cadastro e localização em um único fluxo de consulta. Capacidades da plataforma A visualização pública concentra a consulta patrimonial. Recursos avançados, como módulos internos de histórico, análise e controle, permanecem disponíveis conforme o perfil de acesso do usuário.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqjiwtq5000cmw2b4y8zdd3b	2026-06-18 13:16:12.796	agelson.santana@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	corpo:\n  De: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis. Compartilhamento Compartilhe a visualização atual por link para reproduzir a mesma consulta em outro acesso. Filtros salvos Reaproveite cenários recorrentes de busca sem precisar remontar a consulta a cada acesso.\n Integração com o GeoPE Quando a leitura territorial é necessária, a consulta patrimonial pode ser conectada ao GeoPE para aprofundar o entendimento espacial do imóvel. Consulta patrimonial conectada ao território Essa integração amplia a compreensão do imóvel ao relacionar cadastro e localização em um único fluxo de consulta. Capacidades da plataforma A visualização pública concentra a consulta patrimonial. Recursos avançados, como módulos internos de histórico, análise e controle, permanecem disponíveis conforme o perfil de acesso do usuário.\n  Para: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis. Compartilhamento Compartilhe a visualização atual por link para reproduzir a mesma consulta em outro acesso. Filtros salvos Reaproveite cenários recorrentes de busca sem precisar remontar a consulta a cada acesso.\n Integração com o GeoPE Quando a leitura territorial é necessária, a consulta patrimonial pode ser conectada ao GeoPE para aprofundar o entendimento espacial do imóvel. Consulta patrimonial conectada ao território Essa integração amplia a compreensão do imóvel ao relacionar cadastro e localização em um único fluxo de consulta. Capacidades da plataforma A visualização pública concentra a consulta patrimonial. Recursos avançados, como módulos internos de histórico, análise e controle, permanecem disponíveis conforme o perfil de acesso do usuário.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqjiy0kv000dmw2b1j5olqdj	2026-06-18 13:17:08.334	agelson.santana@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	corpo:\n  De: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis. Compartilhamento Compartilhe a visualização atual por link para reproduzir a mesma consulta em outro acesso. Filtros salvos Reaproveite cenários recorrentes de busca sem precisar remontar a consulta a cada acesso.\n Integração com o GeoPE Quando a leitura territorial é necessária, a consulta patrimonial pode ser conectada ao GeoPE para aprofundar o entendimento espacial do imóvel. Consulta patrimonial conectada ao território Essa integração amplia a compreensão do imóvel ao relacionar cadastro e localização em um único fluxo de consulta. Capacidades da plataforma A visualização pública concentra a consulta patrimonial. Recursos avançados, como módulos internos de histórico, análise e controle, permanecem disponíveis conforme o perfil de acesso do usuário.\n  Para: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis. Compartilhamento Compartilhe a visualização atual por link para reproduzir a mesma consulta em outro acesso. Filtros salvos Reaproveite cenários recorrentes de busca sem precisar remontar a consulta a cada acesso.\n Integração com o GeoPE Quando a leitura territorial é necessária, a consulta patrimonial pode ser conectada ao GeoPE para aprofundar o entendimento espacial do imóvel. Consulta patrimonial conectada ao território Essa integração amplia a compreensão do imóvel ao relacionar cadastro e localização em um único fluxo de consulta. Capacidades da plataforma A visualização pública concentra a consulta patrimonial. Recursos avançados, como módulos internos de histórico, análise e controle, permanecem disponíveis conforme o perfil de acesso do usuário.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqjiyyi8000emw2brw9zm52x	2026-06-18 13:17:52.303	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	resumo:\n  De:            Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n           Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n  Para:            Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n         \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqjizzx6000fmw2bpcz2nmt0	2026-06-18 13:18:40.793	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	resumo:\n  De:            Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PE Integrado seu passo a passo.\n         \n  Para: Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI e seu passo a passo.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmqjkr50400003os2xklpqd92	2026-06-18 14:07:46.706	admin@admin.com	UPDATE	Noticia	cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	Nenhuma alteração detectada.
cmqjkr9ie00013os2pf66ckmd	2026-06-18 14:07:52.548	admin@admin.com	UPDATE	Noticia	cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	Nenhuma alteração detectada.
cmqkv5sjq0000mjv2onhpkgli	2026-06-19 11:46:52.741	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	conteudo:\n  De: Lorem ipsum dolor sit amet. Rem corrupti porro ea numquam nesciunt rem asperiores esse non repudiandae explicabo ut beatae harum. At architecto aspernatur est consequuntur deleniti qui voluptas asperiores 33 reiciendis maiores? Ut alias assumenda ex quia sunt ut nihil necessitatibus eos internos eligendi. Vel voluptatem porro ad quis facere est inventore rerum ut quis optio in voluptatum fugiat. 33 commodi dolores a eius quos est dolores facilis qui consequuntur voluptatibus.\n  Para: Para subir o prédio, e para mantê-lo em pé, a quem irão procurar? Podem contar conosco! Nós somos a área técnica de Engenharia e Arquitetura do Estado. Se é um imóvel do Estado, e já não há quem olhe por ele, nós iremos olhar. Iremos olhar cada canto e detalhe. O layout, a divisória, a mesa e seu lugar; a parede, a alvenaria, o teto e a janela; e mesmo a luz, a água, o terreno e o preço do aluguel. Nosso trabalho é criar e cuidar.
cmr3guggm0006o5a0s94n4c8n	2026-07-02 12:13:46.581	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr3gy0or0007o5a0od7f4cf0	2026-07-02 12:16:32.762	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr3q7ywb0001m829jcbx6kku	2026-07-02 16:36:13.543	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	oQueE:\n  De: Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para recebimento e/ou incorporação de imóveis ao patrimonial estadual por doação (com ou sem encargos), independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado. Link de acesso à Plataforma SEI: xxxxx\n  Para: Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para recebimento e/ou incorporação de imóveis ao patrimonial estadual por doação (com ou sem encargos), independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrb0n4a70006tspsd8mghbty	2026-07-07 19:02:19.758	viktoria.cruz@sad.pe.gov.br	CREATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário 	Registro criado.
cmrupfnbb0001qshws1nmbia2	2026-07-21 13:43:58.915	admin@admin.com	DELETE	PaginaQuemSomos	cmrup7a3e0002vrbsd0kesdxn	Sem título	Registro excluído.
cmrurd2qh0004d883nwnypwc4	2026-07-21 14:37:58.165	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De: Sobre nós\n  Para: Sobre
cmqkv6odg0001mjv2mwe3weu0	2026-06-19 11:47:33.987	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	conteudo:\n  De: Para subir o prédio, e para mantê-lo em pé, a quem irão procurar? Podem contar conosco! Nós somos a área técnica de Engenharia e Arquitetura do Estado. Se é um imóvel do Estado, e já não há quem olhe por ele, nós iremos olhar. Iremos olhar cada canto e detalhe. O layout, a divisória, a mesa e seu lugar; a parede, a alvenaria, o teto e a janela; e mesmo a luz, a água, o terreno e o preço do aluguel. Nosso trabalho é criar e cuidar.\n  Para: [sem texto]\n\nmuralTextoIntrodutorio:\n  De: Lorem ipsum dolor sit amet. Rem corrupti porro ea numquam nesciunt rem asperiores esse non repudiandae explicabo ut beatae harum. At architecto aspernatur est consequuntur deleniti qui voluptas asperiores 33 reiciendis maiores?\n\nUt alias assumenda ex quia sunt ut nihil necessitatibus eos internos eligendi. Vel voluptatem porro ad quis facere est inventore rerum ut quis optio in voluptatum fugiat. 33 commodi dolores a eius quos est dolores facilis qui consequuntur voluptatibus.\n  Para: Para subir o prédio, e para mantê-lo em pé, a quem irão procurar? Podem contar conosco! Nós somos a área técnica de Engenharia e Arquitetura do Estado. Se é um imóvel do Estado, e já não há quem olhe por ele, nós iremos olhar. Iremos olhar cada canto e detalhe. O layout, a divisória, a mesa e seu lugar; a parede, a alvenaria, o teto e a janela; e mesmo a luz, a água, o terreno e o preço do aluguel. Nosso trabalho é criar e cuidar.
cmqkv72w90002mjv2pmuko955	2026-06-19 11:47:52.805	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	tituloDaPagina:\n  De: Quem Somos\n  Para: Time
cmqkv7c840003mjv2atm1olqa	2026-06-19 11:48:04.896	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	tituloDaPagina:\n  De: Time\n  Para: Quem somos
cmqtif9540001hp20xal1tpdp	2026-06-25 13:00:14.726	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmqtipqt1000011mhqkx0qzqv	2026-06-25 13:08:24.179	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De: NOSSOS NÚMEROS\n  Para: Quem somos
cmquw1ctw0000z8ntu17f9572	2026-06-26 12:09:07.122	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	areaResponsavelId:\n  De: vazio\n  Para: cmq6yxa510000nh1tnduds1mc
cmquw1uay0002z8ntko9ud33n	2026-06-26 12:09:29.769	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	muralTextoIntrodutorio:\n  De: \n  Para: Lorem
cmquw2qtt0004z8nt1cza019k	2026-06-26 12:10:11.92	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmquw3zna0006z8nt0epzya9n	2026-06-26 12:11:10.006	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmr0mifze0000o5a0ljcgo9pm	2026-06-30 12:29:05.252	admin@admin.com	UPDATE	Servico	cmq9rvmr1000jg5ahyl18tc2d	Levantamentos topográficos georreferenciados	areaResponsavelId:\n  De: cmq81pn5v0001j9azrqcx4d99\n  Para: cmq6yxa510000nh1tnduds1mc\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmr0mim350001o5a0rc46ry0h	2026-06-30 12:29:13.167	admin@admin.com	UPDATE	Servico	cmq9rvmr1000jg5ahyl18tc2d	Levantamentos topográficos georreferenciados	areaResponsavelId:\n  De: cmq6yxa510000nh1tnduds1mc\n  Para: cmq81pn5v0001j9azrqcx4d99\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr0n19bd0002o5a0z3u6fmjy	2026-06-30 12:43:43.079	admin@admin.com	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De: Quem Somos\n  Para:   
cmr3g19ap0003o5a028pyt4lm	2026-07-02 11:51:04.271	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	oQueE:\n  De: Trata-se do procedimento a ser feito, preferenciamente, via plataforma SEI, para recebimento e/ou incorporação de imóveis ao patrimonial estadual por doação (com ou sem encargos), independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado. Link de acesso à Plataforma SEI: xxxxx\n  Para: Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para recebimento e/ou incorporação de imóveis ao patrimonial estadual por doação (com ou sem encargos), independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado. Link de acesso à Plataforma SEI: xxxxx\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Gustavo Andrade
cmr3g1ijn0004o5a0n0k6n3hr	2026-07-02 11:51:16.258	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jk3re000nboamth81iigz	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	oQueE:\n  De: Trata-se do procedimento a ser feito, preferenciamente, via plataforma SEI, para saída (transferência) de imóveis ao patrimonial estadual por doação (com ou sem encargos) a terceiros, independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado. Link de acesso à Plataforma SEI: xxxxx\n  Para: Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para saída (transferência) de imóveis ao patrimonial estadual por doação (com ou sem encargos) a terceiros, independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado. Link de acesso à Plataforma SEI: xxxxx\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Gustavo Andrade
cmr3gh23x0005o5a0mxeh3map	2026-07-02 12:03:21.451	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr3q7lkj0000m8296o9obths	2026-07-02 16:35:56.269	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50mx3b0006vw8zbgrwtugx	2026-07-03 14:15:33.381	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	ativo:\n  De: true\n  Para: false\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrun80q1000ajzjxhjj2nnes	2026-07-21 12:42:03.816	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	timeTitulo:\n  De: Nosso Time\n  Para: Nossa Gerência
cmrurc46b0001d883rvq6hq47	2026-07-21 14:37:13.376	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De:   Quem somos\n  Para: Sobre nós
cmr3qqkxl0002m829l0qyw5aq	2026-07-02 16:50:41.91	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jk3re000nboamth81iigz	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	oQueE:\n  De: Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para saída (transferência) de imóveis ao patrimonial estadual por doação (com ou sem encargos) a terceiros, independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado. Link de acesso à Plataforma SEI: xxxxx\n  Para: Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para saída (transferência) de imóveis ao patrimonial estadual por doação (com ou sem encargos) a terceiros, independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado.\n\ncomoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr3qr6ie0003m829u5lqcp0g	2026-07-02 16:51:09.877	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr3qvtnw0004m829vrhun5l2	2026-07-02 16:54:46.507	admin@admin.com	UPDATE	Servico	cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	comoSolicitar:\n  De: A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações:\n1- Ofício da Autoridade máxima do órgão solicitando à SEADP/SAD  a inclusão dos bens inservíveis para leilão;\n2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD\nObs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017.\n3- Laudo de Risco Biológico / Ambiental, quando aplicável.\n  Para: A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações:\n 1- Ofício da Autoridade máxima do órgão solicitando à SEADP/SAD  a inclusão dos bens inservíveis para leilão;\n 2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD\nObs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017.\n 3- Laudo de Risco Biológico / Ambiental, quando aplicável.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr3qw4ux0005m829f1xlhh3m	2026-07-02 16:55:01.015	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	quemPrecisa:\n  De: Os serviços da UNAPI são destinados a toda a população que deseja regularizar um bem imóvel por meio da Ação de Usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário). Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo segurança jurídica e o devido registro, pode buscar os serviços da UNAPI para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, valorização do imóvel e pleno exercício dos direitos do proprietário.\n  Para: Esses serviços são destinados a toda a população que deseja regularizar um bem imóvel por meio da Ação de Usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário). Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo segurança jurídica e o devido registro, pode buscar esses serviços para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, valorização do imóvel e pleno exercício dos direitos do proprietário.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Gustavo Andrade
cmr4wl9380007m829by03p7s4	2026-07-03 12:22:17.154	gustavo.andrade@sad.pe.gov.br	CREATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	Registro criado.
cmr4wvvmi0008m82953z2634p	2026-07-03 12:30:32.908	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jf5vi000iboam6yi59usu	Pagamento de Tributos e Taxas de Imóveis Estaduais	oQueE:\n  De: Trata-se da responsabilidade e do comprometimento quanto ao pagamento e a regularização dos tributos, taxas, encargos e despesas de consumo incidentes aos imóveis desocupados, assim permanecendo as obrigações até o ato de sua efetiva destinação.\n  Para: Trata-se da responsabilidade e do comprometimento quanto ao pagamento e a regularização dos tributos, taxas, encargos e despesas de consumo incidentes aos imóveis públicos estaduais desocupados, assim permanecendo as obrigações até o ato de sua efetiva destinação.\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Gustavo Andrade
cmr4x1zpe0009m82903i1sp7k	2026-07-03 12:35:18.144	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	resumo:\n  De: A unidade é responsável por analisar solicitações de usucapião requeridas por terceiros para verificar se o imóvel envolvido pertence ao Estado de Pernambuco ou possui interesse público. Seu trabalho garante segurança jurídica e contribui para a proteção e a boa gestão do patrimônio estadual.\n  Para: Análise das solicitações de usucapião realizadas por terceiros para verificar se o imóvel envolvido pertence ao Estado de Pernambuco ou possui interesse público. Esse trabalho garante segurança jurídica e contribui para a proteção e a boa gestão do patrimônio estadual.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr4zy9yl0000f7xntt32wohg	2026-07-03 13:56:23.658	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: true\n  Para: false\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmr4zynsm0001f7xn0fgiwnuq	2026-07-03 13:56:41.588	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: false\n  Para: true\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50cb1a0000vw8zjdoqkmdy	2026-07-03 14:07:18.232	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: true\n  Para: false\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50cic60001vw8zazbavm1f	2026-07-03 14:07:27.697	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: false\n  Para: true\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50cwem0002vw8znsmio4ij	2026-07-03 14:07:45.931	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: true\n  Para: false\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50d3gi0003vw8zu4z4g4sr	2026-07-03 14:07:55.072	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: false\n  Para: true\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50kayg0004vw8z6qx5q1a3	2026-07-03 14:13:31.374	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: true\n  Para: false\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr50kgu20005vw8znbwjoik1	2026-07-03 14:13:38.992	admin@admin.com	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	ativo:\n  De: false\n  Para: true\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmr97vcif0001tspshfecukp6	2026-07-06 12:49:08.626	admin@admin.com	CREATE	Curso	cmr97vchs0000tspscrk7ea18	Teste	Registro criado.
cmrb1a8gd0007tspser3xrswu	2026-07-07 19:20:18.252	viktoria.cruz@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário 	oQueE:\n  De: [sem texto]\n  Para: O Cadastro Imobiliário Estadual reúne, em uma base cadastral única, os documentos e as informações referentes aos imóveis do Estado de Pernambuco, contemplando dados sobre localização, titularidade, ocupação, destinação e avaliação. Todas as ações relacionadas à atualização e ao aperfeiçoamento do cadastro são registradas em um único sistema, garantindo a integridade, a rastreabilidade e a padronização das informações. O serviço tem como finalidade disponibilizar informações cadastrais e documentais aos órgãos e entidades da Administração Pública, bem como à sociedade, promovendo maior transparência, eficiência na gestão do patrimônio imobiliário estadual e apoio à tomada de decisões.\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Viktoria Heyka
cmrb1gtd70008tspso0mu711t	2026-07-07 19:25:25.29	viktoria.cruz@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	titulo:\n  De: Cadastro Imobiliário \n  Para: Cadastro Imobiliário Estadual\n\nslug:\n  De: cadastro-imobiliario\n  Para: cadastro-imobiliarioestadual\n\nresumo:\n  De: O Cadastro Imobiliário é o registro oficial dos imóveis estaduais, reunindo informações sobre localização, titularidade, ocupação, destinação e o histórico documental de cada imóvel.\n  Para: O Cadastro Imobiliário Estadual é o registro oficial dos imóveis estaduais, reunindo informações sobre localização, titularidade, ocupação, destinação e o histórico documental de cada imóvel.\n\nquemPrecisa:\n  De: [sem texto]\n  Para: Este serviço é destinado aos órgãos e entidades da Administração Pública Estadual, aos demais órgãos públicos das esferas federal, estadual e municipal, aos órgãos de controle, ao Poder Judiciário, aos cartórios, bem como aos cidadãos e demais interessados que necessitem de informações sobre os imóveis pertencentes ao Estado de Pernambuco.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrb1ikmh0009tspsghoh9mlh	2026-07-07 19:26:47.272	viktoria.cruz@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrb1psm6000atspsezc6ysgo	2026-07-07 19:32:24.221	viktoria.cruz@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nmaisInformacoes:\n  De: [sem texto]\n  Para: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone: 3183-7731 ou 3183-7739 E-mail:\n\nsubareaId:\n  De: vazio\n  Para: cmq9j1frn0000boamvyqh9qnc\n\nativo:\n  De: false\n  Para: true\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrb1ug9g000btspsn1k2meon	2026-07-07 19:36:01.486	viktoria.cruz@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	maisInformacoes:\n  De: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone: 3183-7731 ou 3183-7739 E-mail:\n  Para: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone: 3183-7731 ou 3183-7739 E-mail:\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrb1vtsb000ctspszyxioipp	2026-07-07 19:37:05.674	viktoria.cruz@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	updatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrc3ww1t000etspsbd09fzab	2026-07-08 13:21:40.671	admin@admin.com	CREATE	Noticia	cmrc3ww16000dtspszf1dls7l	Lorem ipsum dolor sit amet	Registro criado.
cmrc3zlwb000ftspsmtb3nosj	2026-07-08 13:23:47.481	admin@admin.com	UPDATE	Noticia	cmrc3ww16000dtspszf1dls7l	Lorem ipsum dolor sit amet	subtitulo:\n  De: Ea enim galisum sed magni asperiores et error expedita id numquam ducimus sed aliquam similique\n  Para: Ea enim galisum sed magni asperiores et error expedita id numquam
cmrc3zyfb000gtspsxc6a8rrd	2026-07-08 13:24:03.717	admin@admin.com	UPDATE	Noticia	cmrc3ww16000dtspszf1dls7l	Lorem ipsum dolor sit amet	resumo:\n  De: Et provident autem eos quasi iusto et maxime deleniti et provident voluptatum sit officiis autem. Cum voluptatem nobis id asperiores necessitatibus et quia quam ea reprehenderit ipsa! Est odio excepturi vel natus modi ut provident possimus. \n  Para: Et provident autem eos quasi iusto et maxime deleniti et provident voluptatum sit officiis autem. Cum voluptatem 
cmrc49t7k000itsps3xt4btci	2026-07-08 13:31:43.518	admin@admin.com	CREATE	Noticia	cmrc49t6w000htspszb60i67b	Lorem ipsum dolor sit amet. Non dolorem cumque ut quidem harum et distinctio sint	Registro criado.
cmrc4adip000jtspsaf8l0kq3	2026-07-08 13:32:09.837	admin@admin.com	UPDATE	Noticia	cmrc49t6w000htspszb60i67b	Lorem ipsum dolor sit amet. Non dolorem cumque ut quidem harum et distinctio sint	destaque:\n  De: false\n  Para: true
cmrc4b6tq000ktspsmfiqagh5	2026-07-08 13:32:47.818	admin@admin.com	UPDATE	Noticia	cmrc49t6w000htspszb60i67b	Lorem ipsum dolor sit amet. Non dolorem cumque ut quidem harum et distinctio sint	imagemPrincipal_id:\n  De: RxHa2ekvGXaXZGXRvLO5qw\n  Para: qk4Umdtd09286444zRgLMA\n\nimagemPrincipal_filesize:\n  De: 3060425\n  Para: 1956421\n\nimagemPrincipal_width:\n  De: 6000\n  Para: 5371\n\nimagemPrincipal_height:\n  De: 4000\n  Para: 3581
cmrc4lsju000qtspstvx2e19g	2026-07-08 13:41:02.537	admin@admin.com	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	muralTextoIntrodutorio:\n  De: \n  Para: Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos. Aut similique autem a fugit voluptatem et dolorum magni sit nobis molestiae et deleniti quia et quae voluptas.\n\nareaResponsavelId:\n  De: vazio\n  Para: cmq81pn5v0001j9azrqcx4d99
cmrc4nit9000stspsgr6vosno	2026-07-08 13:42:23.227	admin@admin.com	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	Nenhuma alteração detectada.
cmrc4ywp9000ttsps87vi2br1	2026-07-08 13:51:14.442	admin@admin.com	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	muralTextoIntrodutorio:\n  De: Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos. Aut similique autem a fugit voluptatem et dolorum magni sit nobis molestiae et deleniti quia et quae voluptas.\n  Para: Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos.
cmrc4z28k000utsps1r584c4w	2026-07-08 13:51:21.617	admin@admin.com	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	muralTextoIntrodutorio:\n  De: Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos.\n  Para: Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos. Aut similique autem a fugit voluptatem et dolorum magni sit nobis molestiae et deleniti quia et quae voluptas.
cmrunc9bb000cjzjx2hxjoxdd	2026-07-21 12:45:21.574	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	subareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrurcbw60003d883dquc60fr	2026-07-21 14:37:23.38	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrc5hz29000vtsps3nhq44hz	2026-07-08 14:06:03.968	admin@admin.com	UPDATE	Servico	cmq9rxjkk000lg5ahorb2k5lt	Projetos de engenharia	oQueE:\n  De: Trata-se de serviço técnico que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado. São realizados desenhos, cálculos, orçamentos, especificações e documentos técnicos que orientam a construção/reforma. O objetivo central é o planejamento, cálculo e dimensionamento técnico de subsistemas — como elétrico, hidrossanitário, mecânico e de segurança — assegurando que a execução da obra ocorra de forma integrada. Esses projetos são indispensáveis para garantir a estabilidade das instalações, o cumprimento rigoroso das normas de segurança e o desempenho de longo prazo dos sistemas destinados ao patrimônio público.\nExemplos de projetos de engenharia:\nProjeto estrutural;Projeto elétrico;Projeto hidráulico e sanitário;Projeto de drenagem;Projeto de pavimentação;Projeto de fundações.Para colocar em prática as necessidades do demandante, os projetos de engenharia\nenvolvem uma série de etapas, quais sejam:Levantamento das informações;Análise dos projetos de arquitetura existentes;Estudos e cálculos técnicos;Desenvolvimento de desenhos técnicos;Especificações dos materiais que serão empregados;Elaboração da documentação técnica (memoriais descritivos, orçamentos etc.).\n  Para: Trata-se de serviço técnico que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado. São realizados desenhos, cálculos, orçamentos, especificações e documentos técnicos que orientam a construção/reforma. O objetivo central é o planejamento, cálculo e dimensionamento técnico de subsistemas — como elétrico, hidrossanitário, mecânico e de segurança — assegurando que a execução da obra ocorra de forma integrada. Esses projetos são indispensáveis para garantir a estabilidade das instalações, o cumprimento rigoroso das normas de segurança e o desempenho de longo prazo dos sistemas destinados ao patrimônio público. Exemplos de projetos de engenharia: Projeto estrutural;Projeto elétrico; Projeto hidráulico e sanitário; Projeto de drenagem; Projeto de pavimentação; Projeto de fundações. Para colocar em prática as necessidades do demandante, os projetos de engenharia\nenvolvem uma série de etapas, quais sejam: Levantamento das informações; Análise dos projetos de arquitetura existentes; Estudos e cálculos técnicos; Desenvolvimento de desenhos técnicos; Especificações dos materiais que serão empregados; Elaboração da documentação técnica (memoriais descritivos, orçamentos etc.).\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrc5jovx000wtspsv9hg4bks	2026-07-08 14:07:24.089	admin@admin.com	UPDATE	Servico	cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	oQueE:\n  De: Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\nserviços.\nProjeto arquitetônico;Projeto arquitetônico de reforma;Projeto de ambientação;\nPara colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam:\nLevantamento das necessidades;Estudo preliminar;Anteprojeto;Projeto executivo;Projeto de detalhamento.\nÉ realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis.\n  Para: Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\nserviços.\nProjeto arquitetônico; Projeto arquitetônico de reforma; Projeto de ambientação;\nPara colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam: Levantamento das necessidades; Estudo preliminar; Anteprojeto; Projeto executivo; Projeto de detalhamento. É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis.\n\nquemPrecisa:\n  De: Os projetos de arquitetura são importantes sempre que se faz necessária a construção, reforma ou regularização de um imóvel. A título exemplificativo, indica-se abaixo alguns exemplos de quando se solicitar projetos de arquitetura:\nConstrução de imóvel;Reforma de imóvel;Definição e/ou alteração de layout;Regularização de imóvel junto a prefeituras/cartórios.\n  Para: Os projetos de arquitetura são importantes sempre que se faz necessária a construção, reforma ou regularização de um imóvel. A título exemplificativo, indica-se abaixo alguns exemplos de quando se solicitar projetos de arquitetura: Construção de imóvel; Reforma de imóvel; Definição e/ou alteração de layout; Regularização de imóvel junto a prefeituras/cartórios.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmreyx35g0011tsps8922jae7	2026-07-10 13:25:10.323	admin@admin.com	CREATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Registro criado.
cmrj6gnhs0013tspsukl12ro6	2026-07-13 12:07:25.167	admin@admin.com	CREATE	Noticia		GraphQLError	Registro criado.
cmrj6gwpn0015tspsf2gz33cj	2026-07-13 12:07:37.112	admin@admin.com	CREATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Lorem ipsum dolor sit amet.	Registro criado.
cmrj6jz680017tsps6m3j2ttg	2026-07-13 12:10:00.27	admin@admin.com	CREATE	Servico	cmrj6jz5h0016tspsfrh0gcht	Lorem ipsum dolor sit amet	Registro criado.
cmrj73nve0019tspse1hy78tc	2026-07-13 12:25:18.744	admin@admin.com	CREATE	Solucao	cmrj73nup0018tspsa6le4i3e	Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus nemo nam autem quia ut quaerat ipsa qui iure quas qui minima consequatur	Registro criado.
cmrj7406f001atspsiczrqe80	2026-07-13 12:25:34.694	admin@admin.com	UPDATE	Solucao	cmrj73nup0018tspsa6le4i3e	Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus 	titulo:\n  De: Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus nemo nam autem quia ut quaerat ipsa qui iure quas qui minima consequatur\n  Para: Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus \n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmrj7y8sx001ctsps1e4p4zsq	2026-07-13 12:49:05.552	admin@admin.com	CREATE	Legislacao	cmrj7y8sf001btspsmmnk5tjz	Lorem ipsum dolor sit amet.	Registro criado.
cmrj80iep001etspsxkaxzm6j	2026-07-13 12:50:51.312	admin@admin.com	CREATE	Curso	cmrj80ie7001dtspsxai0zmdh	Lorem ipsum dolor sit amet.	Registro criado.
cmrjacvja001ftsps5btbeqn6	2026-07-13 13:56:27.429	admin@admin.com	UPDATE	Solucao	cmqaxqam4000012bq6kh4olp6	Lorem	corpo:\n  De: Lorem\n  Para: veritatis accusamus non dolores accusantium sit internos obcaecati vel dolore alias sed rerum dolorem et porro Quis et earum tempora. Ut galisum eius At vitae omnis et quia officia?\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Administrador
cmrjadfin001gtspsrmp4x3fh	2026-07-13 13:56:53.325	admin@admin.com	UPDATE	Solucao	cmqaxqam4000012bq6kh4olp6	Lorem	resumo:\n  De: Lorem\n  Para: Sed quas nesciunt qui dolore modi eum quisquam minima sed repellat veritatis ut neque iste ut quae galisum. Et Quis quidem et unde blanditiis et repellendus reprehenderit et eveniet repudiandae. Qui sint omnis cum sunt nobis in nobis voluptatem.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrjb5wet001jtspsj33p11pk	2026-07-13 14:19:01.586	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrkm3wxi0002pejhiim3szjr	2026-07-14 12:13:10.901	admin@admin.com	UPDATE	Servico	cmq9jlsab000pboamrkpkptas	Vistorias nos Imóveis Públicos	imagem_id:\n  De: iEsc35rmmFE7ALYDZNqVYw\n  Para: gDbP6OezPGbiNymMJdQMNA\n\nimagem_filesize:\n  De: 8017\n  Para: 1815626\n\nimagem_width:\n  De: 250\n  Para: 3550\n\nimagem_height:\n  De: 200\n  Para: 4437\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrkm4lly0003pejh03sqc4hb	2026-07-14 12:13:42.885	admin@admin.com	UPDATE	Servico	cmq9jlsab000pboamrkpkptas	Vistorias nos Imóveis Públicos	imagem_id:\n  De: gDbP6OezPGbiNymMJdQMNA\n  Para: Nij0r3XpP3Y9odlFFENZhA\n\nimagem_filesize:\n  De: 1815626\n  Para: 6662124\n\nimagem_width:\n  De: 3550\n  Para: 5760\n\nimagem_height:\n  De: 4437\n  Para: 3840\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrkm6br40004pejhbxuaqcrx	2026-07-14 12:15:03.423	admin@admin.com	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	imagem_id:\n  De: 4QfsCzMSX4iNuUfoJieTXg\n  Para: kxEDEUxgwk9LDZ3bSuPyAQ\n\nimagem_filesize:\n  De: 1397165\n  Para: 1129174\n\nimagem_width:\n  De: 5472\n  Para: 4592\n\nimagem_height:\n  De: 3648\n  Para: 3448\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Gustavo Andrade\n  Para: Administrador
cmrkmjptx0005pejhw5gfd6yq	2026-07-14 12:25:28.195	allan.soares.sad@gmail.com	UPDATE	PaginaQuemSomos	1	Sem título	tituloDaPagina:\n  De:   \n  Para:   Quem somos
cmrm3329k0001lzrgn8q7sv7v	2026-07-15 12:56:10.806	diego.rolim@sad.pe.gov.br	CREATE	Gerencia	cmrm332920000lzrgv70hhm77	Sem título	Registro criado.
cmrm362wq0003lzrgggh5nfwj	2026-07-15 12:58:31.608	diego.rolim@sad.pe.gov.br	CREATE	Gerencia	cmrm362wc0002lzrg75hfrqke	Sem título	Registro criado.
cmrm37v5d0001130s59g3mflv	2026-07-15 12:59:54.864	diego.rolim@sad.pe.gov.br	CREATE	Gerencia	cmrm37v580000130sh22riots	Sem título	Registro criado.
cmrm38ez80003130sy1q0qb8p	2026-07-15 13:00:20.562	diego.rolim@sad.pe.gov.br	CREATE	Gerencia	cmrm38eyv0002130s1gsw2w8d	Sem título	Registro criado.
cmrm39vdv0005130sqzl91cpw	2026-07-15 13:01:28.481	diego.rolim@sad.pe.gov.br	CREATE	Gerencia	cmrm39vdh0004130sa166hfjo	Sem título	Registro criado.
cmrm3bbma0007130sfbsdvk8i	2026-07-15 13:02:36.177	diego.rolim@sad.pe.gov.br	CREATE	Gerencia	cmrm3bblx0006130slfi67gwu	Sem título	Registro criado.
cmrm3k9xl0008130s41n93zcy	2026-07-15 13:09:33.893	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrup7a3h0003vrbskwlcw5eu	2026-07-21 13:37:28.54	clovis.melo@sad.pe.gov.br	CREATE	PaginaQuemSomos	cmrup7a3e0002vrbsd0kesdxn	Sem título	Registro criado.
cmrm47e7700007ondjk3sj2by	2026-07-15 13:27:32.512	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	muralTextoIntrodutorio:\n  De: Lorem ipsum dolor sit amet. Id consequatur tempore ea delectus doloremque ea sint saepe qui excepturi ratione et nihil\n  Para: A Gerência Geral de Serviços Corporativos (GGCOR) é a unidade da Secretaria de Administração de Pernambuco (SAD) responsável por planejar, coordenar e executar políticas e ações voltadas à gestão dos serviços corporativos compartilhados da Administração Pública Estadual. Sua atuação busca promover eficiência, inovação, sustentabilidade e economicidade na prestação dos serviços, contribuindo para o fortalecimento da gestão pública e para a melhoria contínua dos processos administrativos.\n\nA estrutura da GGCOR é composta pela Gerência de Frota Corporativa, responsável pela gestão da frota oficial do Estado; pela Superintendência de Energias Renováveis, que desenvolve ações voltadas à eficiência energética e à expansão de fontes renováveis na Administração Pública; pela Gerência de Contratos Corporativos, responsável pela gestão e fiscalização dos contratos corporativos compartilhados; e pela Gerência de Telemática, que coordena as soluções de telecomunicações, conectividade e serviços de tecnologia corporativos.\n\nAtuando de forma integrada, essas unidades desenvolvem soluções estratégicas que promovem a racionalização dos recursos públicos, a padronização dos serviços corporativos e o fortalecimento da governança administrativa, assegurando maior qualidade, transparência e inovação no atendimento aos órgãos e entidades do Governo do Estado de Pernambuco.
cmrm5edmj0000qomxd9xlo2dy	2026-07-15 14:00:57.973	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	muralTextoIntrodutorio:\n  De: A Gerência Geral de Serviços Corporativos (GGCOR) é a unidade da Secretaria de Administração de Pernambuco (SAD) responsável por planejar, coordenar e executar políticas e ações voltadas à gestão dos serviços corporativos compartilhados da Administração Pública Estadual. Sua atuação busca promover eficiência, inovação, sustentabilidade e economicidade na prestação dos serviços, contribuindo para o fortalecimento da gestão pública e para a melhoria contínua dos processos administrativos.\n\nA estrutura da GGCOR é composta pela Gerência de Frota Corporativa, responsável pela gestão da frota oficial do Estado; pela Superintendência de Energias Renováveis, que desenvolve ações voltadas à eficiência energética e à expansão de fontes renováveis na Administração Pública; pela Gerência de Contratos Corporativos, responsável pela gestão e fiscalização dos contratos corporativos compartilhados; e pela Gerência de Telemática, que coordena as soluções de telecomunicações, conectividade e serviços de tecnologia corporativos.\n\nAtuando de forma integrada, essas unidades desenvolvem soluções estratégicas que promovem a racionalização dos recursos públicos, a padronização dos serviços corporativos e o fortalecimento da governança administrativa, assegurando maior qualidade, transparência e inovação no atendimento aos órgãos e entidades do Governo do Estado de Pernambuco.\n  Para: A Gerência Geral de Serviços Corporativos (GGCOR) é responsável pela gestão dos serviços corporativos compartilhados da Secretaria de Administração de Pernambuco, promovendo eficiência, inovação e sustentabilidade na Administração Pública Estadual. Sua estrutura é composta pela Gerência de Frota Corporativa, Superintendência de Energias Renováveis, Gerência de Contratos Corporativos e Gerência de Telemática, que atuam de forma integrada para oferecer soluções estratégicas, otimizar recursos e aprimorar a prestação dos serviços aos órgãos e entidades do Estado.
cmrp8xdou001ccbhtic0ddbtr	2026-07-17 18:03:01.898	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrp9ido7001tcbhtqpi0qmhf	2026-07-17 18:19:21.654	diego.rolim@sad.pe.gov.br	UPDATE	Subarea	cmq9sphie000sg5ah1lnqkut5	Sem título	nome:\n  De: Frota\n  Para: Gerência de Frota
cmrp9z3jy001xcbhtmn9fqfc0	2026-07-17 18:32:21.693	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmrp9z3je001wcbhtkv3fcdhf	Gerência de Contratos	Registro criado.
cmrpa0ysz0021cbhtv5i63m2k	2026-07-17 18:33:48.85	diego.rolim@sad.pe.gov.br	CREATE	Subarea	cmrpa0ysw0020cbhtq74afxfc	Sem título	Registro criado.
cmrthawpz000amdi1vne2bej8	2026-07-20 17:08:34.72	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmrthawpo0009mdi1h75pkedj	Superintendência de Energias Renováveis e Água	Registro criado.
cmrthj8yd000cmdi1juquthl7	2026-07-20 17:15:03.828	diego.rolim@sad.pe.gov.br	CREATE	Servico		GraphQLError	Registro criado.
cmrthph78000emdi1cmplvsxk	2026-07-20 17:19:54.451	diego.rolim@sad.pe.gov.br	CREATE	Subarea	cmrthph6z000dmdi1k1uh7lqg	Sem título	Registro criado.
cmrthpoqj000gmdi1l86zh96o	2026-07-20 17:20:04.219	diego.rolim@sad.pe.gov.br	CREATE	Servico		GraphQLError	Registro criado.
cmrthqlfu000imdi1ioyaqqo7	2026-07-20 17:20:46.601	diego.rolim@sad.pe.gov.br	CREATE	Servico		GraphQLError	Registro criado.
cmrthqoic000kmdi1p84u4oh8	2026-07-20 17:20:50.579	diego.rolim@sad.pe.gov.br	CREATE	Servico		GraphQLError	Registro criado.
cmrthr374000mmdi1lgif2nrp	2026-07-20 17:21:09.614	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmrthr36k000lmdi13kumqjbi	Superintendência de Energias Renováveis e Água	Registro criado.
cmrtm8qbe000nmdi1vctwhwhq	2026-07-20 19:26:51.194	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrthr36k000lmdi13kumqjbi	Superintendência de Energias Renováveis e Água	subareaId:\n  De: cmrthph6z000dmdi1k1uh7lqg\n  Para: cmq9sphie000sg5ah1lnqkut5
cmrtn2i8u0001bqr521mev2ju	2026-07-20 19:50:00.41	admin@admin.com	CREATE	Subarea	cmrtn2i7v0000bqr5csm0w82l	Sem título	Registro criado.
cmrtn35yq0003bqr5v980uy29	2026-07-20 19:50:31.152	admin@admin.com	CREATE	Subarea	cmrtn35yi0002bqr5ck780vyc	Sem título	Registro criado.
cmrtn3ddq0005bqr5lcgbaahj	2026-07-20 19:50:40.764	admin@admin.com	CREATE	Subarea	cmrtn3ddb0004bqr56kh31dp0	Sem título	Registro criado.
cmrtn3l250007bqr5ntzxhpbl	2026-07-20 19:50:50.716	admin@admin.com	CREATE	Subarea	cmrtn3l1x0006bqr58awnhiel	Sem título	Registro criado.
cmrtn4mld0009bqr5qjxlj2aa	2026-07-20 19:51:39.36	admin@admin.com	CREATE	Servico	cmrtn4ml40008bqr5h7zwgayy	teste	Registro criado.
cmrulu7td0001jzjxpm5covwm	2026-07-21 12:03:20.206	admin@admin.com	DELETE	Subarea	cmrthph6z000dmdi1k1uh7lqg	Sem título	Registro excluído.
cmrulu7td0000jzjx2sh32bm6	2026-07-21 12:03:20.208	admin@admin.com	DELETE	Subarea	cmrpa0ysw0020cbhtq74afxfc	Sem título	Registro excluído.
cmrulu7tj0002jzjxk8ii6b3h	2026-07-21 12:03:20.214	admin@admin.com	DELETE	Subarea	cmq9sphie000sg5ah1lnqkut5	Sem título	Registro excluído.
cmrumf5n00005jzjxunpf72y8	2026-07-21 12:19:37.161	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	muralTextoIntrodutorio:\n  De: Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos. Aut similique autem a fugit voluptatem et dolorum magni sit nobis molestiae et deleniti quia et quae voluptas.\n  Para: Para subir o prédio, e para mantê-lo em pé, a quem irão procurar? Podem contar conosco! Nós somos a área técnica de Engenharia e Arquitetura do Estado. Se é um imóvel do Estado, e já não há quem olhe por ele, nós iremos olhar. Iremos olhar cada canto e detalhe. O layout, a divisória, a mesa e seu lugar; a parede, a alvenaria, o teto e a janela; e mesmo o terreno e o preço do aluguel. Nosso trabalho é criar e cuidar.
cmrumgndd0006jzjxdj97ori8	2026-07-21 12:20:46.798	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	muralTextoIntrodutorio:\n  De: Lorem\n  Para: Desde a maca do hospital à viatura policial. Da escola ao palácio do governo.\nTudo isso faz parte do patrimônio do Estado. E para dar conta de tudo é preciso uma equipe técnica capacitada e uma gestão eficiente. \nUma boa administração patrimonial leva a melhores políticas públicas e a um Estado mais próximo do cidadão. Esse é nosso propósito. 
cmrun1z7t0009jzjx0z10afcf	2026-07-21 12:37:21.928	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrup6xuu0001vrbs8jssy61p	2026-07-21 13:37:12.677	clovis.melo@sad.pe.gov.br	CREATE	PaginaQuemSomos	cmrup6xub0000vrbs5m2rw1sl	Sem título	Registro criado.
cmrurjzfn0008d883k77hkp0h	2026-07-21 14:43:20.483	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmrurlh4h000ad8838t05ysi4	2026-07-21 14:44:30.064	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmruryflo000ed883a46ybiin	2026-07-21 14:54:34.618	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	1	Sem título	Nenhuma alteração detectada.
cmrusjxl0000gd883qim37r2z	2026-07-21 15:11:17.698	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	muralTextoIntrodutorio:\n  De: A Gerência Geral de Serviços Corporativos (GGCOR) é responsável pela gestão dos serviços corporativos compartilhados da Secretaria de Administração de Pernambuco, promovendo eficiência, inovação e sustentabilidade na Administração Pública Estadual. Sua estrutura é composta pela Gerência de Frota Corporativa, Superintendência de Energias Renováveis, Gerência de Contratos Corporativos e Gerência de Telemática, que atuam de forma integrada para oferecer soluções estratégicas, otimizar recursos e aprimorar a prestação dos serviços aos órgãos e entidades do Estado.\n  Para: A área de Serviços Corporativos da Secretaria de Administração do Estado de Pernambuco é responsável por planejar, coordenar e aprimorar serviços compartilhados que dão suporte ao funcionamento da Administração Pública Estadual, promovendo eficiência operacional, padronização de processos e otimização dos recursos públicos.\n\nNossa atuação busca oferecer soluções integradas que atendam às necessidades dos órgãos e entidades estaduais, contribuindo para uma gestão mais moderna, transparente e orientada por resultados. Por meio da implementação de políticas, normas e ferramentas de gestão, fortalecemos a prestação de serviços corporativos essenciais ao desempenho das atividades governamentais.
cmrusk0mf000hd8833wk27oxx	2026-07-21 15:11:21.638	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	tituloDaPagina:\n  De: Quem Somos\n  Para: Sobre
cmrusnbo5000md883p08fq7hy	2026-07-21 15:13:55.923	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrusnvka000nd88318w5ctoa	2026-07-21 15:14:21.705	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	timeTitulo:\n  De: Nossa Gerência\n  Para: Time 
cmrusojop000od883dac99u36	2026-07-21 15:14:52.969	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	timeTitulo:\n  De: Time \n  Para: Nosso time 
cmrusru9f000sd883hnxu1ybk	2026-07-21 15:17:26.641	admin@admin.com	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrustkcv000td883aelsdaft	2026-07-21 15:18:47.116	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrj6jz5h0016tspsfrh0gcht	Lorem ipsum dolor sit amet	subareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrusttj6000ud883y174jqca	2026-07-21 15:18:59.007	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrthr36k000lmdi13kumqjbi	Superintendência de Energias Renováveis e Água	subareaId:\n  De: vazio\n  Para: cmrtn35yi0002bqr5ck780vyc
cmrusu1v7000vd883yhq2v9xh	2026-07-21 15:19:09.808	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmq9sorix000qg5ahfulm0bn6	Lorem ipsum	subareaId:\n  De: vazio\n  Para: cmrtn3l1x0006bqr58awnhiel
cmrusui1b000wd883m1k5ni2d	2026-07-21 15:19:30.766	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmqaxqam4000012bq6kh4olp6	Lorem	subareaId:\n  De: vazio\n  Para: cmrtn35yi0002bqr5ck780vyc
cmrusum8w000xd883xidcrsjr	2026-07-21 15:19:36.224	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmrj73nup0018tspsa6le4i3e	Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus 	subareaId:\n  De: vazio\n  Para: cmrtn3ddb0004bqr56kh31dp0
cmrusv01c000yd883zz70e4lp	2026-07-21 15:19:54.094	clovis.melo@sad.pe.gov.br	UPDATE	Legislacao	cmrj7y8sf001btspsmmnk5tjz	Lorem ipsum dolor sit amet.	subareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: user teste
cmruv8v070011d883n1z159ca	2026-07-21 16:26:39.989	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmruv8uzh0010d88344dlrlbp	Dispositivo à respeito da utilização de veículos oficiais.\t	Registro criado.
cmruv9r810012d883x618x4l7	2026-07-21 16:27:21.744	diego.rolim@sad.pe.gov.br	DELETE	Legislacao	cmrj7y8sf001btspsmmnk5tjz	Lorem ipsum dolor sit amet.	Registro excluído.
cmruwigbg0017d88377z7q7mk	2026-07-21 17:02:07.131	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmruwigb10016d883cbvirylw	Gestão e racionalização do consumo de água	Registro criado.
cmruwliey0019d883fxh490bp	2026-07-21 17:04:29.816	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmruwliek0018d8835m2ky4wi	Gestão e uso eficiente de energia elétrica	Registro criado.
cmrux3afs001bd883kmuc84ys	2026-07-21 17:18:19.287	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrux3w1z001cd883f3183cpq	2026-07-21 17:18:47.302	clovis.melo@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmruxobsu001fd883am6zf0mf	2026-07-21 17:34:40.827	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmq9sorix000qg5ahfulm0bn6	Contratos Corporativos	titulo:\n  De: Lorem ipsum\n  Para: Contratos Corporativos\n\nresumo:\n  De: Lorem ipsum dolor sit amet. Ut numquam alias aut aspernatur fuga qui quod sint. Et omnis officia est quam enim ad corrupti rerum hic aliquid omnis!\n\nUt minus ullam ut dignissimos incidunt 33 quaerat molestiae aut iusto excepturi rem incidunt maiores vel alias harum et velit expedita. \n  Para: A Gerência de Contratos Corporativos administra contratos compartilhados da Secretaria de Administração, promovendo economia de escala, padronização das contratações e maior eficiência na prestação dos serviços aos órgãos e entidades do Poder Executivo Estadual.\n\noQueE:\n  De: Lorem Lorem ipsum dolor sit amet. Ut numquam alias aut aspernatur fuga qui quod sint. Et omnis officia est quam enim ad corrupti rerum hic aliquid omnis! Ut minus ullam ut dignissimos incidunt 33 quaerat molestiae aut iusto excepturi rem incidunt maiores vel alias harum et velit expedita. Quo architecto pariatur eum tenetur consequatur id alias quis aut sequi optio cum facilis dignissimos. Eum asperiores ratione sed sint quia et soluta iure quo dicta similique ut sint quia. Et necessitatibus porro ut quisquam sunt non sint dolorem id animi dolorem et voluptas beatae qui rerum sunt qui totam dolore. Sed natus rerum aut fuga mollitia et accusantium dolorem qui distinctio velit est odit nemo. Id corporis magnam et recusandae ipsam ut quia amet qui labore perferendis sed voluptatem quasi et nulla omnis ea accusamus libero.\n  Para: [sem texto]\n\nquemPrecisa:\n  De: Lorem ipsum dolor sit amet. Ut numquam alias aut aspernatur fuga qui quod sint. Et omnis officia est quam enim ad corrupti rerum hic aliquid omnis! Ut minus ullam ut dignissimos incidunt 33 quaerat molestiae aut iusto excepturi rem incidunt maiores vel alias harum et velit expedita. Quo architecto pariatur eum tenetur consequatur id alias quis aut sequi optio cum facilis dignissimos. Eum asperiores ratione sed sint quia et soluta iure quo dicta similique ut sint quia. Et necessitatibus porro ut quisquam sunt non sint dolorem id animi dolorem et voluptas beatae qui rerum sunt qui totam dolore. Sed natus rerum aut fuga mollitia et accusantium dolorem qui distinctio velit est odit nemo. Id corporis magnam et recusandae ipsam ut quia amet qui labore perferendis sed voluptatem quasi et nulla omnis ea accusamus libero.\n  Para: [sem texto]\n\ncomoSolicitar:\n  De: Lorem ipsum dolor sit amet. Ut numquam alias aut aspernatur fuga qui quod sint. Et omnis officia est quam enim ad corrupti rerum hic aliquid omnis! Ut minus ullam ut dignissimos incidunt 33 quaerat molestiae aut iusto excepturi rem incidunt maiores vel alias harum et velit expedita. Quo architecto pariatur eum tenetur consequatur id alias quis aut sequi optio cum facilis dignissimos. Eum asperiores ratione sed sint quia et soluta iure quo dicta similique ut sint quia. Et necessitatibus porro ut quisquam sunt non sint dolorem id animi dolorem et voluptas beatae qui rerum sunt qui totam dolore. Sed natus rerum aut fuga mollitia et accusantium dolorem qui distinctio velit est odit nemo. Id corporis magnam et recusandae ipsam ut quia amet qui labore perferendis sed voluptatem quasi et nulla omnis ea accusamus libero.\n  Para: [sem texto]
cmrwc2suc000114id86t7edjj	2026-07-22 17:05:36.897	clovis.melo@sad.pe.gov.br	CREATE	Servico	cmrwc2st5000014idm9scvg1s	1 of 3 errors Next.js (14.2.33) is outdated (learn more)  Unhandled Runtime Error Error: Cannot resolve a Slate point from DOM point: [object Text],21  Call Stack Object.toSlatePoint ..\\node_modules\\slate-dom\\dist\\index.es.js (907:1) Object.toSlateRange ..\\node_modules\\slate-dom\\dist\\index.es.js (1019:1) HTMLDivElement.eval ..\\node_modules\\slate-react\\dist\\index.es.js (1811:1)	Registro criado.
cmrwclznv0000d6rnsfi5twae	2026-07-22 17:20:32.201	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	1 of 3 errors Next.js (14.2.33) is outdated (learn more)  Unhandled Runtime Error Error: Cannot resolve a Slate point from DOM point: [object Text],21  Call Stack Object.toSlatePoint ..\\node_modules\\slate-dom\\dist\\index.es.js (907:1) Object.toSlateRange ..\\node_modules\\slate-dom\\dist\\index.es.js (1019:1) HTMLDivElement.eval ..\\node_modules\\slate-react\\dist\\index.es.js (1811:1)	quemPrecisa:\n  De: [sem texto]\n  Para: [sem texto]
cmrwezn9z000bhtwt86z3nquo	2026-07-22 18:27:08.564	admin@admin.com	DELETE	Servico	cmrwet4370005htwtktvcy907	teste	Registro excluído.
cmrwd3hx10001ezmcv1ps8njy	2026-07-22 17:34:09.012	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	1 of 3 errors Next.js (14.2.33) is outdated (learn more)  Unhandled Runtime Error Error: Cannot resolve a Slate point from DOM point: [object Text],21  Call Stack Object.toSlatePoint ..\\node_modules\\slate-dom\\dist\\index.es.js (907:1) Object.toSlateRange ..\\node_modules\\slate-dom\\dist\\index.es.js (1019:1) HTMLDivElement.eval ..\\node_modules\\slate-react\\dist\\index.es.js (1811:1)	quemPrecisa:\n  De: [sem texto]\n  Para: asd
cmrwd92jo0003ezmcqn45lkbn	2026-07-22 17:38:29.025	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	Observações	titulo:\n  De: 1 of 3 errors Next.js (14.2.33) is outdated (learn more)  Unhandled Runtime Error Error: Cannot resolve a Slate point from DOM point: [object Text],21  Call Stack Object.toSlatePoint ..\\node_modules\\slate-dom\\dist\\index.es.js (907:1) Object.toSlateRange ..\\node_modules\\slate-dom\\dist\\index.es.js (1019:1) HTMLDivElement.eval ..\\node_modules\\slate-react\\dist\\index.es.js (1811:1)\n  Para: Observações\n\noQueE:\n  De: [sem texto]\n  Para: StartFragment asdasdObservaçõesdsaasdasdasd EndFragment\n\nquemPrecisa:\n  De: asd\n  Para: asd StartFragment Observações EndFragment\n\ncomoSolicitar:\n  De: [sem texto]\n  Para: StartFragment Observações EndFragment\n\nmaisInformacoes:\n  De: [sem texto]\n  Para: StartFragment Observações EndFragment
cmrwd9o210004ezmceejdopva	2026-07-22 17:38:56.904	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	Observações	quemPrecisa:\n  De: asd StartFragment Observações EndFragment\n  Para: Observações EndFragment EndFragment\n\ncomoSolicitar:\n  De: StartFragment Observações EndFragment\n  Para: Observações EndFragment
cmrwdcye00005ezmcq1mzjl2o	2026-07-22 17:41:30.261	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	Observações	oQueE:\n  De: StartFragment asdasdObservaçõesdsaasdasdasd EndFragment\n  Para: StartFragment Observações EndFragment EndFragment\n\nquemPrecisa:\n  De: Observações EndFragment EndFragment\n  Para: StartFragment Observações EndFragment\n\ncomoSolicitar:\n  De: Observações EndFragment\n  Para: StartFragment Observações EndFragment\n\nmaisInformacoes:\n  De: StartFragment Observações EndFragment\n  Para: StartFragment Observações EndFragment
cmrwdg9a30006ezmcprkbcf2z	2026-07-22 17:44:04.345	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	Observações	oQueE:\n  De: StartFragment Observações EndFragment EndFragment\n  Para: StartFragmentStartFragment Observações EndFragment EndFragment EndFragment\n\nquemPrecisa:\n  De: StartFragment Observações EndFragment\n  Para: StartFragment Observações EndFragment\n\ncomoSolicitar:\n  De: StartFragment Observações EndFragment\n  Para: StartFragment Observações EndFragment\n\nmaisInformacoes:\n  De: StartFragment Observações EndFragment\n  Para: StartFragment Observações StartFragment Observações asdasdasda EndFragment EndFragment
cmrwdgs3p0007ezmcnd5ph98e	2026-07-22 17:44:28.739	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwc2st5000014idm9scvg1s	Observações	oQueE:\n  De: StartFragmentStartFragment Observações EndFragment EndFragment EndFragment\n  Para: Observações EndFragment EndFragment EndFragment
cmrwdhyek0009ezmc2dk57xip	2026-07-22 17:45:23.562	clovis.melo@sad.pe.gov.br	CREATE	Servico	cmrwdhye60008ezmcq1cizyiu	teste2	Registro criado.
cmrwdmdw9000bezmcmj8rzoaw	2026-07-22 17:48:50.264	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrwdhye60008ezmcq1cizyiu	teste2	quemPrecisa:\n  De: StartFragment Observações EndFragment\n  Para: StartFragment Observaçõessd EndFragment
cmrwdo9ks000cezmc5ry94ub7	2026-07-22 17:50:17.979	admin@admin.com	DELETE	Servico	cmrwdhye60008ezmcq1cizyiu	teste2	Registro excluído.
cmrwdo9ks000dezmcx1wz5fq4	2026-07-22 17:50:17.979	admin@admin.com	DELETE	Servico	cmrtn4ml40008bqr5h7zwgayy	teste	Registro excluído.
cmrwdp8fz000fezmcuggwjnkr	2026-07-22 17:51:03.165	admin@admin.com	CREATE	Servico	cmrwdp8fu000eezmcgstyujfy	Observações	Registro criado.
cmrwdpdok000gezmcj46cstx5	2026-07-22 17:51:09.954	admin@admin.com	UPDATE	Servico	cmrwdp8fu000eezmcgstyujfy	Observações	areaResponsavelId:\n  De: vazio\n  Para: cmq81pvoq0003j9azcu4vg0ws\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrwdpvmq000iezmcgqtgrw7g	2026-07-22 17:51:33.216	admin@admin.com	DELETE	Servico	cmrwc2st5000014idm9scvg1s	Observações	Registro excluído.
cmrwdpvmr000jezmcnscj0rhl	2026-07-22 17:51:33.218	admin@admin.com	DELETE	Servico	cmrwdp8fu000eezmcgstyujfy	Observações	Registro excluído.
cmrwdq2nr000lezmch17kdkb0	2026-07-22 17:51:42.326	admin@admin.com	CREATE	Servico	cmrwdq2nm000kezmco8i3ybpr	Observações	Registro criado.
cmrwdrpl4000mezmcyjxgt1u2	2026-07-22 17:52:58.695	admin@admin.com	UPDATE	Servico	cmrwdq2nm000kezmco8i3ybpr	Observações	oQueE:\n  De: StartFragment Observações EndFragment\n  Para: [sem texto]
cmrwds4rn000nezmc9fbd2ym0	2026-07-22 17:53:18.37	admin@admin.com	UPDATE	Servico	cmrwdq2nm000kezmco8i3ybpr	Observações	oQueE:\n  De: [sem texto]\n  Para: StartFragment funciona EndFragment
cmrwe0g1p000124rvy78n1fd4	2026-07-22 17:59:46.234	admin@admin.com	CREATE	Servico	cmrwe0g1d000024rv260cr7yl	teste2	Registro criado.
cmrwe0nu4000224rvkw6ockhx	2026-07-22 17:59:56.33	admin@admin.com	UPDATE	Servico	cmrwe0g1d000024rv260cr7yl	teste2	areaResponsavelId:\n  De: vazio\n  Para: cmq81pvoq0003j9azcu4vg0ws\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrwe335c000424rvpxoibd6q	2026-07-22 18:01:49.487	admin@admin.com	UPDATE	Servico	cmrwdq2nm000kezmco8i3ybpr	Observações	oQueE:\n  De: StartFragment funciona EndFragment\n  Para: StartFragment Reinicie EndFragment EndFragment
cmrwe3m23000624rvvzh6gnt4	2026-07-22 18:02:13.992	admin@admin.com	DELETE	Servico	cmrwdq2nm000kezmco8i3ybpr	Observações	Registro excluído.
cmrwe3tuh000724rve6irlgja	2026-07-22 18:02:24.088	admin@admin.com	UPDATE	Servico	cmrwe0g1d000024rv260cr7yl	teste2	oQueE:\n  De: StartFragment  Atualizara EndFragment\n  Para: StartFragment Reinicie EndFragment
cmrweipkv0003htwtkxbfdf8p	2026-07-22 18:13:58.397	admin@admin.com	UPDATE	Servico	cmrwe0g1d000024rv260cr7yl	teste2	oQueE:\n  De: StartFragment Reinicie EndFragment\n  Para: EndFragment EndFragment StartFragment O que mudou: EndFragment\n\nquemPrecisa:\n  De: [sem texto]\n  Para: EndFragment
cmrwesshh0004htwt6esl9ct0	2026-07-22 18:21:48.723	admin@admin.com	DELETE	Servico	cmrwe0g1d000024rv260cr7yl	teste2	Registro excluído.
cmrwet43j0006htwtij4uyru9	2026-07-22 18:22:03.773	admin@admin.com	CREATE	Servico	cmrwet4370005htwtktvcy907	teste	Registro criado.
cmrwethwe0008htwtwnrij95l	2026-07-22 18:22:21.66	admin@admin.com	UPDATE	Servico	cmrwet4370005htwtktvcy907	teste	oQueE:\n  De: [sem texto]\n  Para: StartFragment asdComo testarasd EndFragment
cmrwetxx60009htwti3oo020u	2026-07-22 18:22:42.424	admin@admin.com	UPDATE	Servico	cmrwet4370005htwtktvcy907	teste	oQueE:\n  De: StartFragment asdComo testarasd EndFragment\n  Para: StartFragment StartFragment StartFragment StartFragment Como testar EndFragment EndFragment EndFragment EndFragment
cmrwexgkp000ahtwtooap96k6	2026-07-22 18:25:26.568	admin@admin.com	UPDATE	Servico	cmrwet4370005htwtktvcy907	teste	oQueE:\n  De: StartFragment StartFragment StartFragment StartFragment Como testar EndFragment EndFragment EndFragment EndFragment\n  Para: StartFragment StartFragment StartFragment StartFragment Como testarsa EndFragment EndFragment EndFragment EndFragment
cmrwf0lxd000dhtwthkyj7oim	2026-07-22 18:27:53.471	admin@admin.com	CREATE	Servico	cmrwf0lx7000chtwt9hkj5p7b	teste	Registro criado.
cmrwf0w3n000ehtwt46erth24	2026-07-22 18:28:06.658	admin@admin.com	UPDATE	Servico	cmrwf0lx7000chtwt9hkj5p7b	teste	areaResponsavelId:\n  De: vazio\n  Para: cmq81pvoq0003j9azcu4vg0ws\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrwf3swb000ghtwtyfts6g48	2026-07-22 18:30:22.472	admin@admin.com	UPDATE	Servico	cmrwf0lx7000chtwt9hkj5p7b	teste	quemPrecisa:\n  De: StartFragment melhor solução EndFragment\n  Para: StartFragment EndFragment
cmrwf5txe000khtwtbmctwdxr	2026-07-22 18:31:57.12	admin@admin.com	UPDATE	Servico	cmrwf5q8h000ihtwt2fgere6x	teste	areaResponsavelId:\n  De: vazio\n  Para: cmq81pvoq0003j9azcu4vg0ws\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrwf5i6k000hhtwtihbko4d3	2026-07-22 18:31:41.897	admin@admin.com	DELETE	Servico	cmrwf0lx7000chtwt9hkj5p7b	teste	Registro excluído.
cmrwf5q8r000jhtwt5y9919n8	2026-07-22 18:31:52.345	admin@admin.com	CREATE	Servico	cmrwf5q8h000ihtwt2fgere6x	teste	Registro criado.
cmrwf67nr000mhtwt5gqysd3b	2026-07-22 18:32:14.918	admin@admin.com	UPDATE	Servico	cmrwf5q8h000ihtwt2fgere6x	teste	quemPrecisa:\n  De: [sem texto]\n  Para: StartFragment Conclusão EndFragment
cmrwfcjgu00008lawmxpv7n5q	2026-07-22 18:37:10.155	admin@admin.com	DELETE	Servico	cmrwf5q8h000ihtwt2fgere6x	teste	Registro excluído.
cmrwfd3in00028lawnz7n4mu1	2026-07-22 18:37:36.142	admin@admin.com	CREATE	Servico	cmrwfd3ia00018lawy5v9wcp3	teste	Registro criado.
cmrwfdb9g00038lawvy01c1yd	2026-07-22 18:37:46.179	admin@admin.com	UPDATE	Servico	cmrwfd3ia00018lawy5v9wcp3	teste	areaResponsavelId:\n  De: vazio\n  Para: cmq81pvoq0003j9azcu4vg0ws\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrwg298s0002x42i1fap0fp7	2026-07-22 18:57:09.96	admin@admin.com	DELETE	Servico	cmrwfd3ia00018lawy5v9wcp3	teste	Registro excluído.
cmrwg6u4400016qu3anlwcwjh	2026-07-22 19:00:43.635	admin@admin.com	CREATE	Servico	cmrwg6u3t00006qu340c3tp39	testeeee	Registro criado.
cmrwg74w200026qu3r9r16izl	2026-07-22 19:00:57.601	admin@admin.com	UPDATE	Servico	cmrwg6u3t00006qu340c3tp39	testeeee	areaResponsavelId:\n  De: vazio\n  Para: cmq81pvoq0003j9azcu4vg0ws\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l
cmrwg7onx00046qu3x297f8hk	2026-07-22 19:01:23.228	admin@admin.com	DELETE	Servico	cmrwg6u3t00006qu340c3tp39	testeeee	Registro excluído.
cmrwgke5k0001thblhyg6g53u	2026-07-22 19:11:16.134	clovis.melo@sad.pe.gov.br	CREATE	Servico	cmrwgke530000thbl54rf0h2c	Copie e cole	Registro criado.
cmrwgki640002thbl3navqc28	2026-07-22 19:11:21.339	clovis.melo@sad.pe.gov.br	DELETE	Servico	cmrwgke530000thbl54rf0h2c	Copie e cole	Registro excluído.
cmrxn0grr0003a05rhtft6h4h	2026-07-23 14:59:29.891	gustavo.andrade@sad.pe.gov.br	UPDATE	Noticia	cmqji11p70005mw2bsma7e9ov	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	imagemPrincipal_id:\n  De: _bp4f1dWhGWDlw2E23DMmg\n  Para: d5dtGMj065Dk-p4zVZR1Aw\n\nimagemPrincipal_filesize:\n  De: 1397165\n  Para: 921133\n\nimagemPrincipal_width:\n  De: 5472\n  Para: 5180\n\nimagemPrincipal_height:\n  De: 3648\n  Para: 3453\n\ncorpo:\n  De: Automóveis, motocicletas, sucatas de informática, móveis e de outros tipos de materiais fazem parte do 5º Leilão de Bens Móveis de 2025, promovido pela Secretaria de Administração (SAD). O certame acontece no dia 24 de novembro, às 9h30, de forma eletrônica. Estão disponíveis 89 lotes para compra. A expectativa de arrecadação é de, no mínimo, R$ 390 mil. Os interessados em participar deverão realizar o cadastro prévio no site do leiloeiro ( ), no prazo máximo de até 72 horas antes do início do leilão virtual. É importante observar as regras nele contidas quanto à efetivação do cadastro, informando um endereço de e-mail para comunicação e envio de documentos, quando necessário. Pessoas físicas e jurídicas de qualquer natureza poderão ofertar lances online para veículos recuperáveis. Quanto às sucatas aproveitáveis e sucatas aproveitáveis com motor inservível, a participação é restrita aos Centros de Desmanches de Veículos Automotores, Comércio de Peças Usadas e Reciclagem de Sucata (CDV), registrados operacionais ou credenciados pelo Detran/PE. Além disso, também podem ofertar lances para sucatas aproveitáveis e sucatas aproveitáveis com motor inservível, as empresas de outras Unidades da Federação que tenham como atividade a desmontagem de veículos automotores terrestres destinados à comercialização de partes, peças e acessórios automotivos, entre outras condições que podem ser conferidas no edital. Esse documento está disponível no link no final do texto e na página eletrônica  . Os lotes estarão disponíveis para visitação nos dois dias úteis que antecedem o leilão virtual, nos locais e horários indicados no edital.\n  Para: [objeto]
cmrxn2cft0007a05rwkoimkvy	2026-07-23 15:00:57.586	gustavo.andrade@sad.pe.gov.br	UPDATE	Noticia	cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	ativo:\n  De: true\n  Para: false\n\ncorpo:\n  De: Automóveis, motocicletas, sucatas de informática, móveis e de outros tipos de materiais fazem parte do 5º Leilão de Bens Móveis de 2025, promovido pela Secretaria de Administração (SAD). O certame acontece no dia 24 de novembro, às 9h30, de forma eletrônica. Estão disponíveis 89 lotes para compra. A expectativa de arrecadação é de, no mínimo, R$ 390 mil.\nOs interessados em participar deverão realizar o cadastro prévio no site do leiloeiro ( ), no prazo máximo de até 72 horas antes do início do leilão virtual. É importante observar as regras nele contidas quanto à efetivação do cadastro, informando um endereço de e-mail para comunicação e envio de documentos, quando necessário.\nPessoas físicas e jurídicas de qualquer natureza poderão ofertar lances online para veículos recuperáveis. Quanto às sucatas aproveitáveis e sucatas aproveitáveis com motor inservível, a participação é restrita aos Centros de Desmanches de Veículos Automotores, Comércio de Peças Usadas e Reciclagem de Sucata (CDV), registrados operacionais ou credenciados pelo Detran/PE.\nAlém disso, também podem ofertar lances para sucatas aproveitáveis e sucatas aproveitáveis com motor inservível, as empresas de outras Unidades da Federação que tenham como atividade a desmontagem de veículos automotores terrestres destinados à comercialização de partes, peças e acessórios automotivos, entre outras condições que podem ser conferidas no edital. Esse documento está disponível no link no final do texto e na página eletrônica  .\nOs lotes estarão disponíveis para visitação nos dois dias úteis que antecedem o leilão virtual, nos locais e horários indicados no edital.\n  Para: [objeto]\n\ndestaque:\n  De: true\n  Para: false
cmrxsw4nu000va05rbtq3d3p7	2026-07-23 17:44:05.271	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrxszfan000xa05rgwm07a0a	2026-07-23 17:46:39.018	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrxt2ehz000za05r8l81ivly	2026-07-23 17:48:57.958	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrxt3yn70011a05rly6jd0eb	2026-07-23 17:50:10.722	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmrxt4xc20013a05rmwq7w6tl	2026-07-23 17:50:55.681	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmryv7cng000466t6d2hhn463	2026-07-24 11:36:34.251	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	imagem_id:\n  De: ocf1pwKBuj1GstK3oW-FiQ\n  Para: A7vY0q8Se8r7Ql-5dnhcnQ\n\nimagem_filesize:\n  De: 3901723\n  Para: 423640\n\nimagem_width:\n  De: 6046\n  Para: 3100\n\nimagem_height:\n  De: 4024\n  Para: 1744\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryv8f1q000666t6dlgoq999	2026-07-24 11:37:24.013	clovis.melo@sad.pe.gov.br	DELETE	Curso	cmqgq837u000046yhbe9456a6	Teste	Registro excluído.
cmryvj79i000766t62idnwuzw	2026-07-24 11:45:47.141	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	imagem_id:\n  De: ZN7yRY1wPKxRXLn4cHSGiQ\n  Para: 4lf5tvoJ6SBsa9bswOklgQ\n\nimagem_filesize:\n  De: 2275162\n  Para: 2297132\n\nimagem_width:\n  De: 1376\n  Para: 5184\n\nimagem_height:\n  De: 768\n  Para: 3456\n\nimagem_extension:\n  De: png\n  Para: jpg\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Gustavo Andrade
cmryvl0bp000866t60zuq6c0n	2026-07-24 11:47:11.46	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jf5vi000iboam6yi59usu	Pagamento de Tributos e Taxas de Imóveis Estaduais	imagem_id:\n  De: H0prnoNr177h9g-DQw0JuQ\n  Para: bC7dlW06dr9pYvOJPiyz2Q\n\nimagem_filesize:\n  De: 2285219\n  Para: 3996120\n\nimagem_width:\n  De: 1408\n  Para: 7360\n\nimagem_height:\n  De: 768\n  Para: 4912\n\nimagem_extension:\n  De: png\n  Para: jpg\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsj1pj1c009p2ggibpsfnejl	2026-08-07 14:34:03.549	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj1pj16009o2ggiw0o1lmks	Parceria e Convênios	Registro criado.
cmrxti5k30014a05ride7kgab	2026-07-23 18:01:12.865	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmqjh72gq0001mw2bhdl87tz9	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	subtitulo:\n  De: Um Passeio pela História de Recife\n  Para: Um Passeio pela História de Recife.\n\ncorpo:\n  De: A capital pernambucana ganhou uma nova representação visual que exalta a riqueza de sua história urbana e arquitetônica. Uma ilustração detalhada destaca o  Patrimônio Imóvel  da cidade, reunindo em um único cenário alguns dos marcos mais emblemáticos que moldaram a identidade recifense ao longo dos séculos. O painel, que traz a assinatura  "Recife • Pernambuco: Preservação da Memória Arquitetônica" , funciona como uma linha do tempo visual, conectando o passado colonial, o classicismo imperial e a modernidade da cidade. Um Passeio pela História de Recife A composição artística recria a atmosfera vibrante das ruas recifenses, mostrando cidadãos e turistas caminhando e pedalando entre monumentos históricos. Entre os grandes destaques da ilustração estão: Ao fundo, elementos como o icônico  Farol de Olinda/Recife , as pontes e os arrecifes completam a cena, emoldurados pelas bandeiras de Pernambuco e do Brasil. O Valor da Preservação Especialistas apontam que iniciativas visuais como esta são fundamentais para conscientizar a população sobre a importância da salvaguarda do patrimônio edificado. Mais do que cartões-postais, esses prédios contam a história do desenvolvimento econômico, político e cultural do estado. O painel reforça a mensagem de que preservar o Patrimônio Imóvel é garantir que as futuras gerações possam continuar caminhando pela história viva de Recife.\n  Para: [objeto]
cmrxtj88j0016a05rle6g2mol	2026-07-23 18:02:02.994	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmqjh72gq0001mw2bhdl87tz9	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	subtitulo:\n  De: Um Passeio pela História de Recife.\n  Para: Um Passeio pela História de Recife\n\ncorpo:\n  De: [objeto]\n  Para: [objeto]
cmrxtyeb30004b70wgk2q8bdj	2026-07-23 18:13:50.702	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmqji11p70005mw2bsma7e9ov	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	subtitulo:\n  De: Leilão de bens móveis\n  Para: Leilão de bens móveis,
cmrxtyme20005b70w28k0o2u4	2026-07-23 18:14:01.175	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmqji11p70005mw2bsma7e9ov	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	subtitulo:\n  De: Leilão de bens móveis,\n  Para: Leilão de bens móveis
cmrxuussy0001v50tl1veu12w	2026-07-23 18:39:02.481	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis.	titulo:\n  De: Doação de Imóveis\n  Para: Doação de Imóveis.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: user teste
cmrxuux230002v50tb54s808r	2026-07-23 18:39:07.994	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	titulo:\n  De: Doação de Imóveis.\n  Para: Doação de Imóveis\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmrxweckw0001w8inbgrl63yq	2026-07-23 19:22:14.191	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	imagem_id:\n  De: sGBW1__TH3cdx2qnsiKV9Q\n  Para: El1fS1WxEqH0wSAOOY6hSg\n\nimagem_filesize:\n  De: 53663\n  Para: 1066651\n\nimagem_width:\n  De: 774\n  Para: 3840\n\nimagem_height:\n  De: 789\n  Para: 2160\n\nimagem_extension:\n  De: png\n  Para: jpg
cmrxwpt4g000aw8inolg29epb	2026-07-23 19:31:08.846	clovis.melo@sad.pe.gov.br	CREATE	Noticia	cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 deste mês	Registro criado.
cmrxwq48v000bw8ine673s6re	2026-07-23 19:31:23.262	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	titulo:\n  De: 5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 deste mês\n  Para: 5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês
cmrxwqtk9000cw8in8sxrw1ck	2026-07-23 19:31:56.072	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	imagemPrincipal_id:\n  De: vazio\n  Para: 817_YhT-9HG9lZhOa-tIMw\n\nimagemPrincipal_filesize:\n  De: vazio\n  Para: 921133\n\nimagemPrincipal_width:\n  De: vazio\n  Para: 5180\n\nimagemPrincipal_height:\n  De: vazio\n  Para: 3453\n\nimagemPrincipal_extension:\n  De: vazio\n  Para: jpg
cmrxwr9hc000dw8inlzh6puya	2026-07-23 19:32:16.702	clovis.melo@sad.pe.gov.br	DELETE	Noticia	cmqji11p70005mw2bsma7e9ov	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	Registro excluído.
cmrxwrekk000ew8in8ocm5o9x	2026-07-23 19:32:23.298	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	subareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmqgnv5xk00003adnqj7bkkdv
cmrxws63c000gw8inwd11fzue	2026-07-23 19:32:58.965	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis é promovido pela SAD no próximo dia 24 desse mês	titulo:\n  De: 5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês\n  Para: 5º Leilão de Bens Móveis é promovido pela SAD no próximo dia 24 desse mês
cmrxwsgmd000hw8inamvikywh	2026-07-23 19:33:12.612	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis é promovido pela SAD no próximo dia 24 desse mês	imagemPrincipalAlt:\n  De: Banner de divulgação do 5º Leilão de Bens Móveis de 2025 promovido pela Secretaria de Administração de Pernambuco.\n  Para: Banner de divulgação do 5º Leilão de Bens Móveis promovido pela Secretaria de Administração de Pernambuco.
cmrxwuxok000jw8inpg132oyg	2026-07-23 19:35:08.035	clovis.melo@sad.pe.gov.br	CREATE	Noticia	cmrxwuxoa000iw8inyqh968qv	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	Registro criado.
cmrxwvogq000lw8ini87pnhvd	2026-07-23 19:35:42.745	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwuxoa000iw8inyqh968qv	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	imagemPrincipal_id:\n  De: vazio\n  Para: MHk5bMG7pGh8_f-SdKCVkw\n\nimagemPrincipal_filesize:\n  De: vazio\n  Para: 2398128\n\nimagemPrincipal_width:\n  De: vazio\n  Para: 1408\n\nimagemPrincipal_height:\n  De: vazio\n  Para: 768\n\nimagemPrincipal_extension:\n  De: vazio\n  Para: png
cmrxwvut6000mw8inbcnvhhcx	2026-07-23 19:35:50.969	clovis.melo@sad.pe.gov.br	DELETE	Noticia	cmqjh72gq0001mw2bhdl87tz9	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	Registro excluído.
cmryuo1sz000266t6t8k81b2d	2026-07-24 11:21:33.73	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	imagem_id:\n  De: U86-5tV3stdXQpZsqR8RSQ\n  Para: ocf1pwKBuj1GstK3oW-FiQ\n\nimagem_filesize:\n  De: 321225\n  Para: 3901723\n\nimagem_width:\n  De: 1408\n  Para: 6046\n\nimagem_height:\n  De: 768\n  Para: 4024\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Allan Soares\n  Para: Gustavo Andrade
cmryz44aq000eeveofrenl87o	2026-07-24 13:26:01.92	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	resumo:\n  De: Plataforma pública de consulta ágil ao patrimônio imobiliário do Estado de Pernambuco.\n  Para: Plataforma digital de consulta ágil ao patrimônio imobiliário do Estado de Pernambuco.
cmryvp6g2000b66t67xhs57iz	2026-07-24 11:50:26.016	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	maisInformacoes:\n  De: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone: 3183-7731 ou 3183-7739 E-mail:\n  Para: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone: 3183-7731 ou 3183-7739 E-mail:\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Viktoria Heyka\n  Para: user teste
cmryvq9m4000c66t6ykoc5x9h	2026-07-24 11:51:16.779	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	updatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: user teste\n  Para: Gustavo Andrade
cmryvtozr000d66t6iiniaodu	2026-07-24 11:53:56.678	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	comoSolicitar:\n  De: A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações:\n 1- Ofício da Autoridade máxima do órgão solicitando à SEADP/SAD  a inclusão dos bens inservíveis para leilão;\n 2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD\nObs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017.\n 3- Laudo de Risco Biológico / Ambiental, quando aplicável.\n  Para: A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações: 1- Ofício da Autoridade máxima do órgão solicitando à SEPEC/SAD  a inclusão dos bens inservíveis para leilão; 2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD\nObs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017. 3- Laudo de Risco Biológico / Ambiental, quando aplicável.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryxbvgo0000eveok3oz7zqz	2026-07-24 12:36:04.474	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	oQueE:\n  De: A Unidade Centra de Patrimônio Móvel e Materiais (UCPAM) capacita e orienta os órgãos e/ou entidades da Administração Pública Estadual quanto à elaboração do Inventário Físico de Bens Materiais.\nO Inventário de Bens Móveis constitui um instrumento de controle administrativo destinado à verificação da existência física dos bens permanentes, estejam eles em uso ou não, nos diversos órgãos e/ou entidades da Administração Pública Estadual.\nEsse procedimento consiste no levantamento físico e financeiro de todos os bens móveis permanentes que se encontram sob a posse e guarda das unidades gestoras, tendo como finalidade confrontar os registros patrimoniais existentes com os bens efetivamente localizados.\n  Para: O Inventário de Físico de Bens Materiais constitui um instrumento de controle administrativo destinado à verificação da existência física dos bens permanentes, estejam eles em uso ou não, nos diversos órgãos e/ou entidades da Administração Pública Estadual. Esse procedimento consiste no levantamento físico e financeiro de todos os bens móveis permanentes que se encontram sob a posse e guarda das unidades gestoras, tendo como finalidade confrontar os registros patrimoniais existentes com os bens efetivamente localizados. Nós atuamos capacitando e orientando os órgãos e/ou entidades da Administração Pública Estadual quanto à elaboração desse inventário.\n\ncomoSolicitar:\n  De: Para mais informações e esclarecimentos acerca do Inventário, favor entrar em contato conosco:\nUnidade Central de Patrimônio Móvel e Materiais (UCPAM)\nFones: 3183-7785\nE-mail:\n  Para: [sem texto]\n\nmaisInformacoes:\n  De: [sem texto]\n  Para: Para mais informações e esclarecimentos acerca do Inventário, favor entrar em contato conosco:\nUnidade Central de Patrimônio Móvel e Materiais (UCPAM)\n Fones:  3183-7785  E-mail:\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryykisn0004eveoa4k0rmp8	2026-07-24 13:10:47.59	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	resumo:\n  De: O Cadastro Imobiliário Estadual é o registro oficial dos imóveis estaduais, reunindo informações sobre localização, titularidade, ocupação, destinação e o histórico documental de cada imóvel.\n  Para: Registro oficial dos imóveis estaduais, reunindo informações sobre localização, titularidade, ocupação, destinação e o histórico documental de cada imóvel.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryylz4z0005eveonaa9qh4o	2026-07-24 13:11:55.426	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	resumo:\n  De: Registro oficial dos imóveis estaduais, reunindo informações sobre localização, titularidade, ocupação, destinação e o histórico documental de cada imóvel.\n  Para: Registro oficial dos imóveis estaduais, reunindo as principais informações de cada imóvel.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryyn17o0006eveoddefp7og	2026-07-24 13:12:44.77	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jf5vi000iboam6yi59usu	Pagamento de Tributos e Taxas de Imóveis Estaduais	resumo:\n  De: Serviços de acompanhamento e controle das notificações de pagamento vinculadas aos imóveis estaduais.\n  Para: Acompanhamento e controle das notificações de pagamento vinculadas aos imóveis estaduais.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryysxku0007eveoiog1ausn	2026-07-24 13:17:19.997	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	resumo:\n  De: Análise das solicitações de usucapião realizadas por terceiros para verificar se o imóvel envolvido pertence ao Estado de Pernambuco ou possui interesse público. Esse trabalho garante segurança jurídica e contribui para a proteção e a boa gestão do patrimônio estadual.\n  Para: Análise das solicitações de usucapião de imóveis, quanto à posse ou interesse públicos.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Gustavo Andrade
cmryytlor0008eveoj3qzvo74	2026-07-24 13:17:51.242	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	resumo:\n  De: Aqui você encontrará as instruções básicas para realizar uma doação de imóvel para o Estado ou, por sua vez, solicitar uma doação.\n  Para: Instruções básicas para realizar uma doação de imóvel para o Estado ou, por sua vez, solicitar uma doação.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: user teste\n  Para: Gustavo Andrade
cmryyx33i0009eveo8hglslm0	2026-07-24 13:20:33.773	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	resumo:\n  De: Plataforma digital que permite a consulta e visualização de informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco, facilitando o acesso a dados patrimoniais e apoiando a gestão dos ativos públicos.\n  Para: Ferramenta de consulta e visualização de informações dos bens móveis pertencentes ao patrimônio público do Estado de Pernambuco.
cmryyz3w9000aeveo1szjlcl3	2026-07-24 13:22:08.12	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	resumo:\n  De: O Atlas.PE é a plataforma pública de consulta ao patrimônio imobiliário do Estado de Pernambuco. Ele organiza a busca, os filtros e a leitura do cadastro em uma experiência mais rápida, clara e fácil de compartilhar.\n  Para: Plataforma pública de consulta ao patrimônio imobiliário do Estado de Pernambuco, através de buscas, filtros e leituras do cadastro em uma experiência mais rápida, clara e fácil de compartilhar.
cmryz2mlw000beveot4r0wz6z	2026-07-24 13:24:52.339	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	resumo:\n  De: Plataforma pública de consulta ao patrimônio imobiliário do Estado de Pernambuco, através de buscas, filtros e leituras do cadastro em uma experiência mais rápida, clara e fácil de compartilhar.\n  Para: Plataforma pública de consulta ágil ao patrimônio imobiliário do Estado de Pernambuco.
cmryz3c6z000ceveo0m706q81	2026-07-24 13:25:25.498	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	resumo:\n  De: Ferramenta de consulta e visualização de informações dos bens móveis pertencentes ao patrimônio público do Estado de Pernambuco.\n  Para: Ferramenta de consulta e visualização de informações dos bens móveis do Estado de Pernambuco.
cmryz3i88000deveosmz2emw4	2026-07-24 13:25:33.32	igor.sacramento@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	comoSolicitar:\n  De: Para obter mais informações detalhadas sobre o procedimento de Usucapião Extrajudicial, consulte o conteúdo disponível no link:\n .\nNesse site você encontrará orientações completas sobre requisitos, documentações necessárias e como dar andamento ao processo de regularização de imóvel por meio da usucapião, especialmente na via extrajudicial.\n  Para: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link:\n Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n\nmaisInformacoes:\n  De: [sem texto]\n  Para: Esclarecimentos adicionais podem ser obtidos nos seguintes contatos: (81)3183-7739 e gestaoimobiliaria@sad.pe.gov.br.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Gustavo Andrade\n  Para: Igor Sacramento
cmryz58qb000feveo7d82d4q7	2026-07-24 13:26:54.322	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmi4krlpf0000wugdaippzc92	Dashboard de Patrimônio Imobiliário	resumo:\n  De: Dashboard interativo desenvolvido em Power BI para monitoramento do patrimônio imobiliário estadual, permitindo acompanhar imóveis públicos, indicadores de gestão e informações territoriais para apoio à tomada de decisão.\n  Para: Painel de monitoramento do patrimônio imobiliário estadual.
cmryz79vh000heveo21rdk4oe	2026-07-24 13:28:29.116	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmid6qe0u0000tmuv7ype3ong	Dashboard de Patrimônio Móvel	resumo:\n  De: Dashboard interativo desenvolvido em Power BI para monitoramento do patrimônio móvel estadual, permitindo acompanhar indicadores, distribuição de bens e informações estratégicas para apoiar a gestão patrimonial.\n  Para: Painel de monitoramento do patrimônio móvel estadual.
cmryz7ia5000ieveo8hetzujr	2026-07-24 13:28:40.012	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	comoSolicitar:\n  De: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link:\n Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n  Para: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: \n Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Igor Sacramento\n  Para: user teste
cmryz7q3b000jeveohx5lai7x	2026-07-24 13:28:50.134	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	comoSolicitar:\n  De: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: \n Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n  Para: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryz85lh000keveo65ce46cg	2026-07-24 13:29:10.228	gustavo.andrade@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	resumo:\n  De: Ferramenta de consulta e visualização de informações dos bens móveis do Estado de Pernambuco.\n  Para: Ferramenta de consulta das informações dos bens móveis do Estado de Pernambuco.
cmryz85sp000leveodgvcip9z	2026-07-24 13:29:10.487	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	comoSolicitar:\n  De: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n  Para: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: https://docs.google.com/document/d/1BLJEXoCGQtwi0bSDmDY3Y5SWpyzS_wFpiZn3erTTcyc/edit?tab=t.0#heading=h.diyw7px6iw4f Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryz8qwz000meveosrgu5is3	2026-07-24 13:29:37.858	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	comoSolicitar:\n  De: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: https://docs.google.com/document/d/1BLJEXoCGQtwi0bSDmDY3Y5SWpyzS_wFpiZn3erTTcyc/edit?tab=t.0#heading=h.diyw7px6iw4f Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n  Para: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmryz980e000neveo477lafd1	2026-07-24 13:30:00.013	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmr4wl92l0006m82919zfq88e	Doação de Imóveis	resumo:\n  De: Instruções básicas para realizar uma doação de imóvel para o Estado ou, por sua vez, solicitar uma doação.\n  Para: Instruções básicas para realizar uma doação de imóvel para o Estado ou solicitar uma doação.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cms3740lx000u2ggijvgmlcjn	2026-07-27 12:20:58.769	clovis.melo@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	imagem_id:\n  De: ff42pDAPu5cuuFZ6kCHZAg\n  Para: NGQJPYh1O8sZsa492Ge6WA\n\nimagem_filesize:\n  De: 91038\n  Para: 4010512\n\nimagem_width:\n  De: 600\n  Para: 5616\n\nimagem_height:\n  De: 400\n  Para: 3744\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Gustavo Andrade\n  Para: user teste
cms3631rr00072ggil64kxrbd	2026-07-27 11:52:14.006	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: O Acervo Móvel é uma aplicação desenvolvida para facilitar o acesso às informações relacionadas aos bens móveis pertencentes ao patrimônio público estadual.\nA plataforma reúne dados patrimoniais organizados de forma estruturada, permitindo a consulta e visualização de informações sobre os bens cadastrados, contribuindo para maior transparência e eficiência na gestão patrimonial.\nPor meio da aplicação, gestores e equipes técnicas podem acessar informações relevantes sobre os bens móveis, auxiliando nos processos de controle, acompanhamento e planejamento da gestão patrimonial.\nEntre as principais funcionalidades da solução estão:\nConsulta de informações sobre bens móveis cadastrados;\nOrganização e visualização estruturada de dados patrimoniais;\nApoio às atividades de controle e acompanhamento dos ativos públicos;\nFacilidade de acesso às informações por parte das equipes gestoras;\nContribuição para maior transparência na gestão do patrimônio público.\nA aplicação contribui para modernizar os processos de gestão patrimonial, permitindo que as informações sobre os bens móveis estejam organizadas e acessíveis de forma prática e segura.\n  Para: Sistema digital de consulta ao acervo de bens móveis do patrimônio público estadual O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma
cms364e9200082ggiullnlfm1	2026-07-27 11:53:16.836	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: Sistema digital de consulta ao acervo de bens móveis do patrimônio público estadual O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma\n  Para: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma
cms365pu800092ggiecok6quz	2026-07-27 11:54:18.511	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma\n  Para: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma
cms3663kd000a2ggi8s9i71ij	2026-07-27 11:54:36.3	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma\n  Para: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma
cms3681b0000b2ggi0uhnzt5x	2026-07-27 11:56:06.683	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma\n  Para: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial: Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada: Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão: Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência: Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma:
cms36b6r1000c2ggig80e6a9u	2026-07-27 11:58:33.708	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: O  Acervo Móvel  é uma plataforma desenvolvida para centralizar e disponibilizar informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco. A solução reúne dados patrimoniais de forma estruturada, permitindo consultas rápidas e organizadas que apoiam a gestão, o controle e o acompanhamento dos ativos públicos. Voltada aos gestores e equipes técnicas da Administração Pública Estadual, a plataforma facilita o acesso às informações patrimoniais, contribuindo para a padronização dos processos, maior eficiência administrativa e fortalecimento da transparência na gestão dos bens públicos. Principais funcionalidades Consulta patrimonial: Localize informações sobre os bens móveis cadastrados de forma rápida e organizada. Visualização estruturada: Acesse dados patrimoniais organizados para facilitar a análise e o acompanhamento dos ativos públicos. Apoio à gestão: Disponibilize informações que auxiliam as atividades de controle, fiscalização e planejamento patrimonial. Transparência: Promova maior acesso às informações patrimoniais, fortalecendo a gestão pública e a prestação de contas. Benefícios da plataforma:\n  Para: O  Acervo Móvel  é a plataforma de consulta das informações dos bens móveis do Estado de Pernambuco, desenvolvida para apoiar a gestão patrimonial e o acompanhamento dos ativos públicos estaduais. A solução reúne dados cadastrais dos bens móveis em um ambiente organizado e de fácil consulta, permitindo que gestores e equipes técnicas acessem informações essenciais para o controle, o planejamento e a administração do patrimônio público. Entre as principais funcionalidades do Acervo Móvel estão: A plataforma contribui para modernizar a gestão dos bens móveis, promovendo maior organização das informações, eficiência administrativa e transparência na gestão do patrimônio público estadual.
cms36bh2i000d2ggi4nzabccc	2026-07-27 11:58:47.081	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	corpo:\n  De: O  Acervo Móvel  é a plataforma de consulta das informações dos bens móveis do Estado de Pernambuco, desenvolvida para apoiar a gestão patrimonial e o acompanhamento dos ativos públicos estaduais. A solução reúne dados cadastrais dos bens móveis em um ambiente organizado e de fácil consulta, permitindo que gestores e equipes técnicas acessem informações essenciais para o controle, o planejamento e a administração do patrimônio público. Entre as principais funcionalidades do Acervo Móvel estão: A plataforma contribui para modernizar a gestão dos bens móveis, promovendo maior organização das informações, eficiência administrativa e transparência na gestão do patrimônio público estadual.\n  Para: O  Acervo Móvel  é a plataforma de consulta das informações dos bens móveis do Estado de Pernambuco, desenvolvida para apoiar a gestão patrimonial e o acompanhamento dos ativos públicos estaduais. A solução reúne dados cadastrais dos bens móveis em um ambiente organizado e de fácil consulta, permitindo que gestores e equipes técnicas acessem informações essenciais para o controle, o planejamento e a administração do patrimônio público. Entre as principais funcionalidades do Acervo Móvel estão: A plataforma contribui para modernizar a gestão dos bens móveis, promovendo maior organização das informações, eficiência administrativa e transparência na gestão do patrimônio público estadual.
cmsj1vigp009r2ggii8sjgfsq	2026-08-07 14:38:42.744	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj1vigh009q2ggi044hoxig	Paceria EGAPE x ENAP	Registro criado.
cms36f0kh000e2ggivphs73k0	2026-07-27 12:01:32.317	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	corpo:\n  De: Consulta operacional Localize rapidamente imóveis, entenda o cadastro e acesse o detalhe consolidado. Leitura patrimonial Consulte informações cadastrais, localização e atributos essenciais do patrimônio. Uso colaborativo Salve filtros, compartilhe visualizações e padronize cenários entre equipes. Plataforma em camadas Além da visualização pública, o Atlas.PE possui módulos internos disponíveis conforme o perfil de acesso.\n Consulta inteligente Localize imóveis por código, NP, endereço, destinação, cidade e outros critérios combináveis. Filtros e recortes Monte recortes por cidade, proprietário, status, tipo de imóvel e outros critérios disponíveis. Compartilhamento Compartilhe a visualização atual por link para reproduzir a mesma consulta em outro acesso. Filtros salvos Reaproveite cenários recorrentes de busca sem precisar remontar a consulta a cada acesso.\n Integração com o GeoPE Quando a leitura territorial é necessária, a consulta patrimonial pode ser conectada ao GeoPE para aprofundar o entendimento espacial do imóvel. Consulta patrimonial conectada ao território Essa integração amplia a compreensão do imóvel ao relacionar cadastro e localização em um único fluxo de consulta. Capacidades da plataforma A visualização pública concentra a consulta patrimonial. Recursos avançados, como módulos internos de histórico, análise e controle, permanecem disponíveis conforme o perfil de acesso do usuário.\n  Para: O  Atlas.PE  é uma plataforma de consulta do patrimônio imobiliário do Estado de Pernambuco, desenvolvida para facilitar o acesso às informações cadastrais dos bens imóveis e apoiar a gestão patrimonial. A solução permite que gestores e equipes técnicas realizem consultas rápidas e organizadas, localizando imóveis por diferentes critérios, visualizando informações consolidadas e compartilhando cenários de consulta entre usuários. Quando necessário, a plataforma integra-se ao GeoPE, ampliando a análise territorial por meio da visualização georreferenciada dos imóveis. Entre as principais funcionalidades do Atlas.PE estão: A plataforma contribui para tornar a consulta patrimonial mais ágil e eficiente, promovendo maior organização das informações, apoio à tomada de decisão e integração entre os dados cadastrais e territoriais do patrimônio público estadual.
cms36g2r1000g2ggiyca1k5xa	2026-07-27 12:02:21.804	clovis.melo@sad.pe.gov.br	DELETE	Solucao	cmi4krlpf0000wugdaippzc92	Dashboard de Patrimônio Imobiliário	Registro excluído.
cms36g2r0000f2ggiqcfg24n7	2026-07-27 12:02:21.803	clovis.melo@sad.pe.gov.br	DELETE	Solucao	cmid6qe0u0000tmuv7ype3ong	Dashboard de Patrimônio Móvel	Registro excluído.
cms36h6ri000h2ggiqgj48f2p	2026-07-27 12:03:13.659	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	corpo:\n  De: O  Atlas.PE  é uma plataforma de consulta do patrimônio imobiliário do Estado de Pernambuco, desenvolvida para facilitar o acesso às informações cadastrais dos bens imóveis e apoiar a gestão patrimonial. A solução permite que gestores e equipes técnicas realizem consultas rápidas e organizadas, localizando imóveis por diferentes critérios, visualizando informações consolidadas e compartilhando cenários de consulta entre usuários. Quando necessário, a plataforma integra-se ao GeoPE, ampliando a análise territorial por meio da visualização georreferenciada dos imóveis. Entre as principais funcionalidades do Atlas.PE estão: A plataforma contribui para tornar a consulta patrimonial mais ágil e eficiente, promovendo maior organização das informações, apoio à tomada de decisão e integração entre os dados cadastrais e territoriais do patrimônio público estadual.\n  Para: O  Atlas.PE  é a plataforma de consulta do patrimônio imobiliário do Estado de Pernambuco, desenvolvida para facilitar o acesso às informações cadastrais dos bens imóveis e apoiar a gestão patrimonial. A solução permite que gestores e equipes técnicas realizem consultas rápidas e organizadas, localizando imóveis por diferentes critérios, visualizando informações consolidadas e compartilhando cenários de consulta entre usuários. Quando necessário, a plataforma integra-se ao GeoPE, ampliando a análise territorial por meio da visualização georreferenciada dos imóveis. Entre as principais funcionalidades do Atlas.PE estão: A plataforma contribui para tornar a consulta patrimonial mais ágil e eficiente, promovendo maior organização das informações, apoio à tomada de decisão e integração entre os dados cadastrais e territoriais do patrimônio público estadual.
cms36htdx000i2ggizyxoam5d	2026-07-27 12:03:42.978	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmi3h5i7b0005vwpm6wngrtl4	GeoPE	corpo:\n  De: O  GeoPE  é a plataforma oficial de georreferenciamento dos imóveis do Estado de Pernambuco, desenvolvida para apoiar a gestão e a análise imobiliária do patrimônio público estadual. A solução utiliza tecnologias de sistemas de informação geográfica para integrar dados espaciais e informações relacionadas aos imóveis pertencentes ao Estado, permitindo que gestores e equipes técnicas visualizem esses dados diretamente no mapa interativo podendo navegar pelas suas informações gerais, cartorárias dos imóveis e chegar até suas documentações. Por meio da plataforma, é possível localizar imóveis públicos no território, analisar sua distribuição geográfica e acessar informações relevantes sobre cada bem imóvel cadastrado. Entre as principais funcionalidades do GeoPE estão: Visualização geográfica dos imóveis pertencentes ao Estado de Pernambuco; A plataforma contribui para ampliar a capacidade de análise territorial da administração pública, promovendo maior integração entre dados, transparência na gestão patrimonial e eficiência no planejamento de ações relacionadas ao patrimônio público estadual.\n  Para: O  GeoPE  é a plataforma oficial de georreferenciamento dos imóveis do Estado de Pernambuco, desenvolvida para apoiar a gestão e a análise imobiliária do patrimônio público estadual. A solução utiliza tecnologias de sistemas de informação geográfica para integrar dados espaciais e informações relacionadas aos imóveis pertencentes ao Estado, permitindo que gestores e equipes técnicas visualizem esses dados diretamente no mapa interativo podendo navegar pelas suas informações gerais, cartorárias dos imóveis e chegar até suas documentações. Por meio da plataforma, é possível localizar imóveis públicos no território, analisar sua distribuição geográfica e acessar informações relevantes sobre cada bem imóvel cadastrado. Entre as principais funcionalidades do GeoPE estão: A plataforma contribui para ampliar a capacidade de análise territorial da administração pública, promovendo maior integração entre dados, transparência na gestão patrimonial e eficiência no planejamento de ações relacionadas ao patrimônio público estadual.
cms36pfg0000m2ggi611cn4jb	2026-07-27 12:09:38.159	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmi3h5i7b0005vwpm6wngrtl4	GeoPE	imagem_id:\n  De: HcAOY1Zjot9EWkPjCRHRVA\n  Para: iNn49AQc6IVi-nC3iqTH6w\n\nimagem_filesize:\n  De: 3250353\n  Para: 1150880\n\nimagem_width:\n  De: 4160\n  Para: 5200\n\nimagem_height:\n  De: 6240\n  Para: 3466
cms36qz5p000n2ggilhdvr8zg	2026-07-27 12:10:50.364	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmq9kax0b0015boamd0oi79c4	Acervo Móvel	imagem_id:\n  De: GYQDRafGH4JfAC_YRLc_Ng\n  Para: Wtvi0EXPZUdtlG-yMycg4Q\n\nimagem_filesize:\n  De: 605334\n  Para: 1423920\n\nimagem_width:\n  De: 4016\n  Para: 3400\n\nimagem_height:\n  De: 6016\n  Para: 3000
cms36thn6000o2ggi9as9ppdo	2026-07-27 12:12:47.632	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmq9k32m60012boamq05d5shl	Evolução do Ecossistema de Contratações Públicas de Pernambuco é tema da nova edição da Maratona Compras Públicas	imagemPrincipal_id:\n  De: H3UpMtV-1Awtbfm2yax9sg\n  Para: RzP1YSLvxfplJXSKOFoRFQ\n\nimagemPrincipal_filesize:\n  De: 1032968\n  Para: 4748234\n\nimagemPrincipal_width:\n  De: 5628\n  Para: 6016\n\nimagemPrincipal_height:\n  De: 3752\n  Para: 4016
cms36utnu000p2ggixoyvarqo	2026-07-27 12:13:49.857	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmq9jzq8i000zboam9nk4qe3h	Governo de Pernambuco injeta cerca de R$ 5 bilhões aquecendo a economia do Estado	imagemPrincipal_id:\n  De: 0RFoOEnkY7hW-GE4MZFLnA\n  Para: lZaOWnz3WTy3J5rnTXfURQ\n\nimagemPrincipal_filesize:\n  De: 9874328\n  Para: 940991\n\nimagemPrincipal_width:\n  De: 5516\n  Para: 3500\n\nimagemPrincipal_height:\n  De: 3677\n  Para: 2333
cms36x5bp000r2ggip5k1rj8o	2026-07-27 12:15:38.287	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwuxoa000iw8inyqh968qv	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	imagemPrincipal_id:\n  De: MHk5bMG7pGh8_f-SdKCVkw\n  Para: 70A2FVRB_PBEltR4JPgvHA\n\nimagemPrincipal_filesize:\n  De: 2398128\n  Para: 3121783\n\nimagemPrincipal_width:\n  De: 1408\n  Para: 3959\n\nimagemPrincipal_height:\n  De: 768\n  Para: 5938\n\nimagemPrincipal_extension:\n  De: png\n  Para: jpg
cms36xhpu000s2ggiyrhsh3pb	2026-07-27 12:15:54.348	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwuxoa000iw8inyqh968qv	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	imagemPrincipal_id:\n  De: 70A2FVRB_PBEltR4JPgvHA\n  Para: SORus874t53I7HM1WlXH1A\n\nimagemPrincipal_filesize:\n  De: 3121783\n  Para: 2639671\n\nimagemPrincipal_width:\n  De: 3959\n  Para: 5314\n\nimagemPrincipal_height:\n  De: 5938\n  Para: 3543
cms36y0k7000t2ggij9ybp4mx	2026-07-27 12:16:18.77	clovis.melo@sad.pe.gov.br	UPDATE	Noticia	cmrxwuxoa000iw8inyqh968qv	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	imagemPrincipal_id:\n  De: SORus874t53I7HM1WlXH1A\n  Para: x_O2IBwkNbEw7S_BgdH9dA\n\nimagemPrincipal_filesize:\n  De: 2639671\n  Para: 2687760\n\nimagemPrincipal_width:\n  De: 5314\n  Para: 5371\n\nimagemPrincipal_height:\n  De: 3543\n  Para: 3581
cms37baw0000v2ggimnijiexk	2026-07-27 12:26:38.684	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	slug:\n  De: Atlas.PE\n  Para: https://atlas.pe.gov.br/login
cms37bqsb000w2ggic9nxpdzz	2026-07-27 12:26:59.286	clovis.melo@sad.pe.gov.br	UPDATE	Solucao	cmqjioi3a0008mw2bfz85q62u	Atlas.PE	slug:\n  De: https://atlas.pe.gov.br/login\n  Para: atlas.pe
cms37dvhq000x2ggi7g3wvu6k	2026-07-27 12:28:38.7	clovis.melo@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	resumo:\n  De: Procedimentos desfazimento Procedimentos desfazimento Procedimentos desfazimento\n  Para: Procedimentos desfazimento\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Allan Soares\n  Para: user teste
cms37e02a000y2ggiee87l8al	2026-07-27 12:28:44.624	clovis.melo@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	resumo:\n  De: Procedimentos desfazimento\n  Para: Procedimento de desfazimento\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cms37ev0z000z2ggifzhkyd96	2026-07-27 12:29:24.753	clovis.melo@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	local:\n  De: \n  Para: Egape - R. Tabira, 252 - Boa Vista, Recife - PE, 50050-330\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cms3g1q5o00132ggiq02qfjjo	2026-07-27 16:31:08.455	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmq9sorix000qg5ahfulm0bn6	Contratos Corporativos	oQueE:\n  De: [sem texto]\n  Para: A Gerência de Contratos Corporativos (GECOR/GGCOR) atua na gestão, acompanhamento e disponibilização de informações referentes aos contratos corporativos do Estado de Pernambuco, promovendo a padronização, eficiência e economicidade na contratação de serviços de uso comum pelos órgãos e entidades da Administração Pública Estadual. Este serviço disponibiliza orientações, informações contratuais, documentos de referência e apoio às unidades participantes dos contratos corporativos gerenciados pela Secretaria de Administração.\n\nquemPrecisa:\n  De: [sem texto]\n  Para: Órgãos e entidades integrantes da Administração Pública Estadual que necessitem consultar informações, orientações ou documentos relacionados aos contratos corporativos vigentes gerenciados pela Secretaria de Administração. O acesso ao serviço é necessário sempre que houver necessidade de adesão, utilização, acompanhamento, esclarecimentos ou consulta sobre contratos corporativos disponibilizados pelo Estado.\n\ncomoSolicitar:\n  De: [sem texto]\n  Para: As solicitações relacionadas aos contratos corporativos devem ser encaminhadas à Gerência Geral de Serviços Corporativos (GGCOR), por meio dos canais institucionais disponibilizados pela Secretaria de Administração. Para atendimento, o órgão interessado deverá informar o contrato corporativo desejado, a demanda apresentada e os dados necessários para análise e orientação pela equipe responsável.\n\nmaisInformacoes:\n  De: [sem texto]\n  Para: A Gerência de Contratos Corporativos (GCCOR) é a unidade responsável, vinculada à Gerência Geral de Serviços Corporativos (GGCOR) da Secretaria de Administração do Estado de Pernambuco (SAD). A Gerência de Contratos Corporativos é responsável pela gestão estratégica dos contratos de natureza corporativa do Estado, promovendo a padronização das contratações, a otimização dos recursos públicos e o suporte aos órgãos e entidades participantes.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Diego Santos Rolim 
cms3itmdw00142ggiiedoh4fq	2026-07-27 17:48:49.171	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrj6jz5h0016tspsfrh0gcht	FROTA	titulo:\n  De: Lorem ipsum dolor sit amet\n  Para: FROTA\n\nresumo:\n  De: Lorem ipsum dolor sit amet. In quas explicabo sit commodi voluptate eos maxime exercitationem qui voluptatem enim aut excepturi dolor quo debitis architecto.\n  Para: A Gerência de Frota, \n\noQueE:\n  De: Lorem ipsum dolor sit amet. In quas explicabo sit commodi voluptate eos maxime exercitationem qui voluptatem enim aut excepturi dolor quo debitis architecto. In voluptatem adipisci et aliquid earum non internos inventore et nemo minima et voluptas voluptates aut sequi quos eos eligendi omnis. Qui necessitatibus odio aut sint iusto eos veritatis dolor quo porro temporibus\n  Para: A Gerência de Frota é a unidade responsável pelo planejamento, coordenação, normatização e acompanhamento das ações relacionadas à gestão da frota oficial do Poder Executivo Estadual. Sua atuação compreende a gestão dos contratos corporativos relacionados à frota, o desenvolvimento de normas e procedimentos, o acompanhamento da utilização dos veículos oficiais, o monitoramento de indicadores de desempenho, a promoção de iniciativas voltadas à redução dos custos operacionais e o apoio técnico aos órgãos e entidades estaduais na administração de seus veículos. A unidade também atua na implementação de boas práticas de gestão, na racionalização dos recursos públicos e na melhoria contínua dos processos relacionados à mobilidade administrativa, assegurando conformidade com a legislação vigente e com as diretrizes da Secretaria de Administração.\n\nquemPrecisa:\n  De: Lorem ipsum dolor sit amet. In quas explicabo sit commodi voluptate eos maxime exercitationem qui voluptatem enim aut excepturi dolor quo debitis architecto. In voluptatem adipisci et aliquid earum non internos inventore et nemo minima et voluptas voluptates aut sequi quos eos eligendi omnis. Qui necessitatibus odio aut sint iusto eos veritatis dolor quo porro temporibus\n  Para: Os serviços da Gerência de Frota destinam-se aos órgãos e entidades integrantes da Administração Pública Estadual que demandem apoio técnico, orientação, acompanhamento ou atendimento relacionado à gestão da frota oficial. O atendimento ocorre sempre que houver necessidade de utilização dos serviços corporativos de frota, acompanhamento de contratos, orientações sobre normas e procedimentos, gestão de veículos oficiais, monitoramento de indicadores, implementação de soluções para otimização da frota ou outras demandas relacionadas às competências da Gerência.\n\ncomoSolicitar:\n  De: Lorem ipsum dolor sit amet. In quas explicabo sit commodi voluptate eos maxime exercitationem qui voluptatem enim aut excepturi dolor quo debitis architecto. In voluptatem adipisci et aliquid earum non internos inventore et nemo minima et voluptas voluptates aut sequi quos eos eligendi omnis. Qui necessitatibus odio aut sint iusto eos veritatis dolor quo porro temporibus\n  Para: As demandas deverão ser encaminhadas pela autoridade competente ou pelo servidor formalmente designado pelo órgão ou entidade demandante, por meio dos canais institucionais da Secretaria de Administração. Quando necessário, a solicitação deverá ser formalizada mediante processo eletrônico no Sistema Eletrônico de Informações (SEI), contendo as informações e documentos pertinentes à demanda, observadas as normas e procedimentos estabelecidos pela Secretaria de Administração. Após o recebimento, a Gerência de Frota realizará a análise da solicitação e adotará as providências cabíveis, observando a legislação vigente, a disponibilidade contratual e os normativos aplicáveis.\n\nmaisInformacoes:\n  De: Lorem ipsum dolor sit amet. In quas explicabo sit commodi voluptate eos maxime exercitationem qui voluptatem enim aut excepturi dolor quo debitis architecto. In voluptatem adipisci et aliquid earum non internos inventore et nemo minima et voluptas voluptates aut sequi quos eos eligendi omnis. Qui necessitatibus odio aut sint iusto eos veritatis dolor quo porro temporibus\n  Para: A Gerência de Frota presta apoio técnico aos órgãos e entidades da Administração Pública Estadual em assuntos relacionados à gestão da frota oficial. Informações complementares, orientações técnicas e esclarecimentos poderão ser obtidos por meio dos canais institucionais da Secretaria de Administração (SAD). Quando necessário, as demandas deverão ser formalizadas no Sistema Eletrônico de Informações (SEI), conforme os procedimentos vigentes.\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Diego Santos Rolim 
cms3j4h3400152gginr207qji	2026-07-27 17:57:15.519	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrj6jz5h0016tspsfrh0gcht	FROTA	resumo:\n  De: A Gerência de Frota, \n  Para: A Gerência de Frota da SAD gere a frota oficial de Pernambuco, garantindo padronização, eficiência, economia e suporte técnico aos órgãos e entidades da Administração Pública do Estado.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cms4x621q001t2ggiyhpriffp	2026-07-28 17:18:10.141	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrthr36k000lmdi13kumqjbi	Superintendência de Energias Renováveis e Água	slug:\n  De: http://desktop-kh2lis7:5176/servicos\n  Para: teste\n\noQueE:\n  De: [sem texto]\n  Para: testandoooooo\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Diego Santos Rolim 
cms4xqjwn001w2ggio2fsaefk	2026-07-28 17:34:06.407	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrthr36k000lmdi13kumqjbi	ENERGIAS RENOVÁVEIS E ÁGUA	titulo:\n  De: Superintendência de Energias Renováveis e Água\n  Para: ENERGIAS RENOVÁVEIS E ÁGUA\n\nresumo:\n  De: Planejar, coordenar e executar ações voltadas às energias renováveis, à eficiência energética e ao uso racional da água, promovendo a sustentabilidade e a otimização dos recursos públicos no âmbito da Administração Pública Estadual.\n  Para: A Superintendência de Energias Renováveis e Água da Secretaria de Administração de Pernambuco atua na formulação, coordenação e execução de políticas voltadas à utilização de fontes renováveis, à eficiência energética e ao consumo racional de água nos imóveis de uso do Estado.\n\noQueE:\n  De: testandoooooo\n  Para: A Superintendência de Energias\nRenováveis e Água é a unidade responsável por propor, planejar, executar e\ncoordenar a política de energias renováveis no âmbito da Secretaria de\nAdministração do Estado de Pernambuco. Sua atuação compreende o\ndesenvolvimento de ações destinadas à melhoria da eficiência energética e\nhídrica dos imóveis utilizados pelos órgãos e entidades estaduais, mediante o\nacompanhamento do consumo, a orientação técnica aos gestores, a identificação\nde oportunidades de economia e o incentivo à adoção de práticas sustentáveis. A Superintendência também exerce\na gestão e a coordenação da concessão administrativa voltada à construção,\noperação, manutenção e gestão de usina de autoprodução de energia renovável,\nalém da aquisição de energia elétrica por meio do Ambiente de Contratação Livre\n– ACL. No âmbito de sua estrutura, a\nGerência de Eficiência Energética e Água é responsável por coordenar e executar\nas ações de eficiência energética e de consumo racional de água, capacitar os\ngestores responsáveis por esses serviços e fiscalizar e acompanhar a execução\nda concessão administrativa de energia renovável. A atuação conjunta das unidades\nbusca promover a redução de custos, o uso eficiente dos recursos públicos, a\nsustentabilidade ambiental e a melhoria contínua da gestão dos serviços de\nenergia elétrica e abastecimento de água no Poder Executivo Estadual.\n\nquemPrecisa:\n  De: [sem texto]\n  Para: Os serviços destinam-se aos órgãos e entidades integrantes do Poder Executivo Estadual que necessitem de apoio técnico, orientação, acompanhamento ou intervenção em assuntos relacionados à energia elétrica, ao abastecimento de água, à eficiência energética, à eficiência hídrica e à utilização de fontes renováveis.\r\nO atendimento poderá ser solicitado, entre outras situações, quando houver necessidade de:\r\n•\tanalisar o consumo ou o faturamento de energia elétrica e água;\r\n•\tidentificar aumentos atípicos de consumo ou possíveis desperdícios;\r\n•\tsolicitar orientação sobre contratos de fornecimento de energia e água;\r\n•\tavaliar a necessidade de alteração cadastral ou contratual de uma unidade consumidora;\r\n•\tobter apoio para a implantação de medidas de eficiência energética ou hídrica;\r\n•\tesclarecer dúvidas relacionadas ao Ambiente de Contratação Livre – ACL;\r\n•\tacompanhar unidades consumidoras contempladas pela concessão administrativa de energia renovável;\r\n•\tcapacitar ou atualizar os gestores responsáveis pelos serviços de energia e água;\r\n•\tdesenvolver ações de conscientização e consumo racional;\r\n•\tsolicitar apoio na interlocução com concessionárias, distribuidoras ou prestadores de serviços.\r\nO atendimento também poderá ocorrer por iniciativa da própria Superintendência, a partir do monitoramento dos indicadores de consumo, da análise de faturas ou da identificação de situações que demandem atuação preventiva ou corretiva.\n\ncomoSolicitar:\n  De: Testando TEXTO 01\n  Para: As demandas deverão ser encaminhadas pelo dirigente competente, pelo gestor de energia e água ou por servidor formalmente designado pelo órgão ou entidade interessada, utilizando os canais institucionais da Secretaria de Administração.\r\nQuando a natureza da solicitação exigir análise técnica, manifestação formal, acesso a documentos ou adoção de providências administrativas, a demanda deverá ser encaminhada por meio de processo no Sistema Eletrônico de Informações – SEI.\r\nA solicitação deverá apresentar, sempre que aplicável:\r\n•\tidentificação do órgão ou entidade solicitante;\r\n•\tidentificação da unidade consumidora;\r\n•\tdescrição objetiva da demanda;\r\n•\tnúmero da instalação, matrícula ou contrato;\r\n•\tendereço do imóvel;\r\n•\tfaturas e documentos relacionados;\r\n•\thistórico das providências já adotadas;\r\n•\tidentificação e contato do servidor responsável pelo acompanhamento.\r\nApós o recebimento, a Superintendência ou a Gerência competente realizará a análise da solicitação e adotará as providências cabíveis, observadas as atribuições institucionais, a legislação vigente, os contratos existentes e os procedimentos estabelecidos pela Secretaria de Administração.\n\nmaisInformacoes:\n  De: testando TEXTO\n  Para: A Superintendência de Energias Renováveis e Água e a Gerência de Eficiência Energética e Água prestam apoio técnico aos órgãos e entidades estaduais em matérias relacionadas à gestão de energia elétrica, energias renováveis, eficiência energética, abastecimento de água e consumo racional.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsda6rdx00382ggibuq1l71t	2026-08-03 13:44:47.395	diego.rolim@sad.pe.gov.br	UPDATE	Legislacao	cmruv8uzh0010d88344dlrlbp	Dispositivo à respeito da utilização de veículos oficiais.\t	linkExterno:\n  De: https://drive.google.com/file/d/128eTXoahK8E-REyJuYWpqNCSZjlP0X_p/view\n  Para: https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=47424&complemento=0&ano=2019&tipo=&url=\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Diego Santos Rolim 
cmsdahjzr003a2ggikx5j69n1	2026-08-03 13:53:11.029	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmsdahjzc00392ggiiw323ox6	Normas gerais relativas ao leilão de bens inservíveis, apreendidos ou abandonados.	Registro criado.
cmsdawi4c003c2ggiw939noz9	2026-08-03 14:04:48.442	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmsdawi3w003b2ggi4tasrthd	Dispositivo sobre o uso de veículos oficiais no âmbito do Poder Executivo Estadual.	Registro criado.
cmsdhb1wf006f2ggijn5z2jxb	2026-08-03 17:04:04.956	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	Nenhuma alteração detectada.
cmsf1erhq00742ggigs6kxsfx	2026-08-04 19:14:36.589	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmsf1erh500732ggiq52nfx24	Responsabilidade em casos de acidentes e infrações de trânsito com veículos oficiais	Registro criado.
cmsf1kara00762ggirfj3e39f	2026-08-04 19:18:54.837	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmsf1kaqv00752ggi89596jji	Especificações do veículos oficiais 	Registro criado.
cmsf1p65q00782ggiddaxrm6k	2026-08-04 19:22:42.157	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmsf1p65j00772ggii01ad3oe	Requisitos mínimos de qualificação relativos ao exercício da função de gestor nas especialidades de telemática, patrimônio e frota 	Registro criado.
cmsf1ry1u007a2ggimo8hu7bh	2026-08-04 19:24:51.612	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmsf1ry1600792ggiuhl1kjqu	Uso, identificação, aquisição, locação e cadastro dos veículos oficiais do Poder Executivo Estadual\t	Registro criado.
cmsixz6s1008p2ggi95ijn8de	2026-08-07 12:49:35.758	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	status:\n  De: PROGRAMADO\n  Para: REALIZADO\n\nlocal:\n  De: \n  Para: EGAPE - Escola de Governo da Administração Pública de Pernambuco\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsgez2qv007e2ggi8o97fb29	2026-08-05 18:22:05.478	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmq9sorix000qg5ahfulm0bn6	Contratos Corporativos	resumo:\n  De: A Gerência de Contratos Corporativos administra contratos compartilhados da Secretaria de Administração, promovendo economia de escala, padronização das contratações e maior eficiência na prestação dos serviços aos órgãos e entidades do Poder Executivo Estadual.\n  Para: A Gerência de Contratos Corporativos do Estado (GCCOR) coordena os procedimentos administrativos dos Contratos Corporativos (Contratos Mater), promovendo sua formalização, alterações e acompanhamento, além de padronizar procedimentos e orientar os órgãos e entidades aderentes.\n\noQueE:\n  De: A Gerência de Contratos Corporativos (GECOR/GGCOR) atua na gestão, acompanhamento e disponibilização de informações referentes aos contratos corporativos do Estado de Pernambuco, promovendo a padronização, eficiência e economicidade na contratação de serviços de uso comum pelos órgãos e entidades da Administração Pública Estadual. Este serviço disponibiliza orientações, informações contratuais, documentos de referência e apoio às unidades participantes dos contratos corporativos gerenciados pela Secretaria de Administração.\n  Para: Serviços oferecidos Elaboração de instrumentos contratuais Os instrumentos contratuais são os documentos que formalizam a relação entre as\npartes, estabelecendo o objeto da contratação, os valores, as obrigações, os\ndireitos, as penalidades aplicáveis e as demais condições específicas de cada\najuste. No âmbito dos Contratos Corporativos, destacam-se os seguintes instrumentos: • Termo de Adesão:  instrumento por meio do qual o órgão ou entidade aderente formaliza sua contratação junto ao Contrato Corporativo, sendo assinado pelo Interveniente\nPrincipal, pelo órgão aderente e pela contratada, assim como o termo aditivo, a\nseguir detalhado. • Termo Aditivo:  instrumento utilizado para promover alterações no Termo de Adesão, tais como modificações de quantitativos, valores, prazos, escopo ou dados cadastrais. • Termo de Apostilamento:  instrumento destinado à formalização de alterações que independem da celebração de Termo Aditivo, tais como reajustes contratuais, atualização da cobertura orçamentária mediante juntada das Notas de Empenho e, no âmbito dos Contratos\nCorporativos, a prorrogação da vigência do Termo de Adesão, desde que não haja\nalteração dos quantitativos ou dos valores originalmente contratados para o\nperíodo prorrogado.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsgfn6ud007g2ggi0d2m991z	2026-08-05 18:40:50.533	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmq9sorix000qg5ahfulm0bn6	Contratos Corporativos	quemPrecisa:\n  De: Órgãos e entidades integrantes da Administração Pública Estadual que necessitem consultar informações, orientações ou documentos relacionados aos contratos corporativos vigentes gerenciados pela Secretaria de Administração. O acesso ao serviço é necessário sempre que houver necessidade de adesão, utilização, acompanhamento, esclarecimentos ou consulta sobre contratos corporativos disponibilizados pelo Estado.\n  Para: O serviço é destinado aos órgãos e entidades da Administração Pública Estadual, bem como aos demais Poderes e instituições que figurem como Intervenientes Aderentes dos respectivos Contratos Corporativos.\n\ncomoSolicitar:\n  De: As solicitações relacionadas aos contratos corporativos devem ser encaminhadas à Gerência Geral de Serviços Corporativos (GGCOR), por meio dos canais institucionais disponibilizados pela Secretaria de Administração. Para atendimento, o órgão interessado deverá informar o contrato corporativo desejado, a demanda apresentada e os dados necessários para análise e orientação pela equipe responsável.\n  Para: Termo de Adesão \r\nQuando a formalização de novo Termo de Adesão decorrer da substituição de instrumento cuja vigência esteja próxima do encerramento, em razão da impossibilidade de prorrogação do respectivo Contrato Corporativo, a Gerência de Contratos Corporativos iniciará o procedimento de forma centralizada, encaminhando aos órgãos e entidades aderentes o respectivo  Adendo , contendo os serviços e quantitativos inicialmente propostos, elaborados com base no Termo de Adesão vigente. Caberá ao órgão aderente analisar as informações constantes do Adendo e, caso necessário, solicitar ajustes nos quantitativos, bem como a inclusão ou exclusão de serviços, observadas as diretrizes da contratação corporativa. Nas demais hipóteses em que se pretenda formalizar novo Termo de Adesão não decorrente da substituição de instrumento vigente, o órgão ou entidade interessada deverá encaminhar ofício, por meio do Sistema SEI, à Gerência Geral de Serviços Corporativos, contendo: •\tjustificativa da contratação;\r\n•\tespecificação dos serviços pretendidos;\r\n•\tquantitativos estimados. Além da Nota de Empenho destinada à cobertura da contratação, deverão ser apresentados os demais documentos exigidos pelos normativos vigentes, dentre os quais a comprovação de que a contratação está prevista no Plano de Contratações Anual (PCA) e, quando aplicável, a autorização da Câmara de Programação Financeira (CPF), nos termos da Resolução CPF nº 001/2026.\r A relação completa da documentação exigida será informada pela Gerência de Contratos Corporativos quando do encaminhamento do respectivo Adendo. Termo Aditivo Os pedidos de formalização de Termo Aditivo para acréscimo ou supressão de quantitativos deverão ser encaminhados à Gerência Geral de Serviços Corporativos - GGCOR, por meio do Sistema SEI, contendo: •\tjustificativa da alteração;\r\n•\tserviços a serem acrescidos ou suprimidos;\r\n•\tquantitativos correspondentes.\r A solicitação será submetida à análise das áreas técnicas competentes (Gerência de Frota ou Gerência de Telemática), com participação da Agência Estadual de Tecnologia da Informação (ATI), quando envolver alterações técnicas relacionadas aos serviços de conectividade, como aumento de velocidade de links (ADC e/ou ADE).\r Sendo a demanda considerada tecnicamente viável e havendo saldo disponível no Contrato Corporativo, será encaminhado ao órgão aderente novo Adendo contemplando as alterações pretendidas, para validação e posterior emissão da Nota de Empenho correspondente.\r Além da Nota de Empenho, deverão ser apresentados os documentos exigidos pela legislação e pelos normativos vigentes, inclusive a comprovação de que a despesa encontra-se prevista no Plano de Contratações Anual (PCA) e, quando aplicável, a autorização da Câmara de Programação Financeira (CPF). A documentação necessária será informada pela Gerência de Contratos Corporativos quando do encaminhamento do respectivo Adendo. Termo de Apostilamento \r Cobertura orçamentária \r Para apostilamento das Notas de Empenho destinadas à cobertura financeira dos respectivos Termos de Adesão, o órgão aderente deverá anexar os documentos ao processo SEI correspondente, acompanhado de solicitação de apostilamento dirigida à Gerência de Contratos Corporativos - GCCOR.\r Prorrogação de vigência \r Nos casos de prorrogação da vigência do Termo de Adesão, sem alteração de quantitativos e valores, caberá ao órgão aderente encaminhar:\r •\tNota de Empenho correspondente ao novo período;\r\n•\tcomprovação de que a prorrogação está contemplada no Plano de Contratações Anual (PCA);\r\n•\tdemais documentos exigidos pelos normativos vigentes.\r Por se tratar de procedimento periódico, a Gerência de Contratos Corporativos iniciará previamente o processo, encaminhando aos órgãos aderentes o respectivo Adendo e a relação da documentação necessária.\r Reajuste contratual \r Quando houver reajuste do Contrato Corporativo, a Secretaria de Administração comunicará formalmente os órgãos aderentes, que deverão providenciar a emissão da Nota de Empenho correspondente ao acréscimo financeiro do respectivo Termo de Adesão, para posterior formalização do apostilamento.\n\nmaisInformacoes:\n  De: A Gerência de Contratos Corporativos (GCCOR) é a unidade responsável, vinculada à Gerência Geral de Serviços Corporativos (GGCOR) da Secretaria de Administração do Estado de Pernambuco (SAD). A Gerência de Contratos Corporativos é responsável pela gestão estratégica dos contratos de natureza corporativa do Estado, promovendo a padronização das contratações, a otimização dos recursos públicos e o suporte aos órgãos e entidades participantes.\n  Para: Em caso de dúvidas, entre em contato com a Gerência de Contratos Corporativos (GCCOR) pelo telefone (81) 3183-7774.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsggm0x7007h2ggiq3fzc672	2026-08-05 19:07:55.817	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrthr36k000lmdi13kumqjbi	ENERGIAS RENOVÁVEIS E ÁGUA	oQueE:\n  De: A Superintendência de Energias\nRenováveis e Água é a unidade responsável por propor, planejar, executar e\ncoordenar a política de energias renováveis no âmbito da Secretaria de\nAdministração do Estado de Pernambuco. Sua atuação compreende o\ndesenvolvimento de ações destinadas à melhoria da eficiência energética e\nhídrica dos imóveis utilizados pelos órgãos e entidades estaduais, mediante o\nacompanhamento do consumo, a orientação técnica aos gestores, a identificação\nde oportunidades de economia e o incentivo à adoção de práticas sustentáveis. A Superintendência também exerce\na gestão e a coordenação da concessão administrativa voltada à construção,\noperação, manutenção e gestão de usina de autoprodução de energia renovável,\nalém da aquisição de energia elétrica por meio do Ambiente de Contratação Livre\n– ACL. No âmbito de sua estrutura, a\nGerência de Eficiência Energética e Água é responsável por coordenar e executar\nas ações de eficiência energética e de consumo racional de água, capacitar os\ngestores responsáveis por esses serviços e fiscalizar e acompanhar a execução\nda concessão administrativa de energia renovável. A atuação conjunta das unidades\nbusca promover a redução de custos, o uso eficiente dos recursos públicos, a\nsustentabilidade ambiental e a melhoria contínua da gestão dos serviços de\nenergia elétrica e abastecimento de água no Poder Executivo Estadual.\n  Para: A Superintendência de Energias Renováveis e Água é a unidade responsável por propor, planejar, executar e coordenar a política de energias renováveis no âmbito da Secretaria de Administração do Estado de Pernambuco.\r Sua atuação compreende o desenvolvimento de ações destinadas à melhoria da eficiência energética e hídrica dos imóveis utilizados pelos órgãos e entidades estaduais dependentes do Tesouro, mediante o acompanhamento do consumo, a orientação técnica aos gestores setoriais, a identificação de oportunidades de economia e o incentivo à adoção de práticas sustentáveis alinhadas com o Plano de Descarbonização do Estado de Pernambuco,com a Transição Energética Nacional e com os Objetivos de Desenvolvimento Sustentável da ONU.\r A Superintendência também exerce a gestão e a coordenação da concessão administrativa voltada à construção, operação, manutenção e gestão de usina de autoprodução de energia renovável, além da aquisição de energia elétrica por meio do Ambiente de Contratação Livre – ACL (PPP – Usina Solar).\r No âmbito de sua estrutura, a Gerência de Eficiência Energética e Água é responsável por coordenar e executar as ações de eficiência energética e de consumo racional de água, capacitar os gestores responsáveis por esses serviços e fiscalizar e acompanhar a execução da concessão administrativa de energia renovável.\r A atuação conjunta das unidades busca promover a redução de custos, o uso eficiente dos recursos públicos, a sustentabilidade ambiental e a melhoria contínua da gestão dos serviços de energia elétrica e abastecimento de água no Poder Executivo Estadual.\n\nquemPrecisa:\n  De: Os serviços destinam-se aos órgãos e entidades integrantes do Poder Executivo Estadual que necessitem de apoio técnico, orientação, acompanhamento ou intervenção em assuntos relacionados à energia elétrica, ao abastecimento de água, à eficiência energética, à eficiência hídrica e à utilização de fontes renováveis.\r\nO atendimento poderá ser solicitado, entre outras situações, quando houver necessidade de:\r\n•\tanalisar o consumo ou o faturamento de energia elétrica e água;\r\n•\tidentificar aumentos atípicos de consumo ou possíveis desperdícios;\r\n•\tsolicitar orientação sobre contratos de fornecimento de energia e água;\r\n•\tavaliar a necessidade de alteração cadastral ou contratual de uma unidade consumidora;\r\n•\tobter apoio para a implantação de medidas de eficiência energética ou hídrica;\r\n•\tesclarecer dúvidas relacionadas ao Ambiente de Contratação Livre – ACL;\r\n•\tacompanhar unidades consumidoras contempladas pela concessão administrativa de energia renovável;\r\n•\tcapacitar ou atualizar os gestores responsáveis pelos serviços de energia e água;\r\n•\tdesenvolver ações de conscientização e consumo racional;\r\n•\tsolicitar apoio na interlocução com concessionárias, distribuidoras ou prestadores de serviços.\r\nO atendimento também poderá ocorrer por iniciativa da própria Superintendência, a partir do monitoramento dos indicadores de consumo, da análise de faturas ou da identificação de situações que demandem atuação preventiva ou corretiva.\n  Para: Os serviços destinam-se aos órgãos e entidades integrantes do Poder Executivo Estadual que necessitem de apoio técnico, orientação, acompanhamento ou intervenção em assuntos relacionados à energia elétrica, ao abastecimento de água, à eficiência energética, à eficiência hídrica e à utilização de fontes renováveis.\r O atendimento poderá ser solicitado, entre outras situações, quando houver necessidade de:\r •\tanalisar o consumo ou o faturamento de energia elétrica e água;\r •\tidentificar aumentos atípicos de consumo ou possíveis desperdícios;\r •\tsolicitar orientação sobre contratos de fornecimento de energia e água;\r •\tavaliar a necessidade de alteração cadastral ou contratual de uma unidade consumidora;\r •\tobter apoio para a implantação de medidas de eficiência energética ou hídrica;\r •\tesclarecer dúvidas relacionadas ao Ambiente de Contratação Livre – ACL;\r •\tacompanhar unidades consumidoras contempladas pela concessão administrativa de energia renovável(PPP – Usina Solar);\r •\tcapacitar ou atualizar os gestores responsáveis pelos serviços de energia e água;\r •\tdesenvolver ações de conscientização e consumo racional;\r •\tsolicitar apoio na interlocução com concessionárias, distribuidoras ou prestadores de serviços.\r O atendimento também poderá ocorrer por iniciativa da própria Superintendência, a partir do monitoramento dos indicadores de consumo, da análise de faturas e/ou da identificação de situações que demandem atuação preventiva ou corretiva.\n\ncomoSolicitar:\n  De: As demandas deverão ser encaminhadas pelo dirigente competente, pelo gestor de energia e água ou por servidor formalmente designado pelo órgão ou entidade interessada, utilizando os canais institucionais da Secretaria de Administração.\r\nQuando a natureza da solicitação exigir análise técnica, manifestação formal, acesso a documentos ou adoção de providências administrativas, a demanda deverá ser encaminhada por meio de processo no Sistema Eletrônico de Informações – SEI.\r\nA solicitação deverá apresentar, sempre que aplicável:\r\n•\tidentificação do órgão ou entidade solicitante;\r\n•\tidentificação da unidade consumidora;\r\n•\tdescrição objetiva da demanda;\r\n•\tnúmero da instalação, matrícula ou contrato;\r\n•\tendereço do imóvel;\r\n•\tfaturas e documentos relacionados;\r\n•\thistórico das providências já adotadas;\r\n•\tidentificação e contato do servidor responsável pelo acompanhamento.\r\nApós o recebimento, a Superintendência ou a Gerência competente realizará a análise da solicitação e adotará as providências cabíveis, observadas as atribuições institucionais, a legislação vigente, os contratos existentes e os procedimentos estabelecidos pela Secretaria de Administração.\n  Para: As demandas deverão ser encaminhadas pelo dirigente competente, pelo gestor de energia e água ou por servidor formalmente designado pelo órgão ou entidade interessada, utilizando os canais institucionais da Secretaria de Administração.\r Quando a natureza da solicitação exigir análise técnica, manifestação formal, acesso a documentos ou adoção de providências administrativas, a demanda deverá ser encaminhada por meio de processo no Sistema Eletrônico de Informações – SEI.\r A solicitação deverá apresentar, sempre que aplicável:\r •\tidentificação do órgão ou entidade solicitante;\r •\tidentificação da unidade consumidora;\r •\tdescrição objetiva da demanda;\r •\tnúmero da instalação, matrícula ou conta contrato;\r •\tendereço do imóvel;\r •\tfaturas e documentos relacionados;\r •\thistórico das providências já adotadas;\r •\tidentificação e contato do servidor responsável pelo acompanhamento.\r Após o recebimento, a Superintendência ou a Gerência competente realizará a análise da solicitação e adotará as providências cabíveis, observadas as atribuições institucionais, a legislação vigente, os contratos existentes e os procedimentos estabelecidos pela Secretaria de Administração.\n\nmaisInformacoes:\n  De: A Superintendência de Energias Renováveis e Água e a Gerência de Eficiência Energética e Água prestam apoio técnico aos órgãos e entidades estaduais em matérias relacionadas à gestão de energia elétrica, energias renováveis, eficiência energética, abastecimento de água e consumo racional.\n  Para: A Superintendência de Energias Renováveis e Água e a Gerência de Eficiência Energética e Água prestam apoio técnico aos órgãos e entidades estaduais em matérias relacionadas à gestão de energia elétrica, energias renováveis, eficiência energética, abastecimento de água e consumo racional. Em 2025, a Superintendência foi vencedora do concurso nacional “Inovação no Setor Público”, promovido pela Escola Nacional de Administração Pública (ENAP) e também foi selecionada para apresentar o projeto/contrato da Usina Solar (PPP) por ocasião do CONSAD, que culminou com a publicação de artigo. Podendo ser contactada por meio do ramal institucional 3183-7720.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmshl7kro007m2ggirivzyp26	2026-08-06 14:04:25.954	diego.rolim@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmreyx3540010tsps2t8u6l90	Sem título	muralTextoIntrodutorio:\n  De: A área de Serviços Corporativos da Secretaria de Administração do Estado de Pernambuco é responsável por planejar, coordenar e aprimorar serviços compartilhados que dão suporte ao funcionamento da Administração Pública Estadual, promovendo eficiência operacional, padronização de processos e otimização dos recursos públicos.\n\nNossa atuação busca oferecer soluções integradas que atendam às necessidades dos órgãos e entidades estaduais, contribuindo para uma gestão mais moderna, transparente e orientada por resultados. Por meio da implementação de políticas, normas e ferramentas de gestão, fortalecemos a prestação de serviços corporativos essenciais ao desempenho das atividades governamentais.\n  Para: A área de Serviços Corporativos da Secretaria de Administração do Estado de Pernambuco é responsável por planejar, disciplinar, coordenar, executar e acompanhar as políticas públicas administrativas relacionadas à gestão dos serviços corporativos, nos temas Telemática, Frota, Energia (PPP e eficiência energética) e Água, no âmbito da Administração Pública Estadual.\n\nNossa atuação busca oferecer soluções integradas que atendam às necessidades dos órgãos e entidades estaduais, contribuindo para uma gestão mais moderna, transparente e orientada por resultados. 
cmshlwztx007n2ggic4ywul5e	2026-08-06 14:24:11.875	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	titulo:\n  De: Lorem ipsum dolor sit amet.\n  Para: Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026\n\nsubtitulo:\n  De: Et corrupti alias est voluptas error est delectus porro et praesentium explicabo\n  Para: 81% da meta anual atingida em maio de 2026\n\nsubareaId:\n  De: vazio\n  Para: cmrtn2i7v0000bqr5csm0w82l\n\ncorpo:\n  De: Lorem ipsum dolor sit amet. Sit repellendus consectetur sit placeat vero aut accusamus molestiae et quia ipsum in Quis fugiat? Est veniam iste nam quia sunt aut saepe harum est similique unde? In dolorem illum ad inventore commodi in tempore nemo? Id voluptatem accusamus id optio nostrum ut recusandae dolor ut explicabo quia in deserunt totam ut quaerat incidunt aut molestias quisquam.\n  Para: A Gerência Geral de Contratos Corporativos (GGCOR), por meio da gestão da Arrecadação com Leilões de Bens Móveis, alcançou um resultado expressivo nos cinco primeiros meses de 2026. Até maio, a arrecadação acumulada atingiu R$ 3,455 milhões, o que representa 81% da meta anual estabelecida de R$ 4,276 milhões. O desempenho demonstra a efetividade das ações desenvolvidas para a destinação de bens móveis inservíveis da Administração Pública Estadual, contribuindo para a otimização da gestão patrimonial, a racionalização dos ativos públicos e o incremento da arrecadação estadual. De acordo com os dados do acompanhamento mensal, o resultado acumulado mantém trajetória de crescimento ao longo do ano, restando R$ 0,83 milhão para o alcance da meta prevista para 2026. O monitoramento contínuo desse indicador reforça o compromisso da GGCOR com a eficiência na gestão dos bens públicos, promovendo maior transparência, sustentabilidade e geração de receitas para o Estado de Pernambuco.
cmshly0gf007o2ggiz4waqdt9	2026-08-06 14:24:59.341	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	subtitulo:\n  De: 81% da meta anual atingida em maio de 2026\n  Para: 
cmshly3gf007p2ggidxue7ttm	2026-08-06 14:25:03.229	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	subtitulo:\n  De: \n  Para: tetetete
cmshlydru007q2ggisopcxfda	2026-08-06 14:25:16.601	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	subtitulo:\n  De: tetetete\n  Para: 81% da meta anual atingida em maio de 2026
cmshm7g0n007r2ggijwle9giu	2026-08-06 14:32:19.414	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	corpo:\n  De: A Gerência Geral de Contratos Corporativos (GGCOR), por meio da gestão da Arrecadação com Leilões de Bens Móveis, alcançou um resultado expressivo nos cinco primeiros meses de 2026. Até maio, a arrecadação acumulada atingiu R$ 3,455 milhões, o que representa 81% da meta anual estabelecida de R$ 4,276 milhões. O desempenho demonstra a efetividade das ações desenvolvidas para a destinação de bens móveis inservíveis da Administração Pública Estadual, contribuindo para a otimização da gestão patrimonial, a racionalização dos ativos públicos e o incremento da arrecadação estadual. De acordo com os dados do acompanhamento mensal, o resultado acumulado mantém trajetória de crescimento ao longo do ano, restando R$ 0,83 milhão para o alcance da meta prevista para 2026. O monitoramento contínuo desse indicador reforça o compromisso da GGCOR com a eficiência na gestão dos bens públicos, promovendo maior transparência, sustentabilidade e geração de receitas para o Estado de Pernambuco.\n  Para: A Gerência Geral de Serviços Corporativos, através da Gerência de Frota por meio da gestão da Arrecadação com Leilões de Bens Móveis, alcançou um resultado expressivo nos cinco primeiros meses de 2026. Até maio, a arrecadação acumulada atingiu R$ 3,455 milhões, o que representa 81% da meta anual estabelecida de R$ 4,276 milhões. O desempenho demonstra a efetividade das ações desenvolvidas para a destinação de bens móveis inservíveis da Administração Pública Estadual, contribuindo para a otimização da gestão patrimonial, a racionalização dos ativos públicos e o incremento da arrecadação estadual. De acordo com os dados do acompanhamento mensal, o resultado acumulado mantém trajetória de crescimento ao longo do ano, restando R$ 0,83 milhão para o alcance da meta prevista para 2026. O monitoramento contínuo desse indicador reforça o compromisso da GGCOR com a eficiência na gestão dos bens públicos, promovendo maior transparência, sustentabilidade e geração de receitas para o Estado de Pernambuco.
cmshmkwog007s2ggin8vbkvqr	2026-08-06 14:42:47.535	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	subtitulo:\n  De: 81% da meta anual atingida em maio de 2026\n  Para: 81% da meta de arrecadação com leilões de bens móveis anual atingida em maio de 2026\n\nresumo:\n  De: Lorem ipsum dolor sit amet. Sit repellendus consectetur sit placeat vero aut accusamus molestiae et quia ipsum in Quis fugiat\n  Para: 81% da meta de arrecadação com leilões de bens móveis anual atingida em maio de 2026
cmshq7pg4007t2ggiiuvq1z3u	2026-08-06 16:24:30.092	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	resumo:\n  De: 81% da meta de arrecadação com leilões de bens móveis anual atingida em maio de 2026\n  Para: TESTE
cmshqc74r007u2ggik76iv7tu	2026-08-06 16:27:59.641	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	subtitulo:\n  De: 81% da meta de arrecadação com leilões de bens móveis anual atingida em maio de 2026\n  Para: Arrecadação acumulada atingiu R$ 3,455 milhões até o mês de maio de 2026.\n\nresumo:\n  De: TESTE\n  Para: 81% da meta de arrecadação com leilões de bens móveis anual atingida em maio de 2026
cmshqf5ff007w2ggiyv08pnxz	2026-08-06 16:30:17.401	diego.rolim@sad.pe.gov.br	DELETE	Noticia	cmq9thhu6001rg5ahvty8whzn	Lorem	Registro excluído.
cmshqqlhw007x2ggil8l6w6ju	2026-08-06 16:39:11.442	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	imagemPrincipal_id:\n  De: AhPZfbvqCsycGS3e0CoBfw\n  Para: DRIQLcH4MML450BOZvjNDg\n\nimagemPrincipal_filesize:\n  De: 2790629\n  Para: 2275162\n\nimagemPrincipal_width:\n  De: 6000\n  Para: 1376\n\nimagemPrincipal_height:\n  De: 4000\n  Para: 768\n\nimagemPrincipal_extension:\n  De: jpg\n  Para: png
cmshqxrus007z2ggi82oix97u	2026-08-06 16:44:46.275	diego.rolim@sad.pe.gov.br	CREATE	Noticia		GraphQLError	Registro criado.
cmshqy18x00812ggihl1qwdaj	2026-08-06 16:44:58.448	diego.rolim@sad.pe.gov.br	CREATE	Noticia		GraphQLError	Registro criado.
cmshqztou00832ggiy5xu430s	2026-08-06 16:46:21.961	diego.rolim@sad.pe.gov.br	CREATE	Noticia		GraphQLError	Registro criado.
cmshr0jez00852ggim4gyaq2a	2026-08-06 16:46:55.306	diego.rolim@sad.pe.gov.br	CREATE	Noticia	cmshr0jeb00842ggi69t9qoil	Gerência de Frota alcança 55,31% da meta anual de economia com a manutenção da frota até maio de 2026	Registro criado.
cmshr5ev900862ggil30wcd0l	2026-08-06 16:50:42.693	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	dataPublicacao:\n  De: [objeto]\n  Para: [objeto]
cmshrk57900882ggihvvxo6sf	2026-08-06 17:02:10.004	diego.rolim@sad.pe.gov.br	CREATE	Noticia	cmshrk56r00872ggi2kh44cst	Superintendência de Energias Renováveis alcança R$ 1,8 milhão em economia com a migração para o Mercado Livre de Energia até março de 2026	Registro criado.
cmshrs45w00892ggi02g0sdwf	2026-08-06 17:08:21.907	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmshr0jeb00842ggi69t9qoil	Gerência de Frota alcança 55,31% da meta anual de economia com a manutenção da frota até maio de 2026	imagemPrincipal_id:\n  De: ed98DSrVSY3nIEwerGd2sw\n  Para: Qx9xIdRV4_fMdrzeSJjCZg\n\nimagemPrincipal_filesize:\n  De: 5864482\n  Para: 3711798\n\nimagemPrincipal_width:\n  De: 4160\n  Para: 5760\n\nimagemPrincipal_height:\n  De: 6240\n  Para: 3840
cmshx7op1008d2ggiv0tqxpm8	2026-08-06 19:40:26.436	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	titulo:\n  De: GESTÃO E FISCALIZAÇÃO DE CONTRATOS ADMINISTRATIVOS SOB A ÓTICA DA NOVA LEI DE LICITAÇÕES E CONTRATOS (LEI FEDERAL Nº 14.133/2021) - 20 h/a\n  Para: Gestão de Patrimônio Móvel - uso do Pe Integrado\n\nstatus:\n  De: PROGRAMADO\n  Para: REALIZADO\n\nresumo:\n  De: Gestão e fiscalização de contratos administrativos.\n  Para: Ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI. \n\nsubareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nlocal:\n  De: \n  Para: A realiza-se na EGAPE\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Allan Soares\n  Para: Agelson Santana
cmshxbbaf008e2ggionbij4eh	2026-08-06 19:43:15.686	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	local:\n  De: A realiza-se na EGAPE\n  Para: Se realizará na EGAPE - Escola de Governo da Administração Pública de Pernambuco\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixhusd008g2ggiitmdvh48	2026-08-07 12:36:07.068	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI. \n  Para: Regras e procedimentos do Patrimônio Móvel Estadual\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixiex7008h2ggiop8o4kol	2026-08-07 12:36:33.161	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos do Patrimônio Móvel Estadual\n  Para: Regras e procedimentos do Patrimônio Móvel Estadual\n\n\n\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixizdo008i2ggi4thc3yry	2026-08-07 12:36:59.675	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos do Patrimônio Móvel Estadual\n\n\n\n  Para: Regras e procedimentos do Patrimônio Móvel Estadual\n            \n              \n               \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixjg30008j2ggim0vxypx6	2026-08-07 12:37:21.323	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos do Patrimônio Móvel Estadual\n            \n              \n               \n  Para: Regras e procedimentos do Patrimônio Móvel Estadual.\n            .\n             . \n               \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixk22u008k2ggigeh3f94d	2026-08-07 12:37:49.828	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos do Patrimônio Móvel Estadual.\n            .\n             . \n               \n  Para: Regras e procedimentos\n               \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixkafy008l2ggix3222v72	2026-08-07 12:38:00.669	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos\n               \n  Para: Regras e procedimentos\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixknz5008m2ggi30o6z2hm	2026-08-07 12:38:18.207	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos\n  Para: Regras e procedimentos do Patrimônio Móvel\n               \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixl4my008n2ggivgrbmb5r	2026-08-07 12:38:39.801	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	local:\n  De: Se realizará na EGAPE - Escola de Governo da Administração Pública de Pernambuco\n  Para: EGAPE - Escola de Governo da Administração Pública de Pernambuco\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsixq24m008o2ggideqhakfi	2026-08-07 12:42:29.825	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	status:\n  De: PROGRAMADO\n  Para: REALIZADO\n\nsubareaId:\n  De: cmq9j1frn0000boamvyqh9qnc\n  Para: cmqgnv5xk00003adnqj7bkkdv\n\nlocal:\n  De: Egape - R. Tabira, 252 - Boa Vista, Recife - PE, 50050-330\n  Para: EGAPE - Escola de Governo da Administração Pública de Pernambuco\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: user teste\n  Para: Agelson Santana
cmsj1imz3009n2ggi95hjnvt7	2026-08-07 14:28:42.062	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj1imyw009m2ggicw6z7imc	INSTRUTORIA INTERNA	Registro criado.
cmsiy4j1x008q2ggi52kpn31i	2026-08-07 12:53:44.948	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	resumo:\n  De: Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI e seu passo a passo.\n  Para: Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiy4zwn008s2ggilwbbx5ir	2026-08-07 12:54:06.79	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS (uso PEI)	Registro criado.
cmsiyabs0008t2ggipmmndo1w	2026-08-07 12:58:15.454	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	dataDoCurso:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiyd0sz008u2gginkfkjas1	2026-08-07 13:00:21.202	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS (uso PEI)	linkExterno:\n  De: https://www.egape.pe.gov.br/cursos\n  Para: https://www.egape.pe.gov.br/cursos/152-cursos/91-inscricoes-em-cursos-presenciais\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsiyopo0008v2ggidy13rvrt	2026-08-07 13:09:26.639	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS (uso PEI)	resumo:\n  De: Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI.\n  Para: Regras e procedimentos do Patrimônio Imobiliário\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiypon6008w2ggii4e6uzim	2026-08-07 13:10:11.969	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	resumo:\n  De: Neste Curso estaremos ensinando as regras de negócio e seus fluxos, como também o manuseio do Sistema PEI.\n  Para: Regras e procedimentos do Patrimônio Imobiliário\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiyqiu8008x2ggiepjwbgaw	2026-08-07 13:10:51.098	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	resumo:\n  De: Procedimento de desfazimento\n  Para: Procedimento de desfazimento Patrimônio Móvel\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiysyq5008y2gginhq5ciek	2026-08-07 13:12:45	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	resumo:\n  De: Procedimento de desfazimento Patrimônio Móvel\n  Para: Procedimentos de Desfazimento Patrim. Móvel\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiyvqea008z2ggi7mcwizrq	2026-08-07 13:14:54.167	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	resumo:\n  De: Procedimentos de Desfazimento Patrim. Móvel\n  Para: Procedimentos de Desfazimentos\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiyws5800902ggiwwnli45k	2026-08-07 13:15:43.099	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS (uso PEI)	resumo:\n  De: Regras e procedimentos do Patrimônio Imobiliário\n  Para: Procedimentos e Usabilidade\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiyxbgj00912ggitx8o7rs2	2026-08-07 13:16:08.13	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos do Patrimônio Imobiliário\n  Para: Procedimentos e Usabilidade\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsiyxlq400922ggiilqwa7if	2026-08-07 13:16:21.434	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	resumo:\n  De: Regras e procedimentos do Patrimônio Móvel\n               \n  Para: Procedimentos e Usabilidade               \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsizb6dh00942ggi91vmbqk8	2026-08-07 13:26:54.723	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsizb6d800932ggi3h6kdzf4	Sistema PE Integrado (EAD autoinstrucional)	Registro criado.
cmsizfttf00952ggii65qigme	2026-08-07 13:30:31.729	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	linkExterno:\n  De: https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf\n  Para: https://www.egape.pe.gov.br/cursos/160-cronogramas/594-cronogramas-2026\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsizg3h600962ggibzogay2t	2026-08-07 13:30:44.248	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgr89vx000011bmsh1k9vov	Desfazimento	linkExterno:\n  De: https://legis.alepe.pe.gov.br/texto.aspx?id=15359&tipo=TEXTOORIGINAL\n  Para: https://www.egape.pe.gov.br/cursos/160-cronogramas/594-cronogramas-2026\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsizgwbj00972ggibfa8rujp	2026-08-07 13:31:21.63	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	linkExterno:\n  De: https://www.egape.pe.gov.br/cursos\n  Para: https://www.egape.pe.gov.br/cursos/160-cronogramas/594-cronogramas-2026\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsizm1r200992ggixncxgmqq	2026-08-07 13:35:21.942	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsizm1qo00982ggi15o3vc2f	Sistema PE Integrado (EAD com Tutoria)	Registro criado.
cmsj00u09009b2ggio7kg42cz	2026-08-07 13:46:51.752	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj00u01009a2ggiaxgj42ah	AGENDA DE CURSOS EGAPE - AGOSTO	Registro criado.
cmsj0peu0009c2ggiqievmsuy	2026-08-07 14:05:58.487	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj00u01009a2ggiaxgj42ah	AGENDA DE CURSOS EGAPE - AGOSTO	resumo:\n  De: Aqui você acessa os cursos que estão disponíveis no mês atual, em sua respectivas modalidades.\n  Para: Aqui você acessa todos os cursos que estão disponíveis no mês e sua modalidades.\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsj0qj9k009d2ggilgp1pdan	2026-08-07 14:06:50.882	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj00u01009a2ggiaxgj42ah	AGENDA DE CURSOS - EGAPE	titulo:\n  De: AGENDA DE CURSOS EGAPE - AGOSTO\n  Para: AGENDA DE CURSOS - EGAPE\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsj0yq4n009f2ggiptaex9qs	2026-08-07 14:13:13.03	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj0yq48009e2ggiqg6ombho	MANUAL DO ALUNO - EGAPE	Registro criado.
cmsj10yqk009g2ggiti9f1nam	2026-08-07 14:14:57.499	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj00u01009a2ggiaxgj42ah	AGENDA DE CURSOS - EGAPE	resumo:\n  De: Aqui você acessa todos os cursos que estão disponíveis no mês e sua modalidades.\n  Para: Acesso de todos os cursos que estão disponíveis no mês e sua modalidades.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsj11d0y009h2ggi7yzcrd0b	2026-08-07 14:15:16.015	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj00u01009a2ggiaxgj42ah	AGENDA DE CURSOS - EGAPE	resumo:\n  De: Acesso de todos os cursos que estão disponíveis no mês e sua modalidades.\n  Para: Acesso de todos os cursos que estão disponíveis no mês e sua modalidade.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsj1c929009j2ggicce8yheh	2026-08-07 14:23:44.096	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj1c925009i2ggiuonnd2lc	O que é Educação Corporativa?	Registro criado.
cmsj1erkq009l2gginpaqgpah	2026-08-07 14:25:41.394	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj1erkl009k2ggid88mmeza	Escolas Corporativas do Estado	Registro criado.
cmsj21nhd009s2ggimjg0dqoq	2026-08-07 14:43:29.184	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1vigh009q2ggi044hoxig	Paceria EGAPE x ENAP	dataDoCurso:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsj25jag009t2ggi1ytsakdy	2026-08-07 14:46:30.375	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS (uso PEI)	resumo:\n  De: Procedimentos e Usabilidade\n  Para: Procedimentos e usabilidade\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsj2rno0009v2ggi51budr5i	2026-08-07 15:03:42.479	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmsj2rnnq009u2ggic98trtic	QUER SE CANDIDATA A INSTRUTOR INTERNO?	Registro criado.
cmsj2tw04009w2ggig5wuz23z	2026-08-07 15:05:26.589	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1imyw009m2ggicw6z7imc	O que é Instrutoria Interna?	titulo:\n  De: INSTRUTORIA INTERNA\n  Para: O que é Instrutoria Interna?\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsj2up3n009x2ggiz7dg9g14	2026-08-07 15:06:04.3	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1c925009i2ggiuonnd2lc	Qual a definição de Educação Corporativa?	titulo:\n  De: O que é Educação Corporativa?\n  Para: Qual a definição de Educação Corporativa?\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsj2vl6r009y2ggi81e0a510	2026-08-07 15:06:45.889	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj0yq48009e2ggiqg6ombho	Manual do Aluno - EGAPE	titulo:\n  De: MANUAL DO ALUNO - EGAPE\n  Para: Manual do Aluno - EGAPE\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsj61gaz00a02ggir0mz84ny	2026-08-07 16:35:18.346	agelson.santana@sad.pe.gov.br	UPDATE	Servico	cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	maisInformacoes:\n  De: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone: 3183-7731 ou 3183-7739 E-mail:\n  Para: Contato Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo: Telefone:  3183-7731 ou 3183-7739 E-mail:\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: user teste\n  Para: Agelson Santana
cmsj6o9de00a62ggi1n40ztww	2026-08-07 16:53:02.449	agelson.santana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	maisInformacoes:\n  De: Esclarecimentos adicionais podem ser obtidos nos seguintes contatos: (81)3183-7739 e gestaoimobiliaria@sad.pe.gov.br.\n  Para: Esclarecimentos adicionais podem ser obtidos nos seguintes contatos: (81) 3183-7739 e gestaoimobiliaria@sad.pe.gov.br.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: user teste\n  Para: Agelson Santana
cmsj6vt4u00a82ggil3qafjmn	2026-08-07 16:58:54.651	agelson.santana@sad.pe.gov.br	UPDATE	Solucao	cmi3h5i7b0005vwpm6wngrtl4	GeoPE	resumo:\n  De: Plataforma de georreferenciamento dos imóveis do Estado de Pernambuco\n  Para: Plataforma de geolocalização dos imóveis do Estado de Pernambuco
cmsj6z8nj00a92ggil5nhy16y	2026-08-07 17:01:34.734	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj00u01009a2ggiaxgj42ah	Agenda de Cursos - EGAPE	titulo:\n  De: AGENDA DE CURSOS - EGAPE\n  Para: Agenda de Cursos - EGAPE\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsj7023600aa2ggiyvy328yw	2026-08-07 17:02:12.881	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj2rnnq009u2ggic98trtic	Quer se candidatar a Instrutor Interno?	titulo:\n  De: QUER SE CANDIDATA A INSTRUTOR INTERNO?\n  Para: Quer se candidatar a Instrutor Interno?\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsn82l3c00ag2ggiy98kxa5s	2026-08-10 12:43:15.142	admin@admin.com	CREATE	Servico	cmsn82l2i00af2ggi52zfgx34	Gestão de Energias Renováveis	Registro criado.
cmsn880cw00aj2ggieleg4equ	2026-08-10 12:47:28.207	admin@admin.com	CREATE	Servico	cmsn880cn00ai2ggiw63p050t	Eficiência Energética	Registro criado.
cmsn8cmnt00am2ggiknyw1y8j	2026-08-10 12:51:03.736	admin@admin.com	CREATE	Servico	cmsn8cmnm00al2ggiust37c4d	Gestão da Água e Eficiência Hídrica	Registro criado.
cmsn8n87500ap2ggif9poxeyp	2026-08-10 12:59:18.208	admin@admin.com	CREATE	Servico	cmsn8n86c00ao2ggif1aywf22	Apoio junto a Concessionárias e Prestadores de Serviços	Registro criado.
cmsn98ckp00ar2ggizri74mov	2026-08-10 13:15:43.653	admin@admin.com	CREATE	Servico	cmsn98ckh00aq2ggi1k8gsdoq	Orientação Técnica em Água e Energia	Registro criado.
cmsn9xknx00at2ggiorqjca5f	2026-08-10 13:35:20.539	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1vigh009q2ggi044hoxig	*Paceria EGAPE x ENAP	titulo:\n  De: Paceria EGAPE x ENAP\n  Para: *Paceria EGAPE x ENAP\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsn9yyhd00au2ggifntc02bl	2026-08-10 13:36:25.098	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1imyw009m2ggicw6z7imc	**O que é Instrutoria Interna?	titulo:\n  De: O que é Instrutoria Interna?\n  Para: **O que é Instrutoria Interna?\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsna0joi00av2ggijp6j32tq	2026-08-10 13:37:39.23	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj2rnnq009u2ggic98trtic	**Quero me candidatar a Instrutor Interno!	titulo:\n  De: Quer se candidatar a Instrutor Interno?\n  Para: **Quero me candidatar a Instrutor Interno!\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsna374400aw2ggi71i40hai	2026-08-10 13:39:42.915	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1pj16009o2ggiw0o1lmks	*Parceria e Convênios	titulo:\n  De: Parceria e Convênios\n  Para: *Parceria e Convênios\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsna59u000ax2ggi7iqf1w6d	2026-08-10 13:41:19.748	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1erkl009k2ggid88mmeza	**Escolas Corporativas do Estado	titulo:\n  De: Escolas Corporativas do Estado\n  Para: **Escolas Corporativas do Estado\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmsna660d00ay2ggi8zf7vg2y	2026-08-10 13:42:01.449	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj1c925009i2ggiuonnd2lc	**Qual a definição de Educação Corporativa?	titulo:\n  De: Qual a definição de Educação Corporativa?\n  Para: **Qual a definição de Educação Corporativa?\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsna6te600az2ggih9ge6va6	2026-08-10 13:42:31.757	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj0yq48009e2ggiqg6ombho	**Manual do Aluno - EGAPE	titulo:\n  De: Manual do Aluno - EGAPE\n  Para: **Manual do Aluno - EGAPE\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsna7aig00b02ggic0hy6558	2026-08-10 13:42:53.943	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsj00u01009a2ggiaxgj42ah	**Agenda de Cursos - EGAPE	titulo:\n  De: Agenda de Cursos - EGAPE\n  Para: **Agenda de Cursos - EGAPE\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsnknub000b82ggigqyymwld	2026-08-10 18:35:42.25	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmsnknua900b72ggiu2lk64wm	Telemática	Registro criado.
cmsonht1400bg2ggitsu77h09	2026-08-11 12:42:45.679	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmsonhszz00bf2ggi2yx80kmi	Telemática	Registro criado.
cmsonj5zr00bj2ggiwfvez2i6	2026-08-11 12:43:49.141	diego.rolim@sad.pe.gov.br	DELETE	Servico	cmsnknua900b72ggiu2lk64wm	Telemática	Registro excluído.
cmsooumgc00bo2ggicwwzp2qv	2026-08-11 13:20:43.299	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmsonhszz00bf2ggi2yx80kmi	Telemática	imagem_id:\n  De: eQSIdNDVcQniYAlgRsacBA\n  Para: HcpWHPDC4k95yA_euGilLg\n\nimagem_filesize:\n  De: 974157\n  Para: 3532629\n\nimagem_width:\n  De: 2591\n  Para: 5568\n\nimagem_height:\n  De: 3887\n  Para: 3712\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Diego Santos Rolim 
cmsxjog2r000913zxcx7rq7ce	2026-08-17 18:05:52.609	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrj6jz5h0016tspsfrh0gcht	Gestão de Manutenção da Frota Própria do Estado	titulo:\n  De: FROTA\n  Para: Gestão de Manutenção da Frota Própria do Estado\n\nimagem_id:\n  De: Tbkk53DYDgGdxw-f0IBBuQ\n  Para: yhofuGoPqwG0CHOLTO49FQ\n\nimagem_filesize:\n  De: 4800734\n  Para: 3711798\n\nimagem_width:\n  De: 5472\n  Para: 5760\n\nimagem_height:\n  De: 3648\n  Para: 3840\n\nresumo:\n  De: A Gerência de Frota da SAD gere a frota oficial de Pernambuco, garantindo padronização, eficiência, economia e suporte técnico aos órgãos e entidades da Administração Pública do Estado.\n  Para: Serviço de suporte e acompanhamento das manutenções preventivas e corretivas de veículos e equipamentos próprios do Estado, visando garantir o funcionamento contínuo, a segurança operacional e a preservação dos bens públicos.\n\noQueE:\n  De: A Gerência de Frota é a unidade responsável pelo planejamento, coordenação, normatização e acompanhamento das ações relacionadas à gestão da frota oficial do Poder Executivo Estadual. Sua atuação compreende a gestão dos contratos corporativos relacionados à frota, o desenvolvimento de normas e procedimentos, o acompanhamento da utilização dos veículos oficiais, o monitoramento de indicadores de desempenho, a promoção de iniciativas voltadas à redução dos custos operacionais e o apoio técnico aos órgãos e entidades estaduais na administração de seus veículos. A unidade também atua na implementação de boas práticas de gestão, na racionalização dos recursos públicos e na melhoria contínua dos processos relacionados à mobilidade administrativa, assegurando conformidade com a legislação vigente e com as diretrizes da Secretaria de Administração.\n  Para: A Unidade de Manutenção da Gerência de Frotas acompanha e presta suporte técnico aos órgãos estaduais no gerenciamento da manutenção de seus veículos próprios e equipamentos motorizados (como tratores, roçadeiras, geradores, embarcações, entre outros).\r O serviço atua no auxílio ao diagnóstico técnico, na mediação e interlocução com a empresa contratada/rede credenciada de oficinas, no alinhamento de orçamentos e no monitoramento dos prazos de reparo, assegurando o correto aproveitamento dos recursos públicos e a conservação do patrimônio estadual.\n\nquemPrecisa:\n  De: Os serviços da Gerência de Frota destinam-se aos órgãos e entidades integrantes da Administração Pública Estadual que demandem apoio técnico, orientação, acompanhamento ou atendimento relacionado à gestão da frota oficial. O atendimento ocorre sempre que houver necessidade de utilização dos serviços corporativos de frota, acompanhamento de contratos, orientações sobre normas e procedimentos, gestão de veículos oficiais, monitoramento de indicadores, implementação de soluções para otimização da frota ou outras demandas relacionadas às competências da Gerência.\n  Para: Gestores de frota e responsáveis patrimoniais dos órgãos e entidades da Administração Pública Estadual que possuem frota própria ou equipamentos patrimoniados (não se aplicando a veículos exclusivamente locados).\r É necessário sempre que houver demanda por revisão periódica (preventiva), falhas operacionais ou mecânicas, necessidade de substituição de peças, reparos corretivos, ou diante de impasses e dúvidas técnicas na relação com a empresa fornecedora dos serviços de manutenção.\n\ncomoSolicitar:\n  De: As demandas deverão ser encaminhadas pela autoridade competente ou pelo servidor formalmente designado pelo órgão ou entidade demandante, por meio dos canais institucionais da Secretaria de Administração. Quando necessário, a solicitação deverá ser formalizada mediante processo eletrônico no Sistema Eletrônico de Informações (SEI), contendo as informações e documentos pertinentes à demanda, observadas as normas e procedimentos estabelecidos pela Secretaria de Administração. Após o recebimento, a Gerência de Frota realizará a análise da solicitação e adotará as providências cabíveis, observando a legislação vigente, a disponibilidade contratual e os normativos aplicáveis.\n  Para: [sem texto]\n\nmaisInformacoes:\n  De: A Gerência de Frota presta apoio técnico aos órgãos e entidades da Administração Pública Estadual em assuntos relacionados à gestão da frota oficial. Informações complementares, orientações técnicas e esclarecimentos poderão ser obtidos por meio dos canais institucionais da Secretaria de Administração (SAD). Quando necessário, as demandas deverão ser formalizadas no Sistema Eletrônico de Informações (SEI), conforme os procedimentos vigentes.\n  Para: Em caso de dúvidas, entre em contato com a Gerência de Frotas (GEFRO) pelo ramal (81) 3183-7745.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsxjpugb000a13zxwzda2xg4	2026-08-17 18:06:57.897	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrj6jz5h0016tspsfrh0gcht	Gestão de Manutenção da Frota Própria do Estado	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsxjqte1000b13zxajg77pe6	2026-08-17 18:07:43.175	diego.rolim@sad.pe.gov.br	UPDATE	Servico	cmrj6jz5h0016tspsfrh0gcht	Gestão de Manutenção da Frota Própria do Estado	comoSolicitar:\n  De: [sem texto]\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmsxkn05c000d13zxdlsk6z89	2026-08-17 18:32:44.923	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmsxkn04g000c13zxiwtir7a8	Gestão de Abastecimento da Frota Estadual	Registro criado.
cmsxlrw4y000f13zxqkl8ibgb	2026-08-17 19:04:32.625	diego.rolim@sad.pe.gov.br	CREATE	Servico	cmsxlrw4d000e13zx6x2el396	Gestão da Realização de Leilões de Inservíveis	Registro criado.
cmt04qd6d000y13zxwab3x3x1	2026-08-19 13:30:46.446	diego.rolim@sad.pe.gov.br	UPDATE	Noticia	cmshr0jeb00842ggi69t9qoil	Gerência de Frota alcança 73,20% da meta anual de economia com a manutenção da frota até julho de 2026	titulo:\n  De: Gerência de Frota alcança 55,31% da meta anual de economia com a manutenção da frota até maio de 2026\n  Para: Gerência de Frota alcança 73,20% da meta anual de economia com a manutenção da frota até julho de 2026\n\nsubtitulo:\n  De: Diferença entre o Orçado e o Executado com a Manutenção da Frota registrou uma economia acumulada de R$ 0,80 milhão\n  Para: Diferença entre o Orçado e o Executado com a Manutenção da Frota registrou uma economia acumulada de R$ 1,061 milhão\n\ncorpo:\n  De: A Gerência Geral de Serviços Corporativos (GGCOR) segue avançando na promoção da eficiência dos contratos corporativos do Estado através da Gerência de Frota. Até maio de 2026, o indicador Economia com a Diferença entre o Orçado e o Executado com a Manutenção da Frota registrou uma economia acumulada de R$ 0,80 milhão, equivalente a 55,31% da meta anual, fixada em R$ 1,45 milhão. O resultado reflete as ações de gestão e fiscalização dos contratos de manutenção da frota estadual, assegurando maior controle sobre os custos, otimização dos recursos públicos e melhoria da eficiência operacional dos serviços. O acompanhamento mensal demonstra a evolução consistente do indicador ao longo do exercício, consolidando a economia alcançada nos cinco primeiros meses do ano e reforçando o compromisso da GGCOR com a busca contínua por melhores resultados para a Administração Pública Estadual. A expectativa é manter o desempenho nos próximos meses, ampliando as economias obtidas e contribuindo para o alcance da meta estabelecida para 2026, fortalecendo a gestão responsável dos recursos públicos e a sustentabilidade das contratações corporativas do Estado.\n  Para: A Gerência Geral de Serviços Corporativos (GGCOR) segue avançando na promoção da eficiência dos contratos corporativos do Estado através da Gerência de Frota. Até julho de 2026, o indicador Economia com a Diferença entre o Orçado e o Executado com a Manutenção da Frota registrou uma economia acumulada de R$ 1,061 milhão, equivalente a 73,20% da meta anual, fixada em R$ 1,45 milhão. O resultado reflete as ações de gestão e fiscalização dos contratos de manutenção da frota estadual, assegurando maior controle sobre os custos, otimização dos recursos públicos e melhoria da eficiência operacional dos serviços. O acompanhamento mensal demonstra a evolução consistente do indicador ao longo do exercício, consolidando a economia alcançada nos cinco primeiros meses do ano e reforçando o compromisso da GGCOR com a busca contínua por melhores resultados para a Administração Pública Estadual. A expectativa é manter o desempenho nos próximos meses, ampliando as economias obtidas e contribuindo para o alcance da meta estabelecida para 2026, fortalecendo a gestão responsável dos recursos públicos e a sustentabilidade das contratações corporativas do Estado.\n\nresumo:\n  De: Economia acumulada de R$ 0,80 milhão, equivalente a 55,31% da meta anual, fixada em R$ 1,45 milhão.\n  Para: Economia acumulada de R$ 1,061 milhão, equivalente a 73,20% da meta anual, fixada em R$ 1,45 milhão.
cmt1viqkq001c13zxfaf579jl	2026-08-20 18:48:26.374	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmrj80ie7001dtspsxai0zmdh	Capacitação de Gest. dos Serv. Corporativos Especialidade TELEMÁTICA (Telefonia Fixa)	titulo:\n  De: Lorem ipsum dolor sit amet.\n  Para: Capacitação de Gest. dos Serv. Corporativos Especialidade TELEMÁTICA (Telefonia Fixa)\n\nresumo:\n  De: Ut voluptas quis 33 tempore dolorem a aperiam eaque sit officiis ipsa aut minima galisum in vero expedita et unde laboriosam. Ea dolore velit ut corporis temporibus et ullam dolorem eos officia reiciendis et molestiae vitae aut consequatur cupiditate ad quam recusandae.\n  Para: Procedimentos quanto a Gestão dos Serviços de Telemática\n\nsubareaId:\n  De: vazio\n  Para: cmrtn3ddb0004bqr56kh31dp0\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Agelson Santana
cmt1vjcz5001d13zxkbzvm1ax	2026-08-20 18:48:55.401	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmrj80ie7001dtspsxai0zmdh	Gestão dos Serv. Corporativos Especialidade TELEMÁTICA (Telefonia Fixa)	titulo:\n  De: Capacitação de Gest. dos Serv. Corporativos Especialidade TELEMÁTICA (Telefonia Fixa)\n  Para: Gestão dos Serv. Corporativos Especialidade TELEMÁTICA (Telefonia Fixa)\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmt1vk1g0001e13zxttxgseqn	2026-08-20 18:49:27.112	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmrj80ie7001dtspsxai0zmdh	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Fixa)	titulo:\n  De: Gestão dos Serv. Corporativos Especialidade TELEMÁTICA (Telefonia Fixa)\n  Para: Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Fixa)\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmt1vkesk001f13zx90k94udf	2026-08-20 18:49:44.412	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmrj80ie7001dtspsxai0zmdh	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Fixa)	local:\n  De: R. Tabira, 252 - Boa Vista, Recife - PE, 50050-330\n  Para: R. Tabira, 252 - Boa Vista, Recife - PE\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmt1vlqva001g13zxq29r25mu	2026-08-20 18:50:46.724	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmrj80ie7001dtspsxai0zmdh	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Fixa)	resumo:\n  De: Procedimentos quanto a Gestão dos Serviços de Telemática\n  Para: Procedimentos quanto a Gestão dos Serviços de Telemática (FIXA)\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmt1vng0j001h13zx4yjmso70	2026-08-20 18:52:05.965	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmrj80ie7001dtspsxai0zmdh	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Fixa)	linkExterno:\n  De: https://www.egape.pe.gov.br/\n  Para: https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmt1vodle001j13zx49gpdoze	2026-08-20 18:52:49.483	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmt1vodkz001i13zx2e5o5v1w	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Móvel)	Registro criado.
cmt1vrj5e001l13zxj8inmlxm	2026-08-20 18:55:16.657	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmt1vrj52001k13zxu01qpjpp	Gestão dos Serviços Corporativos - ÁGUA	Registro criado.
cmt1vtoxf001n13zx0dgtk5n3	2026-08-20 18:56:57.457	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmt1vtox1001m13zxhnb8artw	Gestão dos Serviços Corporativos - ENERGIA	Registro criado.
cmt1vx36a001p13zx63q9faj9	2026-08-20 18:59:35.89	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmt1vx362001o13zx4wt5ynfw	Gestão dos Serviços Corporativos - FROTA	Registro criado.
cmt1vzu7m001r13zx5aj5bt7n	2026-08-20 19:01:44.241	agelson.santana@sad.pe.gov.br	CREATE	Curso	cmt1vzu75001q13zxtg9lqipy	Gestão dos Serviços Corporativos - CONTRATOS	Registro criado.
cmt7m28zn000594zab5lk730i	2026-08-24 19:10:17.6	admin@admin.com	CREATE	Servico	cmt7m28z6000494za6bkjoqc1	teste	Registro criado.
cmt7m37gg000794zaeqlqgqjo	2026-08-24 19:11:02.27	admin@admin.com	DELETE	Servico	cmt7m28z6000494za6bkjoqc1	teste	Registro excluído.
cmtbt8jpv0014lvieana7z3td	2026-08-27 17:42:13.458	agelson.santana@sad.pe.gov.br	UPDATE	Curso	cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS 02 (uso PEI)	titulo:\n  De: Gestor de Patrimônio Imóvel - INDIRETAS (uso PEI)\n  Para: Gestor de Patrimônio Imóvel - INDIRETAS 02 (uso PEI)\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtlwjia600a0lviezknejtkk	2026-09-03 19:12:25.42	anaclaudia.souza@sad.pe.gov.br	UPDATE	Servico	cmq9rxjkk000lg5ahorb2k5lt	Projetos de engenharia e fiscalização de obra 	titulo:\n  De: Projetos de engenharia\n  Para: Projetos de engenharia e fiscalização de obra \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Ana Claudia de Souza Ferreira
cmthj4ls7003flviejh2xfgjb	2026-08-31 17:45:50.405	fabioo.silva@sad.pe.gov.br	UPDATE	Servico	cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	oQueE:\n  De: O Inventário de Físico de Bens Materiais constitui um instrumento de controle administrativo destinado à verificação da existência física dos bens permanentes, estejam eles em uso ou não, nos diversos órgãos e/ou entidades da Administração Pública Estadual. Esse procedimento consiste no levantamento físico e financeiro de todos os bens móveis permanentes que se encontram sob a posse e guarda das unidades gestoras, tendo como finalidade confrontar os registros patrimoniais existentes com os bens efetivamente localizados. Nós atuamos capacitando e orientando os órgãos e/ou entidades da Administração Pública Estadual quanto à elaboração desse inventário.\n  Para: Constitui um instrumento de controle administrativo destinado à verificação da existência física dos bens permanentes, estejam eles em uso ou não, nos diversos órgãos e/ou entidades da Administração Pública Estadual. Esse procedimento consiste no levantamento físico e financeiro de todos os bens móveis permanentes que se encontram sob a posse e guarda das unidades gestoras, tendo como finalidade confrontar os registros patrimoniais existentes com os bens efetivamente localizados.\n\nmaisInformacoes:\n  De: Para mais informações e esclarecimentos acerca do Inventário, favor entrar em contato conosco:\nUnidade Central de Patrimônio Móvel e Materiais (UCPAM)\n Fones:  3183-7785  E-mail:\n  Para: Para mais informações e esclarecimentos acerca do Inventário, favor entrar em contato conosco:\nUnidade Central de Patrimônio Móvel e Materiais (UCPAM)\n E-mail:\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Gustavo Andrade\n  Para: Fabio Oliveira Araújo da Silva
cmtixpo0d004vlviegvo7vbwi	2026-09-01 17:21:53.865	fabioo.silva@sad.pe.gov.br	UPDATE	Legislacao	cmq9kps3w001hboamjv1y4016	Decreto nº 35.706/2010	resumo:\n  De: Institui o Comitê Estadual de Resíduos Sólidos\n  Para: Institui o Comitê Estadual de Resíduos Sólidos \n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Allan Soares\n  Para: Fabio Oliveira Araújo da Silva
cmtlh3qqj0074lvietx0ls8s2	2026-09-03 12:00:15.64	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmtlh3qq50073lviesnwx50kg	Lei de Licitações e Contratos Administrativos	Registro criado.
cmtlhcgnl007alviedrj0hm21	2026-09-03 12:07:02.477	diego.rolim@sad.pe.gov.br	CREATE	Legislacao	cmtlhcgne0079lvie6w5sypic	Regulamenta a Lei Federal nº 14.133 de 2021, no que se refere aos agentes públicos que desempenham funções essenciais nos procedimentos de contratações públicas.	Registro criado.
cmtli3khx007qlviecmznhvbf	2026-09-03 12:28:07.172	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	Nenhuma alteração detectada.
cmtli5zcm007rlvied7epoihj	2026-09-03 12:29:59.733	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9rvmr1000jg5ahyl18tc2d	Levantamentos topográficos georreferenciados	subareaId:\n  De: cmq9rha92000bg5ah7gkhkjyd\n  Para: cmtimbobc0003and9kpvtp3me\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Gustavo Andrade
cmtli6e4j007slvie5jt5t9jq	2026-09-03 12:30:18.881	gustavo.andrade@sad.pe.gov.br	UPDATE	Servico	cmq9rsnxp000hg5ah3lhqu1un	Avaliação de Imóveis	subareaId:\n  De: cmq9rha92000bg5ah7gkhkjyd\n  Para: cmtimbobe0005and9z3nes0so\n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Gustavo Andrade
cmtliqh3f007wlvie4db7rxgf	2026-09-03 12:45:55.85	gustavo.andrade@sad.pe.gov.br	CREATE	Noticia	cmtliqh2u007vlviek7f416fn	Autorizada restauração do antigo prédio do Diario, símbolo da memória jornalística do Estado	Registro criado.
cmtlir720007zlvien2rqf88g	2026-09-03 12:46:29.496	gustavo.andrade@sad.pe.gov.br	UPDATE	Noticia	cmtliqh2u007vlviek7f416fn	Autorizada restauração do antigo prédio do Diario	titulo:\n  De: Autorizada restauração do antigo prédio do Diario, símbolo da memória jornalística do Estado\n  Para: Autorizada restauração do antigo prédio do Diario
cmtltffyv009dlvie4rk9ypgu	2026-09-03 17:45:16.951	gustavo.andrade@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	tituloDaPagina:\n  De: Quem Somos\n  Para: Sobre
cmtltzqq0009klvienh2me9lm	2026-09-03 18:01:04.006	amanda.sbarros@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	muralTextoIntrodutorio:\n  De: Para subir o prédio, e para mantê-lo em pé, a quem irão procurar? Podem contar conosco! Nós somos a área técnica de Engenharia e Arquitetura do Estado. Se é um imóvel do Estado, e já não há quem olhe por ele, nós iremos olhar. Iremos olhar cada canto e detalhe. O layout, a divisória, a mesa e seu lugar; a parede, a alvenaria, o teto e a janela; e mesmo o terreno e o preço do aluguel. Nosso trabalho é criar e cuidar.\n  Para: Da mudança de layout até projetos complexos, do levantamento cartográfico à avaliação de imóveis. A área de arquitetura e engenharia está pronta com uma equipe própria, técnica e qualificada para atuar no Patrimônio Imobiliário da Administração Direta e Vinculada (IASSEPE, ATI e FUNAPE)  Estadual, conforme decreto nº 58.355/2025, de forma a preservar a história, atualizar demandas e permitir edificações seguras e eficientes para todo o Estado de Pernambuco.
cmtlua74x009llvieqkl0wu0a	2026-09-03 18:09:11.839	amanda.sbarros@sad.pe.gov.br	UPDATE	Servico	cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	oQueE:\n  De: Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\nserviços.\nProjeto arquitetônico; Projeto arquitetônico de reforma; Projeto de ambientação;\nPara colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam: Levantamento das necessidades; Estudo preliminar; Anteprojeto; Projeto executivo; Projeto de detalhamento. É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis.\n  Para: Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\nserviços. Exemplos de projetos de arquitetura: Para colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam: É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis.\n\nquemPrecisa:\n  De: Os projetos de arquitetura são importantes sempre que se faz necessária a construção, reforma ou regularização de um imóvel. A título exemplificativo, indica-se abaixo alguns exemplos de quando se solicitar projetos de arquitetura: Construção de imóvel; Reforma de imóvel; Definição e/ou alteração de layout; Regularização de imóvel junto a prefeituras/cartórios.\n  Para: Os projetos de arquitetura são importantes sempre que se faz necessária a construção, reforma ou regularização de um imóvel. O serviço de arquitetura pode ser solicitado para construção ou reforma de imóveis , definição ou alteração de layout, regularização de imóvel junto à prefeitura ou cartórios , entre outros.\n\ncomoSolicitar:\n  De: As solicitações para elaboração de projetos de arquitetura de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício (via Sistema\nEletrônico de Informação), acompanhadas dos respectivos planos de necessidades.\n  Para: As solicitações para elaboração de projetos de arquitetura de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício (via Sistema Eletrônico de Informação), acompanhadas dos respectivos planos de necessidades, seguindo o modelo do formulário abaixo.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Administrador\n  Para: Amanda Soares Barros
cmtlufhye009qlviedrqxwlno	2026-09-03 18:13:19.141	amanda.sbarros@sad.pe.gov.br	UPDATE	Servico	cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	oQueE:\n  De: Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\nserviços. Exemplos de projetos de arquitetura: Para colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam: É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis.\n  Para: Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\nserviços. Exemplos de projetos de arquitetura: Para colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam: É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtlvinl2009slviez5q7hlu4	2026-09-03 18:43:46.021	sylvio.csantana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	oQueE:\n  De: Análise das solicitações de usucapião apresentadas por terceiros quando estas envolvem, ou podem envolver, o patrimônio do Estado de Pernambuco. Sua atuação concentra-se em esclarecer se o imóvel objeto do pedido de usucapião pertence ao Estado ou se possui relevância para a administração pública.\n  Para: Serviço destinado à análise das solicitações de usucapião apresentadas por terceiros quando houver envolvimento, efetivo ou potencial, de bens integrantes do patrimônio do Estado de Pernambuco. O serviço consiste na verificação da titularidade do imóvel objeto da ação de usucapião, com o objetivo de identificar se o bem pertence ao Estado de Pernambuco ou se possui interesse patrimonial ou relevância para a Administração Pública Estadual, subsidiando as providências administrativas e jurídicas cabíveis.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Agelson Santana\n  Para: Sylvio Carlos Santana Siqueira Gomes Macedo Guedes
cmtlw4626009xlvielp7ieits	2026-09-03 19:00:29.741	sylvio.csantana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	resumo:\n  De: Análise das solicitações de usucapião de imóveis, quanto à posse ou interesse públicos.\n  Para: Serviço destinado à análise das solicitações de usucapião de bens imóveis, com a finalidade de verificar a existência de posse, domínio ou interesse patrimonial do Estado de Pernambuco sobre o imóvel objeto do pedido.\n\noQueE:\n  De: Serviço destinado à análise das solicitações de usucapião apresentadas por terceiros quando houver envolvimento, efetivo ou potencial, de bens integrantes do patrimônio do Estado de Pernambuco. O serviço consiste na verificação da titularidade do imóvel objeto da ação de usucapião, com o objetivo de identificar se o bem pertence ao Estado de Pernambuco ou se possui interesse patrimonial ou relevância para a Administração Pública Estadual, subsidiando as providências administrativas e jurídicas cabíveis.\n  Para: A usucapião é um instrumento jurídico previsto na Constituição Federal e em normas infraconstitucionais que permite a aquisição da propriedade de um bem imóvel pela posse contínua, pacífica e pelo período estabelecido em lei, desde que atendidos os demais requisitos legais. No Estado de Pernambuco, a análise das solicitações de usucapião que envolvam, efetiva ou potencialmente, bens do patrimônio estadual é de responsabilidade da Unidade de Avaliação de Processos Patrimoniais (UNAPI), vinculada à Secretaria Executiva de Patrimônio, Engenharia e Serviços Corporativos (SEPEC), da Secretaria de Administração (SAD).\n\nCompete à UNAPI a verificação da titularidade do imóvel objeto da ação de usucapião, bem como da existência de eventual posse, domínio ou interesse patrimonial do Estado de Pernambuco sobre a área. O resultado dessa verificação subsidia a manifestação da Administração Pública Estadual e a adoção das providências administrativas e jurídicas cabíveis, contribuindo para a proteção e a regular gestão do patrimônio público estadual.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtlwexlk009ylvieg37nxsah	2026-09-03 19:08:51.991	sylvio.csantana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	quemPrecisa:\n  De: Esses serviços são destinados a toda a população que deseja regularizar um bem imóvel por meio da Ação de Usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário). Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo segurança jurídica e o devido registro, pode buscar esses serviços para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, valorização do imóvel e pleno exercício dos direitos do proprietário.\n  Para: O serviço tem como destinatários as pessoas físicas ou jurídicas que estejam interessadas em regularizar um bem imóvel por meio do instituto da usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário). Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo o  devido registro e, como decorrência, uma maior segurança jurídica sobre o patrimônio, pode buscar esses serviços para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, cumprimento da função social do imóvel e pleno exercício dos direitos do proprietário.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtlwgbzt009zlviecjk2pt9r	2026-09-03 19:09:57.304	sylvio.csantana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	quemPrecisa:\n  De: O serviço tem como destinatários as pessoas físicas ou jurídicas que estejam interessadas em regularizar um bem imóvel por meio do instituto da usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário). Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo o  devido registro e, como decorrência, uma maior segurança jurídica sobre o patrimônio, pode buscar esses serviços para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, cumprimento da função social do imóvel e pleno exercício dos direitos do proprietário.\n  Para: O serviço tem como destinatárias as pessoas físicas ou jurídicas que estejam interessadas em regularizar um bem imóvel por meio do instituto da usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário). Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo o  devido registro e, como decorrência, uma maior segurança jurídica sobre o patrimônio, pode buscar esses serviços para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, cumprimento da função social do imóvel e pleno exercício dos direitos do proprietário.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtlx0eas00a2lvie1e3y1v1c	2026-09-03 19:25:33.41	anaclaudia.souza@sad.pe.gov.br	CREATE	Servico		GraphQLError	Registro criado.
cmtlx1rcl00a3lvievqbid8p4	2026-09-03 19:26:36.98	sylvio.csantana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	comoSolicitar:\n  De: Para obter mais informações detalhadas sobre o procedimento de Peticionamento Eletrônico do Usucapião Extrajudicial, consulte o conteúdo disponível no link: Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial, descrevendo, de forma clara e detalhada, todas as etapas do procedimento.\n  Para: Com o objetivo de oferecer mais comodidade aos interessados, a Secretaria de Administração de Pernambuco (SAD) disponibiliza o Peticionamento Eletrônico do SEI-PE, um canal eletrônico destinado a pessoas físicas, pessoas jurídicas, órgãos e entidades para a solicitação de serviços e o envio de documentos à SAD. Por meio dessa ferramenta, é possível protocolar documentos e acompanhar a tramitação do processo de forma totalmente eletrônica, sem necessidade de comparecimento presencial à Secretaria de Administração ou de envio de documentação pelos Correios, proporcionando mais agilidade, praticidade e economia ao cidadão. Para obter mais informações sobre o procedimento de Peticionamento Eletrônico da Usucapião Extrajudicial, consulte o manual de instruções disponível no link: Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial. De forma clara e detalhada, são apresentadas todas as etapas necessárias para a realização do procedimento, desde o cadastro do usuário no sistema até o protocolo final do peticionamento.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtlx37qa00a8lvieqtpfmokb	2026-09-03 19:27:44.865	anaclaudia.souza@sad.pe.gov.br	CREATE	Servico	cmtlx37po00a7lviexpiqnucs	Projetos de engenharia e fiscalização de obra 	Registro criado.
cmtlx3uj300a9lvie07jg61df	2026-09-03 19:28:14.413	anaclaudia.souza@sad.pe.gov.br	UPDATE	Servico	cmtlx37po00a7lviexpiqnucs	Projetos de engenharia 	titulo:\n  De: Projetos de engenharia e fiscalização de obra \n  Para: Projetos de engenharia \n\nupdatedAt:\n  De: vazio\n  Para: [objeto]\n\nupdatedBy:\n  De: \n  Para: Ana Claudia de Souza Ferreira
cmtlxflpg00aelvie1i3syhye	2026-09-03 19:37:22.85	sylvio.csantana@sad.pe.gov.br	UPDATE	Servico	cmq9jay9t0009boamyfuz2056	Usucapião	maisInformacoes:\n  De: Esclarecimentos adicionais podem ser obtidos nos seguintes contatos: (81) 3183-7739 e gestaoimobiliaria@sad.pe.gov.br.\n  Para: Esclarecimentos adicionais podem ser obtidos nos seguintes contatos: Telefone: (81) 3183-7739 E-mail: gestaoimobiliaria@sad.pe.gov.br.\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtly3jue00aflvieqfryutil	2026-09-03 19:56:00.18	ingrid.vsilva@sad.pe.gov.br	UPDATE	Servico	cmq9jf5vi000iboam6yi59usu	Devolução de Imóveis Estaduais	titulo:\n  De: Pagamento de Tributos e Taxas de Imóveis Estaduais\n  Para: Devolução de Imóveis Estaduais\n\nslug:\n  De: tributos-taxas\n  Para: devolucao-imoveis\n\nimagemAlt:\n  De: Pagamentos\n  Para: Devolução de imóveis\n\nresumo:\n  De: Acompanhamento e controle das notificações de pagamento vinculadas aos imóveis estaduais.\n  Para: Controle do recebimento de imóveis desocupados, visando garantir a formalização e a conservação dos bens imóveis estaduais.\n\noQueE:\n  De: Trata-se da responsabilidade e do comprometimento quanto ao pagamento e a regularização dos tributos, taxas, encargos e despesas de consumo incidentes aos imóveis públicos estaduais desocupados, assim permanecendo as obrigações até o ato de sua efetiva destinação.\n  Para: Serviço destinado ao controle e acompanhamento do recebimento de Imóveis estaduais desocupados, assegurando a formalização da devolução, a conservação e a regularização dos bens para posterior destinação.\n\nquemPrecisa:\n  De: Os credores e devedores que figurem como titulares das obrigações relativas aos imóveis desocupados. Podem ser considerados credores as empresas e entidades que prestam serviços ao Estado, como o fornecimento de água, energia elétrica, bem como os serviços de coleta e remoção de resíduos sólidos.\n  Para: Órgãos e entidades pública que sejam devolvendo imóveis estaduais. Para a devolução/desocupação do imóvel\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]\n\nupdatedBy:\n  De: Gustavo Andrade\n  Para: Ingrid Valões
cmtly96zf00ailvieoziu2bjt	2026-09-03 20:00:23.45	ingrid.vsilva@sad.pe.gov.br	UPDATE	Servico	cmq9jf5vi000iboam6yi59usu	Devolução de Imóveis Estaduais	comoSolicitar:\n  De: A solicitação de pagamento é formalizada por meio de Comunicação Interna (CI) entre os setores competentes, sendo posteriormente encaminhada ao setor financeiro do Estado para as providências cabíveis.\nÀ referida solicitação são anexados os documentos comprobatórios devidamente autenticados, tais como certidões e guia de pagamento.\nApós o encaminhamento, é realizado o acompanhamento do trâmite processual até a efetiva liquidação dos débitos.\n  Para: [sem texto]\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
cmtmvfyv900axlvieqet6adka	2026-09-04 11:29:26.852	amanda.sbarros@sad.pe.gov.br	UPDATE	PaginaQuemSomos	cmq9rfbp70009g5ah6bliwon4	Sem título	Nenhuma alteração detectada.
cmtmw2cpw00bclvienqqxmbym	2026-09-04 11:46:51.235	amanda.sbarros@sad.pe.gov.br	UPDATE	Servico	cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	resumo:\n  De: Serviço técnico destinado a planejar a reforma e/ou construção de imóvel (casas, apartamentos, prédios, lojas etc.).\n  Para: Serviço técnico destinado ao planejamento, organização e orientação dos projetos de construção ou reformas com o objetivo de fazer um melhor aproveitamento dos espaços , adequados à legislação vigente proporcionando conforto e economia financeira pela antecipação de demandas\n\nupdatedAt:\n  De: [objeto]\n  Para: [objeto]
\.


--
-- Data for Name: Cursos; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Cursos" (id, titulo, resumo, "linkExterno", "dataDoCurso", "areaResponsavel", "createdAt", "createdBy", subarea, "updatedAt", "updatedBy", status, local, modalidade) FROM stdin;
cmi3gfzka0004vwpmkzdk8tia	EXCEL BÁSICO - 20 h/a	Capacitação dos servidores para utilização da ferramenta Miscrosoft Excel.	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2025-12-01 11:00:00	\N	\N		\N	\N		PROGRAMADO		PRESENCIAL
cmi3g8ji50002vwpmbdbic2mb	SISTEMA SEI – SISTEMA ELETRÔNICO DE INFORMAÇÕES - SEI AVANÇADO - 8 h/a	Treinamento para utilização de recursos avançados do Sistema Eletrônico de Informações - SEI	https://www.sgic.pe.gov.br/Sgic/public/pages/login.jsf	2025-12-14 11:00:00	\N	\N		\N	\N		PROGRAMADO		PRESENCIAL
cmsizm1qo00982ggi15o3vc2f	Sistema PE Integrado (EAD com Tutoria)	Usabilidade do Sistema PEI	https://www.egape.pe.gov.br/cursos/152-cursos/599-inscricoes-em-cursos-ead-com-tutoria	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	\N		PROGRAMADO	Ambiente Virtual	EAD
cmr97vchs0000tspscrk7ea18	Teste	Teste	https://powerbi.pe.gov.br/relatorios/powerbi/SAD/GGPAE/NIPAE/PATRIM%C3%94NIO%20M%C3%93VEL/Dashboard%20Patrim%C3%B4nio%20M%C3%B3vel%20(V3)	2026-07-06 03:00:00	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N		PROGRAMADO		PRESENCIAL
cmsj1imyw009m2ggicw6z7imc	**O que é Instrutoria Interna?	Normativos e Definição da estratégia	https://www.egape.pe.gov.br/programa-de-educacao-corporativa/136-programa-de-educacao-corporativa/421-instrutoria-interna	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-08-10 13:36:25.085	Agelson Santana	PROGRAMADO	Pernambuco	EAD
cmsj1pj16009o2ggiw0o1lmks	*Parceria e Convênios	Convênios com ensino superior	https://www.egape.pe.gov.br/parcerias-convenios/131-parcerias-convenios/367-ensino-superior	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-10 13:39:42.903	Agelson Santana	PROGRAMADO	EGAPE	EAD
cmsj1erkl009k2ggid88mmeza	**Escolas Corporativas do Estado	Lista das Escolas	https://www.egape.pe.gov.br/programa-de-educacao-corporativa/136-programa-de-educacao-corporativa/162-escolas-corporativas	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-08-10 13:41:19.734	Agelson Santana	PROGRAMADO	Pernambuco	PRESENCIAL
cmsizb6d800932ggi3h6kdzf4	Sistema PE Integrado (EAD autoinstrucional)	Usabilidade do Sistema PEI	https://www.egape.pe.gov.br/cursos/152-cursos/353-inscricoes-em-cursos-ead-autoinstrucionais	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	\N		PROGRAMADO	Ambiente Virtual	EAD
cmi3gd20r0003vwpmvnyz3la9	Gestão de Patrimônio Móvel - uso do Pe Integrado	Procedimentos e Usabilidade               	https://www.egape.pe.gov.br/cursos/160-cronogramas/594-cronogramas-2026	2025-11-07 11:00:00	cmq6yxa510000nh1tnduds1mc	\N		cmqgnv5xk00003adnqj7bkkdv	2026-08-07 13:30:31.717	Agelson Santana	REALIZADO	EGAPE - Escola de Governo da Administração Pública de Pernambuco	PRESENCIAL
cmqgr89vx000011bmsh1k9vov	Desfazimento	Procedimentos de Desfazimentos	https://www.egape.pe.gov.br/cursos/160-cronogramas/594-cronogramas-2026	2026-05-05 11:30:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-08-07 13:30:44.235	Agelson Santana	REALIZADO	EGAPE - Escola de Governo da Administração Pública de Pernambuco	PRESENCIAL
cmqgvjboi000311bmxtxfctlw	Gestor de Patrimônio Imóvel - uso do Pe Integrado	Procedimentos e Usabilidade	https://www.egape.pe.gov.br/cursos/160-cronogramas/594-cronogramas-2026	2026-06-23 11:30:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-07 13:31:21.615	Agelson Santana	REALIZADO	EGAPE - Escola de Governo da Administração Pública de Pernambuco	PRESENCIAL
cmsj00u01009a2ggiaxgj42ah	**Agenda de Cursos - EGAPE	Acesso de todos os cursos que estão disponíveis no mês e sua modalidade.	https://www.egape.pe.gov.br/images/media/1785165354_08.Cronograma%20AGO.2026.pdf	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-10 13:42:53.928	Agelson Santana	PROGRAMADO	EGAPE	PRESENCIAL
cmrj80ie7001dtspsxai0zmdh	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Fixa)	Procedimentos quanto a Gestão dos Serviços de Telemática (FIXA)	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2026-07-13 12:50:51.291	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn3ddb0004bqr56kh31dp0	2026-08-20 18:52:05.961	Agelson Santana	PROGRAMADO	R. Tabira, 252 - Boa Vista, Recife - PE	PRESENCIAL
cmsj1vigh009q2ggi044hoxig	*Paceria EGAPE x ENAP	Conjunto de serviços disponibilizados em um Portal Único de Governo Federal	https://www.escolavirtual.gov.br/p/governope?page=2	2026-08-07 14:38:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-10 13:35:20.536	Agelson Santana	PROGRAMADO	Virtual	EAD
cmsj2rnnq009u2ggic98trtic	**Quero me candidatar a Instrutor Interno!	Aqui você confirma seu desejo de ser um Instrutor Interno (multiplicador).	https://docs.google.com/forms/d/e/1FAIpQLSeoeaY4hTHTyBAXQuj29Hx7DGCcfiOsicTCkStP83YReOCTzQ/viewform?usp=header	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-10 13:37:39.213	Agelson Santana	PROGRAMADO	egape	EAD
cmsj1c925009i2ggiuonnd2lc	**Qual a definição de Educação Corporativa?	Apresentação da definições	https://www.egape.pe.gov.br/programa-de-educacao-corporativa	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-10 13:42:01.438	Agelson Santana	PROGRAMADO	EGAPE	PRESENCIAL
cmsj0yq48009e2ggiqg6ombho	**Manual do Aluno - EGAPE	Consulta dos procedimento relacionados aos alunos.	https://drive.expresso.pe.gov.br/s/B5oXqqzypoohvrg	2026-08-01 03:00:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-10 13:42:31.744	Agelson Santana	PROGRAMADO	EGAPE	PRESENCIAL
cmt1vodkz001i13zx2e5o5v1w	Gestão dos Serviços Corporativos - TELEMÁTICA (Telefonia Móvel)	Procedimentos quanto a Gestão dos Serviços de Telemática (MÓVEL)	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2026-08-04 11:00:00	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn3ddb0004bqr56kh31dp0	\N		PROGRAMADO	R. Tabira, 252 - Boa Vista, Recife - PE	PRESENCIAL
cmt1vrj52001k13zxu01qpjpp	Gestão dos Serviços Corporativos - ÁGUA	Procedimentos quanto a Gestão dos Serviços de consumo de água.	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2026-08-18 11:00:00	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn35yi0002bqr5ck780vyc	\N		PROGRAMADO	R. Tabira, 252 - Boa Vista, Recife - PE	PRESENCIAL
cmt1vtox1001m13zxhnb8artw	Gestão dos Serviços Corporativos - ENERGIA	Procedimentos quanto a Gestão dos Serviços de consumo de ENERGIA.	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2026-08-24 11:00:00	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn35yi0002bqr5ck780vyc	\N		PROGRAMADO	R. Tabira, 252 - Boa Vista, Recife - PE	PRESENCIAL
cmt1vx362001o13zx4wt5ynfw	Gestão dos Serviços Corporativos - FROTA	Procedimentos quanto a Gestão dos Serviços de FROTA	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2026-08-03 11:00:00	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn2i7v0000bqr5csm0w82l	\N		REALIZADO	R. Tabira, 252 - Boa Vista, Recife - PE	PRESENCIAL
cmt1vzu75001q13zxtg9lqipy	Gestão dos Serviços Corporativos - CONTRATOS	Procedimentos quanto a Gestão dos Serviços de estruturação de contratos corporativos	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	2026-07-01 03:00:00	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn3l1x0006bqr58awnhiel	\N		REALIZADO	R. Tabira, 252 - Boa Vista, Recife - PE	PRESENCIAL
cmsiy4zw6008r2ggixvd4y8za	Gestor de Patrimônio Imóvel - INDIRETAS 02 (uso PEI)	Procedimentos e usabilidade	https://www.egape.pe.gov.br/cursos/152-cursos/91-inscricoes-em-cursos-presenciais	2026-08-24 11:30:00	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	2026-08-27 17:42:13.428	Agelson Santana	PROGRAMADO	EGAPE - Escola de Governo da Administração Pública de Pernambuco	PRESENCIAL
\.


--
-- Data for Name: Gerencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Gerencias" (id, nome, responsavel, telefone1, telefone2, email, area, "createdAt", "createdBy", "updatedAt", "updatedBy") FROM stdin;
cmrm332920000lzrgv70hhm77	Gerência de Frota	Rodrigo Farias				cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmrm362wc0002lzrg75hfrqke	Superintendência de Energia Renováveis	Otávio Malheiros				cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmrm37v580000130sh22riots	Gerência de Telemática	Joseílson Albuquerque				\N	\N		\N	
cmrm38eyv0002130s1gsw2w8d	Gerência de Telemática	Joséilson Albuquerque				\N	\N		\N	
cmrm39vdh0004130sa166hfjo	Gerência de Telemática	Joseílson Albuquerque				cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmrm3bblx0006130slfi67gwu	Gerência de Contratos Corporativos	Henrique Sales de Oliveira				cmq81pvoq0003j9azcu4vg0ws	\N		\N	
\.


--
-- Data for Name: Gestores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Gestores" (id, nome, cargo, descricao, foto_id, foto_filesize, foto_width, foto_height, foto_extension, "areaResponsavel") FROM stdin;
cmql1edtq0000en2miciezyoq	Allan	Teste	Teste teste	B1UurmXGsiqmyKfZae3oXg	15629070	8000	4563	jpg	cmq6yxa510000nh1tnduds1mc
cmqtig8790002hp20oyetl58f	Teste	testando	tal tal atla	dYo30iFNb73ww6cAzoTqbQ	2080182	1536	1024	png	cmq6yxa510000nh1tnduds1mc
\.


--
-- Data for Name: Legislacoes; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Legislacoes" (id, titulo, "linkExterno", categoria, resumo, "areaResponsavel", "createdAt", "createdBy", subarea, "updatedAt", "updatedBy") FROM stdin;
cmq9kh3yo001aboam1wwjq7hc	Lei nº 11.781/2000	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=11781&complemento=0&ano=2000&tipo=&url=	estadual	Regula o Processo Administrativo no âmbito da Administração Pública Estadual.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9kj65x001cboampp9wylsb	Lei nº 13.105/2015	https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2015/lei/l13105.htm	federal	Código de Processo Civil.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9ktgtq001rboamr6wk0amx	Decreto nº 55.946/2023	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=55946&complemento=0&ano=2023&tipo=&url=	estadual	Estabelece procedimentos patrimoniais de cadastro, uso e regularização de imóveis estaduais, altera o Decreto nº 38.875, de 22 de novembro de 2012, e o Decreto nº 39.639, de 25 de julho de 2013.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9kuv8q001vboam7tzkulpa	Lei nº 11.781/2000	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=11781&complemento=0&ano=2000&tipo=&url=	estadual	Regula o Processo Administrativo no âmbito da Administração Pública Estadual.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9kvis7001xboam7x6cwok8	Lei nº 13.105/2015	https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2015/lei/l13105.htm	federal	Código de Processo Civil.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9kyn0g0023boamj4a9n422	Lei nº 6.015/1973	https://www.planalto.gov.br/ccivil_03/leis/l6015compilada.htm	federal	Regulamenta a Lei de Registros Públicos.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9l0meg0029boame3wzch02	Lei nº 9.784/1999	https://www.planalto.gov.br/ccivil_03/leis/l9784.htm	federal	Regula o Processo Administrativo no âmbito da Administração Pública Federal.	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9l2q09002fboamw6bfwo4w	Provimento nº 11/2023 – CGJ/PE	https://portal.tjpe.jus.br/web/corregedoria/codigos-de-normas	estadual	Regulamenta o Código de Normas dos Serviços Notariais e Registrais do Estado de Pernambuco (CNSNR - PE/2023).	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmq9j1frn0000boamvyqh9qnc	\N	
cmq9sv8vo000vg5ah3julaleh	LEI Nº 5.194/1996	https://www.planalto.gov.br/ccivil_03/leis/L5194.htm	federal	Regula o exercício das profissões de Engenheiros	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9sw2oj000xg5ah6tx0gdlq	NBR 14.653	https://memoria-spu.gestao.gov.br/wp-content/uploads/tainacan-items/54791/203875/ABNT-NBR-14653-1-2019.pdf	federal		cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9sxcuu000zg5ah8lb9q2yr	Portaria SAD nº 2.679/2024	https://www.pge.pe.gov.br/App_Themes/PORTARIA%20SAD%20N%C2%BA%202.679%20DO%20DIA%2020%20DE%20AGOSTO%20DE%202024%20-%20Avaliac%CC%A7a%CC%83o%20imoveis.pdf	normativa_interna		cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9kraw1001lboams03lnty6	Decreto nº 39.639/2013	https://legis.alepe.pe.gov.br/texto.aspx?id=15359&tipo=TEXTOORIGINAL	estadual	Reavaliação, Redução e Depreciação dos Bens do Estado	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-16 16:51:35.463	Allan Soares
cmq9ks1hn001nboamqrhnmg1t	Decreto nº 40.222/2013	https://legis.alepe.pe.gov.br/texto.aspx?id=14036&tipo=TEXTOORIGINAL	estadual	Sistema Integrado de Gestão - PE Integrado	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:23:04.211	Allan Soares
cmq9ksuj8001pboam9mvluk8c	Decreto nº 42.589/2016	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=42589&complemento=0&ano=2016&tipo=&url=#:~:text=Disp%C3%B5e%20sobre%20as%20normas%20gerais,II%20e%20IV%20do%20art	estadual	Normas Gerais relativas ao Leilão	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:23:13.175	Allan Soares
cmq9l21al002dboam2m9k5hki	Desfazimento de Semoventes Inservíveis	https://www.gov.br/capes/pt-br/centrais-de-conteudo/portaria-448-2002-material-decapital-deconsumo-pdf	federal	Detalhamento das Naturezas de Despesa	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:23:28.073	Allan Soares
cmq9ku5ka001tboamjxo18q4a	Lei Complementar nº 141/2009	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=2&numero=141&complemento=0&ano=2009&tipo=&url=	estadual	Dispões sobre o Modelo Integrado de Gestão	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:23:34.52	Allan Soares
cmq9kw9zw001zboamxypxte3a	Lei nº 14.236/2010	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=14236&complemento=0&ano=2010&tipo=&url=	estadual	Dispões sobre a Política Estadual de Resíduo Sólido	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:23:42.866	Allan Soares
cmq9kxolx0021boami5dd6wn2	Lei nº 14.680/2012	https://legis.alepe.pe.gov.br/texto.aspx?id=9831&tipo=TEXTOORIGINAL	estadual	Baixa de Veículos Inservíveis	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:23:54.192	Allan Soares
cmq9kz89z0025boammah0dmzn	Lei nº 7.741/1978	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=7741&complemento=0&ano=1978&tipo=&url=	estadual	Institui o Código de Administração Financeira do Estado	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:24:02.368	Allan Soares
cmq9kzt7d0027boambu1eqi6a	Lei nº 9.504/1997	https://www.planalto.gov.br/ccivil_03/leis/l9504.htm	federal	Dispõe sobre Doação de Bens em ano Eleitoral	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:24:11.369	Allan Soares
cmq9l186h002bboamnudi7v6w	Portaria Conjunta SAD/SDS nº 035/2017	https://pt.scribd.com/document/772715769/Portaria-Sad-sds-035-2017-Semoventes-Desfazimento	estadual	Desfazimento de Semoventes Inservíveis	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 12:24:22.959	Allan Soares
cmq9kps3w001hboamjv1y4016	Decreto nº 35.706/2010	https://legis.alepe.pe.gov.br/texto.aspx?id=22163&tipo=TEXTOORIGINAL	estadual	Institui o Comitê Estadual de Resíduos Sólidos 	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-09-01 17:21:53.854	Fabio Oliveira Araújo da Silva
cmq9sy8rq0011g5ahrzjc0tve	RESOLUÇÃO N° 1.073/2016	https://normativos.confea.org.br/Ementas/Visualizar?id=59111	federal	Regulamenta a atribuição de títulos, atividades, competências e campos de atuação profissionais aos profissionais registrados no Sistema Confea/Crea para efeito de fiscalização do exercício profissional no âmbito da Engenharia e da Agronomia.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9sz9ta0013g5ah2fgd16zm	RESOLUÇÃO Nº 1.137/2023	https://normativos.confea.org.br/Ementas/Visualizar?id=76099	federal	Dispõe sobre a Anotação de Responsabilidade Técnica - ART, o Acervo Técnico-Profissional e o Acervo Operacional, e dá outras providências.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9t01on0015g5ah9wd7l4cq	RESOLUÇÃO Nº 218/1973	https://normativos.confea.org.br/Ementas/Visualizar?id=266	federal	Discrimina atividades das diferentes modalidades profissionais da Engenharia, Arquitetura e Agronomia.\n	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9t18vv0017g5ah33e77vmd	RESOLUÇÃO Nº 345/1990.	https://normativos.confea.org.br/Ementas/Visualizar?id=393	federal	Dispõe quanto ao exercício por profissional de Nível Superior das atividades de Engenharia de Avaliações e Perícias de Engenharia.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	\N	
cmq9t34i00019g5ahl0keyhk6	LEI Nº 10.098/2000	https://www.planalto.gov.br/ccivil_03/leis/l10098.htm	federal	Estabelece normas gerais e critérios básicos para a promoção da acessibilidade das pessoas portadoras de deficiência ou com mobilidade reduzida, e dá outras providências.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rhpc1000dg5ah7p97x6qj	\N	
cmq9t3t2o001bg5ah06xmhdzn	LEI Nº12.378/2010	https://www.planalto.gov.br/ccivil_03/_ato2007-2010/2010/lei/l12378.htm	federal	Regulamenta o exercício da Arquitetura e Urbanismo; cria o Conselho de Arquitetura e Urbanismo do Brasil - CAU/BR e os Conselhos de Arquitetura e Urbanismo dos Estados e do Distrito Federal - CAUs; e dá outras providências.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rhpc1000dg5ah7p97x6qj	\N	
cmq9t4bsb001dg5ahphwdu4hj	RESOLUÇÃO N°184/2019	https://transparencia.caubr.gov.br/resolucao184/	federal	Altera as Resoluções CAU/BR nº 91, de 9 de outubro de 2014, e nº 93, de 7 de novembro de 2014, que dispõem, respectivamente, sobre o Registro de Responsabilidade Técnica (RRT) e sobre a emissão de certidões pelos Conselhos de Arquitetura e Urbanismo dos Estados e do Distrito Federal (CAU/UF) e dá outras providências.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rhpc1000dg5ah7p97x6qj	\N	
cmq9t4zu8001fg5ahp5twdwy6	RESOLUÇÃO Nº177/2019	https://transparencia.caubr.gov.br/resolucao177/	federal	Altera a Resolução CAU/BR n° 91, de 9 de outubro de 2014, que dispõe sobre o Registro de Responsabilidade Técnica (RRT), quanto ao RRT Mínimo e RRT Retificador, cria o RRT Social e dá outras providências.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rhpc1000dg5ah7p97x6qj	\N	
cmq9t5o22001hg5ahgkpiaobj	RESOLUÇÃO Nº75/2014	https://transparencia.caubr.gov.br/resolucao75/	federal	Dispõe sobre a indicação da responsabilidade técnica referente a projetos, obras e serviços no âmbito da Arquitetura e Urbanismo, em documentos, placas, peças publicitárias e outros elementos de comunicação.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rhpc1000dg5ah7p97x6qj	\N	
cmq9t6i0l001jg5ah0m4ok9kl	RESOLUÇÃO Nº91/2014	https://transparencia.caubr.gov.br/resolucao91/	federal	Dispõe sobre o Registro de Responsabilidade Técnica (RRT) referente a projetos, obras e demais serviços técnicos no âmbito da Arquitetura e Urbanismo e dá outras providências.	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rhpc1000dg5ah7p97x6qj	\N	
cmq9kp6za001fboamhnrookeb	Decreto nº 12.785/2025	https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/decreto/d12785.htm	federal	Formas de Desfazimento	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-16 16:51:03.422	Allan Soares
cmq9kqgmk001jboamm9004ifs	Decreto nº 39.335/2013	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=38875&complemento=0&ano=2012&tipo=&url=#:~:text=Institui%20o%20Subsistema%20de%20Gest%C3%A3o,Administrativa%20do%20Poder%20Executivo%20Estadual.&text=VI%20-%20descentralizar%20as%20atividades%20relativas%20%C3%A0%20%C3%A1rea%20de%20patrim%C3%B4nio%20e%20materiais	estadual	Institui o Subsistema de Gestão de Patrimônio e Materiais	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-16 16:51:25.847	Allan Soares
cmruwigb10016d883cbvirylw	Gestão e racionalização do consumo de água	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=40903&complemento=0&ano=2014&tipo=&url=#:~:text=DECRETO%20N%C2%BA%2040.903%2C%20DE%2018,II%20e%20IV%20do%20art.	estadual	Dispõe sobre a gestão e a racionalização do consumo de água no âmbito do Poder Executivo Estadual e de suas entidades vinculadas.	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn35yi0002bqr5ck780vyc	\N	
cmruwliek0018d8835m2ky4wi	Gestão e uso eficiente de energia elétrica	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=16062&complemento=0&ano=2017&tipo=&url=	estadual	Dispõe sobre a gestão e o uso eficiente de energia elétrica nos imóveis de uso do Poder Executivo Estadual.	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn35yi0002bqr5ck780vyc	\N	
cmruv8uzh0010d88344dlrlbp	Dispositivo à respeito da utilização de veículos oficiais.\t	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=47424&complemento=0&ano=2019&tipo=&url=	estadual	Dispõe sobre a utilização de veículos oficiais pelos\nórgãos e entidades do Poder Executivo Estadual.	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	2026-08-03 13:44:47.39	Diego Santos Rolim 
cmsdahjzc00392ggiiw323ox6	Normas gerais relativas ao leilão de bens inservíveis, apreendidos ou abandonados.	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=42589&complemento=0&ano=2016&tipo=&url=	estadual	Dispõe sobre as normas gerais relativas ao leilão, realizado pela Secretaria de Administração, para a alienação de bens inservíveis, apreendidos ou abandonados. 	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	\N	
cmsdawi3w003b2ggi4tasrthd	Dispositivo sobre o uso de veículos oficiais no âmbito do Poder Executivo Estadual.	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=16211&complemento=0&ano=2017&tipo=&url=	estadual	Dispõe sobre o uso de veículos oficiais no âmbito do Poder Executivo Estadual.	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	\N	
cmsf1erh500732ggiq52nfx24	Responsabilidade em casos de acidentes e infrações de trânsito com veículos oficiais	https://legislacao-sad.pe.gov.br/Legislacao/html/html.html?portaria_sad_1047__12_07_2013.htm	estadual	Trata da responsabilização em casos de acidentes e infrações de trânsito com veículos oficiais	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	\N	
cmsf1kaqv00752ggi89596jji	Especificações do veículos oficiais 	https://legislacao-sad.pe.gov.br/Legislacao/html/html.html?portaria_sad_1046___12_07_2013.htm	estadual	Especifica os veículos oficiais, considerando sua classificação.	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	\N	
cmsf1p65j00772ggii01ad3oe	Requisitos mínimos de qualificação relativos ao exercício da função de gestor nas especialidades de telemática, patrimônio e frota 	https://legislacao-sad.pe.gov.br/Legislacao/html/html.html?portaria_sad_1045___12_07_2013.htm	estadual	Regulamenta os requisitos mínimos de qualificação relativos ao exercício da função de gestor nas especialidades de telemática, patrimônio e frota 	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	\N	
cmsf1ry1600792ggiuhl1kjqu	Uso, identificação, aquisição, locação e cadastro dos veículos oficiais do Poder Executivo Estadual\t	https://legislacao-sad.pe.gov.br/Legislacao/html/html.html?portaria_sad_556___29_04_2013.htm	estadual	Dispõe sobre uso, identificação, aquisição, locação e cadastro dos veículos oficiais do Poder Executivo Estadual	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn2i7v0000bqr5csm0w82l	\N	
cmtlh3qq50073lviesnwx50kg	Lei de Licitações e Contratos Administrativos	https://www.planalto.gov.br/ccivil_03/_ato2019-2022/2021/lei/l14133.htm	federal	Estabelece normas gerais de licitação e contratação para as Administrações Públicas diretas, autárquicas e fundacionais da União, dos Estados, do Distrito Federal e dos Municípios	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn3l1x0006bqr58awnhiel	\N	
cmtlhcgne0079lvie6w5sypic	Regulamenta a Lei Federal nº 14.133 de 2021, no que se refere aos agentes públicos que desempenham funções essenciais nos procedimentos de contratações públicas.	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=51651&complemento=0&ano=2021&tipo=&url=	estadual	Regulamenta as competências dos agentes públicos que desempenham funções essenciais nos procedimentos de contratação pública realizados no âmbito da Administração Pública Estadual, direta, autárquica ou fundacional	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	cmrtn3l1x0006bqr58awnhiel	\N	
\.


--
-- Data for Name: Noticia; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Noticia" (id, titulo, subtitulo, autor, "dataPublicacao", "imagemPrincipal_id", "imagemPrincipal_filesize", "imagemPrincipal_width", "imagemPrincipal_height", "imagemPrincipal_extension", "imagemPrincipalAlt", corpo, destaque, resumo, slug, "areaResponsavel", "createdAt", "createdBy", subarea, ativo) FROM stdin;
cmq9rkwj7000fg5ahnyowdrmz	Lorem ipsum	Lorem ipsum	cmq6r6jqo0000elnou72iyd14	2026-06-11 17:21:11.261	S4o-1v7g-aJm37eoIf7ISQ	1397165	5472	3648	jpg	lorem	[{"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Qui consectetur quisquam At exercitationem incidunt ut ullam voluptatem eos pariatur cumque qui rerum quas sit laborum enim. Non explicabo magnam ut blanditiis dolore aut soluta voluptatibus ad provident culpa. Quo voluptatem repudiandae et explicabo nesciunt eos aspernatur pariatur et tempore commodi cum dolorem eaque ex quibusdam dolores?"}]}, {"type": "paragraph", "children": [{"text": "Aut quisquam dolor et minima autem et excepturi fuga sed dolor molestiae non repudiandae dolores. Qui asperiores repudiandae id tenetur iure est debitis galisum sit facere ducimus qui laboriosam quia sed veritatis architecto? Et accusantium maxime id repudiandae corrupti quo tempore voluptatum qui dolorem doloribus est eius numquam. Ea dolor harum vel nesciunt sint sit animi dignissimos aut dignissimos ratione et minus officia est corporis dicta."}]}, {"type": "paragraph", "children": [{"text": "Eos saepe voluptatum ea internos corporis ea sint modi. Et dolorem sunt in veritatis velit eos voluptate officia qui dolorem amet ut magni alias aut eligendi recusandae. Ea quasi itaque quo ducimus optio ab nisi fugiat qui autem quidem sed nobis modi. Sed quas debitis eum repellat tenetur rem voluptatibus eaque."}]}]	t	Lorem Ipsun	lorem	cmq81pn5v0001j9azrqcx4d99	\N		cmq9rhpc1000dg5ah7p97x6qj	t
cmrxwuxoa000iw8inyqh968qv	O Estado Celebra sua Memória Arquitetônica com Painel sobre o Patrimônio Imóvel	Evento promove reflexões sobre a importância da preservação do patrimônio imobiliário e destaca a arquitetura como elemento fundamental da identidade cultural pernambucana.	cmrkom6340000esf0tqclr2dl	2026-07-23 03:00:00	x_O2IBwkNbEw7S_BgdH9dA	2687760	5371	3581	jpg	Participantes acompanham painel sobre a preservação do patrimônio imóvel e da memória arquitetônica de Pernambuco.	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "A preservação do patrimônio imóvel representa um dos pilares para a valorização da história, da cultura e da identidade de Pernambuco. Com esse propósito, foi realizado o painel"}, {"bold": true, "text": "\\"O Estado Celebra sua Memória Arquitetônica\\""}, {"text": ", reunindo especialistas, gestores públicos e profissionais da área para discutir a importância da conservação dos bens arquitetônicos e históricos do Estado."}]}, {"type": "paragraph", "children": [{"text": "O encontro proporcionou uma reflexão sobre o papel do patrimônio imóvel na construção da memória coletiva, destacando edifícios históricos, espaços públicos e monumentos que representam diferentes períodos da formação social, econômica e cultural pernambucana."}]}, {"type": "paragraph", "children": [{"text": "Durante o painel, foram apresentados exemplos de iniciativas voltadas à preservação, restauração e uso sustentável dos imóveis públicos, evidenciando a necessidade de conciliar a conservação do patrimônio com as demandas contemporâneas da sociedade."}]}, {"type": "paragraph", "children": [{"text": "Além de contribuir para a valorização da identidade cultural, a preservação dos bens imóveis fortalece o turismo, incentiva a educação patrimonial e amplia o conhecimento da população sobre a importância da proteção dos espaços que fazem parte da história do Estado."}]}, {"type": "paragraph", "children": [{"text": "A Secretaria de Administração reafirma seu compromisso com a gestão responsável do patrimônio público, desenvolvendo ações que promovam a conservação, a modernização e o uso adequado dos imóveis estaduais, sempre respeitando seu valor histórico, arquitetônico e cultural."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	t	Painel reúne especialistas para discutir a preservação do patrimônio imóvel e reforça a importância da arquitetura histórica na construção da memória e da identidade de Pernambuco.	o-estado-celebra-sua-memoria-arquitetonica-com-painel-sobre-o-patrimonio-imovel	cmq6yxa510000nh1tnduds1mc	\N		cmq9j1frn0000boamvyqh9qnc	t
cmq9k32m60012boamq05d5shl	Evolução do Ecossistema de Contratações Públicas de Pernambuco é tema da nova edição da Maratona Compras Públicas	Maratona de compras públicas	cmq6r6jqo0000elnou72iyd14	2026-06-11 13:51:22.055	RzP1YSLvxfplJXSKOFoRFQ	4748234	6016	4016	jpg	tag	[{"type": "paragraph", "children": [{"text": "A Secretaria de Administração (SAD) e a Agência Estadual de Tecnologia da Informação (ATI) realizaram, nesta terça-feira (18), a Maratona Compras Públicas - Evolução do Ecossistema de Contratações Públicas de Pernambuco. A nova edição do evento, promovida na Faculdade de Administração e Direito da Universidade de Pernambuco (FCAP/UPE), contou com palestras, apresentação do projeto Mapear e lançamento do novo Sistema de Governança de Contratações.\\nVoltado para agentes de fase preparatória e agentes de contratação, o encontro abordou as principais entregas de transformação digital no Estado. Representando a secretária de Administração, Ana Maraíza, a secretária executiva de Contratações Públicas, Nayllê Siqueira, ressaltou a importância do evento. “O objetivo desta edição da Maratona Compras Públicas é mostrar o quanto avançamos na modernização das contratações públicas, gerando mais eficiência, governança e novas entregas para a população. Sinto orgulho de cada ação que todos nós fazemos em razão dos benefícios para a sociedade”, destacou.\\nEm seguida, o gerente geral da Central de Licitações do Estado (GGCLE), Bruno Cintra, falou sobre a atuação da GGCLE. “Nós melhoramos muito os procedimentos e, para continuar esse aperfeiçoamento, é necessário o auxílio das ferramentas de tecnologia da informação, como a inteligência artificial, para monitorar, controlar e aprimorar esses processos”, avaliou.\\nAinda dentro da programação, o diretor de TI e Transformação Digital da ATI, Rafael Soares, e o diretor da Central IT, Eduardo Máximo, abordaram o tema “A Nova Era da Inteligência na Gestão Pública”. Eles também participaram do lançamento do novo Sistema de Governança de Contratações (SGC), que tem o objetivo de centralizar e gerenciar todas as contratações planejadas, fortalecendo a governança e entregando mais eficiência ao processo público.\\nA Maratona Compras Públicas - Evolução do Ecossistema de Contratações Públicas de Pernambuco também teve a participação do gerente de Apoio à Fase Preparatória de Precificação e Gestão de Riscos, Diego Figueiroa, que apresentou o projeto Mapear, desenvolvido para otimizar o trabalho de cotação do valor estimado das licitações. Em seguida, o gerente de Planejamento de Compras Corporativas, Marcelo Coelho, abordou a importância do Plano de Contratações Anual (PCA) e o papel do agente de fase preparatória.\\nO evento desta terça-feira ainda teve as presenças do secretário executivo de Transformação Digital, Caio Scheidegger, do gerente de Relacionamento do Governo Digital da ATI, José Pacheco, além de servidores públicos de diversos órgãos ligados à área de contratações públicas."}]}]	t	Maratona de compras públicas	maratona-compras-publicas	cmq6yxa510000nh1tnduds1mc	\N		cmq9j1frn0000boamvyqh9qnc	t
cmq9jzq8i000zboam9nk4qe3h	Governo de Pernambuco injeta cerca de R$ 5 bilhões aquecendo a economia do Estado	Medida proporcionará o aumento significativo de empregos no final de 2025	cmq6r6jqo0000elnou72iyd14	2026-06-11 13:48:46.017	lZaOWnz3WTy3J5rnTXfURQ	940991	3500	2333	jpg	INFORMAÇÃO	[{"type": "paragraph", "children": [{"text": "O Governo do Estado injetará, neste final de ano, cerca de R$ 5 bilhões na economia pernambucana com o pagamento da folha salarial dos meses de novembro, dezembro e do 13º salário. A ação beneficiará servidores públicos ativos, aposentados e pensionistas do Estado. O pagamento deste mês acontece na próxima sexta-feira (28). Já o décimo 13º salário será quitado no dia 19 de dezembro e a folha salarial do mesmo mês será efetuada no dia 30.\\r\\nA medida beneficiará cerca de 234 mil servidores, sendo 129,9 mil ativos, 78,3 mil aposentados e 26,6 mil pensionistas. A secretária de Administração, Ana Maraíza, enfatiza a importância da ação. “Com a garantia do pagamento dos salários de novembro, dezembro e do 13º, o Governo do Estado demonstra o compromisso com o servidor público e reafirma a valorização desses profissionais que diariamente dedicam seu trabalho para atender à população e ofertar serviços públicos de qualidade”, afirmou a secretária."}]}]	t	Medida proporcionará o aumento significativo de empregos no final de 2025.	governo-injeta-5milhoes	cmq6yxa510000nh1tnduds1mc	\N		cmq9j1frn0000boamvyqh9qnc	t
cmq9jw5zr000wboam4ifx9wd9	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24 desse mês	Leilão de bens móveis	cmq6r6jqo0000elnou72iyd14	2026-06-11 13:45:59.698	-oYEnjMnzxLTLbzn9d1pKA	1397165	5472	3648	jpg	tag	{"ativo": false, "destaque": false}	f	Automóveis, motocicletas, sucatas de informática, móveis e de outros tipos de materiais fazem parte do 5º Leilão de Bens Móveis de 2025.	leilao-bens-moveis	cmq6yxa510000nh1tnduds1mc	\N		cmq9j1frn0000boamvyqh9qnc	f
cmrc3ww16000dtspszf1dls7l	Lorem ipsum dolor sit amet	Ea enim galisum sed magni asperiores et error expedita id numquam	cmq6r6jqo0000elnou72iyd14	2026-07-08 03:00:00	eFk36oofHaHAb63wUFtpqg	2225115	3360	5040	jpg	teste	[{"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Ea enim galisum sed magni asperiores et error expedita id numquam ducimus sed aliquam similique. Qui rerum itaque qui veniam unde ut pariatur labore."}]}, {"type": "paragraph", "children": [{"text": "Et provident autem eos quasi iusto et maxime deleniti et provident voluptatum sit officiis autem. Cum voluptatem nobis id asperiores necessitatibus et quia quam ea reprehenderit ipsa! Est odio excepturi vel natus modi ut provident possimus. 33 dignissimos optio aut porro maiores et nostrum nihil ut molestias nulla est illo Quis et facilis voluptatum ut vero voluptas."}]}]	t	Et provident autem eos quasi iusto et maxime deleniti et provident voluptatum sit officiis autem. Cum voluptatem 	lorem-ipsun	cmq81pn5v0001j9azrqcx4d99	\N		cmq9rhpc1000dg5ah7p97x6qj	t
cmrc49t6w000htspszb60i67b	Lorem ipsum dolor sit amet. Non dolorem cumque ut quidem harum et distinctio sint	Aut eveniet fuga sit sapiente doloribus sed magnam omnis hic libero internos	cmq6r6jqo0000elnou72iyd14	2026-07-08 03:00:00	qk4Umdtd09286444zRgLMA	1956421	5371	3581	jpg	teste	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Et unde iste et esse quam ut quia iste et dolores galisum. Ea voluptatem perspiciatis vel voluptatem saepe eos sequi blanditiis ab dicta Quis qui omnis quisquam? Rem eius voluptatibus qui labore voluptatem qui autem saepe."}]}, {"type": "paragraph", "children": [{"text": "Qui soluta obcaecati qui alias omnis vel corporis laudantium et quasi nulla ut eius voluptatibus. Ut dolor error id repellat quasi ad quisquam unde sit facilis voluptas cum facilis neque est quibusdam pariatur."}]}, {"type": "paragraph", "children": [{"text": "Qui laudantium galisum hic ipsum eligendi rem omnis voluptatibus id velit alias. Sit dolor quia et dolor veritatis qui aliquam numquam eum totam culpa et rerum quia. Et quasi minus At distinctio voluptatem in recusandae repellat hic cumque consequatur aut reiciendis suscipit hic minus accusamus."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	t	Lorem ipsum dolor sit amet. Et unde iste et esse quam ut quia iste et dolores galisum. Ea voluptatem perspiciatis vel voluptatem saepe eos sequi blanditiis ab dicta Quis qui omnis quisquam? Rem eius voluptatibus qui labore voluptatem qui autem saepe.	teste	cmq81pn5v0001j9azrqcx4d99	\N		cmq9rha92000bg5ah7gkhkjyd	t
cmrxwpt3f0009w8in7mt42zho	5º Leilão de Bens Móveis é promovido pela SAD no próximo dia 24 desse mês	Certame será realizado na modalidade on-line e disponibiliza veículos, equipamentos e outros bens inservíveis da Administração Pública Estadual. Os interessados devem realizar cadastro prévio e observar as regras previstas no edital.	cmrkom6340000esf0tqclr2dl	2026-07-23 03:00:00	817_YhT-9HG9lZhOa-tIMw	921133	5180	3453	jpg	Banner de divulgação do 5º Leilão de Bens Móveis promovido pela Secretaria de Administração de Pernambuco.	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "A Secretaria de Administração de Pernambuco (SAD), por meio da Secretaria Executiva de Gestão do Patrimônio, realizará, no próximo dia"}, {"bold": true, "text": "24 de junho de 2026"}, {"text": ", o"}, {"bold": true, "text": "5º Leilão de Bens Móveis de 2025"}, {"text": ", destinado à alienação de bens móveis considerados inservíveis para a Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "O leilão será realizado na modalidade eletrônica, proporcionando maior transparência, competitividade e ampla participação dos interessados. Entre os itens disponibilizados poderão estar veículos, mobiliários, equipamentos de informática, máquinas e outros bens patrimoniais classificados como ociosos, antieconômicos ou irrecuperáveis."}]}, {"type": "paragraph", "children": [{"text": "Os interessados deverão efetuar previamente o cadastro junto ao leiloeiro oficial responsável pela condução do certame, observando atentamente os prazos, documentos exigidos e demais condições estabelecidas no edital."}]}, {"type": "paragraph", "children": [{"text": "É importante que todos os participantes leiam integralmente o edital, onde constam as regras para habilitação, visitação dos bens, forma de pagamento, retirada dos lotes e demais procedimentos necessários para participação no leilão."}]}, {"type": "paragraph", "children": [{"text": "A realização dos leilões integra a política de gestão patrimonial do Governo de Pernambuco, promovendo a destinação adequada de bens públicos, a racionalização dos ativos estaduais e a geração de receitas para os cofres públicos."}]}, {"type": "paragraph", "children": [{"text": "Para mais informações, os interessados devem consultar o edital e acompanhar as publicações oficiais da Secretaria de Administração."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	t	A Secretaria de Administração realiza, no dia 24 de junho, o 5º Leilão de Bens Móveis de 2025. Interessados devem realizar cadastro prévio e consultar o edital para conhecer todas as regras de participação.	5-leilao-de-bens-moveis	cmq6yxa510000nh1tnduds1mc	\N		cmqgnv5xk00003adnqj7bkkdv	t
cmrj6gwot0014tspsbzzwtnq8	Gerência de Frota registra 81% da meta anual de arrecadação com leilões de bens móveis até maio de 2026	Arrecadação acumulada atingiu R$ 3,455 milhões até o mês de maio de 2026.	cmq6r6jqo0000elnou72iyd14	2026-05-30 03:00:00	DRIQLcH4MML450BOZvjNDg	2275162	1376	768	png	teste	[{"type": "paragraph", "children": [{"text": "A Gerência Geral de Serviços Corporativos, através da Gerência de Frota por meio da gestão da Arrecadação com Leilões de Bens Móveis, alcançou um resultado expressivo nos cinco primeiros meses de 2026. Até maio, a arrecadação acumulada atingiu R$ 3,455 milhões, o que representa 81% da meta anual estabelecida de R$ 4,276 milhões."}]}, {"type": "paragraph", "children": [{"text": "O desempenho demonstra a efetividade das ações desenvolvidas para a destinação de bens móveis inservíveis da Administração Pública Estadual, contribuindo para a otimização da gestão patrimonial, a racionalização dos ativos públicos e o incremento da arrecadação estadual."}]}, {"type": "paragraph", "children": [{"text": "De acordo com os dados do acompanhamento mensal, o resultado acumulado mantém trajetória de crescimento ao longo do ano, restando R$ 0,83 milhão para o alcance da meta prevista para 2026."}]}, {"type": "paragraph", "children": [{"text": "O monitoramento contínuo desse indicador reforça o compromisso da GGCOR com a eficiência na gestão dos bens públicos, promovendo maior transparência, sustentabilidade e geração de receitas para o Estado de Pernambuco."}]}]	t	81% da meta de arrecadação com leilões de bens móveis anual atingida em maio de 2026	teste2	cmq81pvoq0003j9azcu4vg0ws	\N		cmrtn2i7v0000bqr5csm0w82l	t
cmshrk56r00872ggi2kh44cst	Superintendência de Energias Renováveis alcança R$ 1,8 milhão em economia com a migração para o Mercado Livre de Energia até março de 2026	Economia acumulada foi de R$ 1,8 milhão, correspondente a 19,98% da meta anual, estabelecida em R$ 9,0 milhões.	cmrkp2oro00006q71uhutfoc7	2026-04-10 03:00:00	kx-jOo-ms2akRWalQ-QU_g	3601092	6000	4000	jpg	teste	[{"type": "paragraph", "children": [{"text": " Superintendência de Energias Renováveis segue promovendo iniciativas voltadas à eficiência energética do Estado. Até março de 2026, o indicador Economia na Contratação de Energia no Mercado Livre em relação ao Mercado Cativo registrou uma economia acumulada de R$ 1,8 milhão, correspondente a 19,98% da meta anual, estabelecida em R$ 9,0 milhões."}]}, {"type": "paragraph", "children": [{"text": "O resultado é decorrente das ações de gestão da contratação de energia elétrica no Ambiente de Contratação Livre (ACL), estratégia que permite a redução dos custos com o fornecimento de energia para os órgãos e entidades da Administração Pública Estadual, gerando maior eficiência na aplicação dos recursos públicos."}]}, {"type": "paragraph", "children": [{"text": "A economia acumulada é composta pelos resultados obtidos nos três primeiros meses de 2026: R$ 651.487,00 em janeiro, R$ 590.241,00 em fevereiro e R$ 556.126,00 em março, demonstrando a consistência dos ganhos alcançados desde o início do exercício."}]}, {"type": "paragraph", "children": [{"text": "A Gerência Geral de Serviços Corporativos através da Superintendência de Energias Renováveis mantém o acompanhamento permanente desse indicador e das migrações para o Mercado Livre de Energia, reforçando seu compromisso com a modernização da gestão pública, a sustentabilidade das contratações e a geração de economias que contribuem para a melhoria da eficiência da Administração Pública Estadual."}]}]	t	19,98% da meta anual atingida até março de 2026.	teste5	cmq81pvoq0003j9azcu4vg0ws	\N		cmrtn35yi0002bqr5ck780vyc	t
cmshr0jeb00842ggi69t9qoil	Gerência de Frota alcança 73,20% da meta anual de economia com a manutenção da frota até julho de 2026	Diferença entre o Orçado e o Executado com a Manutenção da Frota registrou uma economia acumulada de R$ 1,061 milhão	cmrkp2oro00006q71uhutfoc7	2026-05-28 03:00:00	Qx9xIdRV4_fMdrzeSJjCZg	3711798	5760	3840	jpg	teste	[{"type": "paragraph", "children": [{"text": "A Gerência Geral de Serviços Corporativos (GGCOR) segue avançando na promoção da eficiência dos contratos corporativos do Estado através da Gerência de Frota. Até julho de 2026, o indicador Economia com a Diferença entre o Orçado e o Executado com a Manutenção da Frota registrou uma economia acumulada de R$ 1,061 milhão, equivalente a 73,20% da meta anual, fixada em R$ 1,45 milhão."}]}, {"type": "paragraph", "children": [{"text": "O resultado reflete as ações de gestão e fiscalização dos contratos de manutenção da frota estadual, assegurando maior controle sobre os custos, otimização dos recursos públicos e melhoria da eficiência operacional dos serviços."}]}, {"type": "paragraph", "children": [{"text": "O acompanhamento mensal demonstra a evolução consistente do indicador ao longo do exercício, consolidando a economia alcançada nos cinco primeiros meses do ano e reforçando o compromisso da GGCOR com a busca contínua por melhores resultados para a Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "A expectativa é manter o desempenho nos próximos meses, ampliando as economias obtidas e contribuindo para o alcance da meta estabelecida para 2026, fortalecendo a gestão responsável dos recursos públicos e a sustentabilidade das contratações corporativas do Estado."}]}]	t	Economia acumulada de R$ 1,061 milhão, equivalente a 73,20% da meta anual, fixada em R$ 1,45 milhão.	teste4	cmq81pvoq0003j9azcu4vg0ws	\N		cmrtn2i7v0000bqr5csm0w82l	t
cmtliqh2u007vlviek7f416fn	Autorizada restauração do antigo prédio do Diario	A governadora Raquel Lyra assinou, nesta terça (26), a ordem de serviço para obras de preservação e requalificação de edificações do patrimônio histórico do estado, dentre elas, o antigo prédio do Diario de Pernambuco	cmqb02fid0000zhxvp8gj34av	2026-09-03 03:00:00	CNe5SHQWt-f1NoggHf5qmQ	202096	960	640	jpg	Edifício da antiga sede do Diario de Pernambuco (Foto: Amália Souto e Silva)	[{"type": "paragraph", "children": [{"text": "Cadu Silva"}]}, {"type": "paragraph", "children": [{"text": "Publicado: 26/05/2026 às 13:32"}]}, {"type": "paragraph", "children": [{"text": "Fonte:"}, {"href": "https://www.diariodepernambuco.com.br/vida-urbana/2026/05/11715036-autorizada-restauracao-do-antigo-predio-do-diario-simbolo-da-memoria-jornalistica-do-estado.html", "type": "link", "children": [{"text": "https://www.diariodepernambuco.com.br/vida-urbana/2026/05/11715036-autorizada-restauracao-do-antigo-predio-do-diario-simbolo-da-memoria-jornalistica-do-estado.html"}]}, {"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "A governadora Raquel Lyra assinou, no começo da tarde desta terça-feira (26), a ordem de serviço para o início das obras de restauração do antigo prédio do Diario de Pernambuco, na Praça da Independência, no bairro de Santo Antônio, área central do Recife."}]}, {"type": "paragraph", "children": [{"text": "O investimento para a requalificação do imóvel, que abrigará a Secretaria de Cultura do estado, será de R$ 32 milhões."}]}, {"type": "paragraph", "children": [{"text": "Tombado pelo Governo do estado, o imóvel integra um dos conjuntos arquitetônicos mais tradicionais da capital e atravessa mais de um século ligado à história política, cultural e jornalística de Pernambuco."}]}, {"type": "paragraph", "children": [{"text": "Erguido entre 1901 e 1903 pelo então proprietário do jornal, o conselheiro Rosa e Silva, o edifício foi projetado para abrigar jornal mais antigo em circulação da América Latina."}]}, {"type": "paragraph", "children": [{"text": "Desde então, o prédio acompanhou revoluções, crises políticas, períodos de censura, visitas ilustres e episódios que marcaram Pernambuco e o Brasil."}]}, {"type": "paragraph", "children": [{"text": "A sede do Diario funcionava como um ponto de encontro da cidade. Era na porta do jornal que os recifenses acompanhavam e buscavam informações sobre acontecimentos nacionais e internacionais e compartilhavam sentimentos diante de fatos que abalavam o mundo."}]}, {"type": "paragraph", "children": [{"text": "A governadora Raquel Lyra celebrou o resgate do antigo prédio do Diario de Pernambuco e seu valor democrático."}]}, {"type": "paragraph", "children": [{"text": "“Para além do resgate da"}, {"href": "https://www.gov.br/fundaj/pt-br/composicao/dimeca/biblioteca/acervos/publicacoes-digitalizadas/historia-da-imprensa-de-pernambuco-2/historia_da_imprensa_v02.pdf", "type": "link", "children": [{"bold": true, "text": "memória da imprensa pernambucana"}]}, {"text": ", o edifício ainda conta a história da nossa democracia. E a democracia do Brasil que passa por Pernambuco”, ressaltou."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Prédio símbolo da luta democrática"}]}, {"type": "paragraph", "children": [{"text": "Um dos episódios mais marcantes da trajetória do edifício aconteceu em março de 1945, nos últimos meses do Estado Novo, ditadura imposta por Getúlio Vargas. Pernambuco vivia sob forte repressão política."}]}, {"type": "paragraph", "children": [{"text": "O estudante da"}, {"href": "https://www.diariodepernambuco.com.br/tags/faculdade-de-direito-do-recife/", "type": "link", "children": [{"bold": true, "text": "Faculdade de Direito do Recife"}]}, {"text": ", Demócrito de Souza Filho, era um dos jovens que participavam ativamente de manifestações contra o regime e contra a atuação das forças de repressão no Estado."}]}, {"type": "paragraph", "children": [{"text": "Na véspera da sua morte, Demócrito e outros estudantes chegaram a rasgar uma fotografia do presidente em um restaurante frequentado por universitários no Recife. O ato provocou reação imediata da polícia política."}]}, {"type": "paragraph", "children": [{"text": "Perseguidos, os estudantes buscaram abrigo no antigo prédio do Diario de Pernambuco, que naquele momento funcionava também como espaço de resistência política e circulação de opositores do regime."}]}, {"type": "paragraph", "children": [{"text": "No dia 3 de março de 1945, uma manifestação contra o Estado Novo reuniu estudantes e militantes em frente ao edifício, na Praça da Independência."}]}, {"type": "paragraph", "children": [{"text": "Demócrito estava em uma das sacadas do prédio aguardando um pronunciamento do sociólogo Gilberto Freyre, quando policiais do governador Agamenon Magalhães abriram fogo contra a multidão."}]}, {"type": "paragraph", "children": [{"text": "Um dos disparos atingiu a cabeça do estudante, que caiu dentro da redação do jornal. O assassinato provocou forte repercussão em Pernambuco e ganhou dimensão nacional, ampliando a pressão política sobre o Estado Novo nos seus últimos meses de existência."}]}, {"type": "paragraph", "children": [{"text": "Após a morte do estudante, militares e agentes ligados ao governo ocuparam o prédio do Diario e impediram a circulação do jornal. As oficinas foram paralisadas numa tentativa de evitar que o crime fosse divulgado e associado à repressão do regime varguista."}]}, {"type": "paragraph", "children": [{"text": "Mesmo sob censura, o Diario conseguiu voltar a circular semanas depois, após decisão judicial. O editorial, assinado pelo diretor Aníbal Fernandes, trazia na manchete, com a grafia da época: “Continuaremos a denunciar os criminosos á Nação”."}]}, {"type": "paragraph", "children": [{"text": "O episódio foi mais um que transformou o edifício em símbolo da resistência à censura e da luta pela liberdade de imprensa em Pernambuco."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Empastelamentos e disputas políticas"}]}, {"type": "paragraph", "children": [{"text": "Antes do Estado Novo, a antiga sede do Diario já estava no centro de conflitos envolvendo poder e imprensa."}]}, {"type": "paragraph", "children": [{"text": "Em 1911, durante disputas políticas em Pernambuco, a redação foi invadida e destruída por aliados do general Dantas Barreto, adversário político de Rosa e Silva."}]}, {"type": "paragraph", "children": [{"text": "O ataque resultou no primeiro empastelamento da história do jornal, termo usado para definir a interrupção forçada de atividades de veículos de imprensa."}]}, {"type": "paragraph", "children": [{"text": "O Diario permaneceu sem circular por um longo período após o episódio."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Visitas históricas"}]}, {"type": "paragraph", "children": [{"text": "Ao longo do século 20, o prédio do Diario consolidou-se como um dos principais pontos de encontro da intelectualidade pernambucana."}]}, {"type": "paragraph", "children": [{"text": "Durante a gestão de Carlos Lira Filho, o espaço tornou-se referência para debates políticos, culturais e literários no Recife."}]}, {"type": "paragraph", "children": [{"text": "O prédio não passou despercebido por personagens históricos. Em novembro de 1968, a Rainha Elizabeth II esteve no Recife. Durante o trajeto da comitiva, chamou a atenção ao parar diante do prédio do jornal e acenar para os funcionários que estava na sacada."}]}, {"type": "paragraph", "children": [{"text": "Anos depois, já durante o período de redemocratização do país, o então presidente José Sarney visitou a antiga redação do jornal acompanhado de ministros, governadores e outras autoridades. Sarney havia atuado anteriormente como colaborador do periódico."}]}, {"type": "paragraph", "children": [{"text": "A redação do Diario funcionou no imóvel até 2004, quando o prédio passou a pertencer ao Governo de Pernambuco."}]}]	t	Emitida a ordem de serviço para obras de preservação e requalificação do antigo prédio do Diario de Pernambuco	diario_de_pernambuco	cmq81pn5v0001j9azrqcx4d99	\N		cmq9rhpc1000dg5ah7p97x6qj	t
\.


--
-- Data for Name: PaginaQuemSomos; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."PaginaQuemSomos" (id, "createdAt", "areaResponsavel", "createdBy", "muralTextoIntrodutorio", subarea, "timeTitulo", "tituloDaPagina") FROM stdin;
cmq9rfbp70009g5ah6bliwon4	\N	cmq81pn5v0001j9azrqcx4d99		Da mudança de layout até projetos complexos, do levantamento cartográfico à avaliação de imóveis. A área de arquitetura e engenharia está pronta com uma equipe própria, técnica e qualificada para atuar no Patrimônio Imobiliário da Administração Direta e Vinculada (IASSEPE, ATI e FUNAPE)  Estadual, conforme decreto nº 58.355/2025, de forma a preservar a história, atualizar demandas e permitir edificações seguras e eficientes para todo o Estado de Pernambuco.	\N	Nosso Time	Sobre
1	\N	cmq6yxa510000nh1tnduds1mc		Desde a maca do hospital à viatura policial. Da escola ao palácio do governo.\nTudo isso faz parte do patrimônio do Estado. E para dar conta de tudo é preciso uma equipe técnica capacitada e uma gestão eficiente. \nUma boa administração patrimonial leva a melhores políticas públicas e a um Estado mais próximo do cidadão. Esse é nosso propósito. 	\N	Nosso Time	Sobre
cmreyx3540010tsps2t8u6l90	2026-07-10 13:25:10.244	cmq81pvoq0003j9azcu4vg0ws		A área de Serviços Corporativos da Secretaria de Administração do Estado de Pernambuco é responsável por planejar, disciplinar, coordenar, executar e acompanhar as políticas públicas administrativas relacionadas à gestão dos serviços corporativos, nos temas Telemática, Frota, Energia (PPP e eficiência energética) e Água, no âmbito da Administração Pública Estadual.\n\nNossa atuação busca oferecer soluções integradas que atendam às necessidades dos órgãos e entidades estaduais, contribuindo para uma gestão mais moderna, transparente e orientada por resultados. 	cmrtn2i7v0000bqr5csm0w82l	Nosso time 	Sobre
\.


--
-- Data for Name: PortfolioImagens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PortfolioImagens" (id, titulo, imagem_id, imagem_filesize, imagem_width, imagem_height, imagem_extension, portfolio, ativo) FROM stdin;
cmqb7om340000tazh97sehe5m	lorem	4Fws-BsAmDcZ8ex-iz5vUw	4313073	5461	8192	jpg	cmqb1j1qg00001wainiagjo70	t
cmqb7pa720001tazh66dypr45	lorem 2	0csY7FWMTuKPtBftmu-3dA	1945470	5184	3888	jpg	cmqb1j1qg00001wainiagjo70	t
cmqb8v75b000185srktslzr8o	Lorem	kx3-Yx8E6mqasYhp0Coxew	856518	3024	4032	jpg	\N	t
cmqb8xjfu000685sr5zuhurld		7Q9Uo2cl-FgFDMYzrzUS6A	885786	5184	3456	jpg	cmqb8vtrh000285sry6i1c7m6	t
cmqb8xqk2000785sr028n6xzg		jgJNH-_Bw-poVHUil70qvg	2058319	4004	6000	jpg	cmqb8vtrh000285sry6i1c7m6	t
cmqb8xy01000885srkkps5wrm		det77cId2Mgl5uDJQKkrXg	862253	4200	2800	jpg	cmqb8vtrh000285sry6i1c7m6	t
cmqb8y6st000985sr54w01xyk		5R6YDaIKMGPL0jsN7uNaag	2167289	3468	4624	jpg	cmqb8vtrh000285sry6i1c7m6	t
\.


--
-- Data for Name: Portfolios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Portfolios" (id, titulo, slug, resumo, imagem_id, imagem_filesize, imagem_width, imagem_height, imagem_extension, "imagemAlt", corpo, "areaResponsavel", subarea, "createdAt", "createdBy", "updatedAt", "updatedBy", ativo) FROM stdin;
cmqb1j1qg00001wainiagjo70	Lorem	lorem	Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus.\n	5g1MBJiXZBe7_IVlztSjBA	605334	4016	6016	jpg	lorem	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "StartFragment"}]}, {"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus."}]}, {"type": "paragraph", "children": [{"text": "Quo fugit consequatur et soluta accusamus ad sunt blanditiis est quibusdam internos. A expedita sint et cupiditate assumenda sit assumenda voluptate. Et deserunt laborum et unde autem id sunt aliquid aut magni velit ut veritatis cupiditate. Et voluptatem earum eos ipsam error ut molestiae quae et totam deleniti."}]}, {"type": "paragraph", "children": [{"text": "EndFragment"}]}]	cmq81pn5v0001j9azrqcx4d99	cmq9rha92000bg5ah7gkhkjyd	\N	Gerado por Administrador	2026-06-12 18:11:38.82	Administrador	t
cmqb8vtrh000285sry6i1c7m6	Lorem 2	lorem 2	Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus.\n	Pz3czc9S1PP0wxyxbB5lQg	2368749	6000	4000	jpg	lorem	[{"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Vel similique laborum est accusantium fugiat qui neque itaque ab veritatis sint in veritatis temporibus. Sit alias eveniet in accusamus repellat qui galisum magnam non soluta omnis qui omnis omnis vel odio accusamus qui eaque tempore? Cum autem consequatur et iusto galisum et labore dolorum et aliquid ipsam aut expedita officiis eos alias quia. Quo molestiae nisi et praesentium unde non perspiciatis doloribus."}]}, {"type": "paragraph", "children": [{"text": "Quo fugit consequatur et soluta accusamus ad sunt blanditiis est quibusdam internos. A expedita sint et cupiditate assumenda sit assumenda voluptate. Et deserunt laborum et unde autem id sunt aliquid aut magni velit ut veritatis cupiditate. Et voluptatem earum eos ipsam error ut molestiae quae et totam deleniti."}]}]	cmq81pn5v0001j9azrqcx4d99	cmq9rhpc1000dg5ah7p97x6qj	\N	Gerado por Administrador	2026-06-12 18:59:42.935	Administrador	t
\.


--
-- Data for Name: QuemSomosMuralItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuemSomosMuralItem" (id, titulo, descricao, pagina, "createdAt", valor, ativo) FROM stdin;
cmrknufgy00005qglwpp71hrv	testando	testando	\N	2026-07-14 13:01:47.587	Testando	t
cmreyw41n000xtsps5bw426jz	Lorem	Lorem ipsum dolor sit amet. Id consequatur tempore ea delectus doloremque ea sint saepe qui excepturi ratione et nihil rerum. Et consequatur velit sed animi fuga quo maiores dolore et enim consectetur ex voluptate possimus ab Quis autem qui accusamus possimus	\N	2026-07-10 13:24:24.825	Lorem	t
cmreywcsh000ytspsm8n4sqp2	Lorem	Lorem ipsum dolor sit amet. Id consequatur tempore ea delectus doloremque ea sint saepe qui excepturi ratione et nihil rerum. Et consequatur velit sed animi fuga quo maiores dolore et enim consectetur ex voluptate possimus ab Quis autem qui accusamus possimus	\N	2026-07-10 13:24:36.16	Lorem	t
cmrm5nzkc0000kt373ho4tf38	Nossa Missão	É oferecer soluções corporativas integradas que tornem a Administração Pública Estadual mais eficiente, inovadora, sustentável e orientada para resultados.	\N	2026-07-15 14:08:26.314	Teste	t
cmrm5s9510000zyikkaij2q4f	Testando		\N	2026-07-15 14:11:45.348	teste	t
cmrp8xb65001bcbht3t4rky47	TESTANDO 	TEXTO TEXTO	\N	2026-07-17 18:02:58.633	Gerencia de Frota TESTE	t
cmquw1tf10001z8ntj3oso9t8	Em bens móveis	Pertencentes ao Estado de Pernambuco	1	2026-06-26 12:09:28.62	R$ 4 Milhões	t
cmruril780005d883tz9hcx6b	Em patrimônio imobiliário	Pertencentes ao Estado de Pernambuco\n	1	2026-07-21 14:42:15.378	R$ 12 Bilhões	t
cmrurjw4u0007d8839gnz580a	de Imóveis	De propriedade do Estado de Pernambuco	1	2026-07-21 14:43:16.205	+ de 3.500 	t
cmrurlgn60009d88346d2eehu	de bens móveis	De propriedade do Estado de Pernambuco	1	2026-07-21 14:44:29.44	+ de 1.2 Milhão 	t
cmrusrtnx000rd883i3qkqiea	Veículos na Frota Estadual		cmreyx3540010tsps2t8u6l90	2026-07-21 15:17:25.866	7728	t
cmrusr1rf000qd883gwg92rku	Em economia de energia		cmreyx3540010tsps2t8u6l90	2026-07-21 15:16:49.705	+ 200 Milhões	t
cmrunc4bi000bjzjx7ltbl2xb	Itens de Conectividades		cmreyx3540010tsps2t8u6l90	2026-07-21 12:45:15.091	36.249	t
cmsdha0ho006d2ggi1ytucw2m	Contas de Energia		cmreyx3540010tsps2t8u6l90	2026-08-03 17:03:16.474	2.821	t
cmsdhaqq3006e2ggiwiwy8rox	Contas de Água		cmreyx3540010tsps2t8u6l90	2026-08-03 17:03:50.471	1.993	t
cmrusqjpd000pd883vc486d2w	Em contratos corporativos		cmreyx3540010tsps2t8u6l90	2026-07-21 15:16:26.303	R$500 Milhões	t
cmrc4ke5o000mtsps4tclm8af	Em patrimônio imobiliário avaliado	Pertencentes ao Estado de Pernambuco	cmq9rfbp70009g5ah6bliwon4	2026-07-08 13:39:57.225	R$ 12 Bilhões	t
cmtli33zy007plviegpgepme8	Em manutenção	dos prédios da Administração Estadual	cmq9rfbp70009g5ah6bliwon4	2026-09-03 12:27:45.788	R$ 2 milhões anuais	t
cmrc4kou8000ntspsidlnopvz	de imóveis históricos	Devolvendo-lhes uso e dando-lhes nova vida	cmq9rfbp70009g5ah6bliwon4	2026-07-08 13:40:11.069	Preservação e resgate	t
cmtmvftlz00awlvieba5a28hy	 levantados pelo PROFISCO	para atualização cadastral	cmq9rfbp70009g5ah6bliwon4	2026-09-04 11:29:20.039	+1100  imóveis	t
\.


--
-- Data for Name: QuemSomosSubareaItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuemSomosSubareaItem" (id, subarea, pagina, "createdAt", conteudo, ativo) FROM stdin;
cmrc4l40o000otsps09v0a3wq	cmq9rhpc1000dg5ah7p97x6qj	cmq9rfbp70009g5ah6bliwon4	2026-07-08 13:40:30.738	[{"type": "paragraph", "children": [{"text": "Est laudantium adipisci aut corrupti facere est veritatis voluptatem et quisquam minus aut doloremque internos. Aut similique autem a fugit voluptatem et dolorum magni sit nobis molestiae et deleniti quia et quae voluptas."}]}]	t
cmrpa29z50022cbht85n479g9	\N	\N	2026-07-17 18:34:49.983	[{"type": "paragraph", "children": [{"text": "A Gerência de Contratos Corporativos do Estado (GCCOR) tem como escopo a gestão centralizada e contínua dos contratos corporativos (contratos mater) de Telemática, de Abastecimento veicular e de manutenção veicular, utilizados pelos órgãos do poder executivo estadual e demais poderes que aderem aos referidos contratos."}]}]	t
cmreywz3j000ztspstlaz133l	\N	\N	2026-07-10 13:25:05.067	[{"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Id consequatur tempore ea delectus doloremque ea sint saepe qui excepturi ratione et nihil rerum. Et consequatur velit sed animi fuga quo maiores dolore et enim consectetur ex voluptate possimus ab Quis autem qui accusamus possimus"}]}]	t
cmrp8jzws001acbht3wafw0hr	\N	\N	2026-07-17 17:52:37.512	[{"type": "paragraph", "children": [{"text": "Testando testando testando"}]}]	t
cmrc4ngku000rtspsyjupmipi	cmq9rha92000bg5ah7gkhkjyd	cmq9rfbp70009g5ah6bliwon4	2026-07-08 13:42:20.329	[{"type": "paragraph", "children": [{"text": "i.Serviço destinado a elaboração de peças técnicas para viabilizar a elaboração de vistorias, manutenções prediais, fiscalizações de obras e outros serviços de engenharia sendo responsável por detalhar e compatibilizar os projetos de arquitetura , engenharia e regularização imobiliária para garantir funcionalidade e eficiência operacional dos sistemas de construção.\n"}]}]	t
cmrusmarg000jd8837gtylwpe	cmrtn3l1x0006bqr58awnhiel	cmreyx3540010tsps2t8u6l90	2026-07-21 15:13:08.087	A área de Contratos Corporativos é responsável pela gestão dos contratos compartilhados da Administração Pública Estadual, promovendo a padronização dos processos de contratação e a otimização da utilização dos recursos públicos.\n\nSua atuação compreende o planejamento, formalização, acompanhamento e fiscalização de contratos corporativos, assegurando conformidade com a legislação vigente, eficiência administrativa e transparência na execução contratual.\n\nAo centralizar e padronizar contratações de interesse comum aos diversos órgãos estaduais, o setor contribui para a redução de custos, o ganho de escala, a melhoria da qualidade dos serviços contratados e o fortalecimento da governança pública.	t
cmquw3yvz0005z8ntb2zh4n8o	cmq9j1frn0000boamvyqh9qnc	1	2026-06-26 12:11:09.02	Somos os responsáveis pela gestão dos imóveis pertencentes ao Estado de Pernambuco, assegurando sua correta administração, utilização, regularização e preservação. Cuidamos do cadastro e atualização das informações dos imóveis estaduais, das análises técnicas, processos de aquisição, das cessões e permissões de uso, da alienação, incorporação, regularização fundiária e do acompanhamento da ocupação dos bens públicos. A gestão eficiente do patrimônio imobiliário contribui para a valorização dos ativos do Estado, otimiza a utilização dos espaços públicos e fornece informações estratégicas que apoiam a tomada de decisões da administração estadual.	t
cmrurnv20000bd883kcummli4	cmqgnv5xk00003adnqj7bkkdv	1	2026-07-21 14:46:21.422	Aqui desenvolvemos as políticas de gerenciamento dos bens móveis utilizados pelos órgãos e entidades da Administração Pública Estadual. Atuamos no controle patrimonial durante todo o ciclo de vida dos bens, incluindo incorporação, registro, identificação, movimentação, inventário, manutenção, transferência, desfazimento e baixa patrimonial. Por meio de normas, procedimentos e sistemas de controle, promovemos maior segurança, rastreabilidade e transparência na administração dos bens móveis, contribuindo para o uso racional dos recursos públicos e para o fortalecimento da governança patrimonial no Estado de Pernambuco.	t
cmrusmvuk000kd883blcqyz38	cmrtn3ddb0004bqr56kh31dp0	cmreyx3540010tsps2t8u6l90	2026-07-21 15:13:35.414	A área de Telemática é responsável pela gestão dos serviços corporativos de telecomunicações e conectividade da Administração Pública Estadual, garantindo infraestrutura tecnológica que suporte as atividades dos órgãos e entidades do Governo de Pernambuco.\n\nSua atuação compreende o planejamento, contratação, monitoramento e gestão dos serviços de telefonia fixa e móvel, comunicação de dados, redes corporativas, internet, videoconferência e demais soluções de telecomunicações, buscando assegurar disponibilidade, qualidade, segurança e eficiência na prestação dos serviços.\n\nPor meio da padronização de processos, acompanhamento de indicadores e adoção de soluções tecnológicas inovadoras, o setor contribui para a modernização da administração pública, promovendo maior integração entre os órgãos estaduais e o uso racional dos recursos públicos destinados às comunicações corporativas.	t
cmrusnazg000ld883olqv6pwo	cmrtn35yi0002bqr5ck780vyc	cmreyx3540010tsps2t8u6l90	2026-07-21 15:13:55.03	A área de Água e Energia é responsável pela gestão dos contratos corporativos relacionados ao fornecimento e consumo de água e energia elétrica dos órgãos e entidades da Administração Pública Estadual.\n\nEntre suas atribuições estão o acompanhamento do consumo, análise das faturas, gestão contratual, monitoramento de indicadores, identificação de oportunidades de economia e implementação de ações voltadas ao uso eficiente dos recursos naturais e financeiros.\n\nA atuação do setor busca promover a sustentabilidade, a redução de desperdícios e a otimização dos gastos públicos, contribuindo para uma gestão mais eficiente dos serviços essenciais e para o fortalecimento das políticas de responsabilidade socioambiental do Estado de Pernambuco.	t
cmruslz3z000id883pdl5bo0b	cmrtn2i7v0000bqr5csm0w82l	cmreyx3540010tsps2t8u6l90	2026-07-21 15:12:52.984	A área de Frota é responsável pela gestão dos veículos oficiais da Administração Pública Estadual, assegurando sua utilização de forma eficiente, econômica e transparente.\n\nEntre suas atribuições estão o planejamento da utilização da frota, controle da documentação, manutenção preventiva e corretiva, gestão do abastecimento, acompanhamento dos contratos relacionados aos veículos e monitoramento dos custos operacionais.\n\nPor meio de práticas modernas de gestão e do acompanhamento contínuo dos indicadores de desempenho, o setor busca otimizar a mobilidade dos órgãos públicos, promover o uso racional dos recursos e garantir maior disponibilidade e segurança da frota estadual.	t
cmrux35rd001ad883iit95t5z	cmrtn3ddb0004bqr56kh31dp0	cmreyx3540010tsps2t8u6l90	2026-07-21 17:18:13.215	Curtir\n\nNão gosto\nLorem Ipsum é um texto de preenchimento usado para simular conteúdo em layouts de design e editoração, permitindo focar na aparência sem distração pelo conteúdo real.	t
cmtmvjzbm00b5lviehj97dy27	cmq9rha92000bg5ah7gkhkjyd	cmq9rfbp70009g5ah6bliwon4	2026-09-04 11:32:34.061	Teste	t
\.


--
-- Data for Name: QuemSomosTimeItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuemSomosTimeItem" (id, nome, cargo, descricao, pagina, "createdAt", foto_extension, foto_filesize, foto_height, foto_id, foto_width, ativo) FROM stdin;
cmrxt3mw00010a05rje40ct1r	Lidiane Nascimento	Gerente de Eficiência Energética		cmreyx3540010tsps2t8u6l90	2026-07-23 17:49:55.483	png	30006	224	6nJyL75zR-9zDdt84CNMHQ	208	t
cmrxt4w090012a05rsfyg4f3x	Joseilson Albuquerque	Gerente de Telemática		cmreyx3540010tsps2t8u6l90	2026-07-23 17:50:53.955	png	30006	224	3kK0pbMH5JH9I38FD4xnow	208	t
cmrc4lk7s000ptspsqirgb8qn	Fabiana Ramalho	Gerente Geral de Arquitetura e Engenharia	Formada em Arquitetura e Urbanismo, com uma carreira consistente na gestão pública, reúne ampla experiência na liderança de equipes multidisciplinares, na coordenação de projetos de arquitetura e engenharia e na governança de processos do setor público.	cmq9rfbp70009g5ah6bliwon4	2026-07-08 13:40:51.726	png	1753139	1254	YersnPT2Il8q_P-yslo2yA	1254	t
cmrurx2qo000cd883hjv6f9sm	Luciana Macedo	Gerente de Destinação Imobiliária		1	2026-07-21 14:53:31.29	png	2259095	1254	3oIOQppIaB9jK5IR_S4zTQ	1254	t
cmrury8vb000dd883iohfxkrp	Eridan Rodrigues	Gerente de Patrimônio Móvel		1	2026-07-21 14:54:25.886	png	1990733	1254	viLwET6EZNZSQzLWYU66hw	1254	t
cmquw2lxk0003z8nt69eo94vc	Adauto Nunes	Gerente Geral de Patrimônio		1	2026-06-26 12:10:05.575	png	1861332	1254	2iCSbl6fFBBEdwDmt3M_Kg	1254	t
cmrurc4li0002d8831cmh2osf	Adriana Cardoso	Gerente Geral de Serviços Corporativos		cmreyx3540010tsps2t8u6l90	2026-07-21 14:37:13.923	png	1938023	1254	r5k4HcRIeax-fzaFAVntcg	1254	t
cmrxszeds000wa05r99ogzdd2	Henrique Sales	Gerente de Contratos Corporativos		cmreyx3540010tsps2t8u6l90	2026-07-23 17:46:37.829	png	30006	224	io8O0v2NWk2fIrf-foMeJg	208	t
cmrxsvi1b000sa05rv76hscf8	Rodrigo Farias	Gerente de Frota		cmreyx3540010tsps2t8u6l90	2026-07-23 17:43:35.948	png	30006	224	VkqRWynag3ZfrB6vAEKwXw	208	t
cmrxt2dpz000ya05rm1d7s3nt	Otávio Malheiros	Superintendente de Energia Renováveis		cmreyx3540010tsps2t8u6l90	2026-07-23 17:48:56.948	png	30006	224	Z7jjI5Z0VmpUajDXLB1yPg	208	t
\.


--
-- Data for Name: Servicos; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Servicos" (id, titulo, slug, imagem_id, imagem_filesize, imagem_width, imagem_height, imagem_extension, "imagemAlt", resumo, "oQueE", "quemPrecisa", "comoSolicitar", "areaResponsavel", "createdAt", "createdBy", "updatedAt", "updatedBy", "deletedAt", "deletedBy", subarea, "maisInformacoes", ativo) FROM stdin;
cmq9sorix000qg5ahfulm0bn6	Contratos Corporativos	lorem	HTrT_WE5C5sw67OaHPmtKQ	2285219	1408	768	png	lorem	A Gerência de Contratos Corporativos do Estado (GCCOR) coordena os procedimentos administrativos dos Contratos Corporativos (Contratos Mater), promovendo sua formalização, alterações e acompanhamento, além de padronizar procedimentos e orientar os órgãos e entidades aderentes.	[{"type": "paragraph", "children": [{"bold": true, "text": "Serviços oferecidos"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Elaboração de instrumentos contratuais"}]}, {"type": "paragraph", "children": [{"text": "Os instrumentos contratuais são os documentos que formalizam a relação entre as\\npartes, estabelecendo o objeto da contratação, os valores, as obrigações, os\\ndireitos, as penalidades aplicáveis e as demais condições específicas de cada\\najuste."}]}, {"type": "paragraph", "children": [{"text": "No âmbito dos Contratos Corporativos, destacam-se os seguintes instrumentos:"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "• Termo de Adesão: "}, {"text": "instrumento por meio do qual o órgão ou entidade aderente formaliza sua contratação junto ao Contrato Corporativo, sendo assinado pelo Interveniente\\nPrincipal, pelo órgão aderente e pela contratada, assim como o termo aditivo, a\\nseguir detalhado."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "• Termo Aditivo: "}, {"text": "instrumento utilizado para promover alterações no Termo de Adesão, tais como modificações de quantitativos, valores, prazos, escopo ou dados cadastrais."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "• Termo de Apostilamento: "}, {"text": "instrumento destinado à formalização de alterações que independem da celebração de Termo Aditivo, tais como reajustes contratuais, atualização da cobertura orçamentária mediante juntada das Notas de Empenho e, no âmbito dos Contratos\\nCorporativos, a prorrogação da vigência do Termo de Adesão, desde que não haja\\nalteração dos quantitativos ou dos valores originalmente contratados para o\\nperíodo prorrogado."}]}]	[{"type": "paragraph", "children": [{"text": "O serviço é destinado aos órgãos e entidades da Administração Pública Estadual, bem como aos demais Poderes e instituições que figurem como Intervenientes Aderentes dos respectivos Contratos Corporativos."}]}]	[{"type": "paragraph", "children": [{"bold": true, "text": "Termo de Adesão"}, {"text": "\\r\\nQuando a formalização de novo Termo de Adesão decorrer da substituição de instrumento cuja vigência esteja próxima do encerramento, em razão da impossibilidade de prorrogação do respectivo Contrato Corporativo, a Gerência de Contratos Corporativos iniciará o procedimento de forma centralizada, encaminhando aos órgãos e entidades aderentes o respectivo "}, {"bold": true, "text": "Adendo"}, {"text": ", contendo os serviços e quantitativos inicialmente propostos, elaborados com base no Termo de Adesão vigente."}]}, {"type": "paragraph", "children": [{"text": "Caberá ao órgão aderente analisar as informações constantes do Adendo e, caso necessário, solicitar ajustes nos quantitativos, bem como a inclusão ou exclusão de serviços, observadas as diretrizes da contratação corporativa."}]}, {"type": "paragraph", "children": [{"text": "Nas demais hipóteses em que se pretenda formalizar novo Termo de Adesão não decorrente da substituição de instrumento vigente, o órgão ou entidade interessada deverá encaminhar ofício, por meio do Sistema SEI, à Gerência Geral de Serviços Corporativos, contendo:"}]}, {"type": "paragraph", "children": [{"text": "•\\tjustificativa da contratação;\\r\\n•\\tespecificação dos serviços pretendidos;\\r\\n•\\tquantitativos estimados."}]}, {"type": "paragraph", "children": [{"text": "Além da Nota de Empenho destinada à cobertura da contratação, deverão ser apresentados os demais documentos exigidos pelos normativos vigentes, dentre os quais a comprovação de que a contratação está prevista no Plano de Contratações Anual (PCA) e, quando aplicável, a autorização da Câmara de Programação Financeira (CPF), nos termos da Resolução CPF nº 001/2026.\\r"}]}, {"type": "paragraph", "children": [{"text": "A relação completa da documentação exigida será informada pela Gerência de Contratos Corporativos quando do encaminhamento do respectivo Adendo."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Termo Aditivo"}]}, {"type": "paragraph", "children": [{"text": "Os pedidos de formalização de Termo Aditivo para acréscimo ou supressão de quantitativos deverão ser encaminhados à Gerência Geral de Serviços Corporativos - GGCOR, por meio do Sistema SEI, contendo:"}]}, {"type": "paragraph", "children": [{"text": "•\\tjustificativa da alteração;\\r\\n•\\tserviços a serem acrescidos ou suprimidos;\\r\\n•\\tquantitativos correspondentes.\\r"}]}, {"type": "paragraph", "children": [{"text": "A solicitação será submetida à análise das áreas técnicas competentes (Gerência de Frota ou Gerência de Telemática), com participação da Agência Estadual de Tecnologia da Informação (ATI), quando envolver alterações técnicas relacionadas aos serviços de conectividade, como aumento de velocidade de links (ADC e/ou ADE).\\r"}]}, {"type": "paragraph", "children": [{"text": "Sendo a demanda considerada tecnicamente viável e havendo saldo disponível no Contrato Corporativo, será encaminhado ao órgão aderente novo Adendo contemplando as alterações pretendidas, para validação e posterior emissão da Nota de Empenho correspondente.\\r"}]}, {"type": "paragraph", "children": [{"text": "Além da Nota de Empenho, deverão ser apresentados os documentos exigidos pela legislação e pelos normativos vigentes, inclusive a comprovação de que a despesa encontra-se prevista no Plano de Contratações Anual (PCA) e, quando aplicável, a autorização da Câmara de Programação Financeira (CPF)."}]}, {"type": "paragraph", "children": [{"text": "A documentação necessária será informada pela Gerência de Contratos Corporativos quando do encaminhamento do respectivo Adendo."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Termo de Apostilamento"}, {"text": "\\r"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Cobertura orçamentária"}, {"text": "\\r"}]}, {"type": "paragraph", "children": [{"text": "Para apostilamento das Notas de Empenho destinadas à cobertura financeira dos respectivos Termos de Adesão, o órgão aderente deverá anexar os documentos ao processo SEI correspondente, acompanhado de solicitação de apostilamento dirigida à Gerência de Contratos Corporativos - GCCOR.\\r"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Prorrogação de vigência"}, {"text": "\\r"}]}, {"type": "paragraph", "children": [{"text": "Nos casos de prorrogação da vigência do Termo de Adesão, sem alteração de quantitativos e valores, caberá ao órgão aderente encaminhar:\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tNota de Empenho correspondente ao novo período;\\r\\n•\\tcomprovação de que a prorrogação está contemplada no Plano de Contratações Anual (PCA);\\r\\n•\\tdemais documentos exigidos pelos normativos vigentes.\\r"}]}, {"type": "paragraph", "children": [{"text": "Por se tratar de procedimento periódico, a Gerência de Contratos Corporativos iniciará previamente o processo, encaminhando aos órgãos aderentes o respectivo Adendo e a relação da documentação necessária.\\r"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Reajuste contratual"}, {"text": "\\r"}]}, {"type": "paragraph", "children": [{"text": "Quando houver reajuste do Contrato Corporativo, a Secretaria de Administração comunicará formalmente os órgãos aderentes, que deverão providenciar a emissão da Nota de Empenho correspondente ao acréscimo financeiro do respectivo Termo de Adesão, para posterior formalização do apostilamento."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	2026-08-05 18:40:50.527	Diego Santos Rolim 	\N		cmrtn3l1x0006bqr58awnhiel	[{"type": "paragraph", "children": [{"text": "Em caso de dúvidas, entre em contato com a Gerência de Contratos Corporativos (GCCOR) pelo telefone (81) 3183-7774."}]}]	t
cmq9jk3re000nboamth81iigz	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	saida-imovel-doacao-patrimonio-estadual	UzRyZclZdaA_EwrVpB1V8A	264293	640	320	png	entrega de chave. saída.	Procedimento necessário à saída de imóveis do patrimônio estadual por doação.	[{"type": "paragraph", "children": [{"text": "Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para saída (transferência) de imóveis ao patrimonial estadual por doação (com ou sem encargos) a terceiros, independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado."}]}]	[{"type": "paragraph", "children": [{"text": "Qualquer terceiro interessado que figure como possível donatário do imóvel estadual, desde particulares a entes públicos não ligados à administração direta e indireta."}]}]	[{"type": "ordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Fazer o cadastro do documento na plataforma SEI"}, {"text": " ("}, {"href": "www.sei.pe.gov.br", "type": "link", "children": [{"text": "www.sei.pe.gov.br"}]}, {"text": ")."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Ao gerar o número de processo, anexar as seguintes documentações:\\n"}, {"text": "\\n2.1 "}, {"bold": true, "text": "Em relação ao imóvel, em possuindo os documentos abaixo:"}, {"text": "\\na) Certidões de Propriedade e de Ônus atualizadas da Matrícula/Transcrição, dentro do prazo de 30 dias;\\nb) Boletim de Cadastro Imobiliário/Ficha do Imóvel;\\nc) Certidão Negativa de Débitos Municipais atualizada no novo período fiscal competente;\\nd) Lei Autorizativa de Doação devidamente publicada.\\n\\n2.2 "}, {"bold": true, "text": "Em relação ao donatário:"}, {"text": "\\n2.2.3 "}, {"bold": true, "text": "No caso de município:"}, {"text": "\\na) Situação Cadastral do Município\\nb) Lei Orgânica Municipal do Município\\nc) Ato de Nomeação do Prefeito do Município\\nd) Documentos de identificação pessoal do Prefeito do Município.\\n\\n2.2.4 "}, {"bold": true, "text": "No caso de Pessoa Jurídica de Direito Privado:"}, {"text": "\\na) Situação Cadastral da empresa;\\nb) Contrato Social da empresa;\\nc) Documentos de identificação pessoal dos sócios-administradores a assinarem o ato.\\n\\n2.2.5 "}, {"bold": true, "text": "No caso de Pessoa Física:"}, {"text": "\\na) Documentos de identificação pessoal dos transmitentes (RG, CPF e/ou Certidão de Casamento/Nascimento).\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Após anexar as devidas documentações, confeccionar ofício para direcionar à Gerência Geral de Patrimônio (GGPAT), com indicação dos documentos ora acostados e os devidos hiperlinks."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-07-03 14:15:42.847	Gustavo Andrade	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "paragraph", "children": [{"text": ""}]}]	f
cmsn82l2i00af2ggi52zfgx34	Gestão de Energias Renováveis	gestao-de-energias-renovaveis	S6rZjlya-6KFkqEkvGbYDA	3027863	3992	2992	jpg	Painéis solares utilizados para geração de energia renovável.	Planejamento e acompanhamento de iniciativas voltadas à utilização de fontes renováveis de energia nos imóveis e serviços da Administração Pública Estadual.	[{"type": "paragraph", "children": [{"text": "A Gestão de Energias Renováveis compreende as ações de planejamento, coordenação e acompanhamento de iniciativas relacionadas à utilização de fontes renováveis de energia no âmbito da Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "A atuação contempla a identificação de oportunidades para utilização de fontes renováveis, o acompanhamento de projetos e contratos e o apoio técnico aos órgãos e entidades estaduais na adoção de soluções que contribuam para a eficiência energética, a redução de custos e a sustentabilidade ambiental."}]}, {"type": "paragraph", "children": [{"text": "As ações estão alinhadas às diretrizes do Plano de Descarbonização do Estado de Pernambuco, à Transição Energética Nacional e aos Objetivos de Desenvolvimento Sustentável (ODS) da Organização das Nações Unidas."}]}]	[{"type": "paragraph", "children": [{"text": "O serviço é destinado aos órgãos e entidades integrantes do Poder Executivo Estadual que necessitem de orientação, apoio técnico ou acompanhamento relacionado à utilização de fontes renováveis de energia."}]}, {"type": "paragraph", "children": [{"text": "Pode ser solicitado quando houver necessidade de avaliar oportunidades de geração de energia renovável, analisar projetos ou iniciativas relacionadas ao tema, obter orientação técnica ou acompanhar ações e contratos voltados à geração e utilização de energia renovável."}]}]	[{"type": "paragraph", "children": [{"text": "As demandas devem ser encaminhadas pelos canais institucionais da Secretaria de Administração, pelo dirigente competente, pelo gestor responsável ou por servidor formalmente designado pelo órgão ou entidade."}]}, {"type": "paragraph", "children": [{"text": "Quando a solicitação exigir análise técnica, manifestação formal, acesso a documentos ou adoção de providências administrativas, deverá ser formalizada por meio de processo no Sistema Eletrônico de Informações (SEI)."}]}, {"type": "paragraph", "children": [{"text": "A solicitação deverá apresentar, quando aplicável, a identificação do órgão ou entidade, descrição da demanda, informações sobre o imóvel ou unidade envolvida, documentos relacionados e identificação do servidor responsável pelo acompanhamento."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	\N		\N		cmrtn35yi0002bqr5ck780vyc	[{"type": "paragraph", "children": [{"text": "A Superintendência de Energias Renováveis e Água é responsável pela proposição, planejamento, execução e coordenação das políticas relacionadas às energias renováveis no âmbito da Secretaria de Administração do Estado de Pernambuco."}]}, {"type": "paragraph", "children": [{"text": "O serviço integra as ações estaduais voltadas à sustentabilidade, à eficiência no uso dos recursos públicos e à transição para uma matriz energética mais limpa."}]}]	t
cmsxlrw4d000e13zx6x2el396	Gestão da Realização de Leilões de Inservíveis	testte1	MaiYj9TMDIOJfxeWmSTeaA	2275162	1376	768	png	teste	Serviço de apoio à realização de leilões de inservíveis que acompanha e facilita o trâmite burocrático de encaminhamento de bens da administração pública para desfazimento por meio de leilão.	[{"type": "paragraph", "children": [{"text": "A Gestão de Leilões de Inservíveis coordena e acompanha o processo de desfazimento de bens móveis da Administração Pública Estadual que perderam a capacidade de atender às finalidades para as quais foram adquiridos. A Comissão Especial de Alienação de Bens Móveis (CEABM) articulada com o setor de patrimônio, que orienta os órgãos com a definição da destinação mais adequada, contribui com o cumprimento dos trâmites legais relacionados ao desfazimento de bens públicos."}]}]	[{"type": "paragraph", "children": [{"text": "Todos os órgãos da administração são clientes em potencial deste serviço, uma vez que os bens do Estado sofrem desgaste natural e de uso, podendo atingir condição de inservibilidade,  caracterizada quando o bem não possui mais capacidade de suprir as necessidades que justificaram sua aquisição. Nessa situação, o bem deve ser vistoriado pelo setor de patrimônio para classificação de sua inservibilidade e orientação quanto à destinação, que pode ser descarte, doação, transferência ou leilão."}]}]	[{"type": "paragraph", "children": [{"text": "O órgão deve encaminhar formalmente sua demanda de desfazimento de bens via SEI à SEPEC (Secretaria Executiva de Patrimônio e Serviços Corporativos), para receber a visita da equipe de patrimônio. Caso a destinação orientada seja o leilão, o setor de patrimônio encaminha o processo à CEABM (Comissão Especial de Alienação de Bens Móveis), que dará início ao processo de leilão em conjunto com as demandas das demais secretarias."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	\N		\N		cmrtn2i7v0000bqr5csm0w82l	[{"type": "paragraph", "children": [{"text": "Em caso de dúvidas, entre em contato com a Comissão Especial de Alienação de Bens Móveis (CEABM) pelo ramal (81) 3183-7445."}]}]	t
cmq9rsnxp000hg5ah3lhqu1un	Avaliação de Imóveis	avaliacao-imobiliaria	bajDR78QPibAii99UordTw	1971089	6000	4004	jpg	Planta de engenharia sobre uma mesa de trabalho com equipamentos de medição.	Serviço técnico destinado à determinação do valor de mercado de terrenos, edifícios e instalações comerciais ou residenciais de interesse do Estado de Pernambuco.	[{"type": "paragraph", "children": [{"text": "Trata-se de procedimento de elaboração de Laudo de Avaliação, por meio do qual se estima o valor mais provável (compra e venda ou locação, por ex.) de um imóvel.\\nÉ realizado por engenheiros e arquitetos, com a devida Anotação/Registro de Responsabilidade Técnica (ART/RRT) e visa a dar transparência e a garantir a justa remuneração nas transações imobiliárias envolvendo o Poder Executivo Estadual."}]}]	[{"type": "paragraph", "children": [{"text": "A avaliação é obrigatória em transações envolvendo\\nimóveis do Estado de Pernambuco, tais como:\\nCompra e venda;Concessão de uso onerosa;Atualização de valor patrimonial para fins contábeis;Locações;Doações;Permutas;Cessão de uso;Fixação de custo para fins de seguro;Desapropriações."}]}]	[{"type": "paragraph", "children": [{"text": "Conforme dispõe o artigo 12 da Portaria SAD nº 2.679/2024, a solicitação de elaboração de Laudo de Avaliação de imóvel urbano, quando encaminhada à SAD, deverá ser mediante Ofício preferencialmente acompanhado dos seguintes documentos:\\nI - croqui e/ou planta baixa atualizado do imóvel avaliando, em que conste:\\na) área total do terreno e das edificações/benfeitorias porventura existentes, discriminadas,\\nquando for o caso, por pavimentos; e\\nb) todas as cotas e seus respectivos carimbos e legendas, especificando:"}]}, {"type": "ordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "identificação do responsável técnico pela elaboração;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "data da execução do serviço;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "endereçamento completo do imóvel avaliando; e"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "escalas utilizadas no desenho.\\nII - documentação dominial; e\\nIII - formulário constante do Anexo Único desta Portaria, devidamente preenchido e assinado\\npela autoridade competente do órgão ou entidade solicitante."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	2026-09-03 12:30:18.861	Gustavo Andrade	\N		cmtimbobe0005and9z3nes0so	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmq9jlsab000pboamrkpkptas	Vistorias nos Imóveis Públicos	vistorias-imoveis	Nij0r3XpP3Y9odlFFENZhA	6662124	5760	3840	jpg	Vistoria	Serviços de vistoriar os imóveis púplicos do Estado.	[{"type": "paragraph", "children": [{"text": "São atividades realizadas pelo governo para inspecionar, verificar e monitorar bens imóveis que pertencem ao Estado, como prédios administrativos, escolas, hospitais, terrenos e outros patrimônios públicos, na finalidade de destinar ou renovar a formalização da ocupação."}]}]	[{"type": "paragraph", "children": [{"text": "Órgãos do governo estadual, Gestores de patrimônio público e Entidades públicas que ocupam os imóveis do Estado."}]}]	[{"type": "paragraph", "children": [{"text": "Através de comunicação interna ou sistemas eletrônicos."}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-07-14 12:13:42.882	Administrador	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmsn880cn00ai2ggiw63p050t	Eficiência Energética	eficiencia-energetica	T9P7HPhs-idQDCCpoO4agA	1267970	5616	3159	jpg	Edificação pública com soluções voltadas à eficiência energética.	Monitoramento e orientação para melhorar o desempenho energético dos imóveis públicos, reduzir desperdícios e otimizar os gastos com energia elétrica.	[{"type": "paragraph", "children": [{"text": "O serviço de Eficiência Energética compreende o acompanhamento do consumo de energia elétrica dos imóveis utilizados pelos órgãos e entidades estaduais, buscando identificar oportunidades de redução de consumo, custos e desperdícios."}]}, {"type": "paragraph", "children": [{"text": "A atuação envolve o monitoramento de indicadores, análise de faturas, identificação de comportamentos atípicos e orientação técnica aos gestores responsáveis pelas unidades consumidoras."}]}, {"type": "paragraph", "children": [{"text": "Também são desenvolvidas ações voltadas à adoção de práticas e medidas que contribuam para o uso mais eficiente da energia elétrica, promovendo economia de recursos públicos e sustentabilidade."}]}]	[{"type": "paragraph", "children": [{"text": "O serviço é destinado aos órgãos e entidades do Poder Executivo Estadual que necessitem de apoio para acompanhar ou melhorar o desempenho energético de suas unidades consumidoras."}]}, {"type": "paragraph", "children": [{"text": "Pode ser solicitado quando houver aumento atípico do consumo, dúvidas sobre faturas, necessidade de identificar oportunidades de economia, implantação de medidas de eficiência energética ou necessidade de orientação técnica sobre o uso racional da energia."}]}]	[{"type": "paragraph", "children": [{"text": "A demanda pode ser encaminhada pelo gestor de energia e água, dirigente competente ou servidor formalmente designado pelo órgão ou entidade, utilizando os canais institucionais da Secretaria de Administração."}]}, {"type": "paragraph", "children": [{"text": "Quando houver necessidade de análise técnica ou adoção de providências administrativas, a solicitação deverá ser formalizada por meio de processo no SEI."}]}, {"type": "paragraph", "children": [{"text": "Sempre que possível, devem ser encaminhadas informações da unidade consumidora, número da instalação ou conta contrato, endereço, faturas relacionadas e descrição da situação identificada."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	\N		\N		cmrtn35yi0002bqr5ck780vyc	[{"type": "paragraph", "children": [{"text": "A Gerência de Eficiência Energética e Água coordena e executa ações relacionadas à eficiência energética no âmbito da Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "O monitoramento contínuo permite identificar situações que demandem atuação preventiva ou corretiva e apoiar os órgãos na adoção de práticas mais eficientes e sustentáveis."}]}]	t
cmq9rxjkk000lg5ahorb2k5lt	Projetos de engenharia e fiscalização de obra 	projetos-engenharia	qFLWrfBaLKnNbzZdBwyOCQ	2080182	1536	1024	png	engenheiros	Os projetos complementares de engenharia se propõem a detalhar e compatibilizar todos os sistemas vitais que compõem uma edificação, indo além da estrutura básica para garantir funcionalidade e eficiência operacional.	[{"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado. São realizados desenhos, cálculos, orçamentos, especificações e documentos técnicos que orientam a construção/reforma."}]}, {"type": "paragraph", "children": [{"text": "O objetivo central é o planejamento, cálculo e dimensionamento técnico de subsistemas — como elétrico, hidrossanitário, mecânico e de segurança — assegurando que a execução da obra ocorra de forma integrada. Esses projetos são indispensáveis para garantir a estabilidade das instalações, o cumprimento rigoroso das normas de segurança e o desempenho de longo prazo dos sistemas destinados ao patrimônio público."}]}, {"type": "paragraph", "children": [{"text": "Exemplos de projetos de engenharia:"}]}, {"type": "paragraph", "children": [{"text": "Projeto estrutural;Projeto elétrico;"}]}, {"type": "paragraph", "children": [{"text": "Projeto hidráulico e sanitário;"}]}, {"type": "paragraph", "children": [{"text": "Projeto de drenagem;"}]}, {"type": "paragraph", "children": [{"text": "Projeto de pavimentação;"}]}, {"type": "paragraph", "children": [{"text": "Projeto de fundações."}]}, {"type": "paragraph", "children": [{"text": "Para colocar em prática as necessidades do demandante, os projetos de engenharia\\nenvolvem uma série de etapas, quais sejam:"}]}, {"type": "paragraph", "children": [{"text": "Levantamento das informações;"}]}, {"type": "paragraph", "children": [{"text": "Análise dos projetos de arquitetura existentes;"}]}, {"type": "paragraph", "children": [{"text": "Estudos e cálculos técnicos;"}]}, {"type": "paragraph", "children": [{"text": "Desenvolvimento de desenhos técnicos;"}]}, {"type": "paragraph", "children": [{"text": "Especificações dos materiais que serão empregados;"}]}, {"type": "paragraph", "children": [{"text": "Elaboração da documentação técnica (memoriais descritivos, orçamentos etc.)."}]}]	[{"type": "paragraph", "children": [{"text": "Os projetos de engenharia são importantes sempre que se faz necessária a construção ou reforma de um imóvel ou equipamento público. Garantem a funcionalidade, segurança e estabilidade das construções e tomam como base o que foi definido nos projetos de arquitetura. É realizado por profissionais habilitados, com o devido registro técnico (ART CREA), sempre que se fizer necessária a construção e/ou reforma de imóveis de interesse do Estado."}]}]	[{"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de engenharia de imóveis de interesse\\ndos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de\\nOfício (via Sistema Eletrônico de Informação)."}]}]	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	2026-09-03 19:12:25.407	Ana Claudia de Souza Ferreira	\N		cmq9rha92000bg5ah7gkhkjyd	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmq9jf5vi000iboam6yi59usu	Devolução de Imóveis Estaduais	devolucao-imoveis	bC7dlW06dr9pYvOJPiyz2Q	3996120	7360	4912	jpg	Devolução de imóveis	Controle do recebimento de imóveis desocupados, visando garantir a formalização e a conservação dos bens imóveis estaduais.	[{"type": "paragraph", "children": [{"text": "Serviço destinado ao controle e acompanhamento do recebimento de Imóveis estaduais desocupados, assegurando a formalização da devolução, a conservação e a regularização dos bens para posterior destinação."}]}]	[{"type": "paragraph", "children": [{"text": "Órgãos e entidades pública que sejam devolvendo imóveis estaduais."}]}, {"type": "paragraph", "children": [{"text": "Para a devolução/desocupação do imóvel"}]}]	[{"type": "paragraph", "children": [{"text": ""}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-09-03 20:00:23.444	Ingrid Valões	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmsn8cmnm00al2ggiust37c4d	Gestão da Água e Eficiência Hídrica	gestao-da-agua-e-eficiencia-hidrica	fkUCFGZIvcf_9yq17yOzXQ	783236	3952	2646	jpg	Uso racional da água.	Acompanhamento do consumo de água e orientação para redução de desperdícios e melhoria da eficiência hídrica nos imóveis estaduais.	[{"type": "paragraph", "children": [{"text": "A Gestão de Água e Eficiência Hídrica compreende ações destinadas ao acompanhamento do consumo de água nos imóveis utilizados pelos órgãos e entidades estaduais."}]}, {"type": "paragraph", "children": [{"text": "O serviço envolve análise de consumo e faturamento, identificação de aumentos atípicos, possíveis desperdícios e oportunidades de economia, além da orientação aos gestores responsáveis pelas unidades consumidoras."}]}, {"type": "paragraph", "children": [{"text": "Também são incentivadas práticas de consumo racional e medidas que contribuam para a utilização eficiente dos recursos hídricos e para a redução dos gastos públicos."}]}]	[{"type": "paragraph", "children": [{"text": "O serviço é destinado aos órgãos e entidades do Poder Executivo Estadual que necessitem de apoio relacionado ao abastecimento de água, ao consumo ou à eficiência hídrica."}]}, {"type": "paragraph", "children": [{"text": "Pode ser solicitado quando houver aumento atípico do consumo, dúvidas sobre faturamento, identificação de possíveis desperdícios, necessidade de orientação sobre o fornecimento de água ou implantação de medidas de consumo racional."}]}]	[{"type": "paragraph", "children": [{"text": "As solicitações devem ser encaminhadas pelo gestor responsável, dirigente competente ou servidor formalmente designado pelo órgão ou entidade, utilizando os canais institucionais da Secretaria de Administração."}]}, {"type": "paragraph", "children": [{"text": "Quando a demanda exigir análise técnica, manifestação formal ou providências administrativas, deverá ser formalizada por meio de processo no SEI."}]}, {"type": "paragraph", "children": [{"text": "A solicitação deverá conter, quando aplicável, identificação da unidade consumidora, número da matrícula ou conta contrato, endereço do imóvel, faturas relacionadas, descrição da demanda e contato do servidor responsável."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	\N		\N		cmrtn35yi0002bqr5ck780vyc	[{"type": "paragraph", "children": [{"text": "A Gerência de Eficiência Energética e Água atua na coordenação e execução das ações relacionadas ao consumo racional de água nos imóveis da Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "O acompanhamento dos indicadores de consumo permite identificar oportunidades de melhoria, prevenir desperdícios e apoiar uma gestão mais eficiente e sustentável dos recursos hídricos."}]}]	t
cmq9jh5ot000kboam5cnn66jg	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	entrada-imovel-doacao-patrimonio-estadual	nuT2GZEwe36KQ0OG7Keuqg	18277	431	431	png	entrega de chave. transferência.	Procedimento necessário ao recebimento de imóveis ao patrimônio estadual por doação.	[{"type": "paragraph", "children": [{"text": "Trata-se do procedimento a ser feito, preferencialmente, via plataforma SEI, para recebimento e/ou incorporação de imóveis ao patrimonial estadual por doação (com ou sem encargos), independentemente do órgão, ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado."}]}]	[{"type": "paragraph", "children": [{"text": "Tribunal de Justiça Estadual (TJPE), Assembleia Legislativa Estadual (ALEPE), Secretarias de Estado (Casa Civil, Administração, Saúde, Educação, Defesa Social, Fazenda, etc.), além de órgãos da administração indireta como a ARPE, ATI, APAC, DETRAN-PE, SUAPE e FUNDARPE, ressalvados os casos em que há superior composição/integralização de capital próprio dos entes da administração indireta."}]}]	[{"type": "ordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Fazer o cadastro do documento na plataforma SEI "}, {"text": "("}, {"href": "www.sei.pe.gov.br", "type": "link", "children": [{"text": "www.sei.pe.gov.br"}]}, {"text": ")"}, {"bold": true, "text": "\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Ao gerar o número de processo, anexar as seguintes documentações:\\n"}, {"text": "\\n2.1"}, {"bold": true, "text": " Em relação ao imóvel:"}, {"text": "\\na) Certidões de Propriedade e de Ônus atualizadas da Matrícula/Transcrição, dentro do prazo de 30 dias;\\nb) Boletim de Cadastro Imobiliário/Ficha do Imóvel; \\nc) Certidão Negativa de Débitos Municipais atualizada no novo período fiscal competente;\\nd) Lei Autorizativa de Doação devidamente publicada (SE NECESSÁRIO).\\n\\n2.2"}, {"bold": true, "text": " Em relação ao doador:\\n"}, {"text": "2.2.1"}, {"bold": true, "text": " No caso de município:"}, {"text": "\\na) Situação Cadastral do Município;\\nb) Lei Orgânica Municipal; \\nc) Ato de Nomeação do Prefeito do Município; \\nd) Documentos de identificação pessoal do Prefeito do Município.\\n\\n2.2.2 "}, {"bold": true, "text": "No caso de Pessoa Jurídica de Direito Privado:"}, {"text": "\\na) Situação Cadastral da empresa;\\nb) Contrato Social da empresa;\\nc) Documentos de identificação pessoal dos sócios administradores a assinarem o ato.\\n\\n2.2.3 "}, {"bold": true, "text": "No caso de Pessoa Física:"}, {"text": "\\na) Documentos de identificação pessoal dos transmitentes (RG, CPF e/ou Certidão de Casamento/Nascimento).\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Após anexar as devidas documentações, confeccionar ofício direcionado à Gerência Geral de Patrimônio (GGPAT), com indicação dos documentos ora acostados."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-07-03 14:15:33.366	Gustavo Andrade	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "paragraph", "children": [{"text": ""}]}]	f
cmq9j1tg90004boamv9qdojzs	Desfazimento de Bens Móveis	desfazimento-de-bens-moveis	4lf5tvoJ6SBsa9bswOklgQ	2297132	5184	3456	jpg	Imagem representativa desfazimento de bens móveis	Procedimento para o desfazimento de bens móveis inservíveis	[{"type": "paragraph", "children": [{"text": "O desfazimento de bens móveis é o conjunto de procedimentos administrativos adotados pela Administração Pública Estadual para retirar do patrimônio bens que não têm mais utilidade.\\r\\nEm termos simples, significa dar uma destinação adequada a bens que já não servem mais, seja porque estão quebrados, obsoletos ou economicamente inviáveis de manter."}]}]	[{"type": "paragraph", "children": [{"text": "Todos os órgãos da Administração Direta, os fundos, as fundações, as autarquias, bem como as empresas públicas e sociedades de economia mista dependentes do Tesouro Estadual. "}]}]	[{"type": "paragraph", "children": [{"text": "A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações:"}]}, {"type": "paragraph", "children": [{"text": "1- Ofício da Autoridade máxima do órgão solicitando à SEPEC/SAD  a inclusão dos bens inservíveis para leilão;"}]}, {"type": "paragraph", "children": [{"text": "2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD\\nObs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017."}]}, {"type": "paragraph", "children": [{"text": "3- Laudo de Risco Biológico / Ambiental, quando aplicável."}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-07-24 11:53:56.675	Gustavo Andrade	\N		cmqgnv5xk00003adnqj7bkkdv	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmtlx37po00a7lviexpiqnucs	Projetos de engenharia 	projetos-engenharia2	BBswEYUpW4PrC_uXz2Th_Q	215904	1315	876	jpg		Elaboração de peças técnicas para viabilizar vistorias, manutenções, obras e serviços de engenharia. Detalha e compatibiliza projetos de arquitetura, engenharia e regularização imobiliária, garantindo a funcionalidade e a eficiência operacional dos sistemas construtivos.	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico que, preliminarmente à execução da melhoria, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado. São realizados desenhos, cálculos, orçamentos, especificações, fiscalizações , vistorias e documentos técnicos que orientam as entregas da área."}]}, {"type": "paragraph", "children": [{"text": "O objetivo central é o planejamento, cálculo e dimensionamento técnico de subsistemas — como estrutural, elétrico, hidrossanitário, mecânico e de segurança do trabalho — assegurando que a execução da obra ocorra de forma integrada. Esses projetos são indispensáveis para garantir a estabilidade das instalações, o cumprimento rigoroso das normas de segurança e o desempenho de longo prazo dos sistemas destinados ao patrimônio público."}]}, {"type": "paragraph", "children": [{"text": "Exemplos de projetos de engenharia:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto Estrutural:"}, {"text": "dimensiona vigas, pilares, lajes e fundações para garantir que a construção obedeça aos padrões de segurança técnicos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto Hidrossanitário:"}, {"text": "estrutura os sistemas de distribuição de água potável, captação de esgoto e escoamento de águas da chuva."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto Elétrico:"}, {"text": "dimensiona a fiação, dispõe sobre a passagem de fios, pontos de luz, tomadas e paineis de energia com segurança."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto Mecânico:"}, {"text": "planeja os sistemas e equipamentos integrados às edificações, como redes de ar-condicionado , elevadores, exaustão, e instalações de combate a incêndio"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Orçamento :"}, {"text": "apoiada por sistemas técnicos ,organiza e dimensiona os custos para intervenções planejadas"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Fiscalização de obra :"}, {"text": "serviço técnico responsável por permitir que a execução dos serviços de construção matenham a qualidade técnica , em conformidade a legislação e as normas e a segurança permitindo o melhor andamento dos projetos."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Segurança do Trabalho:"}, {"text": "respaldada por um conjunto de normas específicas da área ,elabora uma plano de ações preventivas que visa proteger a integridade dos usuários e trabalhadores do espaço , reduzindo a possibilidade de acidente."}]}]}]}, {"type": "paragraph", "children": [{"text": "Para colocar em prática as necessidades do demandante, os projetos de engenharia envolvem uma série de etapas, quais sejam:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Levantamento das informações"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Análise dos projetos de arquitetura existente"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Estudos e cálculos técnicos"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Desenvolvimento de desenhos técnicos"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Especificação dos materiais"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Elaboração de documentação técnica ( memoriais  descritivos , laudos de vistorias , peças orçamentárias)"}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Os projetos de engenharia são importantes sempre que se faz necessária a composição de peças técnicas para subsidiar a construção ou reforma de um imóvel ou equipamento público. Garantem a funcionalidade, segurança e estabilidade das construções e tomam como base o que foi definido nos projetos de arquitetura. É realizado por profissionais habilitados, com o devido registro técnico (ART/CREA),principalmente nas demandas por serviços de manutenção predial, obras , reformas e vistorias."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de engenharia de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício (via Sistema Eletrônico de Informação)."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq81pn5v0001j9azrqcx4d99	\N	Ana Claudia de Souza Ferreira	2026-09-03 19:28:14.399	Ana Claudia de Souza Ferreira	\N		\N	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmr4wl92l0006m82919zfq88e	Doação de Imóveis	doacao-imovel	ilcT3BS-xg5zhh5DuP7oLg	622939	3236	1940	jpg	doação. transferência.	Instruções básicas para realizar uma doação de imóvel para o Estado ou solicitar uma doação.	[{"type": "paragraph", "children": [{"text": "Este serviço permite solicitar a doação de imóveis, tanto para a incorporação de um imóvel ao patrimônio do Estado de Pernambuco quanto para a transferência de um imóvel pertencente ao Estado para outra pessoa ou instituição, com ou sem encargos. O procedimento deve ser realizado, preferencialmente, por meio da plataforma SEI."}]}]	[{"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Órgãos e entidades da Administração Pública Estadual;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Municípios e outros órgãos públicos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Pessoas jurídicas de direito privado;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Pessoas físicas;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Qualquer interessado envolvido em um processo de doação de imóvel para o Estado ou pelo Estado."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "ordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Acesse a plataforma SEI ("}, {"href": "http://www.sei.pe.gov.br", "type": "link", "children": [{"text": "www.sei.pe.gov.br"}]}, {"text": ") e abra um processo."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Após a geração do número do processo, anexe a documentação necessária."}]}]}]}, {"type": "heading", "level": 3, "children": [{"text": "Documentação do imóvel"}]}, {"type": "paragraph", "children": [{"text": "Sempre que disponível, apresente:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Certidão de matrícula e certidão de ônus atualizadas (emitidas há, no máximo, 30 dias);"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Boletim de Cadastro Imobiliário ou Ficha do Imóvel;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Certidão Negativa de Débitos Municipais atualizada;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Lei autorizativa da doação, quando exigida."}]}]}]}, {"type": "heading", "level": 3, "children": [{"text": "Documentação do doador ou donatário"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Se for Município:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Comprovante de situação cadastral;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Lei Orgânica do Município;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Ato de nomeação do Prefeito;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documento de identificação do Prefeito."}]}]}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Se for Pessoa Jurídica de Direito Privado:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Comprovante de situação cadastral da empresa;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Contrato Social;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documento de identificação dos sócios-administradores que assinarão o ato."}]}]}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Se for Pessoa Física:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documento de identificação (RG e CPF) e, quando aplicável, certidão de casamento ou nascimento."}]}]}]}, {"type": "paragraph", "children": [{"text": "3. Após anexar toda a documentação, encaminhe um ofício à Gerência Geral de Patrimônio (GGPAT), informando o número do processo e relacionando os documentos apresentados."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-07-24 13:29:59.995	Gustavo Andrade	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "paragraph", "children": [{"text": "Em caso de dúvidas, entre em contato com a Gerência Geral de Patrimônio (GGPAT).\\n\\n"}]}]	t
cmsn8n86c00ao2ggif1aywf22	Apoio junto a Concessionárias e Prestadores de Serviços	apoio-junto-a-concessionarias-e-prestadores	ohluQjDdpZ89uQqwVkSbQQ	6078078	7952	5304	jpg	Infraestrutura de serviços públicos de energia elétrica e abastecimento de água.	Apoio técnico aos órgãos estaduais na interlocução com concessionárias, distribuidoras e prestadores de serviços de energia elétrica e abastecimento de água.	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "O serviço de Apoio junto a Concessionárias e Prestadores de Serviços oferece suporte aos órgãos e entidades estaduais em demandas relacionadas ao fornecimento de energia elétrica e abastecimento de água."}]}, {"type": "paragraph", "children": [{"text": "A atuação pode envolver orientação sobre contratos de fornecimento, alterações cadastrais ou contratuais, análise de demandas e apoio na interlocução com concessionárias, distribuidoras e prestadores responsáveis pelos serviços."}]}, {"type": "paragraph", "children": [{"text": "O objetivo é contribuir para a adequada gestão dos serviços contratados e para a solução de situações que dependam de comunicação ou providências junto às empresas responsáveis pelo fornecimento."}]}]	[{"type": "paragraph", "children": [{"text": "O serviço é destinado aos órgãos e entidades do Poder Executivo Estadual que necessitem de apoio em questões relacionadas às concessionárias, distribuidoras ou prestadores de serviços de energia elétrica e água."}]}, {"type": "paragraph", "children": [{"text": "Pode ser solicitado quando houver necessidade de:"}]}, {"type": "paragraph", "children": [{"text": "esclarecer dúvidas sobre contratos de fornecimento;\\navaliar alterações cadastrais ou contratuais;\\ntratar situações relacionadas ao fornecimento;\\nobter orientação sobre demandas junto às concessionárias;\\nacompanhar solicitações ou ocorrências relacionadas aos serviços."}]}]	[{"type": "paragraph", "children": [{"text": "A demanda deverá ser encaminhada pelo dirigente competente, gestor responsável ou servidor formalmente designado pelo órgão ou entidade."}]}, {"type": "paragraph", "children": [{"text": "A solicitação deverá apresentar a identificação do órgão, unidade consumidora, número da instalação, matrícula ou conta contrato, endereço do imóvel, descrição objetiva da demanda e documentos relacionados, especialmente faturas, protocolos ou comunicações anteriores, quando disponíveis."}]}, {"type": "paragraph", "children": [{"text": "Quando a demanda exigir análise técnica, manifestação formal ou providências administrativas, deverá ser formalizada por meio de processo no SEI."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	\N		\N		cmrtn35yi0002bqr5ck780vyc	[{"type": "paragraph", "children": [{"text": "A Superintendência de Energias Renováveis e Água presta apoio técnico aos órgãos e entidades estaduais em matérias relacionadas à gestão de energia elétrica, energias renováveis, abastecimento de água e eficiência dos serviços."}]}, {"type": "paragraph", "children": [{"text": "O atendimento observa as atribuições institucionais da Secretaria de Administração, a legislação vigente, os contratos existentes e os procedimentos estabelecidos pelo Estado."}]}]	t
cmrb0n49r0005tspsvs67r5sz	Cadastro Imobiliário Estadual	cadastro-imobiliarioestadual	NGQJPYh1O8sZsa492Ge6WA	4010512	5616	3744	jpg		Registro oficial dos imóveis estaduais, reunindo as principais informações de cada imóvel.	[{"type": "paragraph", "children": [{"text": "O Cadastro Imobiliário Estadual reúne, em uma base cadastral única, os documentos e as informações referentes aos imóveis do Estado de Pernambuco, contemplando dados sobre localização, titularidade, ocupação, destinação e avaliação."}]}, {"type": "paragraph", "children": [{"text": "Todas as ações relacionadas à atualização e ao aperfeiçoamento do cadastro são registradas em um único sistema, garantindo a integridade, a rastreabilidade e a padronização das informações."}]}, {"type": "paragraph", "children": [{"text": "O serviço tem como finalidade disponibilizar informações cadastrais e documentais aos órgãos e entidades da Administração Pública, bem como à sociedade, promovendo maior transparência, eficiência na gestão do patrimônio imobiliário estadual e apoio à tomada de decisões."}]}]	[{"type": "paragraph", "children": [{"text": "Este serviço é destinado aos órgãos e entidades da Administração Pública Estadual, aos demais órgãos públicos das esferas federal, estadual e municipal, aos órgãos de controle, ao Poder Judiciário, aos cartórios, bem como aos cidadãos e demais interessados que necessitem de informações sobre os imóveis pertencentes ao Estado de Pernambuco."}]}]	[{"type": "ordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Acesse a plataforma SEI ("}, {"href": "http://www.sei.pe.gov.br", "type": "link", "children": [{"text": "www.sei.pe.gov.br"}]}, {"text": ") e abra um processo."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Após a geração do número do processo, anexe a documentação necessária e encaminhe para GGPAT (Gerência Geral de Patrimônio)."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq6yxa510000nh1tnduds1mc	\N	Viktoria Heyka	2026-08-07 16:35:18.333	Agelson Santana	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "heading", "level": 4, "children": [{"text": "Contato"}]}, {"type": "paragraph", "children": [{"text": "Para mais informações sobre o Cadastro Imobiliário Estadual, entre em contato com a Unidade de Cadastro Imobiliário pelos canais abaixo:"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Telefone: "}, {"text": "3183-7731 ou 3183-7739"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "E-mail: "}, {"href": "mailto:gestaoimobiliaria@sad.pe.gov.br", "type": "link", "children": [{"text": "gestaoimobiliaria@sad.pe.gov.br"}]}, {"text": ""}]}]	t
cmsn98ckh00aq2ggi1k8gsdoq	Orientação Técnica em Água e Energia	capacitacao-e-orientacao-tecnica-em-energia-e-agua	0UVRKgdWEgRYHYfg8hkyAA	1723347	3456	5184	jpg	imagem de exemplo	Capacitação e orientação técnica para gestores responsáveis pela gestão de energia elétrica e água nos órgãos e entidades estaduais.	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "O serviço de Capacitação e Orientação Técnica oferece apoio aos gestores e servidores responsáveis pelo acompanhamento dos serviços de energia elétrica e abastecimento de água nos órgãos e entidades estaduais."}]}, {"type": "paragraph", "children": [{"text": "A atuação compreende capacitações, atualização de gestores, esclarecimento de dúvidas, orientação sobre procedimentos e disseminação de boas práticas relacionadas ao consumo racional e à gestão eficiente desses recursos."}]}, {"type": "paragraph", "children": [{"text": "O objetivo é fortalecer a capacidade técnica dos órgãos e promover maior eficiência, controle e qualidade na gestão dos serviços."}]}]	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "O serviço é destinado aos gestores de energia e água e aos servidores formalmente responsáveis pelo acompanhamento desses serviços nos órgãos e entidades do Poder Executivo Estadual."}]}, {"type": "paragraph", "children": [{"text": "Pode ser solicitado quando houver necessidade de capacitação, atualização de procedimentos, esclarecimento de dúvidas ou orientação sobre situações relacionadas ao consumo, faturamento, contratos e gestão de energia e água."}]}]	[{"type": "paragraph", "children": [{"text": "A solicitação poderá ser encaminhada pelo dirigente competente, gestor de energia e água ou servidor formalmente designado pelo órgão ou entidade."}]}, {"type": "paragraph", "children": [{"text": "O pedido deverá informar o órgão solicitante, os participantes, o tema ou necessidade identificada e, quando aplicável, a unidade ou serviço relacionado à demanda."}]}, {"type": "paragraph", "children": [{"text": "Quando houver necessidade de formalização administrativa, a solicitação deverá ser encaminhada por meio de processo no SEI."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	\N		\N		cmrtn35yi0002bqr5ck780vyc	[{"type": "paragraph", "children": [{"text": "A Gerência de Eficiência Energética e Água é responsável por coordenar e executar ações de capacitação e orientação dos gestores responsáveis pelos serviços de energia e água."}]}, {"type": "paragraph", "children": [{"text": "As capacitações contribuem para a padronização de procedimentos, melhoria do acompanhamento dos serviços e disseminação de práticas de uso racional dos recursos públicos."}]}]	t
cmq9j4mlw0006boamuptkmd61	Inventário de Bens Móveis	inventario-de-bens-moveis	A7vY0q8Se8r7Ql-5dnhcnQ	423640	3100	1744	jpg	Imagem representativa inventário	Capacitação e orientação quanto à elaboração do Inventário Físico de Bens Materiais.\n	[{"type": "paragraph", "children": [{"text": "Constitui um instrumento de controle administrativo destinado à verificação da existência física dos bens permanentes, estejam eles em uso ou não, nos diversos órgãos e/ou entidades da Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "Esse procedimento consiste no levantamento físico e financeiro de todos os bens móveis permanentes que se encontram sob a posse e guarda das unidades gestoras, tendo como finalidade confrontar os registros patrimoniais existentes com os bens efetivamente localizados."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Todos os órgãos da Administração Direta, os fundos, as fundações, as autarquias, bem como as empresa públicas e sociedades de economia mista dependentes de recursos do Tesouro Estadual, no âmbito do Poder Executivo Estadual."}]}]	[{"type": "paragraph", "children": [{"text": ""}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-08-31 17:45:50.382	Fabio Oliveira Araújo da Silva	\N		cmqgnv5xk00003adnqj7bkkdv	[{"type": "paragraph", "children": [{"text": "Para mais informações e esclarecimentos acerca do Inventário, favor entrar em contato conosco:\\nUnidade Central de Patrimônio Móvel e Materiais (UCPAM)\\n"}, {"bold": true, "text": "E-mail:"}, {"text": " "}, {"href": "mailto:bensmoveis@sad.pe.gov.br", "type": "link", "children": [{"text": "bensmoveis@sad.pe.gov.br"}]}, {"text": ""}]}]	t
cmrp9z3je001wcbhtkv3fcdhf	Gerência de Contratos	WWWW	\N	\N	\N	\N	\N		TESTANDO TEXTP	[{"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}]	\N	\N		\N		\N		\N	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmrthawpo0009mdi1h75pkedj	Superintendência de Energias Renováveis e Água	www	ntaLJR1FtokrJqkmRyNepA	61283	415	740	jpg		Propor, planejar, executar e coordenar a política de energias renováveis, eficiência energética e consumo racional de água no âmbito do Estado de Pernambuco.\n	[{"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}]	\N	\N		\N		\N		\N	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmrthr36k000lmdi13kumqjbi	ENERGIAS RENOVÁVEIS E ÁGUA	teste	uvTe45vC7dVkrYomuJMgAg	61283	415	740	jpg		A Superintendência de Energias Renováveis e Água da Secretaria de Administração de Pernambuco atua na formulação, coordenação e execução de políticas voltadas à utilização de fontes renováveis, à eficiência energética e ao consumo racional de água nos imóveis de uso do Estado.	[{"type": "paragraph", "children": [{"text": "A Superintendência de Energias Renováveis e Água é a unidade responsável por propor, planejar, executar e coordenar a política de energias renováveis no âmbito da Secretaria de Administração do Estado de Pernambuco.\\r"}]}, {"type": "paragraph", "children": [{"text": "Sua atuação compreende o desenvolvimento de ações destinadas à melhoria da eficiência energética e hídrica dos imóveis utilizados pelos órgãos e entidades estaduais dependentes do Tesouro, mediante o acompanhamento do consumo, a orientação técnica aos gestores setoriais, a identificação de oportunidades de economia e o incentivo à adoção de práticas sustentáveis alinhadas com o Plano de Descarbonização do Estado de Pernambuco,com a Transição Energética Nacional e com os Objetivos de Desenvolvimento Sustentável da ONU.\\r"}]}, {"type": "paragraph", "children": [{"text": "A Superintendência também exerce a gestão e a coordenação da concessão administrativa voltada à construção, operação, manutenção e gestão de usina de autoprodução de energia renovável, além da aquisição de energia elétrica por meio do Ambiente de Contratação Livre – ACL (PPP – Usina Solar).\\r"}]}, {"type": "paragraph", "children": [{"text": "No âmbito de sua estrutura, a Gerência de Eficiência Energética e Água é responsável por coordenar e executar as ações de eficiência energética e de consumo racional de água, capacitar os gestores responsáveis por esses serviços e fiscalizar e acompanhar a execução da concessão administrativa de energia renovável.\\r"}]}, {"type": "paragraph", "children": [{"text": "A atuação conjunta das unidades busca promover a redução de custos, o uso eficiente dos recursos públicos, a sustentabilidade ambiental e a melhoria contínua da gestão dos serviços de energia elétrica e abastecimento de água no Poder Executivo Estadual."}]}]	[{"type": "paragraph", "children": [{"text": "Os serviços destinam-se aos órgãos e entidades integrantes do Poder Executivo Estadual que necessitem de apoio técnico, orientação, acompanhamento ou intervenção em assuntos relacionados à energia elétrica, ao abastecimento de água, à eficiência energética, à eficiência hídrica e à utilização de fontes renováveis.\\r"}]}, {"type": "paragraph", "children": [{"text": "O atendimento poderá ser solicitado, entre outras situações, quando houver necessidade de:\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tanalisar o consumo ou o faturamento de energia elétrica e água;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tidentificar aumentos atípicos de consumo ou possíveis desperdícios;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tsolicitar orientação sobre contratos de fornecimento de energia e água;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tavaliar a necessidade de alteração cadastral ou contratual de uma unidade consumidora;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tobter apoio para a implantação de medidas de eficiência energética ou hídrica;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tesclarecer dúvidas relacionadas ao Ambiente de Contratação Livre – ACL;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tacompanhar unidades consumidoras contempladas pela concessão administrativa de energia renovável(PPP – Usina Solar);\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tcapacitar ou atualizar os gestores responsáveis pelos serviços de energia e água;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tdesenvolver ações de conscientização e consumo racional;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tsolicitar apoio na interlocução com concessionárias, distribuidoras ou prestadores de serviços.\\r"}]}, {"type": "paragraph", "children": [{"text": "O atendimento também poderá ocorrer por iniciativa da própria Superintendência, a partir do monitoramento dos indicadores de consumo, da análise de faturas e/ou da identificação de situações que demandem atuação preventiva ou corretiva."}]}]	[{"type": "paragraph", "children": [{"text": "As demandas deverão ser encaminhadas pelo dirigente competente, pelo gestor de energia e água ou por servidor formalmente designado pelo órgão ou entidade interessada, utilizando os canais institucionais da Secretaria de Administração.\\r"}]}, {"type": "paragraph", "children": [{"text": "Quando a natureza da solicitação exigir análise técnica, manifestação formal, acesso a documentos ou adoção de providências administrativas, a demanda deverá ser encaminhada por meio de processo no Sistema Eletrônico de Informações – SEI.\\r"}]}, {"type": "paragraph", "children": [{"text": "A solicitação deverá apresentar, sempre que aplicável:\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tidentificação do órgão ou entidade solicitante;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tidentificação da unidade consumidora;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tdescrição objetiva da demanda;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tnúmero da instalação, matrícula ou conta contrato;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tendereço do imóvel;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tfaturas e documentos relacionados;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\thistórico das providências já adotadas;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tidentificação e contato do servidor responsável pelo acompanhamento.\\r"}]}, {"type": "paragraph", "children": [{"text": "Após o recebimento, a Superintendência ou a Gerência competente realizará a análise da solicitação e adotará as providências cabíveis, observadas as atribuições institucionais, a legislação vigente, os contratos existentes e os procedimentos estabelecidos pela Secretaria de Administração."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N		2026-08-05 19:07:55.802	Diego Santos Rolim 	\N		cmrtn35yi0002bqr5ck780vyc	[{"type": "paragraph", "children": [{"text": "A Superintendência de Energias Renováveis e Água e a Gerência de Eficiência Energética e Água prestam apoio técnico aos órgãos e entidades estaduais em matérias relacionadas à gestão de energia elétrica, energias renováveis, eficiência energética, abastecimento de água e consumo racional. Em 2025, a Superintendência foi vencedora do concurso nacional “Inovação no Setor Público”, promovido pela Escola Nacional de Administração Pública (ENAP) e também foi selecionada para apresentar o projeto/contrato da Usina Solar (PPP) por ocasião do CONSAD, que culminou com a publicação de artigo. Podendo ser contactada por meio do ramal institucional 3183-7720."}]}]	t
cmq9rvmr1000jg5ahyl18tc2d	Levantamentos topográficos georreferenciados	levantamentos-topograficos	9Hz2n0GEeULzlrUlgnxDTQ	2343744	1536	1024	png	Engenheiros realizando medições	Serviço técnico fundamental para a organização espacial das informações territoriais, permitindo a correta identificação, delimitação, análise e gestão de áreas de interesse do Estado de Pernambuco.	[{"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico que visa à realização de levantamentos geoespaciais, produção cartográfica, análises topográficas e geração de bases técnicas, indispensáveis à tomada de decisões administrativas e jurídicas relacionadas ao patrimônio imobiliário estadual.  \\nDentre as principais atividades desenvolvidas, destacam-se: levantamentos aerofotogramétricos com drones, levantamentos topográficos com receptores GNSS, processamento de dados geoespaciais, elaboração de plantas e memoriais descritivos, bem como o suporte técnico a procedimentos relacionados à regularização fundiária e patrimonial.\\nPara tanto, envolve a aplicação de tecnologias modernas de geoprocessamento,  sensoriamento remoto e topografia, com o objetivo de garantir:\\nPrecisão na delimitação territorial de imóveis públicos;Confiabilidade das informações geoespaciais;Suporte técnico às decisões administrativas;Regularização documental e cadastral de imóveis.\\nÉ realizado por engenheiros, com a devida Anotação de Responsabilidade Técnica (ART) sempre que se fizer necessária a correta identificação dos imóveis de interesse do Estado de\\nPernambuco."}]}]	[{"type": "paragraph", "children": [{"text": "Os levantamentos topográficos são necessários sempre que se precisa identificar,\\ncom precisão e acurácia, as medidas e limites de um imóvel. No âmbito da SAD,\\nesta atividade está diretamente ligada às políticas de gestão do patrimônio imobiliário do Estado, contribuindo para a organização, controle e valorização dos bens públicos."}]}]	[{"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de engenharia de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício, com a indicação\\ndo(s) endereço(s) do(s) imóvel(is) de interesse."}]}]	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	2026-09-03 12:29:59.713	Gustavo Andrade	\N		cmtimbobc0003and9kpvtp3me	[{"type": "paragraph", "children": [{"text": ""}]}]	t
cmq9jay9t0009boamyfuz2056	Usucapião	usucapiao	kxEDEUxgwk9LDZ3bSuPyAQ	1129174	4592	3448	jpg	Descreva a imagem.	Serviço destinado à análise das solicitações de usucapião de bens imóveis, com a finalidade de verificar a existência de posse, domínio ou interesse patrimonial do Estado de Pernambuco sobre o imóvel objeto do pedido.	[{"type": "paragraph", "children": [{"text": "A usucapião é um instrumento jurídico previsto na Constituição Federal e em normas infraconstitucionais que permite a aquisição da propriedade de um bem imóvel pela posse contínua, pacífica e pelo período estabelecido em lei, desde que atendidos os demais requisitos legais."}]}, {"type": "paragraph", "children": [{"text": "No Estado de Pernambuco, a análise das solicitações de usucapião que envolvam, efetiva ou potencialmente, bens do patrimônio estadual é de responsabilidade da Unidade de Avaliação de Processos Patrimoniais (UNAPI), vinculada à Secretaria Executiva de Patrimônio, Engenharia e Serviços Corporativos (SEPEC), da Secretaria de Administração (SAD).\\n\\nCompete à UNAPI a verificação da titularidade do imóvel objeto da ação de usucapião, bem como da existência de eventual posse, domínio ou interesse patrimonial do Estado de Pernambuco sobre a área. O resultado dessa verificação subsidia a manifestação da Administração Pública Estadual e a adoção das providências administrativas e jurídicas cabíveis, contribuindo para a proteção e a regular gestão do patrimônio público estadual."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "O serviço tem como destinatárias as pessoas físicas ou jurídicas que estejam interessadas em regularizar um bem imóvel por meio do instituto da usucapião, seja na modalidade extrajudicial (realizada em cartório) ou judicial (por meio do Poder Judiciário)."}]}, {"type": "paragraph", "children": [{"text": "Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo o  devido registro e, como decorrência, uma maior segurança jurídica sobre o patrimônio, pode buscar esses serviços para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido."}]}, {"type": "paragraph", "children": [{"text": "A regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, cumprimento da função social do imóvel e pleno exercício dos direitos do proprietário."}]}]	[{"type": "paragraph", "children": [{"text": "Com o objetivo de oferecer mais comodidade aos interessados, a Secretaria de Administração de Pernambuco (SAD) disponibiliza o Peticionamento Eletrônico do SEI-PE, um canal eletrônico destinado a pessoas físicas, pessoas jurídicas, órgãos e entidades para a solicitação de serviços e o envio de documentos à SAD."}]}, {"type": "paragraph", "children": [{"text": "Por meio dessa ferramenta, é possível protocolar documentos e acompanhar a tramitação do processo de forma totalmente eletrônica, sem necessidade de comparecimento presencial à Secretaria de Administração ou de envio de documentação pelos Correios, proporcionando mais agilidade, praticidade e economia ao cidadão."}]}, {"type": "paragraph", "children": [{"text": "Para obter mais informações sobre o procedimento de Peticionamento Eletrônico da Usucapião Extrajudicial, consulte o manual de instruções disponível no link:"}]}, {"type": "paragraph", "children": [{"text": ""}, {"href": "https://docs.google.com/document/d/1BLJEXoCGQtwi0bSDmDY3Y5SWpyzS_wFpiZn3erTTcyc/edit?tab=t.0#heading=h.diyw7px6iw4f", "type": "link", "children": [{"text": "https://docs.google.com/document/d/1BLJEXoCGQtwi0bSDmDY3Y5SWpyzS_wFpiZn3erTTcyc/edit?tab=t.0#heading=h.diyw7px6iw4f"}]}, {"text": ""}]}, {"type": "paragraph", "children": [{"text": "Este manual apresenta as orientações necessárias para a utilização do sistema de Peticionamento Eletrônico na abertura de processos de Consulta de Usucapião Extrajudicial. De forma clara e detalhada, são apresentadas todas as etapas necessárias para a realização do procedimento, desde o cadastro do usuário no sistema até o protocolo final do peticionamento."}]}]	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	2026-09-03 19:37:22.833	Sylvio Carlos Santana Siqueira Gomes Macedo Guedes	\N		cmq9j1frn0000boamvyqh9qnc	[{"type": "paragraph", "children": [{"text": "Esclarecimentos adicionais podem ser obtidos nos seguintes contatos:"}]}, {"type": "paragraph", "children": [{"text": "Telefone: (81) 3183-7739"}]}, {"type": "paragraph", "children": [{"text": "E-mail: gestaoimobiliaria@sad.pe.gov.br."}]}]	t
cmrj6jz5h0016tspsfrh0gcht	Gestão de Manutenção da Frota Própria do Estado	teste3	yhofuGoPqwG0CHOLTO49FQ	3711798	5760	3840	jpg	teste3	Serviço de suporte e acompanhamento das manutenções preventivas e corretivas de veículos e equipamentos próprios do Estado, visando garantir o funcionamento contínuo, a segurança operacional e a preservação dos bens públicos.	[{"type": "paragraph", "children": [{"text": "A Unidade de Manutenção da Gerência de Frotas acompanha e presta suporte técnico aos órgãos estaduais no gerenciamento da manutenção de seus veículos próprios e equipamentos motorizados (como tratores, roçadeiras, geradores, embarcações, entre outros).\\r"}]}, {"type": "paragraph", "children": [{"text": "O serviço atua no auxílio ao diagnóstico técnico, na mediação e interlocução com a empresa contratada/rede credenciada de oficinas, no alinhamento de orçamentos e no monitoramento dos prazos de reparo, assegurando o correto aproveitamento dos recursos públicos e a conservação do patrimônio estadual."}]}]	[{"type": "paragraph", "children": [{"text": "Gestores de frota e responsáveis patrimoniais dos órgãos e entidades da Administração Pública Estadual que possuem frota própria ou equipamentos patrimoniados (não se aplicando a veículos exclusivamente locados).\\r"}]}, {"type": "paragraph", "children": [{"text": "É necessário sempre que houver demanda por revisão periódica (preventiva), falhas operacionais ou mecânicas, necessidade de substituição de peças, reparos corretivos, ou diante de impasses e dúvidas técnicas na relação com a empresa fornecedora dos serviços de manutenção."}]}]	[{"type": "ordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Abertura de O.S. (Ordem de Serviço):"}, {"text": " Cadastrar o chamado no sistema de gestão de manutenção/frotas, detalhando as necessidades do veículo ou equipamento."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Cotação e Orçamento:"}, {"text": " Para aprovação do orçamento, é necessário que sejam incluídos no mínimo 10 participantes da rede credenciada e obtidas no mínimo 03 respostas de orçamentos que atendam a 100% dos itens solicitados."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Avaliação da Central de Manutenção:"}, {"text": " Após o envio das cotações, a Central de Manutenção avalia o processo, podendo aprovar, negociar valores e até mesmo realizar vistoria in loco no veículo ou equipamento para garantir a correta execução dos serviços e a precificação justa."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Antecipação de Saldo:"}, {"text": " Encaminhar e-mail para: "}, {"href": "mailto:centraldemanutenacao@sad.pe.gov.br", "type": "link", "children": [{"text": "centraldemanutenacao@sad.pe.gov.br"}]}, {"text": " informando responsável, valor, justificativa e período de antecipação."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Adesão e/ou Aditivo de Acréscimo ao Contrato:"}, {"text": " Encaminhar solicitação formal via SEI à SEPEC (Secretaria Executiva de Patrimônio e Serviços Corporativos), com as devidas justificativas e tramitação formal no órgão, observado o fluxo de autorizações."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	2026-08-17 18:07:43.169	Diego Santos Rolim 	\N		cmrtn2i7v0000bqr5csm0w82l	[{"type": "paragraph", "children": [{"text": "Em caso de dúvidas, entre em contato com a Gerência de Frotas (GEFRO) pelo ramal (81) 3183-7745."}]}]	t
cmsonhszz00bf2ggi2yx80kmi	Telemática	teste 8	HcpWHPDC4k95yA_euGilLg	3532629	5568	3712	jpg		A Gerência de Telemática da SAD-PE é responsável pela formulação, gestão, coordenação e acompanhamento dos contratos corporativos de telemática, que fornecem serviços de tecnologia da informação e comunicação aos órgãos da Administração Pública Estadual e a outros poderes com atuação no Estado.	[{"type": "paragraph", "children": [{"text": "A Rede PE-Conectado II é a atual rede corporativa de telemática do Governo de Pernambuco. Ela oferece um conjunto integrado de serviços de telecomunicações, disponibilizados por meio de contrato mater, instrumento contratual corporativo gerenciado pela Secretaria de Administração."}]}, {"type": "paragraph", "children": [{"text": "A rede atende órgãos e entidades do Estado e permite, também, a adesão de instituições públicas de diferentes esferas e poderes que atuem em Pernambuco."}]}, {"type": "paragraph", "children": [{"text": "Os serviços contratados integram comunicação de dados, voz e imagem, contribuindo para a redução de custos e para a melhoria da gestão dos recursos de telecomunicações. A solução possui cobertura em todo o território pernambucano, incluindo a capital e o interior."}]}, {"type": "paragraph", "children": [{"text": "Além disso, a rede intragoverno utiliza tecnologia VoIP, permitindo a comunicação entre unidades participantes sem custos de tráfego telefônico."}]}, {"type": "paragraph", "children": [{"text": "Entre os serviços disponibilizados, destacam-se:"}]}, {"type": "paragraph", "children": [{"text": "•\\ttelefonia móvel;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\ttelefonia fixa;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tlinks de comunicação de dados, com possibilidade de redundância;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\trede sem fio (Wi-Fi);\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tinfraestrutura de voz para contact center;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tcomunicação unificada;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tinternet corporativa;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tsoluções de segurança de redes e acessos;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tcentral de atendimento (help desk);\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tgerenciamento da rede, incluindo monitoramento de disponibilidade, desempenho, falhas, configuração e suporte técnico;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tdemais serviços correlatos de telecomunicações.\\r"}]}, {"type": "paragraph", "children": [{"text": "Esses recursos contribuem para a modernização da administração pública e para a melhoria dos serviços oferecidos à população."}]}]	[{"type": "paragraph", "children": [{"text": "Os serviços destinam-se aos órgãos e entidades do Poder Executivo Estadual e são essenciais para a execução de suas atividades administrativas e finalísticas."}]}, {"type": "paragraph", "children": [{"text": "Os recursos oferecidos possibilitam uma comunicação eficiente entre os órgãos governamentais e também viabilizam canais de atendimento utilizados pelos cidadãos para acesso aos serviços públicos estaduais."}]}]	[{"type": "paragraph", "children": [{"text": "As demandas devem ser encaminhadas pelo dirigente competente ou pelo gestor de telemática formalmente designado pelo órgão ou entidade interessada, por meio dos canais institucionais da Secretaria de Administração."}]}, {"type": "paragraph", "children": [{"text": "Quando a solicitação exigir análise técnica, manifestação formal, acesso a documentos ou adoção de providências administrativas, o encaminhamento deverá ser realizado por processo no Sistema Eletrônico de Informações (SEI)."}]}, {"type": "paragraph", "children": [{"text": "A solicitação deverá conter, sempre que aplicável:\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tidentificação do órgão ou da entidade solicitante;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tdescrição objetiva da demanda;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tjustificativa fundamentada da solicitação;\\r"}]}, {"type": "paragraph", "children": [{"text": "•\\tidentificação e contato do servidor responsável pelo acompanhamento.\\r"}]}, {"type": "paragraph", "children": [{"text": "Após o recebimento, a Superintendência ou Gerência competente realizará a análise da demanda e adotará as providências cabíveis, observando as atribuições institucionais, a legislação vigente, os contratos existentes e os procedimentos estabelecidos pela Secretaria de Administração."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	2026-08-11 13:20:43.28	Diego Santos Rolim 	\N		cmrtn3ddb0004bqr56kh31dp0	[{"type": "paragraph", "children": [{"text": "Em atuação conjunta com a Agência Estadual de Tecnologia da Informação (ATI), as demandas que envolvem análise técnica também são acompanhadas pela Agência.\\r"}]}, {"type": "paragraph", "children": [{"text": "A ATI é responsável pelo acompanhamento técnico da Rede Corporativa de Telemática, monitorando a execução dos serviços contratados e trabalhando junto aos fornecedores para assegurar os níveis de qualidade, disponibilidade e desempenho necessários.\\r"}]}, {"type": "paragraph", "children": [{"text": "Atualmente, está em fase de contratação a nova geração da rede corporativa de telemática do Estado, denominada Rede PE-Ultradigital, que contará com tecnologias mais modernas e recursos avançados de comunicação, contribuindo para a transformação digital e o aprimoramento dos serviços públicos em Pernambuco."}]}]	t
cmsxkn04g000c13zxiwtir7a8	Gestão de Abastecimento da Frota Estadual	testte2	U_xO44CTZ0Q3wo6IjPa6tw	2465454	5258	3365	jpg	teste	A Unidade de Abastecimento da Gerência de Frotas acompanha o consumo de combustíveis, presta suporte aos gestores de frota e atua na articulação entre as Secretarias de Estado e a empresa fornecedora, apoiando aditivos contratuais e antecipação de saldo.	[{"type": "paragraph", "children": [{"text": "A Unidade de Abastecimento é responsável pelo monitoramento contínuo dos saldos mensais de combustível das frotas de todos os órgãos e entidades do Estado de Pernambuco. Por meio desse acompanhamento sistemático, a equipe identifica fragilidades e antecipa situações que possam comprometer o fornecimento, atuando de forma preventiva junto aos gestores de frota. A Unidade também exerce papel central na interlocução entre os órgãos estaduais e a empresa contratada, contribuindo para a fluidez do diálogo e para a continuidade do serviço de abastecimento em toda a Administração Pública Estadual."}]}]	[{"type": "paragraph", "children": [{"text": "Gestores de frota e demais servidores envolvidos com a dinâmica do transporte administrativo. O serviço é necessário sempre que for preciso algum tipo de intervenção direta junto à empresa fornecedora; quando um órgão identificar fragilidade que possa comprometer suas entregas; ou quando for necessário solicitar aumento de limites, seja por meio de aditivo de acréscimo ao contrato, seja por antecipação de saldo mensal."}]}]	[{"type": "paragraph", "children": [{"text": "•\\t"}, {"bold": true, "text": "Antecipação de saldo: "}, {"text": "encaminhar o formulário específico (link abaixo), informando responsável, valor, justificativa e demais dados solicitados.\\r\\nFormulário de antecipação de saldo;"}]}, {"type": "paragraph", "children": [{"text": "•\\t"}, {"bold": true, "text": "Aditivo de acréscimo ao contrato:"}, {"text": " encaminhar solicitação formal via SEI à SEPEC (Secretaria Executiva de Patrimônio e Serviços Corporativos), com as devidas justificativas e tramitação formal no órgão, observado o fluxo de autorizações."}]}]	cmq81pvoq0003j9azcu4vg0ws	\N	Diego Santos Rolim 	\N		\N		cmrtn2i7v0000bqr5csm0w82l	[{"type": "paragraph", "children": [{"text": "Em caso de dúvidas, entre em contato com a GEFRO pelo ramal (81) 3183-7745."}]}]	t
cmq9t9rk4001lg5ahaik26l1u	Projetos de arquitetura	projetos-arquitetura	uUltbFVqhllgP969gdhBVQ	2383059	1536	1024	png	arquitetas desenhando	Serviço técnico destinado ao planejamento, organização e orientação dos projetos de construção ou reformas com o objetivo de fazer um melhor aproveitamento dos espaços , adequados à legislação vigente proporcionando conforto e economia financeira pela antecipação de demandas	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado.\\nSão realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\\nserviços."}]}, {"type": "paragraph", "children": [{"text": "Exemplos de projetos de arquitetura:"}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto arquitetônico:"}, {"text": "dimensiona espaços a partir do programa de necessidades para melhor atendimento das demandas, além de peças técnicas para elaboração de projetos complementares de engenharia, legalização junto ao poder público e detalhamento para posterior execução da obra"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto de reforma:"}, {"text": "elaboração de projetos para readequação dos espaços para que possa servir às demandas atuais"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto de Layout:"}, {"text": "reorganização do espaço física para definição a posição de móveis, equipamentos e rotas de circulação"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Estudo de Viabilidade :"}, {"text": "análise prévia em que é estudado as variáveis de legislação , técnica e econômica para avaliação da viabilidade do projeto."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Apoio Técnico aos Projetos de Restauro:"}, {"text": "Atuação no acompanhamento e suporte técnico às intervenções de conservação, manutenção e restauro de imóveis públicos, contribuindo para a análise das demandas, articulação entre as equipes de arquitetura e engenharia."}]}]}]}, {"type": "paragraph", "children": [{"text": "Para colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Levantamento das necessidades;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Estudo Preliminar;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Anteprojeto;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto Básico;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto Executivo;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"bold": true, "text": "Projeto de Detalhamento."}]}]}]}, {"type": "paragraph", "children": [{"text": "É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Os projetos de arquitetura são importantes sempre que se faz necessária a construção, reforma ou regularização de um imóvel. O serviço de arquitetura pode ser solicitado para construção ou reforma de imóveis , definição ou alteração de layout, regularização de imóvel junto à prefeitura ou cartórios , entre outros."}]}]	[{"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de arquitetura de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício (via Sistema Eletrônico de Informação), acompanhadas dos respectivos planos de necessidades, seguindo o modelo do formulário abaixo."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	2026-09-04 11:46:51.217	Amanda Soares Barros	\N		cmq9rhpc1000dg5ah7p97x6qj	[{"type": "paragraph", "children": [{"text": ""}]}]	t
\.


--
-- Data for Name: Setores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Setores" (id, nome, gerencia, "createdAt", "createdBy", "updatedAt", "updatedBy") FROM stdin;
cmq9j1sbd0002boam73vjfct4	UCPAM	\N	\N		\N	
cmq9jevto000gboam7zrq5u0p	GDEST	\N	\N		\N	
\.


--
-- Data for Name: Solucoes; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Solucoes" (id, titulo, slug, categoria, imagem_id, imagem_filesize, imagem_width, imagem_height, imagem_extension, "imagemAlt", resumo, corpo, "linkExterno", "areaResponsavel", "createdAt", "createdBy", subarea, "updatedAt", "updatedBy", ativo) FROM stdin;
cmi3h5i7b0005vwpm6wngrtl4	GeoPE	geo-pe	geo	iNn49AQc6IVi-nC3iqTH6w	1150880	5200	3466	jpg	GeoPE	Plataforma de geolocalização dos imóveis do Estado de Pernambuco	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "GeoPE"}, {"text": " é a plataforma oficial de georreferenciamento dos imóveis do Estado de Pernambuco, desenvolvida para apoiar a gestão e a análise imobiliária do patrimônio público estadual."}]}, {"type": "paragraph", "children": [{"text": "A solução utiliza tecnologias de sistemas de informação geográfica para integrar dados espaciais e informações relacionadas aos imóveis pertencentes ao Estado, permitindo que gestores e equipes técnicas visualizem esses dados diretamente no mapa interativo podendo navegar pelas suas informações gerais, cartorárias dos imóveis e chegar até suas documentações."}]}, {"type": "paragraph", "children": [{"text": "Por meio da plataforma, é possível localizar imóveis públicos no território, analisar sua distribuição geográfica e acessar informações relevantes sobre cada bem imóvel cadastrado."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Entre as principais funcionalidades do GeoPE estão:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Consulta de informações territoriais e administrativas dos bens;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Apoio ao planejamento e à gestão patrimonial;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Integração entre dados geográficos e informações institucionais;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Ferramentas de análise espacial."}]}]}]}, {"type": "paragraph", "children": [{"text": "A plataforma contribui para ampliar a capacidade de análise territorial da administração pública, promovendo maior integração entre dados, transparência na gestão patrimonial e eficiência no planejamento de ações relacionadas ao patrimônio público estadual."}]}]	https://geope.pe.gov.br/login	cmq6yxa510000nh1tnduds1mc	\N		cmq9j1frn0000boamvyqh9qnc	2026-06-11 13:41:24.02	Administrador	t
cmq9rzu75000ng5ahwwwkegmh	Lorem	lorem	projetos	Cza4EDWgokU-7Q9oroIetQ	1032968	5628	3752	jpg	lorem	Lorem	[{"type": "paragraph", "children": [{"text": "Lorem"}]}]		cmq81pn5v0001j9azrqcx4d99	\N	Gerado por Administrador	cmq9rha92000bg5ah7gkhkjyd	2026-06-11 17:33:21.856	Administrador	t
cmqaxqam4000012bq6kh4olp6	Lorem	Lorem	aplicacoes	AMy2IWoBQoUfTAOVIvsFwQ	876322	4608	3072	jpg	lorem	Sed quas nesciunt qui dolore modi eum quisquam minima sed repellat veritatis ut neque iste ut quae galisum. Et Quis quidem et unde blanditiis et repellendus reprehenderit et eveniet repudiandae. Qui sint omnis cum sunt nobis in nobis voluptatem.	[{"type": "paragraph", "children": [{"text": "veritatis accusamus non dolores accusantium sit internos obcaecati vel dolore alias sed rerum dolorem et porro Quis et earum tempora. Ut galisum eius At vitae omnis et quia officia?"}]}]		cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn35yi0002bqr5ck780vyc	2026-07-13 13:56:53.31	Administrador	t
cmq9kax0b0015boamd0oi79c4	Acervo Móvel	acervo-movel	aplicacoes	Wtvi0EXPZUdtlG-yMycg4Q	1423920	3400	3000	jpg	Sistema digital de consulta ao acervo de bens móveis do patrimônio público estadual	Ferramenta de consulta das informações dos bens móveis do Estado de Pernambuco.	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "Acervo Móvel"}, {"text": " é a plataforma de consulta das informações dos bens móveis do Estado de Pernambuco, desenvolvida para apoiar a gestão patrimonial e o acompanhamento dos ativos públicos estaduais."}]}, {"type": "paragraph", "children": [{"text": "A solução reúne dados cadastrais dos bens móveis em um ambiente organizado e de fácil consulta, permitindo que gestores e equipes técnicas acessem informações essenciais para o controle, o planejamento e a administração do patrimônio público."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Entre as principais funcionalidades do Acervo Móvel estão:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Consulta de informações sobre os bens móveis cadastrados;\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Visualização estruturada dos dados patrimoniais;\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Apoio às atividades de controle e gestão dos ativos públicos;\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Organização das informações para acompanhamento patrimonial;\\n"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Acesso rápido às informações pelos órgãos e equipes gestoras.\\n"}]}]}]}, {"type": "paragraph", "children": [{"text": "A plataforma contribui para modernizar a gestão dos bens móveis, promovendo maior organização das informações, eficiência administrativa e transparência na gestão do patrimônio público estadual."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	https://acervomovel.pe.gov.br/login	cmq6yxa510000nh1tnduds1mc	\N	Gerado por Administrador	cmqgnv5xk00003adnqj7bkkdv	2026-06-17 18:35:36.408	Administrador	t
cmrj73nup0018tspsa6le4i3e	Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus 	teste4	bi	vtTZr5TnquLtE9T1zJr_fA	2399419	6144	4069	jpg	teste	Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus nemo nam autem quia ut quaerat ipsa qui iure quas qui minima consequatur?	[{"type": "paragraph", "children": [{"text": "Lorem ipsum dolor sit amet. Aut maxime consequatur est ducimus nemo nam autem quia ut quaerat ipsa qui iure quas qui minima consequatur? At perspiciatis optio eum magnam enim in quod dolor hic voluptas consectetur? Qui officiis Quis ut galisum velit rem impedit galisum qui quod laborum et quia nesciunt qui commodi nemo et amet magni."}]}]	test4	cmq81pvoq0003j9azcu4vg0ws	\N	Gerado por Administrador	cmrtn3ddb0004bqr56kh31dp0	2026-07-13 12:25:34.689	Administrador	t
cmqjioi3a0008mw2bfz85q62u	Atlas.PE	atlas.pe	geo	El1fS1WxEqH0wSAOOY6hSg	1066651	3840	2160	jpg	Patrimônio do Estado de Pernambuco	Plataforma digital de consulta ágil ao patrimônio imobiliário do Estado de Pernambuco.	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "Atlas.PE"}, {"text": " é a plataforma de consulta do patrimônio imobiliário do Estado de Pernambuco, desenvolvida para facilitar o acesso às informações cadastrais dos bens imóveis e apoiar a gestão patrimonial."}]}, {"type": "paragraph", "children": [{"text": "A solução permite que gestores e equipes técnicas realizem consultas rápidas e organizadas, localizando imóveis por diferentes critérios, visualizando informações consolidadas e compartilhando cenários de consulta entre usuários. Quando necessário, a plataforma integra-se ao GeoPE, ampliando a análise territorial por meio da visualização georreferenciada dos imóveis."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Entre as principais funcionalidades do Atlas.PE estão:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Consulta de imóveis por código, NP, endereço, destinação, município e outros critérios;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Visualização das informações cadastrais e atributos dos bens imóveis"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Aplicação de filtros e recortes para análises específicas;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Compartilhamento de consultas e reutilização de filtros salvos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Integração com o GeoPE para análise espacial dos imóveis;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Acesso a recursos avançados conforme o perfil de acesso do usuário."}]}]}]}, {"type": "paragraph", "children": [{"text": "A plataforma contribui para tornar a consulta patrimonial mais ágil e eficiente, promovendo maior organização das informações, apoio à tomada de decisão e integração entre os dados cadastrais e territoriais do patrimônio público estadual."}]}]	https://atlas.pe.gov.br/login	cmq6yxa510000nh1tnduds1mc	\N	Agelson Santana	cmq9j1frn0000boamvyqh9qnc	2026-06-18 13:17:08.329	Agelson Santana	t
\.


--
-- Data for Name: Subareas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Subareas" (id, nome, area, "createdAt", "createdBy", "updatedAt", "updatedBy") FROM stdin;
cmq9j1frn0000boamvyqh9qnc	Patrimônio Imobiliário	cmq6yxa510000nh1tnduds1mc	\N		\N	
cmq9rhpc1000dg5ah7p97x6qj	Arquitetura	cmq81pn5v0001j9azrqcx4d99	\N		\N	
cmqgnv5xk00003adnqj7bkkdv	Patrimônio Móvel	cmq6yxa510000nh1tnduds1mc	\N		\N	
cmrtn2i7v0000bqr5csm0w82l	Frota	cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmrtn35yi0002bqr5ck780vyc	Água e Energia	cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmrtn3ddb0004bqr56kh31dp0	Telemática	cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmrtn3l1x0006bqr58awnhiel	Contratos Corporativos	cmq81pvoq0003j9azcu4vg0ws	\N		\N	
cmtimbobc0003and9kpvtp3me	Cartografia	cmq81pn5v0001j9azrqcx4d99	\N		\N	
cmtimbobe0005and9z3nes0so	Avaliação	cmq81pn5v0001j9azrqcx4d99	\N		\N	
cmtimbobi0008and9tz72q58n	Frota	cmtimbobf0006and9f8buqgd7	\N		\N	
cmtimbobj000aand9dssjr404	Água e Energia	cmtimbobf0006and9f8buqgd7	\N		\N	
cmq9rha92000bg5ah7gkhkjyd	Engenharia	cmq81pn5v0001j9azrqcx4d99	\N		\N	
\.


--
-- Data for Name: Tag; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Tag" (id, nome, "areaResponsavel", subarea) FROM stdin;
cmi62n48s00011b0bbgg5p8dg	INFORMAÇÕES	\N	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."User" (id, name, email, password, role, "resetCode", "passwordResetToken", "passwordResetIssuedAt", "passwordResetRedeemedAt", "createdAt") FROM stdin;
cmselgwuo006h2ggi2snn8pg9	Fabio Oliveira Araújo da Silva	fabioo.silva@sad.pe.gov.br	$2a$10$HBAPyVbCYQeeF7EBjp7WyOU3irvJ6IgG/I7jcvQJuwsjLpwc.j2dm	operator	vsksrr0a	\N	\N	\N	2026-08-04 03:00:00
cmqb02fid0000zhxvp8gj34av	Gustavo Andrade	gustavo.andrade@sad.pe.gov.br	$2a$10$YSK9YPVM.GbXHbJnUN.c8uklmROKS891gDQXRLXnz/g5gBX0oh/z.	admin		\N	\N	\N	2026-06-12 03:00:00
cmqgp85870000cifj4mbr6ra4	Agelson Santana	agelson.santana@sad.pe.gov.br	$2a$10$V57K.M9qg8t39T1zMXEDL.kZtUnqHy6kSEOipxWadMJNPQHgl1xU.	admin		\N	\N	\N	2026-06-16 03:00:00
cmtipwltp003tlviejt2wj22c	Humberto de Souza	humberto.breves@sad.pe.gov.br	$2a$10$dpphhNl5vJWnYRifiVNxj.DE8AxYojAUSyunBBVk00Fes.CNVFCt.	operator		\N	\N	\N	2026-09-01 03:00:00
cmtiq1va6003ulviezvjmwkvd	Amanda Soares Barros	amanda.sbarros@sad.pe.gov.br	$2a$10$4GW0lIpYSa8upEHTbfoBLunGxFBm40awAF7wIVGxpyg.WC5rjmjFq	operator		\N	\N	\N	2026-09-01 03:00:00
cmtiq3t3k003xlvie37gfda0z	Ana Claudia de Souza Ferreira	anaclaudia.souza@sad.pe.gov.br	$2a$10$e4ROLq1Z5p.aJWHm12ys/O7KqvFsN5RmPSNDy1EpqNRMqWxUggJ0K	operator		\N	\N	\N	2026-09-01 03:00:00
cmtiypxji004xlvie9t1gm66h	Danielly Botelho	danielly.botelho@sad.pe.gov.br	$2a$10$fGIDW7mRb9cMRML0ADSjAOk/Yh46.c33mSLhZtXljQloKYwFMjcD2	operator		\N	\N	\N	2026-09-01 03:00:00
cmtlmtaao008rlvieh8zejs75	Ingrid Valões	ingrid.vsilva@sad.pe.gov.br	$2a$10$m5GKdY.j5Eir2iO5lCnnhOct2SEvqpAXaum6ioCHhOX1BIsVhECoi	operator		\N	\N	\N	2026-09-03 03:00:00
cmray3xuh0004tspshv0iq9t6	Adauto Nunes	adauto.nunes@sad.pe.gov.br	$2a$10$lSjsuxJLKTld9cYpSzDA9.bzZJEGEftVs5zX09oYwLqwG22Gy4y8m	operator		\N	\N	\N	\N
cmray1pv20003tspsextpr2hx	Viktoria Heyka	viktoria.cruz@sad.pe.gov.br	$2a$10$GH0PF7Ys7zgNUsF1W5vEluVv23WFCOY81Sk1OWpUf0RPvbr08ZN1.	operator	m8oc996h	\N	\N	\N	2026-07-07 03:00:00
cmtlv6w2h009rlviejqh418kz	Sylvio Carlos Santana Siqueira Gomes Macedo Guedes	sylvio.csantana@sad.pe.gov.br	$2a$10$/YRdBqvWlqub3tDHW/7H7eGFmkHe/eoOlYydXcU.ySCTtIxTsbpK.	operator		\N	\N	\N	2026-09-03 03:00:00
cmray09z70002tspsy7n7dw4i	Igor Sacramento	igor.sacramento@sad.pe.gov.br	$2a$10$5KOTm5cqC.EBfGhOk62F9e5Lynu0otddHq/5/ROHa3hJZ3K.Qj8F6	operator	yeec36ql	\N	\N	\N	2026-07-07 03:00:00
cmqfanycj0000jgwhdjslktjf	Allan Soares	allan.soares.sad@gmail.com	$2a$10$hElLKxgchw9aYVJ/LaS0xuzhrN3dbjAGtAMXpHPEV.fU1oZHSoZuK	operator	27e9e39i	\N	\N	\N	2026-06-15 03:00:00
cmrkp2oro00006q71uhutfoc7	Diego Santos Rolim 	diego.rolim@sad.pe.gov.br	$2a$10$prbsGZW1W/puT2u2FtzR.Ovx7ArpYmS48J9E.51NTQPW/HIzG/Onq	operator		\N	\N	\N	2026-07-14 03:00:00
cmq6r6jqo0000elnou72iyd14	Administrador	admin@admin.com	$2a$10$2HG0Wxpz6rcKwpn1Uvu0AOEPefNTwMfpcrt4i0quCuYu8lvttdhT6	admin		\N	\N	\N	\N
cmrkom6340000esf0tqclr2dl	user teste	clovis.melo@sad.pe.gov.br	$2a$10$2HG0Wxpz6rcKwpn1Uvu0AOEPefNTwMfpcrt4i0quCuYu8lvttdhT6	operator	5k4wuq9p	\N	\N	\N	2026-07-14 03:00:00
\.


--
-- Data for Name: _Noticia_tags; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."_Noticia_tags" ("A", "B") FROM stdin;
cmq9jzq8i000zboam9nk4qe3h	cmi62n48s00011b0bbgg5p8dg
cmq9k32m60012boamq05d5shl	cmi62n48s00011b0bbgg5p8dg
cmq9rkwj7000fg5ahnyowdrmz	cmi62n48s00011b0bbgg5p8dg
cmq9jw5zr000wboam4ifx9wd9	cmi62n48s00011b0bbgg5p8dg
cmrc3ww16000dtspszf1dls7l	cmi62n48s00011b0bbgg5p8dg
cmtliqh2u007vlviek7f416fn	cmi62n48s00011b0bbgg5p8dg
\.


--
-- Data for Name: _User_areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_User_areas" ("A", "B") FROM stdin;
cmq6yxa510000nh1tnduds1mc	cmray09z70002tspsy7n7dw4i
cmq6yxa510000nh1tnduds1mc	cmray1pv20003tspsextpr2hx
cmq6yxa510000nh1tnduds1mc	cmray3xuh0004tspshv0iq9t6
cmq81pvoq0003j9azcu4vg0ws	cmrkp2oro00006q71uhutfoc7
cmq6yxa510000nh1tnduds1mc	cmrkom6340000esf0tqclr2dl
cmq6yxa510000nh1tnduds1mc	cmselgwuo006h2ggi2snn8pg9
cmq81pn5v0001j9azrqcx4d99	cmqfanycj0000jgwhdjslktjf
cmq6yxa510000nh1tnduds1mc	cmtipwltp003tlviejt2wj22c
cmq81pn5v0001j9azrqcx4d99	cmtipwltp003tlviejt2wj22c
cmq81pvoq0003j9azcu4vg0ws	cmtipwltp003tlviejt2wj22c
cmq81pn5v0001j9azrqcx4d99	cmtiq1va6003ulviezvjmwkvd
cmq81pn5v0001j9azrqcx4d99	cmtiq3t3k003xlvie37gfda0z
cmq6yxa510000nh1tnduds1mc	cmtiypxji004xlvie9t1gm66h
cmq6yxa510000nh1tnduds1mc	cmtlmtaao008rlvieh8zejs75
cmq6yxa510000nh1tnduds1mc	cmtlv6w2h009rlviejqh418kz
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
0e1d1ebd-ce53-41f0-8ecb-c7ce816323b6	4d116064e6a4cd04347b592631db2dd3736fec156b19ee4761b79230562676e3	2026-06-09 11:07:17.53279-03	20260527131323_add_user_areas	\N	\N	2026-06-09 11:07:17.45302-03	1
55f25c3e-bbcd-48c9-9b5a-62acf9dfd942	a69d71ad6857fb30982eecea4f6f1e5b98ba8e249165e8d711afac77f889b9d0	2026-06-09 11:07:17.547857-03	20260527132352_remove_gerencia_setor	\N	\N	2026-06-09 11:07:17.5399-03	1
\.


--
-- Name: Acesso Acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Acesso"
    ADD CONSTRAINT "Acesso_pkey" PRIMARY KEY (id);


--
-- Name: AreasResponsaveis AreasResponsaveis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AreasResponsaveis"
    ADD CONSTRAINT "AreasResponsaveis_pkey" PRIMARY KEY (id);


--
-- Name: AuditLogs AuditLogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLogs"
    ADD CONSTRAINT "AuditLogs_pkey" PRIMARY KEY (id);


--
-- Name: Cursos Cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Cursos"
    ADD CONSTRAINT "Cursos_pkey" PRIMARY KEY (id);


--
-- Name: Gerencias Gerencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Gerencias"
    ADD CONSTRAINT "Gerencias_pkey" PRIMARY KEY (id);


--
-- Name: Gestores Gestores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Gestores"
    ADD CONSTRAINT "Gestores_pkey" PRIMARY KEY (id);


--
-- Name: Legislacoes Legislacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Legislacoes"
    ADD CONSTRAINT "Legislacoes_pkey" PRIMARY KEY (id);


--
-- Name: Noticia Noticia_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Noticia"
    ADD CONSTRAINT "Noticia_pkey" PRIMARY KEY (id);


--
-- Name: PaginaQuemSomos PaginaQuemSomos_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."PaginaQuemSomos"
    ADD CONSTRAINT "PaginaQuemSomos_pkey" PRIMARY KEY (id);


--
-- Name: PortfolioImagens PortfolioImagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PortfolioImagens"
    ADD CONSTRAINT "PortfolioImagens_pkey" PRIMARY KEY (id);


--
-- Name: Portfolios Portfolios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Portfolios"
    ADD CONSTRAINT "Portfolios_pkey" PRIMARY KEY (id);


--
-- Name: QuemSomosMuralItem QuemSomosMuralItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosMuralItem"
    ADD CONSTRAINT "QuemSomosMuralItem_pkey" PRIMARY KEY (id);


--
-- Name: QuemSomosSubareaItem QuemSomosSubareaItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosSubareaItem"
    ADD CONSTRAINT "QuemSomosSubareaItem_pkey" PRIMARY KEY (id);


--
-- Name: QuemSomosTimeItem QuemSomosTimeItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosTimeItem"
    ADD CONSTRAINT "QuemSomosTimeItem_pkey" PRIMARY KEY (id);


--
-- Name: Servicos Servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Servicos"
    ADD CONSTRAINT "Servicos_pkey" PRIMARY KEY (id);


--
-- Name: Setores Setores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Setores"
    ADD CONSTRAINT "Setores_pkey" PRIMARY KEY (id);


--
-- Name: Solucoes Solucoes_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Solucoes"
    ADD CONSTRAINT "Solucoes_pkey" PRIMARY KEY (id);


--
-- Name: Subareas Subareas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subareas"
    ADD CONSTRAINT "Subareas_pkey" PRIMARY KEY (id);


--
-- Name: Tag Tag_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Tag"
    ADD CONSTRAINT "Tag_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Cursos_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Cursos_areaResponsavel_idx" ON public."Cursos" USING btree ("areaResponsavel");


--
-- Name: Cursos_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Cursos_subarea_idx" ON public."Cursos" USING btree (subarea);


--
-- Name: Gerencias_area_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Gerencias_area_idx" ON public."Gerencias" USING btree (area);


--
-- Name: Gestores_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Gestores_areaResponsavel_idx" ON public."Gestores" USING btree ("areaResponsavel");


--
-- Name: Legislacoes_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Legislacoes_areaResponsavel_idx" ON public."Legislacoes" USING btree ("areaResponsavel");


--
-- Name: Legislacoes_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Legislacoes_subarea_idx" ON public."Legislacoes" USING btree (subarea);


--
-- Name: Noticia_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Noticia_areaResponsavel_idx" ON public."Noticia" USING btree ("areaResponsavel");


--
-- Name: Noticia_autor_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Noticia_autor_idx" ON public."Noticia" USING btree (autor);


--
-- Name: Noticia_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Noticia_slug_key" ON public."Noticia" USING btree (slug);


--
-- Name: Noticia_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Noticia_subarea_idx" ON public."Noticia" USING btree (subarea);


--
-- Name: PaginaQuemSomos_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "PaginaQuemSomos_areaResponsavel_idx" ON public."PaginaQuemSomos" USING btree ("areaResponsavel");


--
-- Name: PaginaQuemSomos_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "PaginaQuemSomos_subarea_idx" ON public."PaginaQuemSomos" USING btree (subarea);


--
-- Name: PortfolioImagens_portfolio_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "PortfolioImagens_portfolio_idx" ON public."PortfolioImagens" USING btree (portfolio);


--
-- Name: Portfolios_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Portfolios_areaResponsavel_idx" ON public."Portfolios" USING btree ("areaResponsavel");


--
-- Name: Portfolios_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Portfolios_slug_key" ON public."Portfolios" USING btree (slug);


--
-- Name: Portfolios_subarea_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Portfolios_subarea_idx" ON public."Portfolios" USING btree (subarea);


--
-- Name: QuemSomosMuralItem_pagina_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "QuemSomosMuralItem_pagina_idx" ON public."QuemSomosMuralItem" USING btree (pagina);


--
-- Name: QuemSomosSubareaItem_pagina_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "QuemSomosSubareaItem_pagina_idx" ON public."QuemSomosSubareaItem" USING btree (pagina);


--
-- Name: QuemSomosSubareaItem_subarea_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "QuemSomosSubareaItem_subarea_idx" ON public."QuemSomosSubareaItem" USING btree (subarea);


--
-- Name: QuemSomosTimeItem_pagina_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "QuemSomosTimeItem_pagina_idx" ON public."QuemSomosTimeItem" USING btree (pagina);


--
-- Name: Servicos_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Servicos_areaResponsavel_idx" ON public."Servicos" USING btree ("areaResponsavel");


--
-- Name: Servicos_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Servicos_slug_key" ON public."Servicos" USING btree (slug);


--
-- Name: Servicos_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Servicos_subarea_idx" ON public."Servicos" USING btree (subarea);


--
-- Name: Setores_gerencia_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Setores_gerencia_idx" ON public."Setores" USING btree (gerencia);


--
-- Name: Solucoes_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Solucoes_areaResponsavel_idx" ON public."Solucoes" USING btree ("areaResponsavel");


--
-- Name: Solucoes_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Solucoes_slug_key" ON public."Solucoes" USING btree (slug);


--
-- Name: Solucoes_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Solucoes_subarea_idx" ON public."Solucoes" USING btree (subarea);


--
-- Name: Subareas_area_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Subareas_area_idx" ON public."Subareas" USING btree (area);


--
-- Name: Tag_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Tag_areaResponsavel_idx" ON public."Tag" USING btree ("areaResponsavel");


--
-- Name: Tag_nome_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Tag_nome_key" ON public."Tag" USING btree (nome);


--
-- Name: Tag_subarea_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Tag_subarea_idx" ON public."Tag" USING btree (subarea);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: _Noticia_tags_AB_unique; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "_Noticia_tags_AB_unique" ON public."_Noticia_tags" USING btree ("A", "B");


--
-- Name: _Noticia_tags_B_index; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "_Noticia_tags_B_index" ON public."_Noticia_tags" USING btree ("B");


--
-- Name: _User_areas_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_User_areas_AB_unique" ON public."_User_areas" USING btree ("A", "B");


--
-- Name: _User_areas_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_User_areas_B_index" ON public."_User_areas" USING btree ("B");


--
-- Name: Cursos Cursos_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Cursos"
    ADD CONSTRAINT "Cursos_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Cursos Cursos_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Cursos"
    ADD CONSTRAINT "Cursos_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Gerencias Gerencias_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Gerencias"
    ADD CONSTRAINT "Gerencias_area_fkey" FOREIGN KEY (area) REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Gestores Gestores_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Gestores"
    ADD CONSTRAINT "Gestores_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Legislacoes Legislacoes_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Legislacoes"
    ADD CONSTRAINT "Legislacoes_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Legislacoes Legislacoes_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Legislacoes"
    ADD CONSTRAINT "Legislacoes_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Noticia Noticia_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Noticia"
    ADD CONSTRAINT "Noticia_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Noticia Noticia_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Noticia"
    ADD CONSTRAINT "Noticia_autor_fkey" FOREIGN KEY (autor) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Noticia Noticia_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Noticia"
    ADD CONSTRAINT "Noticia_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PaginaQuemSomos PaginaQuemSomos_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."PaginaQuemSomos"
    ADD CONSTRAINT "PaginaQuemSomos_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PaginaQuemSomos PaginaQuemSomos_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."PaginaQuemSomos"
    ADD CONSTRAINT "PaginaQuemSomos_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PortfolioImagens PortfolioImagens_portfolio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PortfolioImagens"
    ADD CONSTRAINT "PortfolioImagens_portfolio_fkey" FOREIGN KEY (portfolio) REFERENCES public."Portfolios"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Portfolios Portfolios_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Portfolios"
    ADD CONSTRAINT "Portfolios_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Portfolios Portfolios_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Portfolios"
    ADD CONSTRAINT "Portfolios_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: QuemSomosMuralItem QuemSomosMuralItem_pagina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosMuralItem"
    ADD CONSTRAINT "QuemSomosMuralItem_pagina_fkey" FOREIGN KEY (pagina) REFERENCES public."PaginaQuemSomos"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: QuemSomosSubareaItem QuemSomosSubareaItem_pagina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosSubareaItem"
    ADD CONSTRAINT "QuemSomosSubareaItem_pagina_fkey" FOREIGN KEY (pagina) REFERENCES public."PaginaQuemSomos"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: QuemSomosSubareaItem QuemSomosSubareaItem_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosSubareaItem"
    ADD CONSTRAINT "QuemSomosSubareaItem_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: QuemSomosTimeItem QuemSomosTimeItem_pagina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuemSomosTimeItem"
    ADD CONSTRAINT "QuemSomosTimeItem_pagina_fkey" FOREIGN KEY (pagina) REFERENCES public."PaginaQuemSomos"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Servicos Servicos_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Servicos"
    ADD CONSTRAINT "Servicos_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Servicos Servicos_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Servicos"
    ADD CONSTRAINT "Servicos_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Setores Setores_gerencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Setores"
    ADD CONSTRAINT "Setores_gerencia_fkey" FOREIGN KEY (gerencia) REFERENCES public."Gerencias"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Solucoes Solucoes_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Solucoes"
    ADD CONSTRAINT "Solucoes_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Solucoes Solucoes_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Solucoes"
    ADD CONSTRAINT "Solucoes_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Subareas Subareas_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subareas"
    ADD CONSTRAINT "Subareas_area_fkey" FOREIGN KEY (area) REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Tag Tag_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Tag"
    ADD CONSTRAINT "Tag_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Tag Tag_subarea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Tag"
    ADD CONSTRAINT "Tag_subarea_fkey" FOREIGN KEY (subarea) REFERENCES public."Subareas"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _Noticia_tags _Noticia_tags_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."_Noticia_tags"
    ADD CONSTRAINT "_Noticia_tags_A_fkey" FOREIGN KEY ("A") REFERENCES public."Noticia"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _Noticia_tags _Noticia_tags_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."_Noticia_tags"
    ADD CONSTRAINT "_Noticia_tags_B_fkey" FOREIGN KEY ("B") REFERENCES public."Tag"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _User_areas _User_areas_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_User_areas"
    ADD CONSTRAINT "_User_areas_A_fkey" FOREIGN KEY ("A") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _User_areas _User_areas_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_User_areas"
    ADD CONSTRAINT "_User_areas_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: patrimonio_user
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT CREATE ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict QAEwDa6guV0bxXux6654XvIxqJflaoF5mKd0KbkcVupMeqFMgnDfbCrpVnGbCba

