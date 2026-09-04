import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import apiClient from '../../../api';
import siteConfig from '../../../config/siteConfig';
import './style.css';

const GQL_SOLUCOES_QUERY = `
  query GetSolucoes($area: String!) {
    solucoes(
      where: {
        areaResponsavel: {
          nome: {
            equals: $area
          }
        }
      }
      orderBy: { titulo: asc }
    ) {
      id
      titulo
      slug
      resumo
      imagem {
        url
      }
      imagemAlt
    }
  }
`;

const SolucoesComponent = () => {
  const [solucoes, setSolucoes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchSolucoes = async () => {
      try {
        setLoading(true);
        setError(null);

        const response = await apiClient.post('/api/graphql', {
          query: GQL_SOLUCOES_QUERY,
          variables: {
            area: siteConfig.SITE_AREA,
          },
        });

        if (response.data.errors) {
          throw new Error(
            response.data.errors.map((e) => e.message).join('\n')
          );
        }

        const data = response.data.data.solucoes || [];

        setSolucoes(
          data.map((solucao) => ({
            ...solucao,
            imagemUrl: solucao.imagem?.url,
            alt: solucao.imagemAlt || solucao.titulo,
          }))
        );
      } catch (err) {
        console.error(err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchSolucoes();
  }, []);

  if (loading) {
    return (
      <div className="solucoes-loading">
        Carregando Soluções...
      </div>
    );
  }

  if (error) {
    return (
      <div className="solucoes-fallback">
        Erro: {error}
      </div>
    );
  }

  if (!solucoes.length) {
    return (
      <div className="solucoes-fallback">
        Nenhuma solução cadastrada.
      </div>
    );
  }

  return (
    <section className="solucoes-section">
      <div className="cards">
        {solucoes.map((solucao) => (
          <Link
            key={solucao.id}
            to={`/solucoes/${solucao.slug}`}
            className="card-link"
          >
            <div className="card">
              {solucao.imagemUrl && (
                <img
                  src={solucao.imagemUrl}
                  alt={solucao.alt}
                  className="card-image-background"
                />
              )}

              <div className="card-content">
                <h3>{solucao.titulo}</h3>
                {solucao.resumo && <p>{solucao.resumo}</p>}
              </div>
            </div>
          </Link>
        ))}
      </div>
    </section>
  );
};

export default SolucoesComponent;