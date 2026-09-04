import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import './style.css';

const ROUTE_MAP = {
  'sobre': 'Sobre',
  'quem-somos': 'Sobre',
  'servicos': 'Serviços',
  'materias': 'Notícias',
  'noticias': 'Notícias',
  'cursos': 'Cursos e Capacitações',
  'legislacao': 'Legislação',
  'solucoes': 'Projetos e Inovação',
  'duvidas': 'Dúvidas Frequentes',
  'portifolio': 'Portfólio',
  'portfolio': 'Portfólio',
  'gestores': 'Gestores e Equipe',
  'materia-detalhe': 'Notícia',
  'servico-detalhe': 'Serviço',
  'solucao-detalhe': 'Solução',
};

function formatSlug(slug) {
  if (!slug) return '';
  return decodeURIComponent(slug)
    .replace(/[-_]+/g, ' ')
    .replace(/\b\w/g, (c) => c.toUpperCase());
}

export default function Breadcrumb({ customItems }) {
  const location = useLocation();
  const pathname = location.pathname;

  // Não renderiza na página inicial
  if (pathname === '/' || pathname === '') {
    return null;
  }

  let items = [];

  if (customItems && Array.isArray(customItems) && customItems.length > 0) {
    items = customItems;
  } else {
    items.push({ label: 'Início', path: '/' });

    const segments = pathname.split('/').filter(Boolean);
    let accumulatedPath = '';

    segments.forEach((seg, index) => {
      accumulatedPath += `/${seg}`;
      const isLast = index === segments.length - 1;
      const mappedLabel = ROUTE_MAP[seg.toLowerCase()] || formatSlug(seg);

      items.push({
        label: mappedLabel,
        path: isLast ? null : accumulatedPath,
      });
    });
  }

  return (
    <nav className="farelo-pao-nav" aria-label="Caminho de navegação (Breadcrumb)">
      <div className="farelo-pao-container">
        <ol className="farelo-pao-list">
          {items.map((item, idx) => {
            const isLast = idx === items.length - 1;
            return (
              <li key={idx} className={`farelo-pao-item ${isLast ? 'active' : ''}`}>
                {idx === 0 && (
                  <svg
                    className="farelo-pao-home-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    width="13"
                    height="13"
                    aria-hidden="true"
                  >
                    <path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
                    <polyline points="9 22 9 12 15 12 15 22" />
                  </svg>
                )}
                {item.path && !isLast ? (
                  <Link to={item.path} className="farelo-pao-link">
                    {item.label}
                  </Link>
                ) : (
                  <span className="farelo-pao-current" aria-current={isLast ? 'page' : undefined}>
                    {item.label}
                  </span>
                )}
                {!isLast && (
                  <span className="farelo-pao-separator" aria-hidden="true">
                    ›
                  </span>
                )}
              </li>
            );
          })}
        </ol>
      </div>
    </nav>
  );
}
