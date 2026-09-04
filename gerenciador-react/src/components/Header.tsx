import { useAuth } from '@/hooks/useAuth';
import { LogOut, User, LayoutGrid, Menu, ExternalLink } from 'lucide-react';
import { Button } from './ui/button';

interface HeaderProps {
  onToggleSidebar?: () => void;
}

export function Header({ onToggleSidebar }: HeaderProps) {
  const { user, logout } = useAuth();

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-white/95 backdrop-blur supports-[backdrop-filter]:bg-white/80 shadow-sm">
      <div className="flex h-16 items-center px-4 sm:px-6 lg:px-8 justify-between">
        <div className="flex items-center gap-3">
          {onToggleSidebar && (
            <Button
              variant="ghost"
              size="icon"
              onClick={onToggleSidebar}
              className="lg:hidden -ml-2 text-slate-600 hover:text-slate-900"
              aria-label="Abrir Menu"
            >
              <Menu className="h-5 w-5" />
            </Button>
          )}
          <div className="flex items-center justify-center h-10 w-10 rounded-xl bg-gradient-to-br from-[#003087] via-[#004A8D] to-[#00205B] text-white shadow-md ring-2 ring-blue-100">
            <LayoutGrid className="h-5 w-5 text-amber-300" />
          </div>
          <div className="flex flex-col">
            <div className="flex items-center gap-2">
              <h1 className="text-base font-bold text-slate-900 leading-tight">Portais PE</h1>
              <span className="inline-flex items-center px-2 py-0.5 rounded text-[10px] font-semibold bg-blue-100 text-blue-800 hidden sm:inline-flex">
                SAD/PE
              </span>
            </div>
            <span className="text-xs text-slate-500 font-medium leading-tight">
              Gerenciamento de Conteúdo
            </span>
          </div>
        </div>

        <div className="flex items-center gap-2 sm:gap-4">
          <div className="flex items-center gap-2.5 text-sm text-slate-600 bg-slate-50 px-3 py-1.5 rounded-full border border-slate-200/80">
            <div className="flex items-center justify-center h-7 w-7 rounded-full bg-blue-600 text-white font-bold text-xs shrink-0 shadow-xs">
              {user?.name ? user.name.charAt(0).toUpperCase() : <User className="h-3.5 w-3.5" />}
            </div>
            <div className="flex flex-col hidden sm:flex">
              <span className="font-medium text-slate-800 text-xs leading-tight">{user?.name}</span>
              <span className="text-[11px] text-slate-500 leading-tight font-normal">
                {user?.role === 'admin' ? 'Administrador' : 'Operador'}
              </span>
            </div>
          </div>
          <Button variant="ghost" size="sm" onClick={logout} className="text-slate-600 hover:text-red-600 hover:bg-red-50 text-xs font-semibold">
            <LogOut className="h-4 w-4 sm:mr-1" />
            <span className="hidden sm:inline">Sair</span>
          </Button>
        </div>
      </div>
    </header>
  );
}
