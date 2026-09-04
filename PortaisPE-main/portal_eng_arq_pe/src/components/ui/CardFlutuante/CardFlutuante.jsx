import React from 'react';
import './CardFlutuante.css';

const CardFlutuante = ({ icon, valor, titulo, onClick, className = '' }) => {
  return (
    <div className={`componente-card-flutuante ${className}`} onClick={onClick}>
      {/* Se tiver VALOR (ex: "10"), mostra o valor. Se não, mostra o ÍCONE. */}
      {valor ? (
        <span className="card-valor">{valor}</span>
      ) : (
        <div className="card-icon">{icon}</div>
      )}
      <h3 className="card-titulo">{titulo}</h3>
    </div>
  );
};

export default CardFlutuante;