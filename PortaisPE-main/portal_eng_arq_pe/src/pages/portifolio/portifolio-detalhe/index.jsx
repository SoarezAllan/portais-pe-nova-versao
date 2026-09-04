import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { DocumentRenderer } from '@keystone-6/document-renderer';

import apiClient from '../../../api';
import Header from '../../../components/layout/header';
import Footer from '../../../components/layout/footer';
import siteConfig from '../../../config/siteConfig';

import './style.css';

const GQL_QUERY_DETALHE = `
  query GetPortfolioDetalhe($slug: String!, $siteArea: String!) {

    portfolios(
      where: {
        slug: { equals: $slug }
        ativo: { equals: true }
      }
    ) {
      id
      titulo
      resumo
      slug

      imagem {
        url
      }

      imagemAlt

      corpo {
        document
      }

      galeria {
        id
        titulo
        imagem {
          url
        }
      }
    }

    outrosPortfolios: portfolios(
      where: {
        slug: {
          not: {
            equals: $slug
          }
        }

        areaResponsavel: {
          nome: {
            equals: $siteArea
          }
        }

        ativo: { equals: true }
      }

      take: 5

      orderBy: {
        titulo: asc
      }
    ) {
      id
      titulo
      slug
      imagem {
        url
      }
    }
  }
`;

const ItemOutrosPortfolios = ({ item }) => {
  return (
    <li className="lateral-item">
      <Link to={`/portifolio/${item.slug}`} className="lateral-link">
        {item.imagem?.url && (
          <img
            src={item.imagem.url}
            alt={item.titulo}
            className="lateral-thumb"
          />
        )}

        <div className="lateral-textos">
          <p className="lateral-item-titulo">{item.titulo}</p>
        </div>
      </Link>
    </li>
  );
};

const PortfolioDetalhe = () => {
  const { slug } = useParams();

  const [portfolio, setPortfolio] = useState(null);
  const [outrosPortfolios, setOutrosPortfolios] = useState([]);

  const [loading, setLoading] = useState(true);
  const [imagemAtual, setImagemAtual] = useState(0);

  const [error, setError] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);

    const fetchData = async () => {
      if (!slug) {
        setError('Slug do portfólio não encontrado na URL.');
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setError(null);

        const response = await apiClient.post('/api/graphql', {
          query: GQL_QUERY_DETALHE,
          variables: {
            slug,
            siteArea: siteConfig.SITE_AREA,
          },
        });

        if (response.data.errors) {
          throw new Error(
            response.data.errors.map(e => e.message).join('\n')
          );
        }

        const data = response.data.data;

        const item =
          data.portfolios && data.portfolios.length > 0
            ? data.portfolios[0]
            : null;

        if (!item) {
          setError('Portfólio não encontrado.');
          setPortfolio(null);
          return;
        }

        setPortfolio(item);
        setOutrosPortfolios(data.outrosPortfolios || []);
        setImagemAtual(0);

      } catch (err) {
        setError(err?.message || 'Erro ao carregar portfólio.');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [slug]);

  if (loading) {
    return (
      <div className="app-container">
        <Header />
        <main className="solucao-detalhe-loading">
          Carregando Portfólio...
        </main>
        <Footer />
      </div>
    );
  }

  if (error || !portfolio) {
    return (
      <div className="app-container">
        <Header />
        <main className="solucao-detalhe-loading" style={{ padding: 40 }}>
          <h1 style={{ color: 'red' }}>
            {error ? 'Erro ao Carregar' : 'Portfólio não encontrado'}
          </h1>

          {error && <p>{error}</p>}

          <Link to="/portifolio">Voltar para Portfólio</Link>
        </main>
        <Footer />
      </div>
    );
  }

  // 🔥 CAPA + GALERIA UNIFICADAS
  const imagensCarrossel = [
    ...(portfolio.imagem?.url
      ? [
          {
            id: 'capa',
            titulo: portfolio.imagemAlt || portfolio.titulo,
            imagem: portfolio.imagem,
          },
        ]
      : []),
    ...(portfolio.galeria || []),
  ];

  const imagemAtiva = imagensCarrossel[imagemAtual];

  return (
    <div className="app-container">
      <Header />

      <main className="solucao-detalhe-container">
        <article className="solucao-conteudo">

          <h1 className="solucao-titulo">{portfolio.titulo}</h1>

          {portfolio.resumo && (
            <p className="solucao-resumo">{portfolio.resumo}</p>
          )}

          {/* CARROSSEL UNIFICADO */}
          {imagensCarrossel.length > 0 && (
            <div className="portfolio-galeria">

              <div className="portfolio-galeria-principal">
                <img
                  src={imagemAtiva?.imagem?.url}
                  alt={imagemAtiva?.titulo || ''}
                />
              </div>

              <div className="portfolio-galeria-thumbs">
                {imagensCarrossel.map((item, index) => (
                  <button
                    key={item.id || index}
                    type="button"
                    className={
                      imagemAtual === index ? 'thumb active' : 'thumb'
                    }
                    onClick={() => setImagemAtual(index)}
                  >
                    <img
                      src={item.imagem?.url}
                      alt={item.titulo || ''}
                    />
                  </button>
                ))}
              </div>

            </div>
          )}

          <div className="solucao-corpo">
            {portfolio.corpo?.document ? (
              <DocumentRenderer document={portfolio.corpo.document} />
            ) : (
              <p>Nenhuma descrição detalhada disponível.</p>
            )}
          </div>

        </article>

        <aside className="solucao-lateral">
          {outrosPortfolios.length > 0 && (
            <div className="widget-lateral">
              <h3 className="lateral-titulo">Outros Portfólios</h3>

              <ul className="widget-outros-lista">
                {outrosPortfolios.map(item => (
                  <ItemOutrosPortfolios key={item.id} item={item} />
                ))}
              </ul>
            </div>
          )}
        </aside>

      </main>

      <Footer />
    </div>
  );
};

export default PortfolioDetalhe;