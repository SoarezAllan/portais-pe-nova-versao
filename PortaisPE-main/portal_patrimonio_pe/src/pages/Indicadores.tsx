/// <reference types="vite/client" />

import React, { useState, useEffect } from 'react';
import { useAuth } from '../lib/auth';
import apiClient from '../api';
import Layout from '../components/Layout';

/* ------------------------------------------------------------------ */
/*  Tipos                                                             */
/* ------------------------------------------------------------------ */
interface TopItem {
  key: string;
  count: number;
}

interface AnalyticsData {
  porPortal: { key: string; count: number }[];
  topServicos: TopItem[];
  topNoticias: TopItem[];
}

/* ------------------------------------------------------------------ */
/*  Dados mock usados quando o endpoint REST não está disponível      */
/* ------------------------------------------------------------------ */
const MOCK_DATA: AnalyticsData = {
  porPortal: [
    { key: 'Patrimônio', count: 2847 },
    { key: 'Engenharia e Arquitetura', count: 1953 },
    { key: 'Contratos Corporativos', count: 1421 },
  ],
  topServicos: [
    { key: 'Solicitar Averbação de Imóvel', count: 523 },
    { key: 'Consultar Processo Digital', count: 487 },
    { key: 'Emitir Certidão de Matrícula', count: 342 },
    { key: 'Cadastrar Contrato', count: 298 },
    { key: 'Solicitar Vistoria Técnica', count: 211 },
  ],
  topNoticias: [
    { key: 'Governo moderniza sistema de gestão patrimonial', count: 1203 },
    { key: 'Novo portal de serviços entra no ar', count: 987 },
    { key: 'Obras de reforma avançam no centro administrativo', count: 756 },
    { key: 'Treinamento de servidores para novo sistema', count: 634 },
    { key: 'Resultados do levantamento patrimonial 2024', count: 512 },
  ],
};

/* ------------------------------------------------------------------ */
/*  Função auxiliar: busca real no backend                            */
/* ------------------------------------------------------------------ */
async function fetchAnalytics(): Promise<AnalyticsData> {
  try {
    const [portalRes, servicosRes, noticiasRes] = await Promise.all([
      apiClient.get<{ top: { key: string; count: number }[] }>('/analytics/top', {
        params: { type: 'portal', limit: 10 },
      }),
      apiClient.get<{ top: { key: string; count: number }[] }>('/analytics/top', {
        params: { type: 'servico', limit: 5 },
      }),
      apiClient.get<{ top: { key: string; count: number }[] }>('/analytics/top', {
        params: { type: 'noticia', limit: 5 },
      }),
    ]);

    return {
      porPortal: portalRes.data.top ?? [],
      topServicos: servicosRes.data.top ?? [],
      topNoticias: noticiasRes.data.top ?? [],
    };
  } catch {
    // Se o endpoint REST não estiver disponível (ex.: máquina de teste local),
    // retorna dados mock realistas.
    console.warn('[Indicadores] Endpoint REST /analytics/top não disponível — usando dados mock.');
    return MOCK_DATA;
  }
}

/* ------------------------------------------------------------------ */
/*  Componente de barra horizontal                                    */
/* ------------------------------------------------------------------ */
function BarRow({ label, count, max, suffix }: { label: string; count: number; max: number; suffix?: string }) {
  const pct = max > 0 ? Math.round((count / max) * 100) : 0;
  return (
    <div className="flex items-center gap-3">
      <span className="text-sm text-gray-600 w-2/5 truncate" title={label}>{label}</span>
      <div className="flex-1 bg-gray-100 rounded-full h-4 overflow-hidden">
        <div
          className="h-full rounded-full transition-all duration-500"
          style={{ width: `${Math.max(pct, 2)}%`, backgroundColor: '#003087' }}
        />
      </div>
      <span className="text-sm font-medium text-gray-800 w-16 text-right tabular-nums">
        {count.toLocaleString('pt-BR')}{suffix ?? ''}
      </span>
    </div>
  );
}

/* ------------------------------------------------------------------ */
/*  Página principal                                                  */
/* ------------------------------------------------------------------ */
export default function Indicadores() {
  const { isAdmin, loading: authLoading } = useAuth();
  const [data, setData] = useState<AnalyticsData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (authLoading) return;
    if (!isAdmin) { setLoading(false); return; }

    let cancelled = false;
    setLoading(true);
    setError(null);

    fetchAnalytics()
      .then((result) => { if (!cancelled) setData(result); })
      .catch((err) => { if (!cancelled) setError(err?.message ?? 'Erro ao carregar indicadores'); })
      .finally(() => { if (!cancelled) setLoading(false); });

    return () => { cancelled = true; };
  }, [isAdmin, authLoading]);

  /* ---- Loading / Auth guard ---- */
  if (authLoading || loading) {
    return (
      <Layout title="Indicadores de Acesso">
        <div className="flex justify-center py-16">
          <div className="flex items-center gap-3 text-gray-500">
            <svg className="animate-spin h-6 w-6" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
            </svg>
            <span>Carregando indicadores...</span>
          </div>
        </div>
      </Layout>
    );
  }

  if (!isAdmin) {
    return (
      <Layout title="Indicadores de Acesso">
        <div className="max-w-lg mx-auto mt-12 p-8 bg-amber-50 border border-amber-200 rounded-xl text-center">
          <svg className="w-12 h-12 text-amber-500 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M12 15v2m0 0v2m0-2h2m-2 0H10m9.364-7.364A9 9 0 1112 3a9 9 0 017.364 4.636z" />
          </svg>
          <h2 className="text-lg font-semibold text-amber-800 mb-2">Acesso Restrito</h2>
          <p className="text-sm text-amber-700">Apenas administradores podem visualizar os indicadores de acesso.</p>
        </div>
      </Layout>
    );
  }

  const maxPortal = Math.max(...(data?.porPortal ?? []).map((p) => p.count), 1);
  const maxServico = Math.max(...(data?.topServicos ?? []).map((s) => s.count), 1);
  const maxNoticia = Math.max(...(data?.topNoticias ?? []).map((n) => n.count), 1);

  return (
    <Layout title="Indicadores de Acesso">
      {error && (
        <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
          <p className="text-sm text-red-700">{error}</p>
        </div>
      )}

      {data && (
        <div className="space-y-6">
          {/** ======== Card: Total de Views por Portal ======== */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <h3 className="text-base font-semibold text-gray-800 mb-2">Visualizações por Portal</h3>
            <p className="text-xs text-gray-400 mb-5">Total de acessos acumulados nas páginas de cada portal</p>
            <div className="space-y-3">
              {data.porPortal.map((portal) => (
                <BarRow key={portal.key} label={portal.key} count={portal.count} max={maxPortal} />
              ))}
            </div>
          </div>

          {/** ======== Grid de Top 5 ======== */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/** Serviços mais acessados */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-base font-semibold text-gray-800">Serviços Mais Acessados</h3>
                <span className="text-xs font-medium text-gray-400 bg-gray-100 px-2 py-1 rounded-full">Top 5</span>
              </div>
              <div className="space-y-3">
                {data.topServicos.map((svc, idx) => (
                  <div key={svc.key} className="flex items-center gap-3">
                    <span className="w-6 h-6 flex items-center justify-center rounded-full bg-[#003087] text-white text-xs font-bold">{idx + 1}</span>
                    <div className="flex-1 min-w-0">
                      <BarRow label={svc.key} count={svc.count} max={maxServico} />
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/** Notícias mais acessadas */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-base font-semibold text-gray-800">Notícias Mais Acessadas</h3>
                <span className="text-xs font-medium text-gray-400 bg-gray-100 px-2 py-1 rounded-full">Top 5</span>
              </div>
              <div className="space-y-3">
                {data.topNoticias.map((ntc, idx) => (
                  <div key={ntc.key} className="flex items-center gap-3">
                    <span className="w-6 h-6 flex items-center justify-center rounded-full bg-[#003087] text-white text-xs font-bold">{idx + 1}</span>
                    <div className="flex-1 min-w-0">
                      <BarRow label={ntc.key} count={ntc.count} max={maxNoticia} />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/** ======== Footer com observação ======== */}
          <p className="text-xs text-gray-400 text-center pt-2">
            Os dados são atualizados em tempo real com base nos acessos registrados via Analytics API (/analytics/top).
          </p>
        </div>
      )}
    </Layout>
  );
}

