// src/pages/portifolio/index.jsx
import React, { useEffect, useState } from 'react';
import Header from '../../components/layout/header';
import Footer from '../../components/layout/footer';
import PageHero from '../../components/layout/PageHero/PageHero';
import CardImagem from '../../components/ui/CardImagem/CardImagem';
import siteConfig from '../../config/siteConfig';
import { fetchPortfolios } from '../../services/api';

import './style.css';

const PaginaPortifolio = () => {
  const [portfolios, setPortfolios] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);

    const fetchData = async () => {
      try {
        setLoading(true);
        setError(null);

        const data = await fetchPortfolios(siteConfig.SITE_AREA);

        const processados = data.map(item => ({
          ...item,
          _id: item.id,
          imagemUrl: item.imagem?.url,
        }));

        setPortfolios(processados);
      } catch (err) {
        console.error("Erro ao carregar portfólio:", err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return (
      <div>
        <Header />
        <div style={{ minHeight: '50vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <h2>Carregando portfólio...</h2>
        </div>
        <Footer />
      </div>
    );
  }

  return (
    <div>
      <Header />

      <main>
        {/* Hero do Portfólio sem divisão de subáreas */}
        <PageHero
          title="PORTFÓLIO DE PROJETOS E OBRAS"
          bgImage="/slide4.jpg"
          cards={[]}
        />

        <div className="page-main-content solucoes-grid-container">
          {error && (
            <p style={{ color: 'red' }}>
              {error}
            </p>
          )}

          <section className="topic-section">
            <h2 className="topic-title">Nossos Projetos e Obras Realizadas</h2>
            
            {portfolios.length === 0 ? (
              <p style={{ color: '#64748b', fontSize: '1.05rem', padding: '20px 0' }}>
                Nenhum projeto cadastrado no momento.
              </p>
            ) : (
              <div className="topic-cards-grid">
                {portfolios.map((item) => (
                  <CardImagem
                    key={item.id || item._id}
                    titulo={item.titulo}
                    resumo={item.resumo}
                    imagemUrl={item.imagemUrl}
                    slug={item.slug}
                    baseUrl="/portifolio"
                  />
                ))}
              </div>
            )}
          </section>
        </div>
      </main>

      <Footer />
    </div>
  );
};

export default PaginaPortifolio;
