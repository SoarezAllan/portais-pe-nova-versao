import React, { useState } from 'react';
import './MobileNavigation.css';

const MobileNavigation = ({ pageTitle, items = [] }) => {
  const [isOpen, setIsOpen] = useState(false);

  // Se não houver itens na lista, não mostra o botão de expandir
  const hasItems = items && items.length > 0;

  return (
    <div className="mobile-nav-container">
      <h1 className="mobile-nav-title">{pageTitle}</h1>

      {hasItems && (
        <>
          <button 
            className={`mobile-nav-btn ${isOpen ? 'active' : ''}`}
            onClick={() => setIsOpen(!isOpen)}
          >
            <span>Navegar por Seção</span>
            <span className="arrow-indicator">▼</span>
          </button>

          {isOpen && (
            <div className="mobile-nav-dropdown">
              {items.map((item, index) => (
                <div 
                  key={index} 
                  className="mobile-nav-item"
                  onClick={() => {
                    if (item.onClick) item.onClick();
                    setIsOpen(false); // Fecha o menu ao clicar
                  }}
                >
                  {/* Aceita 'valor' (para Quem Somos) ou 'icon' (para os outros) */}
                  <span className="nav-item-icon">
                    {item.valor ? item.valor : (item.icon || '🔗')}
                  </span>
                  <span className="nav-item-text">{item.label}</span>
                </div>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default MobileNavigation;