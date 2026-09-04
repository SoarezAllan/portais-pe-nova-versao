import { getCategoryEmoji } from '../../utils/categoryIcons';
import React, { useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import apiClient from '../../api';
import Header from '../../components/layout/header';
import Footer from '../../components/layout/footer';
import PageHero from '../../components/layout/PageHero/PageHero';
import MobileNavigation from '../../components/mobile/layout/navegacao_areas/MobileNavigation';
import CardImagem from '../../components/ui/CardImagem/CardImagem';
import siteConfig from '../../config/siteConfig';
import './style.css';

const GQL_QUERY = `
  query GetSolucoes($siteArea: String!) {
    solucoes(
      where: {
        areaResponsavel: { nome: { equals: $siteArea } },
        ativo: { equals: true }
      }
      orderBy: { titulo: asc }
    ) {
      id
      titulo
      resumo
      slug
      imagem { url }
      imagemAlt
      linkExterno
      subarea {
        id
        nome
      }
    }
  }
`;

const normalizeId = (label) =>
  (label || '')
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9\s]/g, "")
    .trim()
    .replace(/\s+/g, "_");

const SUBAREAS = siteConfig.SUBAREAS || [];
const subareaLabels = {};
const SUBAREAS_KEYS = [];

SUBAREAS.forEach((s) => {
  const key = normalizeId(s);
  subareaLabels[key] = s;
  SUBAREAS_KEYS.push(key);
});
subareaLabels['outros'] = 'Outros';

const PaginaSolucoes = () => {
  const [solucoesAgrupadas, setSolucoesAgrupadas] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const location = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
    const fetchData = async () => {
      try {
        setLoading(true);
        setError(null);
        const response = await apiClient.post('/api/graphql', {
          query: GQL_QUERY,
          variables: { siteArea: siteConfig.SITE_AREA },
        });
        if (response.data.errors) {
          throw new Error(response.data.errors.map(e => e.message).join('\n'));
        }

        const data = response.data.data.solucoes || [];

        const processados = data.map(item => ({
          ...item,
          _id: item.id,
          imagemUrl: item.imagem?.url,
        }));

        const agrupados = processados.reduce((acc, solucao) => {
          const subareaLabel = solucao.subarea?.nome || '';
          const key = normalizeId(subareaLabel);
          const finalKey = SUBAREAS_KEYS.includes(key) ? key : 'outros';
          if (!acc[finalKey]) acc[finalKey] = [];
          acc[finalKey].push(solucao);
          return acc;
        }, {});

        setSolucoesAgrupadas(agrupados);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  const scrollToCategory = (key) => {
    const element = document.getElementById('categoria-' + key);
    if (element) {
      setTimeout(() => {
        const offset = 120;
        const bodyRect = document.body.getBoundingClientRect().top;
        const elementRect = element.getBoundingClientRect().top;
        const offsetPosition = elementRect - bodyRect - offset;
        window.scrollTo({ top: offsetPosition, behavior: 'smooth' });
      }, 100);
    }
  };

  useEffect(() => {
    if (!loading && location.hash) {
      scrollToCategory(location.hash.replace('#categoria-', '').replace('#', ''));
    }
  }, [loading, location]);

 const icones = {
  patrimonio_imobiliario: '🏠',
  patrimonio_movel: '🛋️',
  engenharia: '🏗️',
  arquitetura: '📐',
  frota: '🚗',
  contratos_corporativos: '📋',
};

const navItems = SUBAREAS_KEYS.map(key => ({
  icon: icones[key] || '🔹',
  label: subareaLabels[key],
  onClick: () => scrollToCategory(key),
}));

  if (solucoesAgrupadas['outros']) {
    navItems.push({
      icon: '🔗',
      label: 'Outros',
      onClick: () => scrollToCategory('outros'),
    });
  }

  const renderGrupos = () => {
    return Object.entries(solucoesAgrupadas).map(([categoriaKey, solucoesDaCategoria]) => {
      return (
        <section key={categoriaKey} id={'categoria-' + categoriaKey} className="topic-section">
          <h2 className="topic-title">
            {subareaLabels[categoriaKey] || 'Outros'}
          </h2>
          <div className="topic-cards-grid">
            {renderCards(solucoesDaCategoria)}
          </div>
        </section>
      );
    });
  };

  const renderCards = (solucoes) => {
    return solucoes.map(item => {
      return (
        <CardImagem
          key={item._id}
          titulo={item.titulo}
          resumo={item.resumo}
          imagemUrl={item.imagemUrl}
          slug={item.slug}
          linkExterno={item.linkExterno}
          baseUrl="/solucoes"
        />
      );
    });
  };

  if (loading) {
    return (
      <div>
        <Header />
        <h2 style={{ textAlign: 'center', marginTop: '50px' }}>Carregando...</h2>
        <Footer />
      </div>
    );
  }

  return (
    <div>
      <Header />
      <main>
        <MobileNavigation pageTitle="SOLUÇÕES" items={navItems} />

        <div className="desktop-only-hero">
          <PageHero title="PROJETOS E INOVAÇÃO" bgImage="/slide4.jpg" cards={navItems} />
        </div>

        <div className="page-main-content solucoes-grid-container">
          {error && <p style={{ color: 'red' }}>{error}</p>}
          {renderGrupos()}
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default PaginaSolucoes;