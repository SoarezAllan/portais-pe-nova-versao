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
  Filter,
  Calendar,
  Layers,
  Loader2,
  Building2,
  ShieldCheck,
  Compass,
} from 'lucide-react';

const ACESSOS_QUERY = `
  query GetAcessos {
    acessos(take: 500, orderBy: [{ dataAcesso: desc }]) {
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

export function IndicadoresPage() {
  const { user, isAdmin } = useAuth();
  const [selectedArea, setSelectedArea] = useState<string>('ALL');
  const [selectedPeriod, setSelectedPeriod] = useState<string>('30'); // '1', '7', '30', 'ALL'

  const { data, isLoading } = useQuery({
    queryKey: ['indicadores-acessos'],
    queryFn: () =>
      graphqlRequest<{ acessos: AcessoItem[]; areas: { id: string; nome: string }[] }>(ACESSOS_QUERY),
  });

  const allAcessos = data?.acessos ?? [];
  const dbAreas = data?.areas ?? [];

  // Available areas for filtering
  const availableAreas = useMemo(() => {
    if (isAdmin) {
      return dbAreas;
    }
    return user?.areas || [];
  }, [isAdmin, dbAreas, user?.areas]);

  // Filtered acessos based on role, area filter, and period filter
  const filteredAcessos = useMemo(() => {
    const now = new Date();
    return allAcessos.filter((item) => {
      // 1. Role-based / area filter
      if (!isAdmin) {
        const userAreaNames = (user?.areas || []).map((a) => a.nome);
        const userAreaIds = (user?.areas || []).map((a) => a.id);
        const matchesUserArea =
          userAreaNames.includes(item.area) ||
          userAreaIds.includes(item.area) ||
          userAreaNames.some((n) => item.portal.includes(n));
        if (!matchesUserArea) return false;
      }

      if (selectedArea !== 'ALL') {
        const matchesSelected =
          item.area === selectedArea ||
          item.portal.toLowerCase().includes(selectedArea.toLowerCase());
        if (!matchesSelected) return false;
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
  const uniqueIps = useMemo(() => new Set(filteredAcessos.map((a) => a.ip).filter(Boolean)).size, [filteredAcessos]);

  // By Portal / Area
  const byPortal = useMemo(() => {
    const map: Record<string, number> = {};
    filteredAcessos.forEach((a) => {
      const key = a.area || a.portal || 'Geral';
      map[key] = (map[key] || 0) + 1;
    });
    return Object.entries(map).sort((a, b) => b[1] - a[1]);
  }, [filteredAcessos]);

  // By Section / Type
  const byTipo = useMemo(() => {
    const map: Record<string, number> = {};
    filteredAcessos.forEach((a) => {
      const key = a.tipo || 'Página Inicial';
      map[key] = (map[key] || 0) + 1;
    });
    return Object.entries(map).sort((a, b) => b[1] - a[1]);
  }, [filteredAcessos]);

  // By Date (Last 7 Days)
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
      <div className="flex items-center justify-center py-20">
        <Loader2 className="h-10 w-10 animate-spin text-blue-600" />
      </div>
    );
  }

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <div className="flex items-center gap-2">
            <h2 className="text-2xl font-bold text-gray-900">Indicadores de Acesso</h2>
            <Badge variant="outline" className={isAdmin ? 'bg-blue-50 text-blue-700 border-blue-200' : 'bg-green-50 text-green-700 border-green-200'}>
              {isAdmin ? 'Visão Geral (Admin)' : 'Visão Setorial (Operador)'}
            </Badge>
          </div>
          <p className="text-sm text-gray-500 mt-1">
            {isAdmin
              ? 'Métricas consolidadas de tráfego e visualizações de todos os portais do Estado'
              : `Métricas de acesso filtradas para sua(s) área(s): ${user?.areas?.map((a) => a.nome).join(', ') || 'Nenhuma área vinculada'}`}
          </p>
        </div>

        {/* Filters */}
        <div className="flex flex-wrap items-center gap-3">
          {/* Area Filter */}
          <div className="flex items-center gap-2 bg-white px-3 py-1.5 rounded-lg border shadow-sm">
            <Building2 className="h-4 w-4 text-gray-500" />
            <select
              value={selectedArea}
              onChange={(e) => setSelectedArea(e.target.value)}
              className="text-sm bg-transparent border-none focus:outline-none text-gray-700 font-medium"
            >
              <option value="ALL">{isAdmin ? 'Todas as Áreas / Portais' : 'Todas as Minhas Áreas'}</option>
              {availableAreas.map((area) => (
                <option key={area.id} value={area.nome}>
                  {area.nome}
                </option>
              ))}
            </select>
          </div>

          {/* Period Filter */}
          <div className="flex items-center gap-2 bg-white px-3 py-1.5 rounded-lg border shadow-sm">
            <Calendar className="h-4 w-4 text-gray-500" />
            <select
              value={selectedPeriod}
              onChange={(e) => setSelectedPeriod(e.target.value)}
              className="text-sm bg-transparent border-none focus:outline-none text-gray-700 font-medium"
            >
              <option value="1">Hoje (24h)</option>
              <option value="7">Últimos 7 dias</option>
              <option value="30">Últimos 30 dias</option>
              <option value="ALL">Todo o período</option>
            </select>
          </div>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        <Card className="border shadow-sm hover:shadow transition-shadow">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-semibold uppercase text-slate-500 tracking-wider">Total de Acessos</p>
              <p className="text-3xl font-extrabold text-slate-900 mt-2">{totalAcessos}</p>
              <p className="text-xs text-blue-600 mt-1 flex items-center gap-1 font-medium">
                <TrendingUp className="h-3.5 w-3.5" /> Registros no período
              </p>
            </div>
            <div className="h-12 w-12 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center">
              <Eye className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>

        <Card className="border shadow-sm hover:shadow transition-shadow">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-semibold uppercase text-slate-500 tracking-wider">Visitantes Únicos</p>
              <p className="text-3xl font-extrabold text-slate-900 mt-2">{uniqueIps}</p>
              <p className="text-xs text-green-600 mt-1 flex items-center gap-1 font-medium">
                <Users className="h-3.5 w-3.5" /> Endereços IP distintos
              </p>
            </div>
            <div className="h-12 w-12 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center">
              <Users className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>

        <Card className="border shadow-sm hover:shadow transition-shadow">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-semibold uppercase text-slate-500 tracking-wider">Média Diária</p>
              <p className="text-3xl font-extrabold text-slate-900 mt-2">
                {selectedPeriod === '1' ? totalAcessos : Math.round(totalAcessos / (parseInt(selectedPeriod, 10) || 30))}
              </p>
              <p className="text-xs text-slate-500 mt-1 flex items-center gap-1">
                <Activity className="h-3.5 w-3.5" /> Acessos / dia
              </p>
            </div>
            <div className="h-12 w-12 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center">
              <Activity className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>

        <Card className="border shadow-sm hover:shadow transition-shadow">
          <CardContent className="p-5 flex items-center justify-between">
            <div>
              <p className="text-xs font-semibold uppercase text-slate-500 tracking-wider">Principal Conteúdo</p>
              <p className="text-lg font-bold text-slate-900 mt-2 line-clamp-1">
                {byTipo[0]?.[0] || 'N/A'}
              </p>
              <p className="text-xs text-slate-500 mt-1">
                {byTipo[0]?.[1] || 0} acessos registrados
              </p>
            </div>
            <div className="h-12 w-12 rounded-xl bg-amber-50 text-amber-600 flex items-center justify-center">
              <Compass className="h-6 w-6" />
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Charts & Analytics Grids */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Distribution by Area/Portal */}
        <Card className="border shadow-sm">
          <CardHeader className="pb-3 border-b">
            <CardTitle className="text-base font-bold flex items-center gap-2 text-slate-800">
              <Globe className="h-4 w-4 text-blue-600" /> Acessos por Área / Portal
            </CardTitle>
          </CardHeader>
          <CardContent className="p-5 space-y-4">
            {byPortal.length === 0 ? (
              <p className="text-sm text-slate-400 text-center py-6">Nenhum dado registrado para o filtro atual.</p>
            ) : (
              byPortal.map(([portal, count]) => {
                const percentage = totalAcessos > 0 ? Math.round((count / totalAcessos) * 100) : 0;
                return (
                  <div key={portal} className="space-y-1.5">
                    <div className="flex justify-between text-sm">
                      <span className="font-medium text-slate-700">{portal}</span>
                      <span className="text-slate-500 font-semibold">{count} ({percentage}%)</span>
                    </div>
                    <div className="w-full bg-slate-100 h-2.5 rounded-full overflow-hidden">
                      <div
                        className="bg-blue-600 h-full rounded-full transition-all duration-500"
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
        <Card className="border shadow-sm">
          <CardHeader className="pb-3 border-b">
            <CardTitle className="text-base font-bold flex items-center gap-2 text-slate-800">
              <Layers className="h-4 w-4 text-purple-600" /> Acessos por Tipo de Conteúdo
            </CardTitle>
          </CardHeader>
          <CardContent className="p-5 space-y-4">
            {byTipo.length === 0 ? (
              <p className="text-sm text-slate-400 text-center py-6">Nenhum dado registrado para o filtro atual.</p>
            ) : (
              byTipo.map(([tipo, count]) => {
                const percentage = totalAcessos > 0 ? Math.round((count / totalAcessos) * 100) : 0;
                return (
                  <div key={tipo} className="space-y-1.5">
                    <div className="flex justify-between text-sm">
                      <span className="font-medium text-slate-700">{tipo}</span>
                      <span className="text-slate-500 font-semibold">{count} ({percentage}%)</span>
                    </div>
                    <div className="w-full bg-slate-100 h-2.5 rounded-full overflow-hidden">
                      <div
                        className="bg-purple-600 h-full rounded-full transition-all duration-500"
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
      <Card className="border shadow-sm">
        <CardHeader className="pb-3 border-b">
          <CardTitle className="text-base font-bold flex items-center gap-2 text-slate-800">
            <TrendingUp className="h-4 w-4 text-emerald-600" /> Atividade nos Últimos 7 Dias
          </CardTitle>
        </CardHeader>
        <CardContent className="p-6">
          <div className="flex items-end justify-between gap-2 h-40 pt-4">
            {byDay.map(([dateStr, count]) => {
              const heightPercent = Math.round((count / maxDayCount) * 100);
              const formattedDate = new Date(dateStr + 'T00:00:00').toLocaleDateString('pt-BR', {
                weekday: 'short',
                day: '2-digit',
                month: '2-digit',
              });
              return (
                <div key={dateStr} className="flex-1 flex flex-col items-center gap-2 h-full justify-end group">
                  <span className="text-xs font-bold text-slate-700 group-hover:text-blue-600 transition-colors">
                    {count}
                  </span>
                  <div className="w-full max-w-[48px] bg-slate-100 rounded-t-md h-full flex items-end overflow-hidden">
                    <div
                      className="w-full bg-blue-600 hover:bg-blue-700 transition-all rounded-t-md"
                      style={{ height: `${Math.max(heightPercent, 6)}%` }}
                    />
                  </div>
                  <span className="text-[11px] text-slate-500 font-medium capitalize">
                    {formattedDate}
                  </span>
                </div>
              );
            })}
          </div>
        </CardContent>
      </Card>

      {/* Recent Access Log Table */}
      <Card className="border shadow-sm">
        <CardHeader className="pb-3 border-b flex flex-row items-center justify-between">
          <CardTitle className="text-base font-bold text-slate-800">
            Registros Recentes de Acesso
          </CardTitle>
          <span className="text-xs text-slate-500">Exibindo os últimos acessos</span>
        </CardHeader>
        <CardContent className="p-0">
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead className="bg-slate-50 text-slate-700 font-semibold border-b text-xs uppercase tracking-wider">
                <tr>
                  <th className="px-5 py-3">Data / Hora</th>
                  <th className="px-5 py-3">Portal</th>
                  <th className="px-5 py-3">Área</th>
                  <th className="px-5 py-3">Conteúdo / Ação</th>
                  <th className="px-5 py-3">IP do Visitante</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {filteredAcessos.slice(0, 15).map((log) => (
                  <tr key={log.id} className="hover:bg-slate-50 transition-colors">
                    <td className="px-5 py-3 text-xs text-slate-500 whitespace-nowrap font-mono">
                      {log.dataAcesso ? new Date(log.dataAcesso).toLocaleString('pt-BR') : '-'}
                    </td>
                    <td className="px-5 py-3 font-medium text-slate-900">{log.portal || '-'}</td>
                    <td className="px-5 py-3">
                      <Badge variant="outline" className="text-xs font-normal">
                        {log.area || '-'}
                      </Badge>
                    </td>
                    <td className="px-5 py-3 text-slate-700 font-medium">{log.tipo || 'Visualização de Página'}</td>
                    <td className="px-5 py-3 text-xs font-mono text-slate-500">{log.ip || '127.0.0.1'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

export default IndicadoresPage;
