import { useState, useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';
import { useAuth } from '@/hooks/useAuth';
import { graphqlRequest } from '@/lib/api';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import {
  TrendingUp,
  Users,
  Eye,
  Activity,
  Globe,
  Calendar,
  Layers,
  Loader2,
  Building2,
  Newspaper,
  Briefcase,
  Lightbulb,
  Gavel,
  GraduationCap,
  Sparkles,
  CheckCircle2,
  ArrowUpRight,
} from 'lucide-react';

const ACESSOS_QUERY = `
  query GetAcessos {
    acessos(take: 1500, orderBy: [{ dataAcesso: desc }]) {
      id
      portal
      tipo
      area
      usuario
      ip
      dataAcesso
    }
    areas {
      id
      nome
    }
  }
`;

interface AcessoItem {
  id: string;
  portal: string;
  tipo: string;
  area: string;
  usuario: string;
  ip: string;
  dataAcesso: string;
}

// Configuração visual dos Portais
const PORTAL_CONFIG: Record<string, { label: string; color: string; bg: string; text: string; bar: string }> = {
  'Engenharia e Arquitetura': {
    label: 'Engenharia e Arquitetura',
    color: 'bg-indigo-600',
    bg: 'bg-indigo-50',
    text: 'text-indigo-700',
    bar: 'from-indigo-500 to-indigo-700',
  },
  'Patrimônio': {
    label: 'Patrimônio Estadual',
    color: 'bg-amber-500',
    bg: 'bg-amber-50',
    text: 'text-amber-800',
    bar: 'from-amber-400 to-amber-500',
  },
  'Serviços Corporativos': {
    label: 'Serviços Corporativos',
    color: 'bg-emerald-600',
    bg: 'bg-emerald-50',
    text: 'text-emerald-700',
    bar: 'from-emerald-500 to-emerald-700',
  },
  'Contratos Corporativos': {
    label: 'Serviços Corporativos',
    color: 'bg-emerald-600',
    bg: 'bg-emerald-50',
    text: 'text-emerald-700',
    bar: 'from-emerald-500 to-emerald-700',
  },
};

// Normalizador de nomes de portais/áreas
function normalizePortalName(raw: string): string {
  const lower = (raw || '').toLowerCase();
  if (lower.includes('eng') || lower.includes('arq')) return 'Engenharia e Arquitetura';
  if (lower.includes('patrim')) return 'Patrimônio';
  if (lower.includes('servi') || lower.includes('contrat')) return 'Serviços Corporativos';
  return raw || 'Geral';
}

// Configuração visual e amigável dos Tipos de Conteúdo
const TIPO_CONFIG: Record<string, { label: string; icon: any; color: string; bg: string; text: string; bar: string }> = {
  PORTAL_VIEW: {
    label: 'Páginas Iniciais e Navegação',
    icon: Globe,
    color: 'bg-blue-500',
    bg: 'bg-blue-50',
    text: 'text-blue-700',
    bar: 'from-blue-400 to-blue-600',
  },
  PAGE_VIEW: {
    label: 'Páginas Iniciais e Navegação',
    icon: Globe,
    color: 'bg-blue-500',
    bg: 'bg-blue-50',
    text: 'text-blue-700',
    bar: 'from-blue-400 to-blue-600',
  },
  SERVICO_VIEW: {
    label: 'Visualizações de Serviços',
    icon: Briefcase,
    color: 'bg-purple-500',
    bg: 'bg-purple-50',
    text: 'text-purple-700',
    bar: 'from-purple-400 to-purple-600',
  },
  NOTICIA_VIEW: {
    label: 'Leituras de Notícias',
    icon: Newspaper,
    color: 'bg-emerald-500',
    bg: 'bg-emerald-50',
    text: 'text-emerald-700',
    bar: 'from-emerald-400 to-emerald-600',
  },
  SOLUCAO_VIEW: {
    label: 'Projetos e Inovação',
    icon: Lightbulb,
    color: 'bg-amber-500',
    bg: 'bg-amber-50',
    text: 'text-amber-700',
    bar: 'from-amber-400 to-amber-600',
  },
  LEGISLACAO_VIEW: {
    label: 'Consultas a Legislações',
    icon: Gavel,
    color: 'bg-slate-600',
    bg: 'bg-slate-50',
    text: 'text-slate-700',
    bar: 'from-slate-500 to-slate-700',
  },
  CURSO_VIEW: {
    label: 'Capacitações e Cursos',
    icon: GraduationCap,
    color: 'bg-cyan-500',
    bg: 'bg-cyan-50',
    text: 'text-cyan-700',
    bar: 'from-cyan-400 to-cyan-600',
  },
};

function formatTipo(raw: string) {
  return TIPO_CONFIG[raw] || {
    label: raw || 'Navegação Geral',
    icon: Layers,
    color: 'bg-slate-500',
    bg: 'bg-slate-50',
    text: 'text-slate-700',
    bar: 'from-slate-400 to-slate-600',
  };
}

export function IndicadoresPage() {
  const { user, isAdmin } = useAuth();
  const [selectedArea, setSelectedArea] = useState<string>('ALL');
  const [selectedPeriod, setSelectedPeriod] = useState<string>('ALL'); // '1', '7', '30', 'ALL'

  const { data, isLoading } = useQuery({
    queryKey: ['indicadores-acessos'],
    queryFn: () =>
      graphqlRequest<{ acessos: AcessoItem[]; areas: { id: string; nome: string }[] }>(ACESSOS_QUERY),
  });

  const allAcessos = useMemo(() => {
    return (data?.acessos ?? []).map((a) => ({
      ...a,
      portalNormalizado: normalizePortalName(a.portal || a.area),
    }));
  }, [data?.acessos]);

  const dbAreas = data?.areas ?? [];

  // Áreas disponíveis para filtro
  const availableAreas = useMemo(() => {
    if (isAdmin) {
      return [
        { id: 'all', nome: 'Todas as Áreas' },
        { id: 'eng', nome: 'Engenharia e Arquitetura' },
        { id: 'pat', nome: 'Patrimônio' },
        { id: 'serv', nome: 'Serviços Corporativos' },
      ];
    }
    return user?.areas || [];
  }, [isAdmin, user?.areas]);

  // Acessos filtrados
  const filteredAcessos = useMemo(() => {
    const now = new Date();
    return allAcessos.filter((item) => {
      // 1. Role-based / area filter
      if (!isAdmin) {
        const userAreaNames = (user?.areas || []).map((a) => normalizePortalName(a.nome));
        const matchesUserArea = userAreaNames.includes(item.portalNormalizado);
        if (!matchesUserArea) return false;
      }

      if (selectedArea !== 'ALL') {
        const normSelected = normalizePortalName(selectedArea);
        if (item.portalNormalizado !== normSelected) return false;
      }

      // 2. Period filter
      if (selectedPeriod !== 'ALL' && item.dataAcesso) {
        const itemDate = new Date(item.dataAcesso);
        const diffDays = (now.getTime() - itemDate.getTime()) / (1000 * 3600 * 24);
        const maxDays = parseInt(selectedPeriod, 10);
        if (diffDays > maxDays) return false;
      }

      return true;
    });
  }, [allAcessos, isAdmin, user?.areas, selectedArea, selectedPeriod]);

  // KPIs
  const totalAcessos = filteredAcessos.length;
  const uniqueIps = useMemo(
    () => new Set(filteredAcessos.map((a) => a.ip).filter(Boolean)).size,
    [filteredAcessos]
  );

  // Agrupamento por Portal Normalizado
  const byPortal = useMemo(() => {
    const map: Record<string, number> = {};
    filteredAcessos.forEach((a) => {
      const key = a.portalNormalizado;
      map[key] = (map[key] || 0) + 1;
    });
    return Object.entries(map).sort((a, b) => b[1] - a[1]);
  }, [filteredAcessos]);

  // Agrupamento por Tipo de Conteúdo
  const byTipo = useMemo(() => {
    const map: Record<string, number> = {};
    filteredAcessos.forEach((a) => {
      const key = a.tipo || 'PORTAL_VIEW';
      map[key] = (map[key] || 0) + 1;
    });
    return Object.entries(map).sort((a, b) => b[1] - a[1]);
  }, [filteredAcessos]);

  // Atividade nos Últimos 7 Dias
  const byDay = useMemo(() => {
    const map: Record<string, number> = {};
    const last7Days = Array.from({ length: 7 }, (_, i) => {
      const d = new Date();
      d.setDate(d.getDate() - (6 - i));
      return d.toISOString().split('T')[0];
    });

    last7Days.forEach((dateStr) => {
      map[dateStr] = 0;
    });

    filteredAcessos.forEach((a) => {
      if (a.dataAcesso) {
        const dateStr = a.dataAcesso.split('T')[0];
        if (map[dateStr] !== undefined) {
          map[dateStr] = (map[dateStr] || 0) + 1;
        }
      }
    });

    return Object.entries(map);
  }, [filteredAcessos]);

  const maxDayCount = useMemo(() => {
    const counts = byDay.map(([_, count]) => count);
    return Math.max(...counts, 1);
  }, [byDay]);

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center py-24">
        <Loader2 className="h-10 w-10 animate-spin text-[#003087]" />
        <p className="text-sm text-slate-500 mt-3 font-medium">Carregando indicadores de acesso...</p>
      </div>
    );
  }

  return (
    <div className="space-y-8">
      {/* Top Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm">
        <div>
          <div className="flex items-center gap-3">
            <h2 className="text-2xl font-bold text-slate-900 tracking-tight">Indicadores de Acesso</h2>
            <Badge
              variant="outline"
              className={
                isAdmin
                  ? 'bg-blue-50 text-[#003087] border-blue-200 font-semibold px-2.5 py-0.5'
                  : 'bg-emerald-50 text-emerald-700 border-emerald-200 font-semibold px-2.5 py-0.5'
              }
            >
              {isAdmin ? 'Visão Consolidada (Admin)' : 'Visão Setorial'}
            </Badge>
          </div>
          <p className="text-sm text-slate-500 mt-1">
            Métricas de visualização e engajamento dos cidadãos e servidores nos portais do Estado de Pernambuco
          </p>
        </div>

        {/* Filters */}
        <div className="flex flex-wrap items-center gap-3">
          {/* Area Filter */}
          <div className="flex items-center gap-2 bg-slate-50 px-3.5 py-2 rounded-xl border border-slate-200 shadow-sm focus-within:ring-2 focus-within:ring-[#003087]">
            <Building2 className="h-4 w-4 text-slate-500" />
            <select
              value={selectedArea}
              onChange={(e) => setSelectedArea(e.target.value)}
              className="text-sm bg-transparent border-none focus:outline-none text-slate-700 font-medium cursor-pointer"
            >
              <option value="ALL">Todos os Portais</option>
              <option value="Engenharia e Arquitetura">Engenharia e Arquitetura</option>
              <option value="Patrimônio">Patrimônio Estadual</option>
              <option value="Serviços Corporativos">Serviços Corporativos</option>
            </select>
          </div>

          {/* Period Filter */}
          <div className="flex items-center gap-2 bg-slate-50 px-3.5 py-2 rounded-xl border border-slate-200 shadow-sm focus-within:ring-2 focus-within:ring-[#003087]">
            <Calendar className="h-4 w-4 text-slate-500" />
            <select
              value={selectedPeriod}
              onChange={(e) => setSelectedPeriod(e.target.value)}
              className="text-sm bg-transparent border-none focus:outline-none text-slate-700 font-medium cursor-pointer"
            >
              <option value="ALL">Todo o Período</option>
              <option value="30">Últimos 30 dias</option>
              <option value="7">Últimos 7 dias</option>
              <option value="1">Hoje (Últimas 24h)</option>
            </select>
          </div>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        <Card className="border border-slate-100 shadow-sm hover:shadow-md transition-all rounded-2xl bg-gradient-to-br from-white to-blue-50/30">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-bold uppercase text-slate-500 tracking-wider">Total de Acessos</p>
              <p className="text-3xl font-extrabold text-slate-900 mt-2">{totalAcessos.toLocaleString('pt-BR')}</p>
              <p className="text-xs text-blue-600 mt-1 flex items-center gap-1 font-semibold">
                <TrendingUp className="h-3.5 w-3.5" /> Registros confirmados
              </p>
            </div>
            <div className="h-12 w-12 rounded-2xl bg-blue-100 text-[#003087] flex items-center justify-center shadow-inner">
              <Eye className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>

        <Card className="border border-slate-100 shadow-sm hover:shadow-md transition-all rounded-2xl bg-gradient-to-br from-white to-emerald-50/30">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-bold uppercase text-slate-500 tracking-wider">Visitantes Únicos</p>
              <p className="text-3xl font-extrabold text-slate-900 mt-2">{uniqueIps.toLocaleString('pt-BR')}</p>
              <p className="text-xs text-emerald-600 mt-1 flex items-center gap-1 font-semibold">
                <Users className="h-3.5 w-3.5" /> Endereços IP distintos
              </p>
            </div>
            <div className="h-12 w-12 rounded-2xl bg-emerald-100 text-emerald-700 flex items-center justify-center shadow-inner">
              <Users className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>

        <Card className="border border-slate-100 shadow-sm hover:shadow-md transition-all rounded-2xl bg-gradient-to-br from-white to-purple-50/30">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-bold uppercase text-slate-500 tracking-wider">Portal Mais Acessado</p>
              <p className="text-lg font-bold text-slate-900 mt-2 line-clamp-1">
                {byPortal[0]?.[0] || 'Engenharia e Arq.'}
              </p>
              <p className="text-xs text-purple-600 mt-1 font-semibold">
                {byPortal[0]?.[1] || 0} visitas ({totalAcessos > 0 ? Math.round(((byPortal[0]?.[1] || 0) / totalAcessos) * 100) : 0}%)
              </p>
            </div>
            <div className="h-12 w-12 rounded-2xl bg-purple-100 text-purple-700 flex items-center justify-center shadow-inner">
              <Building2 className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>

        <Card className="border border-slate-100 shadow-sm hover:shadow-md transition-all rounded-2xl bg-gradient-to-br from-white to-amber-50/30">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-bold uppercase text-slate-500 tracking-wider">Principal Conteúdo</p>
              <p className="text-lg font-bold text-slate-900 mt-2 line-clamp-1">
                {formatTipo(byTipo[0]?.[0]).label}
              </p>
              <p className="text-xs text-amber-700 mt-1 font-semibold">
                {byTipo[0]?.[1] || 0} acessos ({totalAcessos > 0 ? Math.round(((byTipo[0]?.[1] || 0) / totalAcessos) * 100) : 0}%)
              </p>
            </div>
            <div className="h-12 w-12 rounded-2xl bg-amber-100 text-amber-700 flex items-center justify-center shadow-inner">
              <Sparkles className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Proportional Segment Bar (Total Distribution) */}
      <Card className="border border-slate-100 shadow-sm rounded-2xl p-5 bg-white">
        <div className="space-y-3">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <h3 className="text-sm font-bold text-slate-800 flex items-center gap-2">
              <Activity className="h-4 w-4 text-[#003087]" /> Divisão Geral de Tráfego entre Portais
            </h3>
            <span className="text-xs font-semibold text-slate-500">100% dos {totalAcessos} acessos</span>
          </div>

          {/* Segmented Bar */}
          <div className="h-4 w-full bg-slate-100 rounded-full overflow-hidden flex shadow-inner">
            {byPortal.map(([portal, count]) => {
              const pct = totalAcessos > 0 ? (count / totalAcessos) * 100 : 0;
              const cfg = PORTAL_CONFIG[portal] || { color: 'bg-slate-500' };
              return (
                <div
                  key={portal}
                  style={{ width: `${pct}%` }}
                  className={`${cfg.color} h-full transition-all duration-500 hover:opacity-90`}
                  title={`${portal}: ${count} (${Math.round(pct)}%)`}
                />
              );
            })}
          </div>

          {/* Legend */}
          <div className="flex flex-wrap gap-4 pt-1">
            {byPortal.map(([portal, count]) => {
              const pct = totalAcessos > 0 ? Math.round((count / totalAcessos) * 100) : 0;
              const cfg = PORTAL_CONFIG[portal] || { color: 'bg-slate-500', text: 'text-slate-700' };
              return (
                <div key={portal} className="flex items-center gap-2 text-xs">
                  <span className={`h-3 w-3 rounded-full ${cfg.color}`} />
                  <span className="font-semibold text-slate-700">{portal}:</span>
                  <span className="font-bold text-slate-900">{count} ({pct}%)</span>
                </div>
              );
            })}
          </div>
        </div>
      </Card>

      {/* Charts & Analytics Grids */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Distribution by Area/Portal */}
        <Card className="border border-slate-100 shadow-sm rounded-2xl overflow-hidden bg-white">
          <CardHeader className="pb-3 border-b border-slate-100 bg-slate-50/50">
            <CardTitle className="text-base font-bold flex items-center justify-between text-slate-900">
              <span className="flex items-center gap-2">
                <Globe className="h-4 w-4 text-[#003087]" /> Acessos por Portal Oficial
              </span>
              <span className="text-xs font-normal text-slate-500">Consolidado</span>
            </CardTitle>
          </CardHeader>
          <CardContent className="p-6 space-y-5">
            {byPortal.length === 0 ? (
              <p className="text-sm text-slate-400 text-center py-6">Nenhum dado registrado para o filtro atual.</p>
            ) : (
              byPortal.map(([portal, count]) => {
                const percentage = totalAcessos > 0 ? Math.round((count / totalAcessos) * 100) : 0;
                const cfg = PORTAL_CONFIG[portal] || {
                  label: portal,
                  color: 'bg-slate-600',
                  bg: 'bg-slate-50',
                  text: 'text-slate-700',
                  bar: 'from-slate-500 to-slate-700',
                };
                return (
                  <div key={portal} className="space-y-2 bg-slate-50/60 p-3.5 rounded-xl border border-slate-100">
                    <div className="flex justify-between items-center text-sm">
                      <span className="font-bold text-slate-800 flex items-center gap-2">
                        <span className={`h-2.5 w-2.5 rounded-full ${cfg.color}`} />
                        {cfg.label}
                      </span>
                      <div className="flex items-center gap-2">
                        <span className="text-slate-900 font-extrabold">{count.toLocaleString('pt-BR')}</span>
                        <Badge variant="outline" className={`${cfg.bg} ${cfg.text} border-transparent font-bold text-xs`}>
                          {percentage}%
                        </Badge>
                      </div>
                    </div>
                    <div className="w-full bg-slate-200/70 h-3 rounded-full overflow-hidden p-0.5">
                      <div
                        className={`bg-gradient-to-r ${cfg.bar} h-full rounded-full transition-all duration-700`}
                        style={{ width: `${percentage}%` }}
                      />
                    </div>
                  </div>
                );
              })
            )}
          </CardContent>
        </Card>

        {/* Distribution by Content Type */}
        <Card className="border border-slate-100 shadow-sm rounded-2xl overflow-hidden bg-white">
          <CardHeader className="pb-3 border-b border-slate-100 bg-slate-50/50">
            <CardTitle className="text-base font-bold flex items-center justify-between text-slate-900">
              <span className="flex items-center gap-2">
                <Layers className="h-4 w-4 text-purple-600" /> Acessos por Tipo de Conteúdo
              </span>
              <span className="text-xs font-normal text-slate-500">Engajamento</span>
            </CardTitle>
          </CardHeader>
          <CardContent className="p-6 space-y-5">
            {byTipo.length === 0 ? (
              <p className="text-sm text-slate-400 text-center py-6">Nenhum dado registrado para o filtro atual.</p>
            ) : (
              byTipo.map(([rawTipo, count]) => {
                const percentage = totalAcessos > 0 ? Math.round((count / totalAcessos) * 100) : 0;
                const tipoInfo = formatTipo(rawTipo);
                const IconComponent = tipoInfo.icon;
                return (
                  <div key={rawTipo} className="space-y-2 bg-slate-50/60 p-3.5 rounded-xl border border-slate-100">
                    <div className="flex justify-between items-center text-sm">
                      <span className="font-bold text-slate-800 flex items-center gap-2">
                        <div className={`p-1 rounded-md ${tipoInfo.bg} ${tipoInfo.text}`}>
                          <IconComponent className="h-4 w-4" />
                        </div>
                        {tipoInfo.label}
                      </span>
                      <div className="flex items-center gap-2">
                        <span className="text-slate-900 font-extrabold">{count.toLocaleString('pt-BR')}</span>
                        <Badge variant="outline" className={`${tipoInfo.bg} ${tipoInfo.text} border-transparent font-bold text-xs`}>
                          {percentage}%
                        </Badge>
                      </div>
                    </div>
                    <div className="w-full bg-slate-200/70 h-3 rounded-full overflow-hidden p-0.5">
                      <div
                        className={`bg-gradient-to-r ${tipoInfo.bar} h-full rounded-full transition-all duration-700`}
                        style={{ width: `${percentage}%` }}
                      />
                    </div>
                  </div>
                );
              })
            )}
          </CardContent>
        </Card>
      </div>

      {/* Activity Timeline (Last 7 Days) */}
      <Card className="border border-slate-100 shadow-sm rounded-2xl bg-white overflow-hidden">
        <CardHeader className="pb-3 border-b border-slate-100 bg-slate-50/50">
          <CardTitle className="text-base font-bold flex items-center justify-between text-slate-900">
            <span className="flex items-center gap-2">
              <TrendingUp className="h-4 w-4 text-emerald-600" /> Histórico de Atividade Recente (Últimos 7 Dias)
            </span>
            <span className="text-xs font-normal text-slate-500">Volume Diário</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="p-6">
          <div className="flex items-end justify-between gap-3 h-48 pt-6">
            {byDay.map(([dateStr, count]) => {
              const heightPercent = Math.round((count / maxDayCount) * 100);
              const formattedDate = new Date(dateStr + 'T00:00:00').toLocaleDateString('pt-BR', {
                weekday: 'short',
                day: '2-digit',
                month: '2-digit',
              });
              return (
                <div key={dateStr} className="flex-1 flex flex-col items-center gap-2 h-full justify-end group">
                  <span className="text-xs font-bold text-slate-800 group-hover:text-[#003087] group-hover:scale-110 transition-all">
                    {count}
                  </span>
                  <div className="w-full max-w-[56px] bg-slate-100 rounded-t-xl h-full flex items-end overflow-hidden p-1 shadow-inner">
                    <div
                      className="w-full bg-gradient-to-t from-[#003087] to-blue-500 hover:from-blue-600 hover:to-blue-400 transition-all rounded-t-lg shadow-sm"
                      style={{ height: `${Math.max(heightPercent, 8)}%` }}
                    />
                  </div>
                  <span className="text-[11px] text-slate-500 font-semibold capitalize tracking-tight">
                    {formattedDate}
                  </span>
                </div>
              );
            })}
          </div>
        </CardContent>
      </Card>

      {/* Recent Access Log Table */}
      <Card className="border border-slate-100 shadow-sm rounded-2xl bg-white overflow-hidden">
        <CardHeader className="pb-3 border-b border-slate-100 bg-slate-50/50 flex flex-row items-center justify-between">
          <div>
            <CardTitle className="text-base font-bold text-slate-900">
              Registros em Tempo Real
            </CardTitle>
            <p className="text-xs text-slate-500 mt-0.5">Últimos acessos auditados pelo sistema</p>
          </div>
          <Badge variant="outline" className="bg-white text-slate-600 border-slate-200">
            {filteredAcessos.length} total
          </Badge>
        </CardHeader>
        <CardContent className="p-0">
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead className="bg-slate-50 text-slate-600 font-bold border-b border-slate-100 text-xs uppercase tracking-wider">
                <tr>
                  <th className="px-6 py-3.5">Data / Hora</th>
                  <th className="px-6 py-3.5">Portal Oficial</th>
                  <th className="px-6 py-3.5">Tipo de Acesso</th>
                  <th className="px-6 py-3.5">Endereço IP</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {filteredAcessos.slice(0, 15).map((log) => {
                  const portalCfg = PORTAL_CONFIG[log.portalNormalizado] || {
                    bg: 'bg-slate-100',
                    text: 'text-slate-800',
                  };
                  const tipoCfg = formatTipo(log.tipo);
                  const IconComp = tipoCfg.icon;
                  return (
                    <tr key={log.id} className="hover:bg-blue-50/30 transition-colors">
                      <td className="px-6 py-3.5 text-xs text-slate-600 whitespace-nowrap font-mono font-medium">
                        {log.dataAcesso ? new Date(log.dataAcesso).toLocaleString('pt-BR') : '-'}
                      </td>
                      <td className="px-6 py-3.5">
                        <span className={`inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold ${portalCfg.bg} ${portalCfg.text}`}>
                          {log.portalNormalizado}
                        </span>
                      </td>
                      <td className="px-6 py-3.5">
                        <div className="flex items-center gap-2">
                          <IconComp className="h-3.5 w-3.5 text-slate-500" />
                          <span className="font-semibold text-slate-800 text-xs">{tipoCfg.label}</span>
                        </div>
                      </td>
                      <td className="px-6 py-3.5 text-xs font-mono text-slate-500">{log.ip || '127.0.0.1'}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

export default IndicadoresPage;
