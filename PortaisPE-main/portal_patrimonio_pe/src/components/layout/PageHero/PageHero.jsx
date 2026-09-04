import React from 'react';
import './PageHero.css';

const PageHero = ({ title, bgImage, cards }) => {
  // Garante que 'cards' seja sempre uma lista, mesmo que não seja passado
  const listaCards = Array.isArray(cards) ? cards : [];

  return (
    <section 
      className="page-hero-component"
      style={{ backgroundImage: `url('${bgImage}')` }}
    >
      <div className="hero-overlay"></div>
      
      {/* Wrapper principal para o conteúdo, para garantir o alinhamento em bloco */}
      <div className="hero-main-content-wrapper">
        
        <div className="hero-content">
          <h1 className="hero-title">{title}</h1>
        </div>

        {listaCards.length > 0 && (
          <div className="hero-cards-container">
            {listaCards.map((card, index) => (
              <div 
                key={index} 
                className="hero-square-card"
                onClick={card.onClick}
              >
                {/* Se tiver valor (Quem Somos), mostra valor. Se não, mostra ícone (Serviços) */}
                {card.valor ? (
                  <span className="card-value">{card.valor}</span>
                ) : (
                  <div className="card-icon">{card.icon}</div>
                )}
                
                <h3 className="card-label">{card.label}</h3>
              </div>
            ))}
          </div>
        )}
      </div>
    </section>
  );
};

export default PageHero;
