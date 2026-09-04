import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import apiClient from "../../../api";
import siteConfig from "../../../config/siteConfig";
import "./style.css";

const GQL_SERVICOS_QUERY = `
  query GetServicos($area: String!) {
    servicos(
      where: {
        areaResponsavel: {
          nome: {
            equals: $area
          }
        }
         ativo: { equals: true }
      }
      orderBy: { titulo: asc }
    ) {
      id
      titulo
      slug
      resumo
      imagem {
        url
      }
      imagemAlt
    }
  }
`;

const ServicosComponent = () => {
  const [servicos, setServicos] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    const fetchServicos = async () => {
      try {
        const response = await apiClient.post("/api/graphql", {
          query: GQL_SERVICOS_QUERY,
          variables: {
            area: siteConfig.SITE_AREA,
          },
        });

        const data = response?.data?.data?.servicos || [];

        setServicos(
          data.map((s) => ({
            ...s,
            imagemUrl: s.imagem?.url,
            alt: s.imagemAlt || s.titulo,
          }))
        );
      } catch (err) {
        console.error("Erro ao carregar serviços:", err);
      }
    };

    fetchServicos();
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

  if (!servicos.length) return null;

  return (
    <div className="servicos-component-wrapper">
      <div className="outros-servicos-carrossel">
        <div
          className="carousel-slide"
          style={{
            transform: `translateX(-${currentIndex * 100}%)`,
          }}
        >
          {pages.map((grupo, i) => (
            <div key={i} className="carousel-page">
              {grupo.map((servico) => (
                <div key={servico.id} className="carousel-card-item">
                  <Link
                    to={`/servicos/${servico.slug}`}
                    className="card-link"
                  >
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
              className={`carousel-dot ${
                index === currentIndex ? "active" : ""
              }`}
              onClick={() => setCurrentIndex(index)}
            />
          ))}
        </div>
      )}
    </div>
  );
};

export default ServicosComponent;