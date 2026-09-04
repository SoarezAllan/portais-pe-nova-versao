import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import siteConfig from "../../../config/siteConfig";
import { fetchPortfolios } from "../../../services/api";
import "./style.css";

const PortfolioComponent = () => {
  const [portfolios, setPortfolios] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const carregarPortfolios = async () => {
      try {
        setLoading(true);
        setError(null);
        const data = await fetchPortfolios(siteConfig.SITE_AREA);
        setPortfolios(
          data.map((p) => ({
            ...p,
            imagemUrl: p.imagem?.url,
            alt: p.imagemAlt || p.titulo,
          }))
        );
      } catch (err) {
        console.error("Erro ao buscar portfólios:", err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    carregarPortfolios();
  }, []);

  useEffect(() => {
    if (!portfolios.length) return;
    const totalPages = Math.ceil(portfolios.length / 3);
    const interval = setInterval(() => {
      setCurrentIndex((prev) => (prev + 1) % totalPages);
    }, 10000);
    return () => clearInterval(interval);
  }, [portfolios]);

  const pages = [];
  for (let i = 0; i < portfolios.length; i += 3) {
    pages.push(portfolios.slice(i, i + 3));
  }
  const totalPages = pages.length;

  if (loading) return <div className="solucoes-loading">Carregando Portfólio...</div>;
  if (error) return <div className="solucoes-fallback">Erro: {error}</div>;
  if (!portfolios.length) return <div className="solucoes-fallback">Nenhum portfólio cadastrado.</div>;

  return (
    <div className="servicos-component-wrapper">
      <div className="outros-servicos-carrossel">
        <div
          className="carousel-slide"
          style={{ transform: `translateX(-${currentIndex * 100}%)` }}
        >
          {pages.map((grupo, i) => (
            <div key={i} className="carousel-page">
              {grupo.map((portfolio) => (
                <div key={portfolio.id} className="carousel-card-item">
                  <Link to={`/portifolio/${portfolio.slug}`} className="card-link">
                    <div className="card">
                      {portfolio.imagemUrl && (
                        <img
                          src={portfolio.imagemUrl}
                          alt={portfolio.alt}
                          className="card-image-background"
                        />
                      )}
                      <div className="card-content">
                        <h3>{portfolio.titulo}</h3>
                        {portfolio.resumo && <p>{portfolio.resumo}</p>}
                      </div>
                    </div>
                  </Link>
                </div>
              ))}
            </div>
          ))}
        </div>
      </div>

      {totalPages > 1 && (
        <div className="carousel-controls">
          {pages.map((_, index) => (
            <div
              key={index}
              className={`carousel-dot ${index === currentIndex ? "active" : ""}`}
              onClick={() => setCurrentIndex(index)}
            />
          ))}
        </div>
      )}
    </div>
  );
};

export default PortfolioComponent;