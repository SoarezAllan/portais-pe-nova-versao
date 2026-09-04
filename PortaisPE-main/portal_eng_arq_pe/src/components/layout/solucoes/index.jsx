import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import siteConfig from "../../../config/siteConfig";
import { fetchSolucoes } from "../../../services/api";
import "./style.css";

const SolucoesComponent = () => {
  const [solucoes, setSolucoes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const carregarSolucoes = async () => {
      try {
        setLoading(true);
        setError(null);

        const data = await fetchSolucoes(siteConfig.SITE_AREA);

        const processedSolucoes = data.map((solucao) => ({
          ...solucao,
          imagemUrl: solucao.imagem?.url,
          alt: solucao.imagemAlt || solucao.titulo,
        }));

        setSolucoes(processedSolucoes);
      } catch (err) {
        console.error("Erro ao buscar soluções:", err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    carregarSolucoes();
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

  if (solucoes.length === 0) {
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