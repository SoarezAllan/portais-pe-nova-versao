import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import siteConfig from "../../../config/siteConfig";
import { fetchServicos } from "../../../services/api";
import "./style.css";

const ServicosComponent = () => {
  const [servicos, setServicos] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [erro, setErro] = useState(null);

  useEffect(() => {
    const carregarServicos = async () => {
      try {
        const data = await fetchServicos(siteConfig.SITE_AREA);
        setServicos(
          data.map((s) => ({
            ...s,
            imagemUrl: s.imagem?.url,
            alt: s.imagemAlt || s.titulo,
          }))
        );
      } catch (err) {
        console.error('[Servicos] Erro:', err);
        setErro(err.message);
        setServicos([]);
      }
    };
    carregarServicos();
  }, []);

  useEffect(() => {
    if (!servicos.length) return;
    const totalPages = Math.ceil(servicos.length / 3);
    const interval = setInterval(() => {
      setCurrentIndex((prev) => (prev + 1) % totalPages);
    }, 10000);
    return () => clearInterval(interval);
  }, [servicos]);

  const pages = [];
  for (let i = 0; i < servicos.length; i += 3) {
    pages.push(servicos.slice(i, i + 3));
  }
  const totalPages = pages.length;

  if (erro) return <p style={{ color: 'red', padding: 20 }}>Erro ao carregar serviços: {erro}</p>;
  if (!servicos.length) return <p style={{ padding: 20 }}>Nenhum serviço encontrado para "{siteConfig.SITE_AREA}"</p>;

  return (
    <div className="servicos-component-wrapper">
      <div className="outros-servicos-carrossel">
        <div
          className="carousel-slide"
          style={{ transform: `translateX(-${currentIndex * 100}%)` }}
        >
          {pages.map((grupo, i) => (
            <div key={i} className="carousel-page">
              {grupo.map((servico) => (
                <div key={servico.id} className="carousel-card-item">
                  <Link to={`/servicos/${servico.slug}`} className="card-link">
                    <div className="card">
                      {servico.imagemUrl && (
                        <img
                          src={servico.imagemUrl}
                          alt={servico.alt}
                          className="card-image-background"
                        />
                      )}
                      <div className="card-content">
                        <h3>{servico.titulo}</h3>
                        {servico.resumo && <p>{servico.resumo}</p>}
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

export default ServicosComponent;