// ARQUIVO: src/components/ui/CardImagem/CardImagem.jsx

import React from 'react';
import { Link } from 'react-router-dom';
import './CardImagem.css';

const placeholderImage = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='300' viewBox='0 0 400 300'%3E%3Cdefs%3E%3ClinearGradient id='g' x1='0%25' y1='0%25' x2='100%25' y2='100%25'%3E%3Cstop offset='0%25' stop-color='%23003087'/%3E%3Cstop offset='100%25' stop-color='%23001844'/%3E%3C/linearGradient%3E%3C/defs%3E%3Crect width='400' height='300' fill='url(%23g)'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' font-family='Montserrat, sans-serif' font-weight='600' font-size='16' fill='%23ffffff' opacity='0.7'%3ESAD • GOV PE%3C/text%3E%3C/svg%3E";

const CardImagem = ({ titulo, resumo, descricao, imagemUrl, slug, linkExterno, baseUrl = '', onClick }) => {
  const textoResumo = resumo || descricao || '';

  // Conteúdo visual do card
  const CardContent = () => (
    <>
      <img 
        src={imagemUrl || placeholderImage} 
        alt={titulo} 
        className="card-imagem-bg"
        loading="lazy"
        decoding="async" 
        onError={(e) => {
          if (e.target.src !== placeholderImage) {
            e.target.src = placeholderImage;
          }
        }}
      />
      <div className="card-imagem-overlay">
        <h3 className="card-imagem-title">{titulo}</h3>
        {textoResumo ? <p className="card-imagem-resumo">{textoResumo}</p> : null}
      </div>
    </>
  );

  // Link externo
  if (linkExterno) {
    return (
      <a href={linkExterno} target="_blank" rel="noopener noreferrer" className="componente-card-imagem-wrapper" onClick={onClick}>
        <div className="componente-card-imagem">
          <CardContent />
        </div>
      </a>
    );
  }

  // Sempre usa Link interno (slug + baseUrl)
  if (slug) {
    const cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.slice(0, -1) : baseUrl;
    const finalUrl = `${cleanBaseUrl}/${slug}`;

    return (
      <Link to={finalUrl} className="componente-card-imagem-wrapper" onClick={onClick}>
        <div className="componente-card-imagem">
          <CardContent />
        </div>
      </Link>
    );
  }

  // Sem Link (apenas visual)
  return (
    <div className="componente-card-imagem-wrapper" onClick={onClick}>
      <div className="componente-card-imagem">
        <CardContent />
      </div>
    </div>
  );
};

export default CardImagem;
