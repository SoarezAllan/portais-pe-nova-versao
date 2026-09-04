import React, { useEffect, useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import apiClient from "../../api";
import { format } from "date-fns";
import siteConfig from "../../config/siteConfig";

import Header from "../../components/layout/header";
import Footer from "../../components/layout/footer";

import "./style.css";

const normalize = (value) =>
  (value || "")
    .toString()
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim();

const GQL_QUERY = `
  query GetNoticias($siteArea: String!) {
    noticias(
      where: {
        areaResponsavel: {
          nome: {
            equals: $siteArea
          }
        }
        ativo: { equals: true }
      }
      orderBy: [{ dataPublicacao: desc }]
    ) {
      id

      titulo

      resumo

      slug

      dataPublicacao

      imagemPrincipal {
        url
      }

      imagemPrincipalAlt

      tags {
        id
        nome
      }
    }
  }
`;

export default function NoticiasHistorico() {
  const [loading, setLoading] = useState(true);

  const [error, setError] = useState(null);

  const [searchTerm, setSearchTerm] = useState("");

  const [allNoticias, setAllNoticias] = useState([]);

  const [filteredNoticias, setFilteredNoticias] = useState([]);

  const location = useLocation();

  const navigate = useNavigate();

  const queryParams = new URLSearchParams(location.search);

  const rawTagFilter = queryParams.get("tag");

  const tagFilter = normalize(rawTagFilter);

  useEffect(() => {

    window.scrollTo(0, 0);

    const fetchData = async () => {

      try {

        const response = await apiClient.post("/api/graphql", {
          query: GQL_QUERY,

          variables: {
            siteArea: siteConfig.SITE_AREA,
          },
        });

        if (response.data?.errors) {

          throw new Error(
            response.data.errors
              .map((e) => e.message)
              .join("\n")
          );

        }

        const data =
          response.data?.data?.noticias || [];

        const processadas = data.map((item) => ({
          ...item,

          imagemUrl:
            item.imagemPrincipal?.url || null,

          imagemAlt:
            item.imagemPrincipalAlt ||
            item.titulo,
        }));

        setAllNoticias(processadas);

      } catch (err) {

        console.error(err);

        setError(err.message);

      } finally {

        setLoading(false);

      }

    };

    fetchData();

  }, []);

  useEffect(() => {

    if (!allNoticias.length) {

      setFilteredNoticias([]);

      return;

    }

    let filtradas = [...allNoticias];

    // filtro por tag

    if (tagFilter) {

      filtradas = filtradas.filter((n) =>

        (n.tags || []).some((t) =>
          normalize(t?.nome).includes(tagFilter)
        )

      );

    }

    // filtro por pesquisa

    if (searchTerm) {

      const termo = normalize(searchTerm);

      filtradas = filtradas.filter((n) =>

        normalize(n.titulo).includes(termo) ||

        normalize(n.resumo).includes(termo)

      );

    }

    setFilteredNoticias(filtradas);

  }, [searchTerm, allNoticias, tagFilter]);

  const clearTag = () => {

    navigate("/noticias");

  };

  if (loading) {

    return (

      <>

        <Header />

        <main className="page-main-content">

          <div className="loading-container">

            <h2>Carregando notícias...</h2>

          </div>

        </main>

        <Footer />

      </>

    );

  }

  return (

    <>

      <Header />

      <main className="page-main-content">

        <section className="noticias-section">

          <h1 className="section-title historico-title">

            HISTÓRICO DE NOTÍCIAS

          </h1>

          <div className="search-bar-container">

            <input
              type="text"
              className="search-input"
              placeholder="Pesquisar por título ou resumo..."
              value={searchTerm}
              onChange={(e) =>
                setSearchTerm(e.target.value)
              }
            />

          </div>

          {rawTagFilter && (

            <div className="active-filter-container">

              <div className="filter-info">

                <span className="filter-label">

                  Filtrando por:

                </span>

                <span className="filter-tag-badge">

                  #{rawTagFilter}

                  <span className="filter-count">

                    {filteredNoticias.length}

                  </span>

                </span>

              </div>

              <button
                onClick={clearTag}
                className="clear-filter-btn"
              >

                Limpar filtro ✕

              </button>

            </div>

          )}

          {error && (

            <p
              style={{
                color: "red",
                textAlign: "center",
              }}
            >

              {error}

            </p>

          )}

          {filteredNoticias.length === 0 &&
            !loading && (

            <div className="noticia-no-results">

              <p>

                Nenhuma notícia encontrada

                {rawTagFilter
                  ? ` com a tag "${rawTagFilter}"`
                  : ""}

              </p>

              {rawTagFilter && (

                <button
                  onClick={clearTag}
                  className="btn-voltar-filtro"
                >

                  Ver todas as notícias

                </button>

              )}

            </div>

          )}

          <div className="noticias-container">

            {filteredNoticias.map((noticia) => (

              <div
                key={noticia.id}
                className="noticia-item"
              >

                {noticia.imagemUrl && (

                  <div className="noticia-img-wrap">

                    <img
                      src={noticia.imagemUrl}
                      alt={noticia.imagemAlt}
                      className="noticia-img"
                    />

                  </div>

                )}

                <div className="noticia-text">

                  <div className="card-tags-list">

                    {noticia.tags?.map((tag) => (

                      <span
                        key={tag.id}
                        className="mini-tag"
                      >

                        #{tag.nome}

                      </span>

                    ))}

                  </div>

                  <h2 className="noticia-titulo">

                    {noticia.titulo}

                  </h2>

                  <p className="noticia-resumo">

                    {noticia.resumo}

                  </p>

                  <span className="noticia-data">

                    {format(
                      new Date(
                        noticia.dataPublicacao
                      ),
                      "dd/MM/yyyy"
                    )}

                  </span>

                </div>

                <Link
                  to={`/materias/${noticia.slug}`}
                  className="noticia-btn"
                >

                  Ler Matéria

                </Link>

              </div>

            ))}

          </div>

        </section>

      </main>

      <Footer />

    </>

  );

}