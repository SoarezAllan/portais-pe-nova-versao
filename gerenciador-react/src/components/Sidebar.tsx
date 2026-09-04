import { NavLink } from 'react-router-dom';
import {
  LayoutDashboard,
  BarChart3,
  Globe,
  Newspaper,
  Gavel,
  GraduationCap,
  Users,
  Building2,
  FolderTree,
  Lightbulb,
  Tag,
  Shield,
  ScrollText,
  Image,
  ChevronDown,
  X,
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { useState } from 'react';

interface NavItem {
  to: string;
  label: string;
  icon: any;
}

interface NavGroup {
  title: string;
  items: NavItem[];
}

const navGroups: NavGroup[] = [
  {
    title: 'Principal',
    items: [
      { to: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
      { to: '/indicadores', label: 'Indicadores', icon: BarChart3 },
    ],
  },
  {
    title: 'Operação',
    items: [
      { to: '/areas', label: 'Áreas', icon: Building2 },
      { to: '/subareas', label: 'Subáreas', icon: FolderTree },
    ],
  },
  {
    title: 'Conteúdo',
    items: [
      { to: '/servicos', label: 'Serviços', icon: Globe },
      { to: '/noticias', label: 'Notícias', icon: Newspaper },
      { to: '/legislacao', label: 'Legislação', icon: Gavel },
      { to: '/cursos', label: 'Cursos e Capacitações', icon: GraduationCap },
      { to: '/solucoes', label: 'Soluções', icon: Lightbulb },
      { to: '/tags', label: 'Tags', icon: Tag },
    ],
  },
  {
    title: 'Institucional',
    items: [
      { to: '/quem-somos', label: 'Sobre', icon: Users },
      { to: '/portfolio', label: 'Portfólio', icon: Image },
    ],
  },
  {
    title: 'Sistema',
    items: [
      { to: '/usuarios', label: 'Usuários', icon: Shield },
      { to: '/auditoria', label: 'Audit Log', icon: ScrollText },
    ],
  },
];

function NavGroupSection({ group, onNavigate }: { group: NavGroup; onNavigate?: () => void }) {
  const [open, setOpen] = useState(true);

  return (
    <div className="mb-1">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="flex w-full items-center justify-between px-3 py-2 text-[11px] font-bold uppercase tracking-wider text-slate-400 hover:text-slate-600 transition-colors"
      >
        {group.title}
        <ChevronDown className={cn('h-3.5 w-3.5 transition-transform', open && 'rotate-180')} />
      </button>
      {open && (
        <div className="flex flex-col gap-0.5 px-2">
          {group.items.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              end={item.to === '/dashboard'}
              onClick={onNavigate}
              className={({ isActive }) =>
                cn(
                  'flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-all',
                  isActive
                    ? 'bg-blue-600 text-white shadow-sm'
                    : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900'
                )
              }
            >
              <item.icon className="h-4 w-4 shrink-0" />
              {item.label}
            </NavLink>
          ))}
        </div>
      )}
    </div>
  );
}

interface SidebarProps {
  open?: boolean;
  onClose?: () => void;
}

export function Sidebar({ open, onClose }: SidebarProps) {
  return (
    <>
      {/* Backdrop para mobile */}
      {open && (
        <div
          className="fixed inset-0 z-40 bg-slate-900/40 backdrop-blur-sm lg:hidden transition-opacity"
          onClick={onClose}
        />
      )}

      <aside
        className={cn(
          'fixed inset-y-0 left-0 z-50 w-64 bg-white border-r flex flex-col transition-transform duration-300 ease-in-out lg:static lg:translate-x-0 lg:z-auto lg:h-[calc(100vh-4rem)] lg:top-16 lg:sticky',
          open ? 'translate-x-0' : '-translate-x-full'
        )}
      >
        <div className="flex items-center justify-between p-4 border-b lg:hidden">
          <span className="font-bold text-slate-900">Menu Principal</span>
          <button
            onClick={onClose}
            className="p-1 rounded-md text-slate-400 hover:text-slate-700 hover:bg-slate-100"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <nav className="flex-1 overflow-y-auto p-3 flex flex-col gap-1">
          {navGroups.map((group) => (
            <NavGroupSection key={group.title} group={group} onNavigate={onClose} />
          ))}
        </nav>
      </aside>
    </>
  );
}
