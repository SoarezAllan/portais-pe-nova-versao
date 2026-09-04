/// <reference types="vite/client" />

import React, { type ReactNode } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from '../lib/auth';

interface NavItem {
  label: string;
  path: string;
  icon?: string;
}

const navItems: NavItem[] = [
  { label: 'Dashboard', path: '/admin/dashboard' },
  { label: 'Indicadores', path: '/indicadores' },
  { label: 'Serviços', path: '/servicos' },
  { label: 'Soluções', path: '/solucoes' },
  { label: 'Notícias', path: '/noticias' },
  { label: 'Legislação', path: '/legislacao' },
  { label: 'Cursos', path: '/cursos' },
  { label: 'Gestores', path: '/gestores' },
  { label: 'Quem Somos', path: '/quem-somos' },
];

interface LayoutProps {
  children: ReactNode;
  title?: string;
}

/**
 * Layout administrativo com sidebar de navegação e topbar.
 */
export default function Layout({ children, title = 'Gerenciador' }: LayoutProps) {
  const { user, isAdmin, isOperator, logout } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/gerenciador-login');
  };

  return (
    <div className="min-h-screen flex bg-gray-100">
      {/* Sidebar */}
      <aside className="w-64 bg-[#003087] text-white flex flex-col shadow-lg">
        {/* Logo / Header */}
        <div className="p-5 border-b border-blue-800">
          <h1 className="text-xl font-bold tracking-tight">Portais PE</h1>
          <p className="text-sm text-blue-200 mt-1">Admin</p>
        </div>

        {/* User Info */}
        <div className="px-5 py-3 border-b border-blue-800 bg-blue-900/30">
          <p className="text-sm font-medium truncate">{user?.name}</p>
          <p className="text-xs text-blue-300 capitalize">{isAdmin ? 'Administrador' : 'Operador'}</p>
          {isOperator && user?.areas && user.areas.length > 0 && (
            <p className="text-xs text-blue-300 truncate mt-0.5">
              {user.areas.map((a) => a.nome).join(', ')}
            </p>
          )}
        </div>

        {/* Navigation */}
        <nav className="flex-1 overflow-y-auto py-4">
          <ul className="space-y-1 px-3">
{navItems
              .filter((item) => {
                // Indicadores e Dashboard só aparecem para admin
                if (item.path === '/indicadores' || item.path === '/admin/dashboard') return user?.role === 'admin';
                return true;
              })
              .map((item) => {
              const isActive = location.pathname === item.path || location.pathname.startsWith(item.path + '/');
              return (
                <li key={item.path}>
                  <Link
                    to={item.path}
                    className={`flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-colors ${
                      isActive
                        ? 'bg-white/20 text-white'
                        : 'text-blue-200 hover:bg-white/10 hover:text-white'
                    }`}
                  >
                    {item.icon && <span className="text-lg">{item.icon}</span>}
                    {item.label}
                  </Link>
                </li>
              );
            })}
          </ul>
        </nav>

        {/* Footer */}
        <div className="p-4 border-t border-blue-800">
          <button
            onClick={handleLogout}
            className="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
            Sair
          </button>
        </div>
      </aside>

      {/* Main Content */}
      <div className="flex-1 flex flex-col">
        {/* Top Bar */}
        <header className="bg-white shadow-sm border-b border-gray-200">
          <div className="px-6 py-4 flex items-center justify-between">
            <h2 className="text-lg font-semibold text-gray-800">{title}</h2>
            <div className="flex items-center gap-4">
              <span className="text-sm text-gray-500">
                {user?.email}
              </span>
            </div>
          </div>
        </header>

        {/* Content */}
        <main className="flex-1 overflow-y-auto p-6">
          {children}
        </main>
      </div>
    </div>
  );
}

