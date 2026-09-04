import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { DocumentRenderer } from "@keystone-6/document-renderer";

import apiClient from "../../api";
import siteConfig from "../../config/siteConfig";

import Header from "../../components/layout/header";
import Footer from "../../components/layout/footer";

import "./style.css";

import { trackNoticiaView } from "../../utils/analytics";

export default function MateriaDetalhe() {

  const { slug } = useParams();

  const [noticia, setNoticia] = useState(null);
  const [historico, setHistorico] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {

    window.scrollTo(0, 0);

    const GQL_MATERIA = `
      query GetNoticiaPorSlug($slug: String!) {


        noticias(
          where: {
            slug: { equals: $slug }
            ativo: { equals: true }
          }
        ) {

          id

          titulo

          subtitulo

          corpo {
            document
          }

          resumo

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

    const GQL_HISTORICO = `
      query GetUltimasNoticias($siteArea: String!) {

        noticias(

          where: {

            areaResponsavel: {

              nome: {

                equals: $siteArea

              }

            },

            ativo: { equals: true }

          }

          orderBy: [

            {

              dataPublicacao: desc

            }

          ]

          take: 5

        ) {

          id

          titulo

          slug

          dataPublicacao

          imagemPrincipal {

            url

          }

        }

      }
    `;

    const fetchData = async () => {

      try {

        setLoading(true);

        const [

          responseMateria,

          responseHistorico,

        ] = await Promise.all([

          apiClient.post("/api/graphql", {

            query: GQL_MATERIA,

            variables: {

              slug,

            },

          }),

          apiClient.post("/api/graphql", {

            query: GQL_HISTORICO,

            variables: {

              siteArea: siteConfig.SITE_AREA,

            },

          }),

        ]);

        if (responseMateria.data?.errors) {
          console.error(
            "GraphQL Errors (Materia):",
            responseMateria.data.errors
          );
        }

        const noticiaFirst = responseMateria.data?.data?.noticias?.[0] || null;
        setNoticia(noticiaFirst);
        trackNoticiaView(slug);

        setHistorico(

          responseHistorico.data?.data?.noticias ||

          []

        );

      }

      catch (error) {

        console.error(

          "Erro ao carregar materia:",

          error

        );

      }

      finally {

        setLoading(false);

      }

    };

    fetchData();

  }, [slug]);



  if (loading) {

    return (

      <div className="app-container">

        <Header />

        <main className="materia-detalhe-loading">

          Carregando matéria...

        </main>

        <Footer />

      </div>

    );

  }



  if (!noticia) {

    return (

      <div className="app-container">

        <Header />

        <main

          className="materia-detalhe-loading"

          style={{

            padding: "40px",

          }}

        >

          <h1 style={{ color: "red" }}>

            Erro

          </h1>

          <p>

            Matéria não encontrada.

          </p>

          <Link to="/materias">

            Voltar para Notícias

          </Link>

        </main>

        <Footer />

      </div>

    );

  }



  return (

    <div className="app-container">

      <Header />

      <main className="materia-detalhe-container">

        <article className="materia-conteudo">

          <h1 className="materia-titulo">

            {noticia.titulo}

          </h1>



          {noticia.subtitulo && (

            <h2 className="materia-subtitulo">

              {noticia.subtitulo}

            </h2>

          )}



          {noticia.imagemPrincipal?.url && (

            <img

              src={

                noticia.imagemPrincipal.url

              }

              alt={

                noticia.imagemPrincipalAlt ||

                noticia.titulo

              }

              className="materia-imagem"

            />

          )}



          <div className="materia-meta">

            <span className="materia-data">

              {

                noticia.dataPublicacao

                ?

                new Date(

                  noticia.dataPublicacao

                ).toLocaleDateString(

                  "pt-BR"

                )

                :

                "Data não disponível"

              }

            </span>

          </div>



          {noticia.resumo && (

            <p className="materia-resumo">

              {noticia.resumo}

            </p>

          )}



          <div className="materia-corpo">

            {

              Array.isArray(noticia.corpo?.document) && noticia.corpo.document.length > 0

              ?

              (

                <DocumentRenderer

                  document={

                    noticia.corpo.document

                  }

                />

              )

              :

              (

                <p>

                  Conteúdo não disponível.

                </p>

              )

            }

          </div>



          {/* TAGS */}

          {noticia.tags?.length > 0 && (

            <section className="materia-tags-section">

              <div className="materia-tags-divider" />



              <h3 className="tags-titulo">

                Tópicos relacionados

              </h3>



              <div className="tags-lista">

                {

                  noticia.tags.map((tag) => (

                    <Link

                      key={tag.id}

                      to={`/noticias?tag=${encodeURIComponent(

                        tag.nome

                      )}`}

                      className="tag-badge"

                    >

                      #{tag.nome}

                    </Link>

                  ))

                }

              </div>

            </section>

          )}

        </article>



        <aside className="materia-lateral">

          <h3 className="lateral-titulo">

            Últimas notícias

          </h3>



          <ul className="lateral-lista">

            {

              historico.map((item) => (

                <li

                  key={item.id}

                  className="lateral-item"

                >

                  <Link

                    to={`/materias/${item.slug}`}

                    className="lateral-link"

                  >

                    {

                      item.imagemPrincipal?.url && (

                        <img

                          src={

                            item.imagemPrincipal.url

                          }

                          alt={item.titulo}

                          className="lateral-thumb"

                        />

                      )

                    }



                    <div className="lateral-textos">

                      <p className="lateral-item-titulo">

                        {item.titulo}

                      </p>



                      <span className="lateral-data">

                        {

                          item.dataPublicacao

                          ?

                          new Date(

                            item.dataPublicacao

                          ).toLocaleDateString(

                            "pt-BR"

                          )

                          :

                          ""

                        }

                      </span>

                    </div>

                  </Link>

                </li>

              ))

            }

          </ul>

        </aside>

      </main>

      <Footer />

    </div>

  );

}
