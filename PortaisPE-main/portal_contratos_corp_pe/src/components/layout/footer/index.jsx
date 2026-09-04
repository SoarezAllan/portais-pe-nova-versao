// Arquivo: src/components/layout/footer/index.jsx (ROTAS CORRIGIDAS)

import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom"; // Importar o Link
import "./style.css";
import siteConfig from "../../../config/siteConfig";

function Footer() {
  const [showBackToTop, setShowBackToTop] = useState(false);

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  useEffect(() => {
    const handleScroll = () => {
      // Mostra o botão depois de rolar 400px para baixo
      if (window.scrollY > 400) {
        setShowBackToTop(true);
      } else {
        setShowBackToTop(false);
      }
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <>
      {/* Botão Voltar ao Topo - AJUSTADO */}
      <button
        className={`back-to-top ${showBackToTop ? "show" : ""}`}
        onClick={scrollToTop}
        aria-label="Voltar ao início"
      >
        <span className="arrow-up">↑</span>
        Voltar ao início
      </button>

      <footer className="footer" id="CONTATO">
        <div className="footer-main">
          {/* --- Coluna 1: Sobre e Logo --- */}
          <div className="footer-column">
            <h3 className="footer-logo-placeholder">{siteConfig.SITE_TITLE}</h3>
          </div>

          {/* --- Coluna 2: Links Rápidos --- */}
          <div className="footer-column">
            <h3 className="footer-heading">Acessos Rápidos</h3>
            
            {/* ▼▼▼ MUDANÇAS AQUI ▼▼▼ */}
            <ul className="footer-links">
              <li><Link to="/">Início</Link></li>
              <li><Link to="/sobre">Sobre</Link></li>
              <li><Link to="/materias">Notícias</Link></li>
              <li><Link to="/servicos">Serviços</Link></li>
              <li><Link to="/solucoes">Projetos e Inovação</Link></li>
              <li><Link to="/legislacao">Legislação</Link></li>
              <li><Link to="/cursos">Cursos</Link></li>
            </ul>
            {/* ▲▲▲ FIM DAS MUDANÇAS ▲▲▲ */}

          </div>

          {/* --- Coluna 3: Contato --- */}
          <div className="footer-column">
            <h3 className="footer-heading">Contato</h3>
            <div className="contact-info">
              <p><strong>Endereço:</strong> R. do Futuro, 150 - Aflitos, Recife - PE</p>
              <p><strong>Telefone:</strong> (81) 99999-9999</p>
              <p><strong>Email:</strong> contato@orgao.pe.gov.br</p>
            </div>
          </div>
        </div>

        <div className="footer-bottom">
          <p className="footer-copy">
            © {new Date().getFullYear()} {siteConfig.SITE_TITLE}. Todos os direitos reservados.
          </p>
        </div>
      </footer>
    </>
  );
}

export default Footer;