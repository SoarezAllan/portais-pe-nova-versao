--
-- PostgreSQL database dump
--

\restrict 9zbksXuEVVuSgXQ5al805bLyaC0jk2yKK3YXR5T7j37T9sJozLuxHzXcxYbXMc9

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
-- Name: AreasResponsaveis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AreasResponsaveis" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    telefone1 text DEFAULT ''::text NOT NULL,
    telefone2 text DEFAULT ''::text NOT NULL,
    responsavel text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
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
    slug text DEFAULT ''::text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    "linkExterno" text DEFAULT ''::text NOT NULL,
    categoria text DEFAULT 'outros'::text NOT NULL,
    "dataDoCurso" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Cursos" OWNER TO patrimonio_user;

--
-- Name: Gerencia; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Gerencia" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Gerencia" OWNER TO patrimonio_user;

--
-- Name: Gestores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Gestores" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    cargo text DEFAULT ''::text NOT NULL,
    descricao text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    telefone text DEFAULT ''::text NOT NULL,
    foto_id text,
    foto_filesize integer,
    foto_width integer,
    foto_height integer,
    foto_extension text
);


ALTER TABLE public."Gestores" OWNER TO postgres;

--
-- Name: Legislacoes; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Legislacoes" (
    id text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    "linkExterno" text DEFAULT ''::text NOT NULL,
    area text NOT NULL,
    categoria text NOT NULL,
    resumo text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Legislacoes" OWNER TO patrimonio_user;

--
-- Name: MuralItem; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."MuralItem" (
    id text NOT NULL,
    valor text DEFAULT ''::text NOT NULL,
    titulo text DEFAULT ''::text NOT NULL,
    descricao text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."MuralItem" OWNER TO patrimonio_user;

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
    categoria text NOT NULL,
    destaque boolean DEFAULT false NOT NULL,
    resumo text DEFAULT ''::text NOT NULL,
    etiqueta text DEFAULT 'INFORMAÇÕES'::text NOT NULL,
    slug text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Noticia" OWNER TO patrimonio_user;

--
-- Name: PaginaQuemSomos; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."PaginaQuemSomos" (
    id integer NOT NULL,
    "tituloDaPagina" text DEFAULT 'Quem Somos'::text NOT NULL,
    "muralTextoIntrodutorio" text DEFAULT ''::text NOT NULL,
    "organogramaTitulo" text DEFAULT 'Organograma'::text NOT NULL,
    "organogramaImagem_id" text,
    "organogramaImagem_filesize" integer,
    "organogramaImagem_width" integer,
    "organogramaImagem_height" integer,
    "organogramaImagem_extension" text,
    "organogramaImagemAlt" text DEFAULT ''::text NOT NULL,
    "patrimonioImobiliario" text DEFAULT ''::text NOT NULL,
    "patrimonioMovel" text DEFAULT ''::text NOT NULL,
    "engenhariaArquitetura" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."PaginaQuemSomos" OWNER TO patrimonio_user;

--
-- Name: Servicos; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Servicos" (
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
    "oQueE" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "quemPrecisa" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "baseNormativa" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "comoSolicitar" jsonb DEFAULT '[{"type": "paragraph", "children": [{"text": ""}]}]'::jsonb NOT NULL,
    "areaResponsavel" text,
    "createdAt" timestamp(3) without time zone,
    "createdBy" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "updatedBy" text DEFAULT ''::text NOT NULL,
    "deletedAt" timestamp(3) without time zone,
    "deletedBy" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Servicos" OWNER TO patrimonio_user;

--
-- Name: Setor; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Setor" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL,
    gerencia text
);


ALTER TABLE public."Setor" OWNER TO patrimonio_user;

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
    "linkExterno" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Solucoes" OWNER TO patrimonio_user;

--
-- Name: Tag; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."Tag" (
    id text NOT NULL,
    nome text DEFAULT ''::text NOT NULL
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
    "createdAt" timestamp(3) without time zone,
    gerencia text,
    setor text
);


ALTER TABLE public."User" OWNER TO patrimonio_user;

--
-- Name: _AreaResponsavel_gestores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_AreaResponsavel_gestores" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_AreaResponsavel_gestores" OWNER TO postgres;

--
-- Name: _Noticia_tags; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."_Noticia_tags" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_Noticia_tags" OWNER TO patrimonio_user;

--
-- Name: _PaginaQuemSomos_muralItens; Type: TABLE; Schema: public; Owner: patrimonio_user
--

CREATE TABLE public."_PaginaQuemSomos_muralItens" (
    "A" text NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_PaginaQuemSomos_muralItens" OWNER TO patrimonio_user;

--
-- Data for Name: AreasResponsaveis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AreasResponsaveis" (id, nome, telefone1, telefone2, responsavel, email, "createdAt", "createdBy", "updatedAt", "updatedBy", "deletedAt", "deletedBy") FROM stdin;
cmm9d25bc00004jter9pli8eh	UCADI					\N		\N		\N	
cmm9d7djb0000zolqpm53460w	GDEST					\N		\N		\N	
cmn4v9lci0001qaxktu3i2xrl	UCPAM	(81) 3183-7785			bensmoveis@sad.pe.gov.br	\N		\N		\N	
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
\.


--
-- Data for Name: Cursos; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Cursos" (id, titulo, slug, resumo, "linkExterno", categoria, "dataDoCurso") FROM stdin;
cmi3gd20r0003vwpmvnyz3la9	GESTÃO E FISCALIZAÇÃO DE CONTRATOS ADMINISTRATIVOS SOB A ÓTICA DA NOVA LEI DE LICITAÇÕES E CONTRATOS (LEI FEDERAL Nº 14.133/2021) - 20 h/a	fiscalizacoes-contratos	Gestão e fiscalização de contratos administrativos.	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	outros	2025-11-07 11:00:00
cmi3gfzka0004vwpmkzdk8tia	EXCEL BÁSICO - 20 h/a	excel-basico	Capacitação dos servidores para utilização da ferramenta Miscrosoft Excel.	https://www.sgic.pe.gov.br/Sgic/public/pages/inscricaoPresencial.jsf	outros	2025-12-01 11:00:00
cmi3g8ji50002vwpmbdbic2mb	SISTEMA SEI – SISTEMA ELETRÔNICO DE INFORMAÇÕES - SEI AVANÇADO - 8 h/a	sei-avancado	Treinamento para utilização de recursos avançados do Sistema Eletrônico de Informações - SEI	https://www.sgic.pe.gov.br/Sgic/public/pages/login.jsf	outros	2025-12-14 11:00:00
\.


--
-- Data for Name: Gerencia; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Gerencia" (id, nome) FROM stdin;
cmiekian0000012f46dg1pz2h	Patrimônio Imobiliário
cmiekilbt000112f4i8cbm4f5	Patrimônio Móvel
cmiekixm8000212f4xfgxu61o	Engenharia
\.


--
-- Data for Name: Gestores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Gestores" (id, nome, cargo, descricao, email, telefone, foto_id, foto_filesize, foto_width, foto_height, foto_extension) FROM stdin;
\.


--
-- Data for Name: Legislacoes; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Legislacoes" (id, titulo, "linkExterno", area, categoria, resumo) FROM stdin;
cmi3fvv5d0000vwpmoascppy2	NBR 14.653	https://memoria-spu.gestao.gov.br/wp-content/uploads/tainacan-items/54791/203875/ABNT-NBR-14653-1-2019.pdf	engenharia	federal	
cmi3fxau20001vwpmxysnn764	Portaria SAD nº 2.679/2024	https://www.pge.pe.gov.br/App_Themes/PORTARIA%20SAD%20N%C2%BA%202.679%20DO%20DIA%2020%20DE%20AGOSTO%20DE%202024%20-%20Avaliac%CC%A7a%CC%83o%20imoveis.pdf	engenharia	normativa_interna	
cmmvzyzgf000hui04ctnx967i	RESOLUÇÃO Nº177/2019	https://transparencia.caubr.gov.br/resolucao177/	arquitetura	federal	Altera a Resolução CAU/BR n° 91, de 9 de outubro de 2014, que dispõe sobre o Registro de Responsabilidade Técnica (RRT), quanto ao RRT Mínimo e RRT Retificador, cria o RRT Social e dá outras providências.
cmmw007sn000iui04o7lqi4p4	RESOLUÇÃO Nº91/2014	https://transparencia.caubr.gov.br/resolucao91/	arquitetura	federal	Dispõe sobre o Registro de Responsabilidade Técnica (RRT) referente a projetos, obras e demais serviços técnicos no âmbito da Arquitetura e Urbanismo e dá outras providências.
cmmw011kc000jui049lgbdr9i	RESOLUÇÃO Nº75/2014	https://transparencia.caubr.gov.br/resolucao75/	arquitetura	federal	Dispõe sobre a indicação da responsabilidade técnica referente a projetos, obras e serviços no âmbito da Arquitetura e Urbanismo, em documentos, placas, peças publicitárias e outros elementos de comunicação.
cmi6eru6w00051b0bwl2kt1gt	Lei nº 13.105/2015	https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2015/lei/l13105.htm	patrimonio_imovel	federal	Código de Processo Civil.
cmmnid4bb0005ui04wp4ko9fd	Decreto nº 55.946/2023	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=55946&complemento=0&ano=2023&tipo=&url=	patrimonio_imovel	estadual	Estabelece procedimentos patrimoniais de cadastro, uso e regularização de imóveis estaduais, altera o Decreto nº 38.875, de 22 de novembro de 2012, e o Decreto nº 39.639, de 25 de julho de 2013.
cmmngu0ml0001ui0474i7pcl9	Provimento nº 11/2023 – CGJ/PE	https://portal.tjpe.jus.br/web/corregedoria/codigos-de-normas	patrimonio_imovel	estadual	Regulamenta o Código de Normas dos Serviços Notariais e Registrais do Estado de Pernambuco (CNSNR - PE/2023).
cmmnh3mjd0003ui046mrhcl3i	Lei nº 9.784/1999	https://www.planalto.gov.br/ccivil_03/leis/l9784.htm	patrimonio_imovel	federal	Regula o Processo Administrativo no âmbito da Administração Pública Federal.
cmmngqdky0000ui04g3vns0gq	Lei nº 6.015/1973	https://www.planalto.gov.br/ccivil_03/leis/l6015compilada.htm	patrimonio_imovel	federal	Regulamenta a Lei de Registros Públicos.
cmmnh0wfx0002ui041c8qt0d4	Lei nº 11.781/2000	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=11781&complemento=0&ano=2000&tipo=&url=	patrimonio_imovel	estadual	Regula o Processo Administrativo no âmbito da Administração Pública Estadual.
cmmvzi1890009ui0497xp02fv	LEI Nº 5.194/1996	https://www.planalto.gov.br/ccivil_03/leis/L5194.htm	engenharia	federal	Regula o exercício das profissões de Engenheiros
cmmvzkg9a000aui047b2yhrwg	RESOLUÇÃO N° 1.073/2016	https://normativos.confea.org.br/Ementas/Visualizar?id=59111	engenharia	federal	Regulamenta a atribuição de títulos, atividades, competências e campos de atuação profissionais aos profissionais registrados no Sistema Confea/Crea para efeito de fiscalização do exercício profissional no âmbito da Engenharia e da Agronomia.
cmmvzlhc0000bui04506pwdfm	RESOLUÇÃO Nº 345/1990.	https://normativos.confea.org.br/Ementas/Visualizar?id=393	engenharia	federal	Dispõe quanto ao exercício por profissional de Nível Superior das atividades de Engenharia de Avaliações e Perícias de Engenharia.
cmmvzmelt000cui04alrdavhq	RESOLUÇÃO Nº 1.137/2023	https://normativos.confea.org.br/Ementas/Visualizar?id=76099	engenharia	federal	Dispõe sobre a Anotação de Responsabilidade Técnica - ART, o Acervo Técnico-Profissional e o Acervo Operacional, e dá outras providências.
cmmvznghy000dui04i1mppwzp	RESOLUÇÃO Nº 218/1973	https://normativos.confea.org.br/Ementas/Visualizar?id=266	engenharia	federal	Discrimina atividades das diferentes modalidades profissionais da Engenharia, Arquitetura e Agronomia.\n
cmmvzofd6000eui04tqbjg2h5	LEI Nº 10.098/2000	https://www.planalto.gov.br/ccivil_03/leis/l10098.htm	arquitetura	federal	Estabelece normas gerais e critérios básicos para a promoção da acessibilidade das pessoas portadoras de deficiência ou com mobilidade reduzida, e dá outras providências.
cmmvzqck2000fui04g7lp69d0	LEI Nº12.378/2010	https://www.planalto.gov.br/ccivil_03/_ato2007-2010/2010/lei/l12378.htm	arquitetura	federal	Regulamenta o exercício da Arquitetura e Urbanismo; cria o Conselho de Arquitetura e Urbanismo do Brasil - CAU/BR e os Conselhos de Arquitetura e Urbanismo dos Estados e do Distrito Federal - CAUs; e dá outras providências.
cmmvzxtd1000gui04y90tl72v	RESOLUÇÃO N°184/2019	https://transparencia.caubr.gov.br/resolucao184/	arquitetura	federal	Altera as Resoluções CAU/BR nº 91, de 9 de outubro de 2014, e nº 93, de 7 de novembro de 2014, que dispõem, respectivamente, sobre o Registro de Responsabilidade Técnica (RRT) e sobre a emissão de certidões pelos Conselhos de Arquitetura e Urbanismo dos Estados e do Distrito Federal (CAU/UF) e dá outras providências.
cmo2u3zr20004159k81mpl5mo	Portaria STN nº 448/2002	https://www.gov.br/capes/pt-br/centrais-de-conteudo/portaria-448-2002-material-decapital-deconsumo-pdf	patrimonio_movel	federal	Detalhamento das Naturezas de Despesa
cmo2uweth0006159krno18ojg	Decreto nº 35.706/2010	https://legis.alepe.pe.gov.br/texto.aspx?id=22163&tipo=TEXTOORIGINAL	patrimonio_movel	estadual	Institui o Comitê Estadual de Resíduos Sólidos
cmo2udz620005159kp8hfbot4	Portaria Conjunta SAD/SDS nº 035/2017	https://pt.scribd.com/document/772715769/Portaria-Sad-sds-035-2017-Semoventes-Desfazimento	patrimonio_movel	estadual	Desfazimento de Semoventes Inservíveis
cmo2v4h3l0007159k56s8yh7d	Decreto nº 12.785/2025	https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/decreto/d12785.htm	patrimonio_movel	federal	Formas de Desfazimento
cmo2vyqtf0009159kilb2xcr5	Decreto nº 39.639/2013	https://legis.alepe.pe.gov.br/texto.aspx?id=15359&tipo=TEXTOORIGINAL	patrimonio_movel	estadual	Reavaliação, Redução e Depreciação dos Bens do Estado
cmo2w8618000a159kctjn1a45	Decreto nº 40.222/2013	https://legis.alepe.pe.gov.br/texto.aspx?id=14036&tipo=TEXTOORIGINAL	patrimonio_movel	estadual	Sistema Integrado de Gestão - PE Integrado
cmo2wg6r4000b159kwuczhd29	Decreto nº 42.589/2016	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=42589&complemento=0&ano=2016&tipo=&url=#:~:text=Disp%C3%B5e%20sobre%20as%20normas%20gerais,II%20e%20IV%20do%20art	patrimonio_movel	estadual	Normas Gerais relativas ao Leilão
cmo2vg2ns0008159k10dp70uy	Decreto nº 39.335/2013	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=6&numero=38875&complemento=0&ano=2012&tipo=&url=#:~:text=Institui%20o%20Subsistema%20de%20Gest%C3%A3o,Administrativa%20do%20Poder%20Executivo%20Estadual.&text=VI%20-%20descentralizar%20as%20atividades%20relativas%20%C3%A0%20%C3%A1rea%20de%20patrim%C3%B4nio%20e%20materiais	patrimonio_movel	estadual	Institui o Subsistema de Gestão de Patrimônio e Materiais
cmo2wmw0f000c159kg0omdcj4	Lei Complementar nº 141/2009	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=2&numero=141&complemento=0&ano=2009&tipo=&url=	patrimonio_movel	estadual	Dispões sobre o Modelo Integrado de Gestão
cmo2wszta000d159kxfsgcx99	Lei nº 14.236/2010	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=14236&complemento=0&ano=2010&tipo=&url=	patrimonio_movel	estadual	Dispões sobre a Política Estadual de Resíduo Sólido
cmo2wx8l6000e159k7bdkxtnc	Lei nº 7.741/1978	https://legis.alepe.pe.gov.br/texto.aspx?tiponorma=1&numero=7741&complemento=0&ano=1978&tipo=&url=	patrimonio_movel	estadual	Institui o Código de Administração Financeira do Estado
cmo2x2g0q000f159kre5jpjl2	Lei nº 9.504/1997	https://www.planalto.gov.br/ccivil_03/leis/l9504.htm	patrimonio_movel	federal	Dispõe sobre Doação de Bens em ano Eleitoral
cmo2xj877000g159kkqjlu9eg	Lei nº 14.680/2012	https://legis.alepe.pe.gov.br/texto.aspx?id=9831&tipo=TEXTOORIGINAL	patrimonio_movel	estadual	Baixa de Veículos Inservíveis
\.


--
-- Data for Name: MuralItem; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."MuralItem" (id, valor, titulo, descricao) FROM stdin;
cmn50xcur0005qaxkkhtg6ri2	teste	teste	teste
cmn50xs2m0007qaxk927skmrw	teste	teste	teste
cmi4l8mis0002wugdn3oz9hvc	12 Bilhões	Em valor estimado	O valor total do acervo imobiliário de Pernambuco chega a ultrapassar 12 bilhões de reais.
cmi4ldcmg0004wugdvkxw24vx	1 Bilhão	Em valor estimado	O valor total do acervo mobiliário de Pernambuco chega a ultrapassar 1 Bilhão de reais.
cmi34ocqx0006pu9zizgkeauw	3600	Imóveis Cadastrados	 O acervo imobiliário estadual consta com cerca de 3600 imóveis cadastrados em sua base.
cmi4lbl3p0003wugdnpr0n4nf	1 Milhão	Bens Móveis Cadastrados	O acervo mobiliário estadual consta com mais de 900 mil imóveis cadastrados em sua base.
\.


--
-- Data for Name: Noticia; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Noticia" (id, titulo, subtitulo, autor, "dataPublicacao", "imagemPrincipal_id", "imagemPrincipal_filesize", "imagemPrincipal_width", "imagemPrincipal_height", "imagemPrincipal_extension", "imagemPrincipalAlt", corpo, categoria, destaque, resumo, etiqueta, slug) FROM stdin;
cmi62n7d700021b0bord7df5s	Evolução do Ecossistema de Contratações Públicas de Pernambuco é tema da nova edição da Maratona Compras Públicas	Maratona de compras públicas	4908bab7-d11b-4fed-bd24-45649d9e0fd2	2025-11-18 11:00:00	29XmUhCUEsj6P7ZM4DVtpA	1032968	5628	3752	jpg	tag	[{"type": "paragraph", "children": [{"text": "A Secretaria de Administração (SAD) e a Agência Estadual de Tecnologia da Informação (ATI) realizaram, nesta terça-feira (18), a Maratona Compras Públicas - Evolução do Ecossistema de Contratações Públicas de Pernambuco. A nova edição do evento, promovida na Faculdade de Administração e Direito da Universidade de Pernambuco (FCAP/UPE), contou com palestras, apresentação do projeto Mapear e lançamento do novo Sistema de Governança de Contratações."}]}, {"type": "paragraph", "children": [{"text": "Voltado para agentes de fase preparatória e agentes de contratação, o encontro abordou as principais entregas de transformação digital no Estado. Representando a secretária de Administração, Ana Maraíza, a secretária executiva de Contratações Públicas, Nayllê Siqueira, ressaltou a importância do evento. “O objetivo desta edição da Maratona Compras Públicas é mostrar o quanto avançamos na modernização das contratações públicas, gerando mais eficiência, governança e novas entregas para a população. Sinto orgulho de cada ação que todos nós fazemos em razão dos benefícios para a sociedade”, destacou."}]}, {"type": "paragraph", "children": [{"text": "Em seguida, o gerente geral da Central de Licitações do Estado (GGCLE), Bruno Cintra, falou sobre a atuação da GGCLE. “Nós melhoramos muito os procedimentos e, para continuar esse aperfeiçoamento, é necessário o auxílio das ferramentas de tecnologia da informação, como a inteligência artificial, para monitorar, controlar e aprimorar esses processos”, avaliou."}]}, {"type": "paragraph", "children": [{"text": "Ainda dentro da programação, o diretor de TI e Transformação Digital da ATI, Rafael Soares, e o diretor da Central IT, Eduardo Máximo, abordaram o tema “A Nova Era da Inteligência na Gestão Pública”. Eles também participaram do lançamento do novo Sistema de Governança de Contratações (SGC), que tem o objetivo de centralizar e gerenciar todas as contratações planejadas, fortalecendo a governança e entregando mais eficiência ao processo público."}]}, {"type": "paragraph", "children": [{"text": "A Maratona Compras Públicas - Evolução do Ecossistema de Contratações Públicas de Pernambuco também teve a participação do gerente de Apoio à Fase Preparatória de Precificação e Gestão de Riscos, Diego Figueiroa, que apresentou o projeto Mapear, desenvolvido para otimizar o trabalho de cotação do valor estimado das licitações. Em seguida, o gerente de Planejamento de Compras Corporativas, Marcelo Coelho, abordou a importância do Plano de Contratações Anual (PCA) e o papel do agente de fase preparatória."}]}, {"type": "paragraph", "children": [{"text": "O evento desta terça-feira ainda teve as presenças do secretário executivo de Transformação Digital, Caio Scheidegger, do gerente de Relacionamento do Governo Digital da ATI, José Pacheco, além de servidores públicos de diversos órgãos ligados à área de contratações públicas."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	outros	t	Maratona de compras públicas	INFORMAÇÕES	maratona-compras-publicas
cmi62s9s200031b0bbwag1qkk	5º Leilão de Bens Móveis de 2025 é promovido pela SAD no próximo dia 24	Leilão de bens móveis	4908bab7-d11b-4fed-bd24-45649d9e0fd2	2025-11-19 11:00:00	Wa38YjgCCcivfhETqfQtUg	1397165	5472	3648	jpg	tag	[{"type": "paragraph", "children": [{"text": "Automóveis, motocicletas, sucatas de informática, móveis e de outros tipos de materiais fazem parte do 5º Leilão de Bens Móveis de 2025, promovido pela Secretaria de Administração (SAD). O certame acontece no dia 24 de novembro, às 9h30, de forma eletrônica. Estão disponíveis 89 lotes para compra. A expectativa de arrecadação é de, no mínimo, R$ 390 mil."}]}, {"type": "paragraph", "children": [{"text": "Os interessados em participar deverão realizar o cadastro prévio no site do leiloeiro ("}, {"href": "http://www.aragaoleiloes.com.br/", "type": "link", "children": [{"text": "www.aragaoleiloes.com.br"}]}, {"text": "), no prazo máximo de até 72 horas antes do início do leilão virtual. É importante observar as regras nele contidas quanto à efetivação do cadastro, informando um endereço de e-mail para comunicação e envio de documentos, quando necessário."}]}, {"type": "paragraph", "children": [{"text": "Pessoas físicas e jurídicas de qualquer natureza poderão ofertar lances online para veículos recuperáveis. Quanto às sucatas aproveitáveis e sucatas aproveitáveis com motor inservível, a participação é restrita aos Centros de Desmanches de Veículos Automotores, Comércio de Peças Usadas e Reciclagem de Sucata (CDV), registrados operacionais ou credenciados pelo Detran/PE."}]}, {"type": "paragraph", "children": [{"text": "Além disso, também podem ofertar lances para sucatas aproveitáveis e sucatas aproveitáveis com motor inservível, as empresas de outras Unidades da Federação que tenham como atividade a desmontagem de veículos automotores terrestres destinados à comercialização de partes, peças e acessórios automotivos, entre outras condições que podem ser conferidas no edital. Esse documento está disponível no link no final do texto e na página eletrônica "}, {"href": "http://www.aragaoleiloes.com.br/", "type": "link", "children": [{"text": "www.aragaoleiloes.com.br"}]}, {"text": "."}]}, {"type": "paragraph", "children": [{"text": "Os lotes estarão disponíveis para visitação nos dois dias úteis que antecedem o leilão virtual, nos locais e horários indicados no edital."}]}]	patrimonio_movel	t	Automóveis, motocicletas, sucatas de informática, móveis e de outros tipos de materiais fazem parte do 5º Leilão de Bens Móveis de 2025.	INFORMAÇÕES	leilao-bens-moveis
cmi60sfw700001b0bxawf43fw	Governo de Pernambuco injeta cerca de R$ 5 bilhões aquecendo a economia do Estado	Medida proporcionará o aumento significativo de empregos no final de 2025	4908bab7-d11b-4fed-bd24-45649d9e0fd2	2025-11-19 11:00:00	GeHExP3_ZHO96t_u2qMysw	9874328	5516	3677	jpg	INFORMAÇÃO	[{"type": "paragraph", "children": [{"text": "O Governo do Estado injetará, neste final de ano, cerca de R$ 5 bilhões na economia pernambucana com o pagamento da folha salarial dos meses de novembro, dezembro e do 13º salário. A ação beneficiará servidores públicos ativos, aposentados e pensionistas do Estado. O pagamento deste mês acontece na próxima sexta-feira (28). Já o décimo 13º salário será quitado no dia 19 de dezembro e a folha salarial do mesmo mês será efetuada no dia 30."}]}, {"type": "paragraph", "children": [{"text": "A medida beneficiará cerca de 234 mil servidores, sendo 129,9 mil ativos, 78,3 mil aposentados e 26,6 mil pensionistas. A secretária de Administração, Ana Maraíza, enfatiza a importância da ação. “Com a garantia do pagamento dos salários de novembro, dezembro e do 13º, o Governo do Estado demonstra o compromisso com o servidor público e reafirma a valorização desses profissionais que diariamente dedicam seu trabalho para atender à população e ofertar serviços públicos de qualidade”, afirmou a secretária."}]}]	patrimonio_imobiliario	t	Medida proporcionará o aumento significativo de empregos no final de 2025.	INFORMAÇÕES	governo-injeta-5milhoes
\.


--
-- Data for Name: PaginaQuemSomos; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."PaginaQuemSomos" (id, "tituloDaPagina", "muralTextoIntrodutorio", "organogramaTitulo", "organogramaImagem_id", "organogramaImagem_filesize", "organogramaImagem_width", "organogramaImagem_height", "organogramaImagem_extension", "organogramaImagemAlt", "patrimonioImobiliario", "patrimonioMovel", "engenhariaArquitetura") FROM stdin;
1	Quem Somos	Desde a maca do hospital à viatura policial. Da escola ao palácio do governo.\nTudo isso faz parte do patrimônio do Estado. E para dar conta de tudo é preciso uma equipe técnica capacitada e uma gestão eficiente. \nUma boa administração patrimonial leva a melhores políticas públicas e a um Estado mais próximo do cidadão. Esse é nosso propósito.	Organograma	StRCKrMKfniIU9KDCndnPg	1971089	6000	4004	jpg	rwer	De forma simples podemos dizer que o “Patrimônio Imóvel” público corresponde aos prédios pertencentes ao Estado. Mas, ainda assim, é preciso fazer uma diferenciação.\nNormalmente, cada órgão ou entidade do Estado é responsável pelos seus próprios prédios e instalações, no entanto, há órgãos que não dispõem de equipe técnica especializada ou muitas edificações já não tem alguém que olhe por elas ou já não têm uso. São desses imóveis que tomamos conta por aqui.	Se quando tratamos de “Patrimônio Imóvel” é fácil lembrarmos dos prédios públicos, talvez ao falarmos de “Patrimônio Móvel” as coisas não fiquem tão claras assim. Mas é simples.\nEsse patrimônio corresponde a todo bem e equipamento de propriedade do Estado. Seja aquele bem utilizado em atividades administrativas - uma cadeira ou um computador, por exemplo - como também a carteira da escola, a máquina de ressonância do hospital e até o helicóptero dos bombeiros.	Para além da gestão do próprio imóvel, muitos órgãos e entidades não dispõem de equipe técnica especializada de arquitetura ou de engenharia. Também estamos aqui para ajudá-los.\nNossa equipe é composta por um grande número de arquitetos e engenheiros, das mais diversas formações, que atuam desde a análise técnica à elaboração de layouts e projetos arquitetônicos e de engenharia. Auxiliando nas pequenas manutenções e reformas, e também nos grandes projetos de transformação.
\.


--
-- Data for Name: Servicos; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Servicos" (id, titulo, slug, categoria, imagem_id, imagem_filesize, imagem_width, imagem_height, imagem_extension, "imagemAlt", resumo, "oQueE", "quemPrecisa", "baseNormativa", "comoSolicitar", "areaResponsavel", "createdAt", "createdBy", "updatedAt", "updatedBy", "deletedAt", "deletedBy") FROM stdin;
cmi33vzle0001pu9zzmgywqep	Usucapião	usucapiao	patrimonio_imobiliario	xHD1CvadQ4SXZrSW9yYyUw	1397165	5472	3648	jpg	Descreva a imagem.	A unidade é responsável por analisar solicitações de usucapião requeridas por terceiros para verificar se o imóvel envolvido pertence ao Estado de Pernambuco ou possui interesse público. Seu trabalho garante segurança jurídica e contribui para a proteção e a boa gestão do patrimônio estadual.	[{"type": "paragraph", "children": [{"text": "Análise das solicitações de usucapião apresentadas por terceiros quando estas envolvem, ou podem envolver, o patrimônio do Estado de Pernambuco. Sua atuação concentra-se em esclarecer se o imóvel objeto do pedido de usucapião pertence ao Estado ou se possui relevância para a administração pública."}]}]	[{"type": "paragraph", "children": [{"text": "Os serviços da UNAPI são destinados a toda a população que deseja regularizar um bem imóvel por meio da Ação de Usucapião, seja na modalidade "}, {"bold": true, "text": "extrajudicial"}, {"text": " (realizada em cartório) ou "}, {"bold": true, "text": "judicial"}, {"text": " (por meio do Poder Judiciário). \\n"}]}, {"type": "paragraph", "children": [{"text": "Assim, qualquer pessoa que possua um imóvel e necessite formalizar a propriedade, garantindo segurança jurídica e o devido registro, pode buscar os serviços da UNAPI para averiguar possível interesse do Estado de Pernambuco no imóvel a ser usucapido. \\n\\nA regularização por usucapião é um importante instrumento de efetivação do direito à moradia e à propriedade, proporcionando tranquilidade, valorização do imóvel e pleno exercício dos direitos do proprietário.\\n\\n\\n\\n\\n"}]}]	[{"type": "paragraph", "children": [{"text": "A base normativa que fundamenta a atuação consultiva da "}, {"bold": true, "text": "UNAPI"}, {"text": " encontra-se expressamente prevista na "}, {"bold": true, "text": "Recomendação nº 05, de 02 de agosto de 2024 (Corregedoria Auxiliar para os Serviços Extrajudiciais)"}, {"text": "."}]}, {"type": "paragraph", "children": [{"text": "Referida recomendação estabelece as diretrizes e parâmetros para o exercício das atividades consultivas, conferindo respaldo jurídico e institucional às orientações e manifestações técnicas emitidas no âmbito da UNAPI."}]}]	[{"type": "paragraph", "children": [{"text": "Para obter mais informações detalhadas sobre o procedimento de "}, {"bold": true, "text": "Usucapião Extrajudicial"}, {"text": ", consulte o conteúdo disponível no link: "}]}, {"type": "paragraph", "children": [{"text": ""}, {"href": "https://www.sad.pe.gov.br/patrimonio/48-patrimonio/23104-usucapiao-extrajudicial", "type": "link", "children": [{"bold": true, "text": "https://www.sad.pe.gov.br/patrimonio/48-patrimonio/23104-usucapiao-extrajudicial"}]}, {"text": "."}]}, {"type": "paragraph", "children": [{"text": "Nesse site você encontrará orientações completas sobre requisitos, documentações necessárias e como dar andamento ao processo de regularização de imóvel por meio da usucapião, especialmente na via "}, {"bold": true, "text": "extrajudicial"}, {"text": "."}]}]	\N	\N		\N		\N	
cmi38hfxl0001lx7ivrzpyur1	Avaliação de Imóveis	avaliacao-imobiliaria	engenharia	dtVQaXXG7lccCTBPN_kcog	1971089	6000	4004	jpg	Planta de engenharia sobre uma mesa de trabalho com equipamentos de medição.	Serviço técnico destinado à determinação do valor de mercado de terrenos, edifícios e instalações comerciais ou residenciais de interesse do Estado de Pernambuco.	[{"type": "paragraph", "children": [{"text": "Trata-se de procedimento de elaboração de Laudo de Avaliação, por meio do qual se estima o valor mais provável (compra e venda ou locação, por ex.) de um imóvel."}]}, {"type": "paragraph", "children": [{"text": "É realizado por engenheiros e arquitetos, com a devida Anotação/Registro de Responsabilidade Técnica (ART/RRT) e visa a dar transparência e a garantir a justa remuneração nas transações imobiliárias envolvendo o Poder Executivo Estadual. "}]}]	[{"type": "paragraph", "children": [{"text": "A avaliação é obrigatória em transações envolvendo\\nimóveis do Estado de Pernambuco, tais como:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Compra e venda;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Concessão de uso onerosa;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Atualização de valor patrimonial para fins contábeis;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Locações;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Doações;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Permutas;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Cessão de uso;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Fixação de custo para fins de seguro;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Desapropriações."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Todas as avaliações seguem rigorosamente a família\\nda Norma "}, {"bold": true, "text": "NBR 14.653"}, {"text": " da Associação Brasileira de Normas Técnicas (ABNT),\\ngarantindo precisão técnica e segurança jurídica para o Estado. "}]}, {"type": "paragraph", "children": [{"text": "Ademais, tem-se, também, a Portaria SAD nº 2.679/2024\\nque disciplina o procedimento de avaliação de bens imóveis no âmbito do Poder\\nExecutivo do Estado de Pernambuco."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Conforme dispõe o artigo 12 da Portaria SAD nº 2.679/2024, a solicitação de elaboração de Laudo de Avaliação de imóvel urbano, quando encaminhada à SAD, deverá ser mediante Ofício preferencialmente acompanhado dos seguintes documentos:"}]}, {"type": "paragraph", "children": [{"text": "I - croqui e/ou planta baixa atualizado do imóvel avaliando, em que conste:"}]}, {"type": "paragraph", "children": [{"text": "a) área total do terreno e das edificações/benfeitorias porventura existentes, discriminadas,\\nquando for o caso, por pavimentos; e"}]}, {"type": "paragraph", "children": [{"text": "b) todas as cotas e seus respectivos carimbos e legendas, especificando:"}]}, {"type": "paragraph", "children": [{"text": "1. identificação do responsável técnico pela elaboração;"}]}, {"type": "paragraph", "children": [{"text": "2. data da execução do serviço;"}]}, {"type": "paragraph", "children": [{"text": "3. endereçamento completo do imóvel avaliando; e"}]}, {"type": "paragraph", "children": [{"text": "4. escalas utilizadas no desenho."}]}, {"type": "paragraph", "children": [{"text": "II - documentação dominial; e"}]}, {"type": "paragraph", "children": [{"text": "III - formulário constante do Anexo Único desta Portaria, devidamente preenchido e assinado\\npela autoridade competente do órgão ou entidade solicitante."}]}]	\N	\N		\N		\N	
cmmvxoebf0008ui04wg0gx2w6	Projetos de arquitetura	projetos-arquitetura	arquitetura	pnvxX7ZkPvk250BoPbeuFA	2383059	1536	1024	png	arquitetas desenhando	Serviço técnico destinado a planejar a reforma e/ou construção de imóvel (casas, apartamentos, prédios, lojas etc.).	[{"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico de planejamento que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado."}]}, {"type": "paragraph", "children": [{"text": "São realizados desenhos e medições, por meio dos quais são retratados em projeto tudo aquilo inicialmente proposto para o imóvel em análise. Ou seja, os projetos de arquitetura orientam a construção/reforma desde a concepção inicial da ideia até a execução dos\\nserviços."}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto arquitetônico;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto arquitetônico de reforma;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto de ambientação;"}]}]}]}, {"type": "paragraph", "children": [{"text": "Para colocar em prática as necessidades do demandante, os projetos de arquitetura envolvem uma série de etapas, quais sejam:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Levantamento das necessidades;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Estudo preliminar;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Anteprojeto;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto executivo;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto de detalhamento."}]}]}]}, {"type": "paragraph", "children": [{"text": "É realizado por arquitetos, com o devido Registro de Responsabilidade Técnica (RRT), sempre que se fizer necessária a construção e/ou reforma de imóveis."}]}]	[{"type": "paragraph", "children": [{"text": "Os projetos de arquitetura são importantes sempre que se faz necessária a construção, reforma ou regularização de um imóvel. A título exemplificativo, indica-se abaixo alguns exemplos de quando se solicitar projetos de arquitetura:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Construção de imóvel;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Reforma de imóvel;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Definição e/ou alteração de layout;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Regularização de imóvel junto a prefeituras/cartórios."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Todos os projetos de arquitetura elaborados pela SAD/PE seguem as orientações das NRB’s 13.532 (Elaboração de projetos de edificações), 6492 (Representação de projetos de Arquitetura), 9050 (Acessibilidade), 15575 (Desempenho de edificações habitacionais), 9077 (Saídas de emergência) da Associação Brasileira de Normas Técnicas (ABNT), como também\\nde leis urbanísticas municipais."}]}]	[{"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de arquitetura de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício (via Sistema\\nEletrônico de Informação), acompanhadas dos respectivos planos de necessidades."}]}]	\N	\N		\N		\N	
cmmwekafg000lui041w3y1kgp	Projetos de engenharia	projetos-engenharia	engenharia	pbQwa9iSsDM_2YvT0oYIEw	2080182	1536	1024	png	engenheiros	Os projetos complementares de engenharia se propõem a detalhar e compatibilizar todos os sistemas vitais que compõem uma edificação, indo além da estrutura básica para garantir funcionalidade e eficiência operacional.	[{"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico que, preliminarmente à execução da obra/reforma, define como ficará o imóvel após as intervenções necessárias e demandadas pelo interessado. São realizados desenhos, cálculos, orçamentos, especificações e documentos técnicos que orientam a construção/reforma.\\n"}]}, {"type": "paragraph", "children": [{"text": "O objetivo central é o planejamento, cálculo e dimensionamento técnico de subsistemas — como elétrico, hidrossanitário, mecânico e de segurança — assegurando que a execução da obra ocorra de forma integrada. Esses projetos são indispensáveis para garantir a estabilidade das instalações, o cumprimento rigoroso das normas de segurança e o desempenho de longo prazo dos sistemas destinados ao patrimônio público."}]}, {"type": "paragraph", "children": [{"text": "Exemplos de projetos de engenharia:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto estrutural;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto elétrico;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto hidráulico e sanitário;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto de drenagem;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto de pavimentação;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Projeto de fundações."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Para colocar em prática as necessidades do demandante, os projetos de engenharia\\nenvolvem uma série de etapas, quais sejam:"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Levantamento das informações;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Análise dos projetos de arquitetura existentes;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Estudos e cálculos técnicos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Desenvolvimento de desenhos técnicos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Especificações dos materiais que serão empregados;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Elaboração da documentação técnica (memoriais descritivos, orçamentos etc.)."}]}]}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "\\n\\n"}]}]	[{"type": "paragraph", "children": [{"text": "Os projetos de engenharia são importantes sempre que se faz necessária a construção ou reforma de um imóvel ou equipamento público. Garantem a funcionalidade, segurança e estabilidade das construções e tomam como base o que foi definido nos projetos de arquitetura. É realizado por profissionais habilitados, com o devido registro técnico (ART CREA), sempre que se fizer necessária a construção e/ou reforma de imóveis de interesse do Estado."}]}]	[{"type": "paragraph", "children": [{"text": "Para assegurar o alto padrão técnico, a viabilidade operacional e a segurança jurídica das intervenções no patrimônio público, todos os projetos desenvolvidos são fundamentados no estrito cumprimento das Normas Brasileiras (NBRs) da ABNT e das Normas Regulamentadoras (NRs) do Ministério do Trabalho. A atuação do núcleo observa ainda a legislação específica do Estado de Pernambuco, incluindo as diretrizes do Corpo de\\nBombeiros Militar (COSCIP-PE) e as normas de licitações e contratos, garantindo que cada edificação atenda aos requisitos de desempenho, acessibilidade e proteção contra incêndio vigentes."}]}, {"type": "paragraph", "children": [{"text": "Elétrica e Sistemas:"}]}, {"type": "paragraph", "children": [{"text": "NR-10: Segurança em Instalações e Serviços em Eletricidade."}]}, {"type": "paragraph", "children": [{"text": "NR-35: Trabalho em Altura."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 5410: Instalações elétricas de baixa tensão."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 14039: Instalações elétricas de média tensão de 1,0 kV a 36,2 kV (regente para Subestações)."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 7117: Medição da resistividade e determinação da estratificação do solo (fundamental para Aterramento)."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 15751: Sistemas de aterramento de subestações - Requisitos."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 5419: Proteção contra descargas atmosféricas (SPDA)."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 17240: Sistemas de detecção e alarme de incêndio – Projeto, instalação, comissionamento e manutenção de sistemas de detecção e alarme de incêndio – Requisitos."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 13231: Proteção contra incêndio em subestações elétricas."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 14565: Cabeamento estruturado para edifícios comerciais e "}, {"text": "data centers", "italic": true}, {"text": "."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16415: Caminhos e espaços para cabeamento estruturado."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR IEC 62676: Sistemas de vídeo vigilância para uso em aplicações de segurança (CFTV)."}]}, {"type": "paragraph", "children": [{"text": "Mecânica e Climatização:"}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16401 1: Instalações de Ar Condicionado/Parte 1."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16401 2: Instalações de Ar Condicionado/Parte 2."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16401 3: Instalações de Ar Condicionado/Parte 3."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 17037: Qualidade do Ar."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 14679: Limpeza de Dutos."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 14880: Pressurização de Escadas."}]}, {"type": "paragraph", "children": [{"text": "PORTARIA 3523/98: Ministério da Saúde."}]}, {"type": "paragraph", "children": [{"text": "RESOLUÇÃO 09/2003: Anvisa."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16858-1: Novas instalações, requisitos de segurança para construção e instalação de novos elevadores de passageiros e carga."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16858-2: Estabelece normas para cálculos, projetos, inspeções e ensaios de componentes."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16858-3: Foca nos requisitos de acessibilidade para pessoas com deficiência."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16858-6: Trata especificamente dos elevadores de emergência para uso dos bombeiros."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16858-7: Trata de melhorias de segurança em elevadores já instalados."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 12892:2022: Estabelece os requisitos de segurança para o projeto, fabricação e instalação de elevadores uni-familiares ou de uso por pessoas com mobilidade reduzida."}]}, {"type": "paragraph", "children": [{"text": "NBR ISO 9386-1: Regras para plataformas de elevação vertical motorizada."}]}, {"type": "paragraph", "children": [{"text": "NBR 16083: Instruções de manutenção para elevadores, escadas e esteiras."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR ISO 4344:2025: Especifica os requisitos mínimos para cabos de aço carbono, polidos ou galvanizados, utilizados em elevadores."}]}, {"type": "paragraph", "children": [{"text": "NBR 8800: Projeto de estruturas de aço e de estruturas mistas de aço e concreto de edifícios)."}]}, {"type": "paragraph", "children": [{"text": "NBR 14762: Dimensionamento de estruturas de aço constituídas por perfis formados a frio)."}]}, {"type": "paragraph", "children": [{"text": "Civil/Hidrossanitário:"}]}, {"type": "paragraph", "children": [{"text": "NBR-5626/98: Instalação predial de água fria."}]}, {"type": "paragraph", "children": [{"text": "NBR-5648/99: Tubo de PVC rígido para instalações prediais de Água Fria."}]}, {"type": "paragraph", "children": [{"text": "NBR-5680/77: Tubos de PVC rígido – dimensões – padronização."}]}, {"type": "paragraph", "children": [{"text": "NBR-8160/99: Sistemas prediais de esgoto sanitário Projeto e Execução."}]}, {"type": "paragraph", "children": [{"text": "NBR-9814/87: Execução de rede coletora de esgoto sanitário – Procedimento."}]}, {"type": "paragraph", "children": [{"text": "NBR-10844/89: Instalações prediais de águas pluviais."}]}, {"type": "paragraph", "children": [{"text": "NBR-5688/99: Sistemas prediais de água pluviais ventilação, esgotamento sanitário, tubos e conexões de PVC."}]}, {"type": "paragraph", "children": [{"text": "NBR-13969/97: Tanques sépticos – Unidades de tratamento complementar e disposição final dos efluentes líquidos."}]}, {"type": "paragraph", "children": [{"text": "Projetos de Combate a Incêndio:"}]}, {"type": "paragraph", "children": [{"text": "Decreto Estadual n.º 19.644, de 13 de março de 1997."}]}, {"type": "paragraph", "children": [{"text": "Lei Estadual n.º 11.186, de 22 de dezembro de 1994."}]}, {"type": "paragraph", "children": [{"text": "Decreto n.º 58.690, de 27 de maio de 2025: Alterou diversos artigos do anexo do Decreto nº 19.644/1997 para aprimorar critérios de prevenção e combate a incêndios."}]}, {"type": "paragraph", "children": [{"text": "Decreto n.º 59.579, de 14 de outubro de 2025: Introduziu novas alterações no regulamento aprovado originalmente em 1997. "}]}, {"type": "paragraph", "children": [{"text": "NR-23: Proteção Contra Incêndios."}]}, {"type": "paragraph", "children": [{"text": "NR-20: Segurança e Saúde no Trabalho com Inflamáveis e Combustíveis."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 17240: Sistemas de detecção e alarme de incêndio – Requisitos."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 10898: Sistema de iluminação de emergência."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 12693: Sistemas de proteção por extintores de incêndio."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 13714: Sistemas de hidrantes e de mangotinhos para combate a incêndio."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 10897: Sistemas de proteção contra incêndio por chuveiros automáticos ("}, {"text": "Sprinklers", "italic": true}, {"text": ")."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 13231: Proteção contra incêndio em subestações elétricas."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 16820: Sistemas de sinalização de emergência — Projeto, fabricação e instalação."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 9077: Saídas de emergência em edifícios."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 11742: Porta corta fogo para saída de emergência."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 14276: Brigada de incêndio e emergência — Requisitos e procedimentos."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 15219: Plano de emergência — Requisitos e procedimentos."}]}, {"type": "paragraph", "children": [{"text": "ABNT NBR 14432: Exigências de resistência ao fogo de elementos construtivos de edificações."}]}, {"type": "paragraph", "children": [{"text": "Orçamentos:"}]}, {"type": "paragraph", "children": [{"text": "As atividades de orçamentação seguem critérios técnicos e legais para garantir a transparência e eficiência dos gastos públicos, incluindo: levantamento de serviços; memória de cálculo; cotações; composições de preços unitários; orçamento sintético; elaboração de BDI e encargos sociais; curva ABC; e cronograma físico-financeiro."}]}, {"type": "paragraph", "children": [{"text": "Lei n.º 14.133, de 1º de abril de 2021."}]}, {"type": "paragraph", "children": [{"text": "Decreto n.º 54.884, de 20 de junho de 2023 (PE)."}]}, {"type": "paragraph", "children": [{"text": "Fiscalização de Obras"}]}, {"type": "paragraph", "children": [{"text": "Atividade conduzida sob as diretrizes de conselhos profissionais e legislação específica:"}]}, {"type": "paragraph", "children": [{"text": "Resolução CONFEA n.º 218/1973."}]}, {"type": "paragraph", "children": [{"text": "Decreto Casa Civil n.º 23.569/1933."}]}]	[{"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de engenharia de imóveis de interesse\\ndos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de\\nOfício (via Sistema Eletrônico de Informação)."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	\N	\N		\N		\N	
cmmxu4m1u000mui04m63ik29e	Transferência (saída) de imóvel do Patrimônio Estadual por doação 	saida-imovel-doacao-patrimonio-estadual	patrimonio_imobiliario	ZlAPyXhagy3l0lYiW2dYHg	264293	640	320	png	entrega de chave. saída.	Procedimento necessário à saída de imóveis do patrimônio estadual por doação.	[{"type": "paragraph", "children": [{"text": "Trata-se do procedimento a ser feito, "}, {"bold": true, "text": "preferenciamente"}, {"text": ", "}, {"text": "via plataforma SEI", "italic": true}, {"text": ", para saída (transferência) de imóveis ao patrimonial estadual por doação (com ou sem encargos) a terceiros, "}, {"bold": true, "text": "independentemente do órgão"}, {"text": ", ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado."}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Link de acesso à Plataforma SEI: xxxxx"}]}]	[{"type": "paragraph", "children": [{"text": "Qualquer terceiro interessado que figure como "}, {"bold": true, "text": "possível donatário"}, {"text": " do imóvel estadual, desde particulares a entes públicos não ligados à administração direta e indireta."}]}]	[{"type": "paragraph", "children": [{"bold": true, "text": "- "}, {"text": "Decreto Estadual nº 55.946/2023."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "- "}, {"text": "Art. 1.140 do Provimento nº 11/2023 - CGJ/PE."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Bases normativas disponíveis no caminho \\"Legislação > Patrimônio Imobiliário\\"."}]}]	[{"type": "paragraph", "children": [{"bold": true, "text": "1."}, {"text": " Fazer o cadastro do documento na plataforma SEI xxxx."}]}, {"type": "paragraph", "children": [{"bold": true, "text": ""}]}, {"type": "paragraph", "children": [{"bold": true, "text": "2."}, {"text": " Ao gerar o número de processso, anexar as seguintes documentações:"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "   2.1 Em relação ao imóvel:", "italic": true}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Certidões de Propriedade e de Ônus atualizadas da Matrícula/Transcrição, dentro do prazo de 30 dias (SE JÁ POSSUIR)."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Boletim de Cadastro Imobiliário/Ficha do Imóvel (SE JÁ POSSUIR)."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Certidão Negativa de Débitos Municipais atualizada no novo período fiscal competente (SE JÁ POSSUIR)."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Lei Autorizativa de Doação devidamente publicada (SE JÁ EXISTENTE E NECESSÁRIA)."}]}]}]}, {"type": "paragraph", "children": [{"bold": true, "text": "   2.2 Em relação ao donatário:", "italic": true}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Situação Cadastral do Município"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Lei Orgânica Municipal do Município."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Ato de Nomeação do Prefeito do Município."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documentos de identificação pessoal do Prefeito do Município."}]}]}]}, {"type": "paragraph", "children": [{"text": "     (SE FOR MUNICÍPIO)"}], "textAlign": "center"}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Situação Cadastral da empresa."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Contrato Social da empresa."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documentos de identificação pessoal dos sócios-administradores a assinarem o ato."}]}]}]}, {"type": "paragraph", "children": [{"text": "     (SE FOR PESSOA JURÍDICA DE DIREITO PRIVADO)"}], "textAlign": "center"}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documentos de identificação pessoal dos transmitentes (RG, CPF e/ou Certidão de Casamento/Nascimento)."}]}]}]}, {"type": "paragraph", "children": [{"text": "     (SE FOR PESSOA FÍSICA)"}], "textAlign": "center"}, {"type": "paragraph", "children": [{"text": ""}], "textAlign": "center"}, {"type": "paragraph", "children": [{"bold": true, "text": "3."}, {"text": " Após anexar as devidas documentações, confeccionar ofício para direcionar à Gerência-Geral de Patrimônio (GGPAT), com indicação dos documentos ora acostados e os devidos "}, {"text": "hiperlinks", "italic": true}, {"text": "."}]}]	\N	\N		\N		\N	
cmmay50kt0000ubfw9hyxd9cr	Pagamento de Tributos e Taxas de Imóveis Estaduais	tributos-taxas	patrimonio_imobiliario	rIt6jdDiGOOi36GRT88X7g	2285219	1408	768	png	Pagamentos	Serviços de acompanhamento e controle das notificações de pagamento vinculadas aos imóveis estaduais.	[{"type": "paragraph", "children": [{"text": "Trata-se da responsabilidade e do comprometimento quanto ao pagamento e a regularização dos tributos, taxas, encargos e despesas de consumo incidentes aos imóveis desocupados, assim permanecendo as obrigações até o ato de sua efetiva destinação.\\n"}]}]	[{"type": "paragraph", "children": [{"text": "Os credores e devedores que figurem como titulares das obrigações relativas aos imóveis desocupados.  "}]}, {"type": "paragraph", "children": [{"text": "\\nPodem ser considerados credores as empresas e entidades que prestam serviços ao Estado, como o fornecimento de água, energia elétrica, bem como os serviços de coleta e remoção de resíduos sólidos.\\n\\n\\n\\n"}]}]	[{"type": "paragraph", "children": [{"bold": true, "text": "Lei Federal nº 12.305/2010 (Política Nacional de Resíduos Sólidos):"}, {"text": " Estabelece as diretrizes para gestão integrada de resíduos e responsabilidades do poder público."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Súmula Vinculante nº 19 do STF:"}, {"text": " Confirma a constitucionalidade da cobrança de taxa de coleta, remoção e tratamento de lixo;"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Constituição Federal (Art. 175):"}, {"text": " Estabelece que o regime de concessão ou permissão de serviços públicos (como energia elétrica) exige a devida contraprestação (pagamento) pelo consumo;"}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "A solicitação de pagamento é formalizada por meio de Comunicação Interna (CI) entre os setores competentes, sendo posteriormente encaminhada ao setor financeiro do Estado para as providências cabíveis."}]}, {"type": "paragraph", "children": [{"text": "À referida solicitação são anexados os documentos comprobatórios devidamente autenticados, tais como certidões e guia de pagamento."}]}, {"type": "paragraph", "children": [{"text": "Após o encaminhamento, é realizado o acompanhamento do trâmite processual até a efetiva liquidação dos débitos."}]}]	cmm9d7djb0000zolqpm53460w	\N		\N		\N	
cmmup7m1n0006ui044zzclap5	Inventário de Bens Móveis	inventario-de-bens-moveis	patrimonio_movel	HUrDJh56LXBFBOsP-ZsBpQ	321225	1408	768	jpg	Imagem representativa inventário	Capacitação e orientação quanto à elaboração do Inventário Físico de Bens Materiais.\n	[{"type": "paragraph", "children": [{"text": "A Unidade Centra de Patrimônio Móvel e Materiais (UCPAM) capacita e orienta os órgãos e/ou entidades da Administração Pública Estadual quanto à elaboração do Inventário Físico de Bens Materiais."}]}, {"type": "paragraph", "children": [{"text": "O Inventário de Bens Móveis constitui um instrumento de controle administrativo destinado à verificação da existência física dos bens permanentes, estejam eles em uso ou não, nos diversos órgãos e/ou entidades da Administração Pública Estadual."}]}, {"type": "paragraph", "children": [{"text": "Esse procedimento consiste no levantamento físico e financeiro de todos os bens móveis permanentes que se encontram sob a posse e guarda das unidades gestoras, tendo como finalidade confrontar os registros patrimoniais existentes com os bens efetivamente localizados."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Todos os órgãos da Administração Direta, os fundos, as fundações, as autarquias, bem como as empresa públicas e sociedades de economia mista dependentes de recursos do Tesouro Estadual, no âmbito do Poder Executivo Estadual.\\n\\n"}]}]	[{"type": "paragraph", "children": [{"text": "Portaria conjunta SAD/SEFAZ  nº 152 de 30 de Dezembro de 2016"}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Para mais informações e esclarecimentos acerca do "}, {"bold": true, "text": "Inventário"}, {"text": ", favor entrar em contato conosco:"}]}, {"type": "paragraph", "children": [{"text": "Unidade Central de Patrimônio Móvel e Materiais (UCPAM)"}]}, {"type": "paragraph", "children": [{"text": "Fones: 3183-7785"}]}, {"type": "paragraph", "children": [{"text": "E-mail: "}, {"href": "mailto:bensmoveis@sad.pe.gov.br", "type": "link", "children": [{"text": "bensmoveis@sad.pe.gov.br"}]}, {"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}]	\N	\N		\N		\N	
cmmvx9xrn0007ui047so5rqg3	Levantamentos topográficos georreferenciados	levantamentos-topograficos	engenharia	BNdKzh3fomWRiuNhdWxYig	2343744	1536	1024	png	Engenheiros realizando medições	Serviço técnico fundamental para a organização espacial das informações territoriais, permitindo a correta identificação, delimitação, análise e gestão de áreas de interesse do Estado de Pernambuco.	[{"type": "paragraph", "children": [{"text": "Trata-se de serviço técnico que visa à realização de levantamentos geoespaciais, produção cartográfica, análises topográficas e geração de bases técnicas, indispensáveis à tomada de decisões administrativas e jurídicas relacionadas ao patrimônio imobiliário estadual.  "}]}, {"type": "paragraph", "children": [{"text": "Dentre as principais atividades desenvolvidas, destacam-se: levantamentos aerofotogramétricos com drones, levantamentos topográficos com receptores GNSS, processamento de dados geoespaciais, elaboração de plantas e memoriais descritivos, bem como o suporte técnico a procedimentos relacionados à regularização fundiária e patrimonial."}]}, {"type": "paragraph", "children": [{"text": "Para tanto, envolve a aplicação de tecnologias modernas de geoprocessamento,  sensoriamento remoto e topografia, com o objetivo de garantir:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Precisão na delimitação territorial de imóveis públicos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Confiabilidade das informações geoespaciais;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Suporte técnico às decisões administrativas;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Regularização documental e cadastral de imóveis."}]}]}]}, {"type": "paragraph", "children": [{"text": "É realizado por engenheiros, com a devida Anotação de Responsabilidade Técnica (ART) sempre que se fizer necessária a correta identificação dos imóveis de interesse do Estado de\\nPernambuco."}]}]	[{"type": "paragraph", "children": [{"text": "Os levantamentos topográficos são necessários sempre que se precisa identificar,\\ncom precisão e acurácia, as medidas e limites de um imóvel. No âmbito da SAD,\\nesta atividade está diretamente ligada às políticas de gestão do patrimônio imobiliário do Estado, contribuindo para a organização, controle e valorização dos bens públicos."}]}]	[{"type": "paragraph", "children": [{"text": "Todos os levantamentos topográficos elaborados pela SAD/PE seguem as orientações das NBR 13133 (Levantamento topográfico), NBR 14166 (Rede cadastral municipal), 15661 (Aerolevantamento), 14645 (Terminologia fotogramétrica), 8196 (Escalas em desenho técnico), 8403 (Tipos de linhas), 10068 (Formato de pranchas), 17047 (Cadastro territorial multifinalitário) da Associação Brasileira de Normas Técnicas (ABNT)."}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "As solicitações para elaboração de projetos de engenharia de imóveis de interesse dos órgãos e entidades estaduais deverão ser encaminhadas à SAD por meio de Ofício, com a indicação\\ndo(s) endereço(s) do(s) imóvel(is) de interesse."}]}]	\N	\N		\N		\N	
cmmnibogh0004ui04iewzs7gl	Transferência (entrada) de imóvel ao Patrimônio Estadual por doação	entrada-imovel-doacao-patrimonio-estadual	patrimonio_imobiliario	61ufWiq4T6czAYNDasDlbg	18277	431	431	png	entrega de chave. transferência.	Procedimento necessário ao recebimento de imóveis ao patrimônio estadual por doação.	[{"type": "paragraph", "children": [{"text": "Trata-se do procedimento a ser feito, "}, {"bold": true, "text": "preferenciamente"}, {"text": ", "}, {"text": "via plataforma SEI", "italic": true}, {"text": ", para recebimento e/ou incorporação de imóveis ao patrimonial estadual por doação (com ou sem encargos), "}, {"bold": true, "text": "independentemente do órgão"}, {"text": ", ainda que do Poder Judiciário ou do Poder Legislativo, ou do ente público a que seu uso ou destinação venha a ser afetado."}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": "Link de acesso à Plataforma SEI: xxxxx"}]}]	[{"type": "paragraph", "children": [{"text": "Tribunal de Justiça Estadual (TJPE), Assembleia Legislativa Estadual (ALEPE), Secretarias de Estado (Casa Civil, Administração, Saúde, Educação, Defesa Social, Fazenda, etc.), além de órgãos da administração indireta como a ARPE, ATI, APAC, DETRAN-PE, SUAPE e FUNDARPE, "}, {"bold": true, "text": "ressalvados "}, {"text": "os casos em que há superior composição/integralização de capital próprio dos entes da administração indireta."}]}]	[{"type": "paragraph", "children": [{"bold": true, "text": "- "}, {"text": "Decreto Estadual nº 55.946/2023."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "- "}, {"text": "Art. 1.140 do Provimento nº 11/2023 - CGJ/PE."}]}, {"type": "paragraph", "children": [{"bold": true, "text": "Bases normativas disponíveis no caminho \\"Legislação > Patrimônio Imobiliário\\"."}]}]	[{"type": "paragraph", "children": [{"bold": true, "text": "1."}, {"text": " Fazer o cadastro do documento na plataforma SEI xxxx."}]}, {"type": "paragraph", "children": [{"bold": true, "text": ""}]}, {"type": "paragraph", "children": [{"bold": true, "text": "2."}, {"text": " Ao gerar o número de processso, anexar as seguintes documentações:"}]}, {"type": "paragraph", "children": [{"bold": true, "text": "   2.1 Em relação ao imóvel:", "italic": true}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Certidões de Propriedade e de Ônus atualizadas da Matrícula/Transcrição, dentro do prazo de 30 dias."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Boletim de Cadastro Imobiliário/Ficha do Imóvel."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Certidão Negativa de Débitos Municipais atualizada no novo período fiscal competente."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Lei Autorizativa de Doação devidamente publicada (SE NECESSÁRIO)."}]}]}]}, {"type": "paragraph", "children": [{"bold": true, "text": "   2.2 Em relação ao doador:", "italic": true}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Situação Cadastral do Município"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Lei Orgânica Municipal do Município."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Ato de Nomeação do Prefeito do Município."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documentos de identificação pessoal do Prefeito do Município."}]}]}]}, {"type": "paragraph", "children": [{"text": "     (SE FOR MUNICÍPIO)"}], "textAlign": "center"}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Situação Cadastral da empresa."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Contrato Social da empresa."}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documentos de identificação pessoal dos sócios-administradores a assinarem o ato."}]}]}]}, {"type": "paragraph", "children": [{"text": "     (SE FOR PESSOA JURÍDICA DE DIREITO PRIVADO)"}], "textAlign": "center"}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Documentos de identificação pessoal dos transmitentes (RG, CPF e/ou Certidão de Casamento/Nascimento)."}]}]}]}, {"type": "paragraph", "children": [{"text": "     (SE FOR PESSOA FÍSICA)"}], "textAlign": "center"}, {"type": "paragraph", "children": [{"text": ""}], "textAlign": "center"}, {"type": "paragraph", "children": [{"bold": true, "text": "3."}, {"text": " Após anexar as devidas documentações, confeccionar ofício para direcionar à Gerência-Geral de Patrimônio (GGPAT), com indicação dos documentos ora acostados e os devidos "}, {"text": "hiperlinks", "italic": true}, {"text": "."}]}]	\N	\N		\N		\N	
cmmyzu4li000nui04m2vplsan	Vistorias nos Imóveis Públicos	vistorias-imoveis	patrimonio_imobiliario	k1Mdc8jkidkY2QGOyyMeOg	8017	250	200	jpg	Vistoria	Serviços de vistoriar os imóveis púplicos do Estado.	[{"type": "paragraph", "children": [{"text": "São atividades realizadas pelo governo para "}, {"bold": true, "text": "inspecionar, verificar e monitorar bens imóveis que pertencem ao Estado"}, {"text": ", como prédios administrativos, escolas, hospitais, terrenos e outros patrimônios públicos, na finalidade de destinar ou renovar a formalização da ocupação.\\n\\n"}]}]	[{"type": "paragraph", "children": [{"text": "Órgãos do governo estadual, Gestores de patrimônio público e Entidades públicas que ocupam os imóveis do Estado."}]}]	[{"type": "paragraph", "children": [{"text": "Decreto nº 39.117, de 8 de Fevereiro de 2013\\n5º Compete, em especial:\\n\\"VI - à Gerência Geral de Patrimônio, Arquitetura e Engenharia do Estado: formular políticas e diretrizes e exercer a direção, a coordenação, a supervisão e o controle dos procedimentos técnicos e administrativos inerentes à gestão de materiais e do patrimônio público estadual, incluindo a padronização de projetos de construção, reforma ou restauração, realização de perícias e de avaliação técnicas de imóveis da administração direta e indireta do Estado.\\"\\n\\n"}]}]	[{"type": "paragraph", "children": [{"text": "Através de comunicação interna ou sistemas eletrônicos."}]}]	cmm9d7djb0000zolqpm53460w	\N		\N		\N	
cmmw3fu3a000kui04n93be0fp	Desfazimento de Bens Móveis	desfazimento-de-bens-moveis	patrimonio_movel	BATu4P84bmBW-Yxv9qL91Q	2275162	1376	768	png	Imagem representativa desfazimento de bens móveis	Procedimento para o desfazimento de bens móveis inservíveis	[{"type": "paragraph", "children": [{"text": "O desfazimento de bens móveis é o conjunto de procedimentos administrativos adotados pela Administração Pública Estadual para retirar do patrimônio bens que não têm mais utilidade.\\r\\nEm termos simples, significa dar uma destinação adequada a bens que já não servem mais, seja porque estão quebrados, obsoletos ou economicamente inviáveis de manter."}]}]	[{"type": "paragraph", "children": [{"text": "Todos os órgãos da Administração Direta, os fundos, as fundações, as autarquias, bem como as empresas públicas e sociedades de economia mista dependentes do Tesouro Estadual. "}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "Portaria SAD nº 505 de 14 de Fevereiro de 2017"}]}, {"type": "paragraph", "children": [{"text": ""}]}]	[{"type": "paragraph", "children": [{"text": "A solicitação para inclusão dos bens inservíveis para leilão deverá ser feita exclusivamente  através do processo SEI, o referido processo deve conter as seguintes informações:"}]}, {"type": "paragraph", "children": [{"text": "1- Ofício da Autoridade máxima do órgão solicitando à SEADP/SAD  a inclusão dos bens inservíveis para leilão;"}]}, {"type": "paragraph", "children": [{"text": "2- RBMI (Relatório de Bens Móveis Inservíveis), modelo SAD"}]}, {"type": "paragraph", "children": [{"text": "Obs: Esse modelo encontra-se no anexo I da Portaria SAD nº 505/2017."}]}, {"type": "paragraph", "children": [{"text": "3- Laudo de Risco Biológico / Ambiental, quando aplicável."}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}, {"type": "paragraph", "children": [{"text": ""}]}]	cmn4v9lci0001qaxktu3i2xrl	\N		\N		\N	
\.


--
-- Data for Name: Setor; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Setor" (id, nome, gerencia) FROM stdin;
\.


--
-- Data for Name: Solucoes; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Solucoes" (id, titulo, slug, categoria, imagem_id, imagem_filesize, imagem_width, imagem_height, imagem_extension, "imagemAlt", resumo, corpo, "linkExterno") FROM stdin;
cmi3h5i7b0005vwpm6wngrtl4	GeoPE	geo-pe	geo	HcAOY1Zjot9EWkPjCRHRVA	3250353	4160	6240	jpg	GeoPE	Plataforma de georreferenciamento dos imóveis do Estado de Pernambuco	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "GeoPE"}, {"text": " é a plataforma oficial de georreferenciamento dos imóveis do Estado de Pernambuco, desenvolvida para apoiar a gestão e a análise imobiliária do patrimônio público estadual."}]}, {"type": "paragraph", "children": [{"text": "A solução utiliza tecnologias de sistemas de informação geográfica para integrar dados espaciais e informações relacionadas aos imóveis pertencentes ao Estado, permitindo que gestores e equipes técnicas visualizem esses dados diretamente no mapa interativo podendo navegar pelas suas informações gerais, cartorárias dos imóveis e chegar até suas documentações."}]}, {"type": "paragraph", "children": [{"text": "Por meio da plataforma, é possível localizar imóveis públicos no território, analisar sua distribuição geográfica e acessar informações relevantes sobre cada bem imóvel cadastrado."}]}, {"type": "paragraph", "children": [{"text": "Entre as principais funcionalidades do GeoPE estão:"}]}, {"type": "paragraph", "children": [{"text": "Visualização geográfica dos imóveis pertencentes ao Estado de Pernambuco;"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Consulta de informações territoriais e administrativas dos bens;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Apoio ao planejamento e à gestão patrimonial;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Integração entre dados geográficos e informações institucionais;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Ferramentas de análise espacial."}]}]}]}, {"type": "paragraph", "children": [{"text": "A plataforma contribui para ampliar a capacidade de análise territorial da administração pública, promovendo maior integração entre dados, transparência na gestão patrimonial e eficiência no planejamento de ações relacionadas ao patrimônio público estadual."}]}]	https://geope.pe.gov.br/login
cmi4krlpf0000wugdaippzc92	Dashboard de Patrimônio Imobiliário	dashboard-patrimonio-imobiliario	bi	uUm3z_K6jeyK1PzkGDvJCg	15629070	8000	4563	jpg	Dashboard em Power BI com indicadores e mapas de monitoramento do patrimônio imobiliário estadual	Dashboard interativo desenvolvido em Power BI para monitoramento do patrimônio imobiliário estadual, permitindo acompanhar imóveis públicos, indicadores de gestão e informações territoriais para apoio à tomada de decisão.	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "Dashboard de Patrimônio Imobiliário"}, {"text": " é uma solução de Business Intelligence desenvolvida em "}, {"bold": true, "text": "Power BI"}, {"text": " com o objetivo de apoiar o monitoramento e a gestão dos imóveis pertencentes ao patrimônio público estadual."}]}, {"type": "paragraph", "children": [{"text": "A ferramenta consolida informações provenientes de diferentes bases institucionais e apresenta os dados por meio de painéis interativos, indicadores e visualizações analíticas que facilitam a compreensão das informações patrimoniais."}]}, {"type": "paragraph", "children": [{"text": "Por meio do dashboard, gestores e equipes técnicas podem acompanhar a distribuição dos imóveis no território, visualizar indicadores estratégicos e obter uma visão consolidada do patrimônio imobiliário do Estado."}]}, {"type": "paragraph", "children": [{"text": "Entre as principais funcionalidades da solução estão:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Visualização consolidada dos imóveis pertencentes ao Estado;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Monitoramento de indicadores de gestão do patrimônio imobiliário;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Análise da distribuição territorial dos imóveis;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Painéis interativos que facilitam a exploração e interpretação dos dados;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Apoio à tomada de decisão baseada em informações patrimoniais."}]}]}]}, {"type": "paragraph", "children": [{"text": "A solução contribui para fortalecer os processos de gestão patrimonial, ampliar a transparência das informações e apoiar o planejamento de ações relacionadas à administração dos bens imóveis públicos."}]}]	https://powerbi.pe.gov.br/relatorios/powerbi/SAD/GGPAE/NIPAE/PATRIM%C3%94NIO%20IMOBILI%C3%81RIO/DASHBOARD%20DE%20IM%C3%93VEIS%20PE
cmid6qe0u0000tmuv7ype3ong	Dashboard de Patrimônio Móvel	dashboard-de-moveis	bi	lCPOb7PtcVokmD-lmgOwtQ	8451576	5616	3744	jpg	Painel em Power BI com indicadores de gestão do patrimônio móvel do Estado	Dashboard interativo desenvolvido em Power BI para monitoramento do patrimônio móvel estadual, permitindo acompanhar indicadores, distribuição de bens e informações estratégicas para apoiar a gestão patrimonial.	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "Dashboard de Patrimônio Móvel"}, {"text": " é uma solução de Business Intelligence desenvolvida em "}, {"bold": true, "text": "Power BI"}, {"text": " com o objetivo de apoiar o monitoramento e a gestão dos bens móveis pertencentes ao Estado."}]}, {"type": "paragraph", "children": [{"text": "A ferramenta consolida dados provenientes de sistemas patrimoniais e apresenta as informações por meio de painéis interativos, gráficos e indicadores estratégicos, permitindo que gestores tenham uma visão clara e atualizada da situação do patrimônio móvel."}]}, {"type": "paragraph", "children": [{"text": "Por meio do dashboard, é possível acompanhar a distribuição dos bens por órgão, identificar padrões de utilização e obter informações relevantes para o planejamento e o controle patrimonial."}]}, {"type": "paragraph", "children": [{"text": "Entre as principais funcionalidades da solução estão:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Visualização consolidada dos bens móveis do Estado;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Monitoramento de indicadores estratégicos de gestão patrimonial;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Análise da distribuição dos bens por órgão ou unidade administrativa;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Painéis interativos que facilitam a exploração e interpretação dos dados;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Apoio à tomada de decisão baseada em dados."}]}]}]}, {"type": "paragraph", "children": [{"text": "A solução contribui para fortalecer a governança patrimonial, ampliar a transparência das informações e apoiar uma gestão pública mais eficiente e orientada por dados."}]}]	https://powerbi.pe.gov.br/relatorios/powerbi/SAD/GGPAE/NIPAE/PATRIM%C3%94NIO%20M%C3%93VEL/Dashboard%20Patrim%C3%B4nio%20M%C3%B3vel%20(V3)
cmi6a9j8g00041b0b0fqqwtwq	Acervo Móvel	acervo-movel	aplicacoes	M7TT_9Evfgb3yFpzdUkSlw	605334	4016	6016	jpg	Sistema digital de consulta ao acervo de bens móveis do patrimônio público estadual	Plataforma digital que permite a consulta e visualização de informações sobre os bens móveis pertencentes ao patrimônio público do Estado de Pernambuco, facilitando o acesso a dados patrimoniais e apoiando a gestão dos ativos públicos.	[{"type": "paragraph", "children": [{"text": "O "}, {"bold": true, "text": "Acervo Móvel"}, {"text": " é uma aplicação desenvolvida para facilitar o acesso às informações relacionadas aos bens móveis pertencentes ao patrimônio público estadual."}]}, {"type": "paragraph", "children": [{"text": "A plataforma reúne dados patrimoniais organizados de forma estruturada, permitindo a consulta e visualização de informações sobre os bens cadastrados, contribuindo para maior transparência e eficiência na gestão patrimonial."}]}, {"type": "paragraph", "children": [{"text": "Por meio da aplicação, gestores e equipes técnicas podem acessar informações relevantes sobre os bens móveis, auxiliando nos processos de controle, acompanhamento e planejamento da gestão patrimonial."}]}, {"type": "paragraph", "children": [{"text": "Entre as principais funcionalidades da solução estão:"}]}, {"type": "unordered-list", "children": [{"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Consulta de informações sobre bens móveis cadastrados;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Organização e visualização estruturada de dados patrimoniais;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Apoio às atividades de controle e acompanhamento dos ativos públicos;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Facilidade de acesso às informações por parte das equipes gestoras;"}]}]}, {"type": "list-item", "children": [{"type": "list-item-content", "children": [{"text": "Contribuição para maior transparência na gestão do patrimônio público."}]}]}]}, {"type": "paragraph", "children": [{"text": "A aplicação contribui para modernizar os processos de gestão patrimonial, permitindo que as informações sobre os bens móveis estejam organizadas e acessíveis de forma prática e segura."}]}]	https://acervomovel.pe.gov.br/login
\.


--
-- Data for Name: Tag; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."Tag" (id, nome) FROM stdin;
cmi62n48s00011b0bbgg5p8dg	INFORMAÇÕES
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."User" (id, name, email, password, role, "resetCode", "passwordResetToken", "passwordResetIssuedAt", "passwordResetRedeemedAt", "createdAt", gerencia, setor) FROM stdin;
0441f332-b4fc-4094-abea-fcd9ca8eec2c	Hugo Leonardo	hugo.sramos@sad.pe.gov.br	$2a$10$kHcZIIv0ypOeuLoXI33VJ..UMcMYqsKg4H3PwG3xnJhtwT6oGGK02	operator		\N	\N	\N	2025-11-17 03:00:00	\N	\N
630585af-a78f-42cc-9e8a-bf3438fe3d25	Igor Sacramento	igor.sacramento@sad.pe.gov.br	$2a$10$.6E3TkucONRpFxq5Lxe4tuEhS73Pnz7ELRM8ExVAoPNaZpcXQaWPa	operator		\N	\N	\N	2025-11-17 03:00:00	\N	\N
6dae8d3c-cd92-4be7-819a-791f85d3d5db	Luciana de Macedo Machado Lages	luciana.macedo@sad.pe.gov.br	$2a$10$c9ePcjyOtowxIxSP2CoF3Oa5Q21kcrRhT7Usku4D4P7OULyXBhI0u	operator		\N	\N	\N	2026-03-02 03:00:00	\N	\N
d5979719-0ec0-41cc-bf59-3767724411f2	Emilio Vieira	emilio.vieira@sad.pe.gov.br	$2a$10$z079yDwF1sdoYOcpb4M3RuYkXoPqxHQiX3mbUuXBqOaUFKJU8tBdG	admin		\N	\N	\N	2025-11-25 03:00:00	\N	\N
bb78e562-0fc6-4094-b02d-2dd1cb1df96d	Gustavo Andrade	gustavo.andrade@sad.pe.gov.br	$2a$10$7f6KY7w4PbSi4xGMxa9cv.4qIuIkmRhLZgH.NcFPoTu8v23mtV4ia	admin		\N	\N	\N	2026-03-03 03:00:00	\N	\N
a68e5a8c-7311-4ed9-8802-342c0c2e0bfc	Ana Paula de Castro Vieira	anapaula.castro@sad.pe.gov.br	$2a$10$3pm1p41egMWHD9UBrBhgEeq6JgGhF0c3W7.5I06VSTyv1ESsGOIZO	operator		\N	\N	\N	2026-03-04 14:57:28.062	\N	\N
54da2182-5bc7-4f9f-afac-0e221aa7b3e3	Ana Beatriz Barbosa Soares	ana.soaress@sad.pe.gov.br	$2a$10$Ligc4zBmsra8XzRSSHU5OeDEk.8piloM4nE.mwsTX0PEwo3cvcMKu	operator		\N	\N	\N	2026-03-05 03:00:00	\N	\N
0c6e34f7-2d2f-4f57-81af-e09d9f76970b	Jamesson Luna Muniz Júnior	jamesson.muniz@sad.pe.gov.br	$2a$10$5fU9pjqoEKjJ6BOy4.t5Y.6lBvju5kH7H//fIxT1EYP78w3k5CLU.	operator		\N	\N	\N	2026-03-09 03:00:00	\N	\N
126d4e04-c3c4-4b77-b66c-de3d329f78a9	Fabio Oliveira Araújo da Silva	fabioo.silva@sad.pe.gov.br	$2a$10$1Y53ay6HOzzo/Scw8z7q7uVCbnJCAQJ.tEKKzK0ji7zSqmRSYB.3W	operator		\N	\N	\N	2026-02-26 17:05:00	cmiekilbt000112f4i8cbm4f5	\N
ac6ee09d-e85b-41e0-aafb-24cb71fa5179	Eduardo Medicis M. Lacerda	eduardo.medicis@sad.pe.gov.br	$2a$10$GyCfdpMgwGnXL7HDp7w/U.axZdNR/1nejcXiU32LQ5gWV2oneV002	operator		\N	\N	\N	2025-11-17 03:00:00	\N	\N
04184f54-4410-4e5b-acc3-97b00e4bc9c5	adm_portal	clovis.melo@sad.pe.gov.br	$2a$10$YIk218ujBZFp4x7qPhyASuclZQR7x4nKQeovj3R0dpdANBcNysobm	admin	pfcu6q3k	\N	\N	\N	2025-11-13 14:11:10.024	\N	\N
4908bab7-d11b-4fed-bd24-45649d9e0fd2	operador	allan.soares.sad@gmail.com	$2a$10$rRaT3v4PhcfQoiNndIu1qO/pVMbI3BVvejqg46gRL2DIQW8Bhna9e	operator	f8tog8et	\N	\N	\N	2025-11-13 03:00:00	\N	\N
d272e905-a804-4dc5-b9da-508f1231016e	Ingrid Valões Barros da Silva	ingrid.vsilva@sad.pe.gov.br	$2a$10$mkWzAUgbvsS9fBE2SxOHK.k6XlBSGJ3kYvwOFEiBpbqA9HFhl80b.	operator		\N	\N	\N	2026-03-02 03:00:00	\N	\N
\.


--
-- Data for Name: _AreaResponsavel_gestores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_AreaResponsavel_gestores" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _Noticia_tags; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."_Noticia_tags" ("A", "B") FROM stdin;
cmi62n7d700021b0bord7df5s	cmi62n48s00011b0bbgg5p8dg
cmi62s9s200031b0bbwag1qkk	cmi62n48s00011b0bbgg5p8dg
\.


--
-- Data for Name: _PaginaQuemSomos_muralItens; Type: TABLE DATA; Schema: public; Owner: patrimonio_user
--

COPY public."_PaginaQuemSomos_muralItens" ("A", "B") FROM stdin;
cmi34ocqx0006pu9zizgkeauw	1
cmi4l8mis0002wugdn3oz9hvc	1
cmi4lbl3p0003wugdnpr0n4nf	1
cmi4ldcmg0004wugdvkxw24vx	1
\.


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
-- Name: Gerencia Gerencia_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Gerencia"
    ADD CONSTRAINT "Gerencia_pkey" PRIMARY KEY (id);


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
-- Name: MuralItem MuralItem_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."MuralItem"
    ADD CONSTRAINT "MuralItem_pkey" PRIMARY KEY (id);


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
-- Name: Servicos Servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Servicos"
    ADD CONSTRAINT "Servicos_pkey" PRIMARY KEY (id);


--
-- Name: Setor Setor_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Setor"
    ADD CONSTRAINT "Setor_pkey" PRIMARY KEY (id);


--
-- Name: Solucoes Solucoes_pkey; Type: CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Solucoes"
    ADD CONSTRAINT "Solucoes_pkey" PRIMARY KEY (id);


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
-- Name: Cursos_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Cursos_slug_key" ON public."Cursos" USING btree (slug);


--
-- Name: Gerencia_nome_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Gerencia_nome_key" ON public."Gerencia" USING btree (nome);


--
-- Name: Noticia_autor_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Noticia_autor_idx" ON public."Noticia" USING btree (autor);


--
-- Name: Noticia_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Noticia_slug_key" ON public."Noticia" USING btree (slug);


--
-- Name: Servicos_areaResponsavel_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Servicos_areaResponsavel_idx" ON public."Servicos" USING btree ("areaResponsavel");


--
-- Name: Servicos_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Servicos_slug_key" ON public."Servicos" USING btree (slug);


--
-- Name: Setor_gerencia_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "Setor_gerencia_idx" ON public."Setor" USING btree (gerencia);


--
-- Name: Setor_nome_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Setor_nome_key" ON public."Setor" USING btree (nome);


--
-- Name: Solucoes_slug_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Solucoes_slug_key" ON public."Solucoes" USING btree (slug);


--
-- Name: Tag_nome_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "Tag_nome_key" ON public."Tag" USING btree (nome);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_gerencia_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "User_gerencia_idx" ON public."User" USING btree (gerencia);


--
-- Name: User_setor_idx; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "User_setor_idx" ON public."User" USING btree (setor);


--
-- Name: _AreaResponsavel_gestores_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_AreaResponsavel_gestores_AB_unique" ON public."_AreaResponsavel_gestores" USING btree ("A", "B");


--
-- Name: _AreaResponsavel_gestores_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_AreaResponsavel_gestores_B_index" ON public."_AreaResponsavel_gestores" USING btree ("B");


--
-- Name: _Noticia_tags_AB_unique; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "_Noticia_tags_AB_unique" ON public."_Noticia_tags" USING btree ("A", "B");


--
-- Name: _Noticia_tags_B_index; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "_Noticia_tags_B_index" ON public."_Noticia_tags" USING btree ("B");


--
-- Name: _PaginaQuemSomos_muralItens_AB_unique; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE UNIQUE INDEX "_PaginaQuemSomos_muralItens_AB_unique" ON public."_PaginaQuemSomos_muralItens" USING btree ("A", "B");


--
-- Name: _PaginaQuemSomos_muralItens_B_index; Type: INDEX; Schema: public; Owner: patrimonio_user
--

CREATE INDEX "_PaginaQuemSomos_muralItens_B_index" ON public."_PaginaQuemSomos_muralItens" USING btree ("B");


--
-- Name: Noticia Noticia_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Noticia"
    ADD CONSTRAINT "Noticia_autor_fkey" FOREIGN KEY (autor) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Servicos Servicos_areaResponsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Servicos"
    ADD CONSTRAINT "Servicos_areaResponsavel_fkey" FOREIGN KEY ("areaResponsavel") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Setor Setor_gerencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."Setor"
    ADD CONSTRAINT "Setor_gerencia_fkey" FOREIGN KEY (gerencia) REFERENCES public."Gerencia"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: User User_gerencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_gerencia_fkey" FOREIGN KEY (gerencia) REFERENCES public."Gerencia"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: User User_setor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_setor_fkey" FOREIGN KEY (setor) REFERENCES public."Setor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _AreaResponsavel_gestores _AreaResponsavel_gestores_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_AreaResponsavel_gestores"
    ADD CONSTRAINT "_AreaResponsavel_gestores_A_fkey" FOREIGN KEY ("A") REFERENCES public."AreasResponsaveis"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AreaResponsavel_gestores _AreaResponsavel_gestores_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_AreaResponsavel_gestores"
    ADD CONSTRAINT "_AreaResponsavel_gestores_B_fkey" FOREIGN KEY ("B") REFERENCES public."Gestores"(id) ON UPDATE CASCADE ON DELETE CASCADE;


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
-- Name: _PaginaQuemSomos_muralItens _PaginaQuemSomos_muralItens_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."_PaginaQuemSomos_muralItens"
    ADD CONSTRAINT "_PaginaQuemSomos_muralItens_A_fkey" FOREIGN KEY ("A") REFERENCES public."MuralItem"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _PaginaQuemSomos_muralItens _PaginaQuemSomos_muralItens_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: patrimonio_user
--

ALTER TABLE ONLY public."_PaginaQuemSomos_muralItens"
    ADD CONSTRAINT "_PaginaQuemSomos_muralItens_B_fkey" FOREIGN KEY ("B") REFERENCES public."PaginaQuemSomos"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: patrimonio_user
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict 9zbksXuEVVuSgXQ5al805bLyaC0jk2yKK3YXR5T7j37T9sJozLuxHzXcxYbXMc9

