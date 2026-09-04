import React from 'react';
import { Link } from 'react-router-dom';
import './tag.css';

const Tag = ({ label, className = '' }) => {
  // Se não vier texto, não mostra nada (evita botões vazios)
  if (!label) return null;

  return (
    <Link 
      // ✅ AQUI ESTÁ A MÁGICA:
      // Cria o link enviando o nome da tag via parâmetro de URL (?tag=Nome)
      to={`/materias?tag=${encodeURIComponent(label)}`}
      className={`tag-component ${className}`}
    >
      {label}
    </Link>
  );
};

export default Tag;