import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { ChevronRight, Home } from 'lucide-react';

const ROUTE_NAMES: Record<string, string> = {
  'dashboard': 'Painel Principal',
  'servicos': 'Serviços',
  'noticias': 'Notícias',
  'cursos': 'Cursos',
  'solucoes': 'Soluções',
  'legislacao': 'Legislação',
  'gestores': 'Gestores e Equipe',
  'quem-somos': 'Sobre',
  'usuarios': 'Usuários',
  'auditoria': 'Logs de Auditoria',
  'novo': 'Novo Registro',
  'edit': 'Editar',
};

export function Breadcrumb() {
  const location = useLocation();
  const segments = location.pathname.split('/').filter(Boolean);

  if (segments.length === 0 || (segments.length === 1 && segments[0] === 'dashboard')) {
    return null;
  }

  const items = [{ label: 'Painel', path: '/dashboard' }];
  let currentPath = '';

  segments.forEach((seg, idx) => {
    if (seg === 'admin' || seg === 'operador') return;
    currentPath += `/${seg}`;
    const isLast = idx === segments.length - 1;

    let label = ROUTE_NAMES[seg.toLowerCase()] || seg;
    if (seg.length > 20) {
      label = 'Editar Registro';
    }

    items.push({
      label,
      path: isLast ? '' : currentPath,
    });
  });

  return (
    <nav className="flex items-center gap-1.5 text-xs text-slate-500 mb-6 bg-white border border-slate-200 px-4 py-2.5 rounded-lg shadow-sm" aria-label="Breadcrumb">
      {items.map((item, index) => {
        const isLast = index === items.length - 1;
        return (
          <React.Fragment key={index}>
            {index > 0 && <ChevronRight className="w-3.5 h-3.5 text-slate-400 shrink-0" />}
            {index === 0 && <Home className="w-3.5 h-3.5 text-blue-600 shrink-0 mr-0.5" />}
            {item.path && !isLast ? (
              <Link to={item.path} className="hover:text-blue-600 hover:underline font-medium transition-colors">
                {item.label}
              </Link>
            ) : (
              <span className="font-semibold text-slate-800" aria-current="page">
                {item.label}
              </span>
            )}
          </React.Fragment>
        );
      })}
    </nav>
  );
}
