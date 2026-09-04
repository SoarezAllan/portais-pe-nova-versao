import "./style.css";
import React, { useEffect } from "react";
import { useLocation } from "react-router-dom";

// Estilos globais dos cards
import "../../styles/topic_cards.css";
import siteConfig from "../../config/siteConfig";

// Componentes Gerais
import Header from "../../components/layout/header/index";
import Footer from "../../components/layout/footer/index";
import Carrossel from "../../components/layout/carrossel/index";

// Componentes de Conteúdo
import Servicos from "../../components/layout/servicos";
import Portfolio from "../../components/layout/portifolio";

// Componente de seção
import SectionBlock from "../../components/layout/SectionBlock";

const Home = () => {
  const location = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);

    // ===== Analytics: PORTAL_VIEW (frontend) =====
    // Conta entrada no portal quando a rota principal é carregada.
    try {
      const portal = siteConfig.SITE_AREA;
      const eventId = `portal_view:${portal}:${Date.now()}:${Math.random().toString(16).slice(2)}`;

      const payload = {
        eventId,
        type: 'PORTAL_VIEW',
        ts: new Date().toISOString(),
        portal,
      };

      const url = 'http://DESKTOP-KH2LIS7:3001/analytics/track';
      const body = JSON.stringify(payload);

      if (navigator.sendBeacon) {
        const blob = new Blob([body], { type: 'application/json' });
        navigator.sendBeacon(url, blob);
      } else {
        fetch(url, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body,
          keepalive: true,
        }).catch(() => {});
      }
    } catch (e) {
      // não impactar a UI
    }

    const hash = location.hash;


    if (hash) {
      const element = document.querySelector(hash);

      if (element) {
        setTimeout(() => {
          element.scrollIntoView({
            behavior: "smooth",
            block: "start",
          });
        }, 50);
      }
    }
  }, [location]);

  return (
    <div className="home">
      <Header />

      <Carrossel />

      {/* ============================================= */}
      {/* SERVIÇOS                                      */}
      {/* ============================================= */}
      <SectionBlock
        id="servicos"
        title="NOSSOS SERVIÇOS"
        linkTo="/servicos"
        linkText="VEJA MAIS"
      >
        <Servicos />
      </SectionBlock>

      {/* ============================================= */}
      {/* PORTFÓLIO                                     */}
      {/* ============================================= */}
      <SectionBlock
        id="portfolio"
        title="PORTFÓLIO"
        linkTo="/portifolio"
        linkText="VEJA MAIS"
      >
        <Portfolio />
      </SectionBlock>

      <Footer />
    </div>
  );
};

export default Home;