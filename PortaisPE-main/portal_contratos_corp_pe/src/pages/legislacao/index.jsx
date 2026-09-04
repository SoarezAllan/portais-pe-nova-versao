import { getCategoryEmoji } from '../../utils/categoryIcons';
import React, { useState, useEffect } from "react";
import "./style.css";
import Header from "../../components/layout/header";
import Footer from "../../components/layout/footer";
import { useLocation } from "react-router-dom";

import PageHero from "../../components/layout/PageHero/PageHero";
import MobileNavigation from "../../components/mobile/layout/navegacao_areas/MobileNavigation";
import siteConfig from "../../config/siteConfig";
import apiClient from "../../api"; // Importar apiClient para fazer a requisição GraphQL

const GQL_QUERY = `
  query BuscarLegislacoes($siteArea: String!) {
    legislacoes(
      where: { areaResponsavel: { nome: { equals: $siteArea } } }
      orderBy: { titulo: asc }
    ) {
      id
      titulo
      linkExterno
      categoria
      resumo
      subarea {
        nome
      }
    }
  }
`;

const normalizeId = (label) =>
  (label || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s]/g, '')
    .trim()
    .replace(/\s+/g, '_');

const areaLabels = {};
const areaIcones = {};
const AREAS_DESTAQUE = [];

// Usar siteConfig.SUBAREAS para popular as áreas de destaque
const icones = {
  patrimonio_imobiliario: '🏠',
  patrimonio_movel: '🛋️',
  engenharia: '🏗️',
  arquitetura: '📐',
  frota: '🚗',
  contratos_corporativos: '📋',
  agua_e_energia: '💧',
  telematica: '📡',
  outros: '🔗',
};

siteConfig.SUBAREAS.forEach((s) => {
  const key = normalizeId(s);
  areaLabels[key] = s;
  areaIcones[key] = getCategoryEmoji(s);
  AREAS_DESTAQUE.push(key);
});
areaLabels['outros'] = 'Outras Legislações';
areaIcones['outros'] = '🔗';

function LegislacaoIndexPage() {
  const [subareasList, setSubareasList] = useState(siteConfig.SUBAREAS || []);
  const location = useLocation();

  const [searchTerm, setSearchTerm] = useState("");
  const [allLegislacoes, setAllLegislacoes] = useState([]);
  const [legislacoesAgrupadas, setLegislacoesAgrupadas] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  /* =========================
     BUSCA DOS DADOS
  ========================= */
  useEffect(() => {
    const loadLegislacoes = async () => {
      try {
        setLoading(true);
        const response = await apiClient.post('/api/graphql', {
          query: GQL_QUERY,
          variables: { siteArea: siteConfig.SITE_AREA }, // Passar a área do site como variável
        });

        if (response.data?.errors) {
          throw new Error(response.data.errors.map((e) => e.message).join("\n"));
        }

        const data = response.data?.data?.legislacoes || [];
        setAllLegislacoes(data || []);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    loadLegislacoes();
    fetchSubareas(siteConfig.SITE_AREA).then(data => { if (data && data.length) setSubareasList(data); }).catch(() => {});
  }, []);

  /* =========================
     FILTRO + AGRUPAMENTO
  ========================= */
  useEffect(() => {
    const termo = searchTerm.toLowerCase();

    const filtradas = allLegislacoes.filter((leg) =>
      leg.titulo.toLowerCase().includes(termo) ||
      (leg.resumo && leg.resumo.toLowerCase().includes(termo))
    );

    const agrupado = filtradas.reduce((acc, leg) => {
      const raw = (leg.subarea?.nome || '').toString(); // Usar leg.subarea.nome
      const key = normalizeId(raw);
      const allowed = AREAS_DESTAQUE.includes(key);
      const finalKey = allowed ? key : 'outros';
      if (!acc[finalKey]) acc[finalKey] = [];
      acc[finalKey].push(leg);
      return acc;
    }, {});

    setLegislacoesAgrupadas(agrupado);
  }, [searchTerm, allLegislacoes]);

  /* =========================
     SCROLL COM ÂNCORA (CORRETO)
  ========================= */
  const scrollToAnchor = (id) => {
    const element = document.getElementById(id);
    if (!element) return;

    const offset = 120;
    const elementTop = element.getBoundingClientRect().top + window.scrollY;

    window.scrollTo({
      top: elementTop - offset,
      behavior: "smooth",
    });
  };

  useEffect(() => {
    if (loading) return;
    if (!location.hash) return;
    if (!Object.keys(legislacoesAgrupadas).length) return;

    scrollToAnchor(location.hash.substring(1));
  }, [loading, location.hash, legislacoesAgrupadas]);

  /* =========================
     SCROLL NORMAL (SEM HASH)
  ========================= */
  useEffect(() => {
    if (!location.hash) {
      window.scrollTo(0, 0);
    }
  }, [location.hash]);

  /* =========================
     NAVEGAÇÃO (HERO + MOBILE)
  ========================= */
  const navItems = AREAS_DESTAQUE.map((areaKey) => ({
    icon: areaIcones[areaKey],
    label: areaLabels[areaKey],
    onClick: () => scrollToAnchor(`area-${areaKey}`),
  }));

  if (legislacoesAgrupadas["outros"]) {
    navItems.push({
      icon: areaIcones.outros,
      label: areaLabels.outros,
      onClick: () => scrollToAnchor("area-outros"),
    });
  }

  return (
    <div className="app-container">
      <Header />

      <main className="legislacao-main-content">
        <MobileNavigation pageTitle="LEGISLAÇÃO" items={navItems} />

        <div className="desktop-only-hero">
          <PageHero title="LEGISLAÇÃO" bgImage="/slide2.jpg" cards={navItems} />
        </div>

        <div className="legislacao-grid-container page-main-content">
          <section className="legislacao-list-section">
            <div className="search-bar-container">
              <input
                type="text"
                placeholder="Pesquisar por título ou resumo..."
                className="search-input"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>

            {loading && <p>Carregando...</p>}

            {error && (
              <p style={{ color: "red", fontWeight: "bold" }}>
                Erro: {error}
              </p>
            )}

            {!loading &&
              !error &&
              Object.entries(legislacoesAgrupadas).map(([areaKey, legis]) => (
                <section
                  key={areaKey}
                  id={`area-${areaKey}`}
                  className="topic-section"
                >
                  <h2 className="topic-title">
                    {areaLabels[areaKey] || "Outros"}
                  </h2>

                  <ul className="legislacao-modern-list">
                    {legis.map((leg) => (
                      <li
                        key={leg.id}
                        className="legislacao-modern-list-item"
                      >
                        <a
                          href={leg.linkExterno}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="legislacao-item-link"
                        >
                          <span className="item-category-tag">
                            {leg.categoria || "Geral"}
                          </span>
                          <h3 className="item-title">{leg.titulo}</h3>
                          {leg.resumo && (
                            <p className="item-summary">{leg.resumo}</p>
                          )}
                        </a>
                      </li>
                    ))}
                  </ul>
                </section>
              ))}
          </section>
        </div>
      </main>

      <Footer />
    </div>
  );
}

export default LegislacaoIndexPage;