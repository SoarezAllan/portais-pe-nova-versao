import { getCategoryEmoji } from '../../utils/categoryIcons';
import React, { useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import { fetchServicos, fetchSubareas } from '../../services/api';
import Header from '../../components/layout/header';
import siteConfig from '../../config/siteConfig';
import Footer from '../../components/layout/footer';

import PageHero from '../../components/layout/PageHero/PageHero';
import MobileNavigation from '../../components/mobile/layout/navegacao_areas/MobileNavigation';
import CardImagem from '../../components/ui/CardImagem/CardImagem';

import './style.css';

const normalizeId = (label) =>
  (label || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s]/g, '')
    .trim()
    .replace(/\s+/g, '_');

const categoriaIcones = {
  patrimonio_imobiliario: '🏠',
  patrimonio_movel: '🛋️',
  engenharia: '🏗️',
  arquitetura: '📐',
  frota: '🚗',
  contratos_corporativos: '📋',
  outros: '🔗',
};

const PaginaServicos = () => {
  const [subareasList, setSubareasList] = useState(siteConfig.SUBAREAS || []);
  const [servicosAgrupados, setServicosAgrupados] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const location = useLocation();

  const scrollToElement = (hash) => {
    const targetId = hash.startsWith('#') ? hash.substring(1) : hash;
    const element = document.getElementById(targetId);
    if (element) {
      setTimeout(() => {
        const offset = 120;
        const bodyRect = document.body.getBoundingClientRect().top;
        const elementRect = element.getBoundingClientRect().top;
        const elementPosition = elementRect - bodyRect;
        const offsetPosition = elementPosition - offset;
        window.scrollTo({ top: offsetPosition, behavior: 'smooth' });
      }, 100);
    }
  };

  useEffect(() => {
    window.scrollTo(0, 0);
    const fetchData = async () => {
      try {
        setLoading(true);
        setError(null);
        const data = await fetchServicos(siteConfig.SITE_AREA);
        const processados = data.map(item => ({
          ...item,
          _id: item.id,
          imagemUrl: item.imagem?.url,
        }));

        const agrupados = (processados || []).reduce((acc, servico) => {
          const sub = servico.subarea?.nome || 'Outros';
          const key = sub === 'Outros' ? 'outros' : normalizeId(sub);
          if (!acc[key]) acc[key] = [];
          acc[key].push(servico);
          return acc;
        }, {});

        setServicosAgrupados(agrupados);
      } catch (err) {
        console.error("Erro:", err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
    fetchSubareas(siteConfig.SITE_AREA).then(data => { if (data && data.length) setSubareasList(data); }).catch(() => {});
  }, []);

  useEffect(() => {
    if (!loading && location.hash) {
      scrollToElement(location.hash);
    }
  }, [loading, location.hash]);

  const categorias = {};
  subareasList.forEach((s) => {
    categorias[normalizeId(s)] = s;
  });
  categorias['outros'] = 'Outros';

  const navItems = subareasList.map((s) => {
    const key = normalizeId(s);
    return {
      icon: getCategoryEmoji(s),
      label: s,
      onClick: () => scrollToElement(`categoria-${key}`),
    };
  });

  if (servicosAgrupados['outros']) {
    navItems.push({
      icon: categoriaIcones['outros'],
      label: 'Outros',
      onClick: () => scrollToElement('categoria-outros'),
    });
  }

  if (loading) return (
    <div>
      <Header />
      <div style={{ minHeight: '50vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <h2>Carregando serviços...</h2>
      </div>
      <Footer />
    </div>
  );

  return (
    <div>
      <Header />
      <main>
        <MobileNavigation
          pageTitle="SERVIÇOS"
          items={navItems}
        />

        <div className="desktop-only-hero">
          <PageHero
            title="NOSSOS SERVIÇOS"
            bgImage="/slide2.jpg"
            cards={navItems}
          />
        </div>

        <div className="page-main-content servicos-grid-container">
          {error && (
            <section className="topic-section">
              <h2 className="topic-title" style={{ color: 'red' }}>Erro ao Carregar</h2>
              <p>{error}</p>
            </section>
          )}

          {Object.entries(servicosAgrupados).map(([categoriaKey, servicosDaCategoria]) => (
            <section key={categoriaKey} id={`categoria-${categoriaKey}`} className="topic-section">
              <h2 className="topic-title">{categorias[categoriaKey] || 'Outros'}</h2>
              <div className="topic-cards-grid">
                {servicosDaCategoria.map((item) => (
                  <CardImagem
                    key={item._id}
                    titulo={item.titulo}
                    resumo={item.resumo}
                    imagemUrl={item.imagemUrl}
                    slug={item.slug}
                    baseUrl="/servicos"
                  />
                ))}
              </div>
            </section>
          ))}
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default PaginaServicos;