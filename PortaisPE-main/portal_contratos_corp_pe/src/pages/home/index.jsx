import "./style.css";
import React, { useEffect } from "react";
import { useLocation } from "react-router-dom";

// Importa o estilo global dos cards (Mantivemos pois afeta os filhos)
import "../../styles/topic_cards.css";

// Componentes Gerais
import Header from '../../components/layout/header/index';
import Footer from '../../components/layout/footer/index';
import Carrossel from '../../components/layout/carrossel/index';

// Componentes de Conteúdo
import Servicos from '../../components/layout/servicos';
import Solucoes from '../../components/layout/solucoes';

// O NOVO COMPONENTE QUE CRIAMOS
import SectionBlock from '../../components/layout/SectionBlock';

const Home = () => {
  const location = useLocation();

  // Mantive sua lógica de scroll intacta
  useEffect(() => {
    window.scrollTo(0, 0);
    const hash = location.hash;
    if (hash) {
      const element = document.querySelector(hash);
      if (element) {
        setTimeout(() => {
          element.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 50);
      }
    }
  }, [location]);

  return (
    <div className="home">
      <Header />
      <Carrossel />

      {/* ================================================= */}
      {/* SEÇÃO 1: SERVIÇOS (Refatorada)                    */}
      {/* ================================================= */}
      <SectionBlock 
        id="servicos" 
        title="NOSSOS SERVIÇOS" 
        linkTo="/servicos" 
        linkText="VEJA MAIS"
      >
        {/* Aqui dentro vai apenas o conteúdo dos cards */}
        <Servicos />
      </SectionBlock>

      {/* ================================================= */}
      {/* SEÇÃO 2: SOLUÇÕES (Refatorada)                    */}
      {/* ================================================= */}
      <SectionBlock 
        id="solucoes" 
        title="PROJETOS E INOVAÇÃO" 
        linkTo="/solucoes" 
        linkText="VEJA MAIS"
      >
        <Solucoes />
      </SectionBlock>

      <Footer />
    </div>
  );
};

export default Home;