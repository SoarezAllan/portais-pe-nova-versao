/// <reference types="vite/client" />

import React, { useState, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useList } from '../../hooks/useList';
import { graphqlRequest } from '../../lib/api';
import Layout from '../../components/Layout';

interface SolucaoItem {
  id: string;
  titulo: string;
  slug: string;
  categoria: string;
  resumo: string;
  ativo: boolean;
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
}

const categoriaLabels: Record<string, string> = {
  geo: 'Geo',
  bi: 'BI',
  aplicacoes: 'Aplicações',
  projetos: 'Projetos',
  outros: 'Outros',
};

const categoriaColors: Record<string, string> = {
  geo: 'bg-green-100 text-green-800',
  bi: 'bg-blue-100 text-blue-800',
  aplicacoes: 'bg-purple-100 text-purple-800',
  projetos: 'bg-orange-100 text-orange-800',
  outros: 'bg-gray-100 text-gray-600',
};

export default function SolucaoList() {
  const navigate = useNavigate();
  const [searchTerm, setSearchTerm] = useState('');
  const [searchInput, setSearchInput] = useState('');

  const baseWhere = searchTerm ? { titulo: { contains: searchTerm, mode: 'insensitive' as const } } : undefined;
  const { data, loading, error, total, refetch, setSkip } = useList({
    queryName: 'solucoes',
    fields: 'id titulo slug categoria resumo ativo areaResponsavel { id nome } subarea { id nome }',
    baseWhere, take: 10, skip: 0,
  });
  const items = (data as SolucaoItem[]) ?? [];
  const totalPages = Math.ceil(total / 10);
  const [currentPage, setCurrentPage] = useState(0);

  const doSearch = useCallback((e: React.FormEvent) => { e.preventDefault(); setSearchTerm(searchInput); setSkip(0); setCurrentPage(0); }, [searchInput, setSkip]);
  const clearSearch = useCallback(() => { setSearchInput(''); setSearchTerm(''); setSkip(0); setCurrentPage(0); }, [setSkip]);
  const prev = useCallback(() => { setSkip(Math.max(0, currentPage - 1) * 10); setCurrentPage((p) => Math.max(0, p - 1)); }, [currentPage, setSkip]);
  const next = useCallback(() => { setSkip(Math.min(totalPages - 1, currentPage + 1) * 10); setCurrentPage((p) => Math.min(totalPages - 1, p + 1)); }, [currentPage, totalPages, setSkip]);

  const handleToggleAtivo = useCallback(async (item: SolucaoItem) => {
    try { await graphqlRequest(`mutation { updateSolucao(where: { id: "${item.id}" }, data: { ativo: ${!item.ativo} }) { id ativo } }`); refetch(); }
    catch { alert('Erro ao alterar status'); }
  }, [refetch]);

  return (
    <Layout title="Soluções">
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <p className="text-sm text-gray-500">Total de {total} solução(ões)</p>
          <button onClick={() => navigate('/solucoes/novo')} className="inline-flex items-center gap-2 px-4 py-2 bg-[#003087] text-white font-medium rounded-lg hover:bg-[#001f54] text-sm">
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" /></svg> Nova Solução
          </button>
        </div>
        <form onSubmit={doSearch} className="flex gap-2">
          <input type="text" value={searchInput} onChange={(e) => setSearchInput(e.target.value)} placeholder="Buscar por título..." className="flex-1 px-4 py-2 border border-gray-300 rounded-lg text-sm outline-none focus:ring-2 focus:ring-[#003087]" />
          <button type="submit" className="px-4 py-2 bg-gray-200 text-gray-700 font-medium rounded-lg hover:bg-gray-300 text-sm">Buscar</button>
          {searchTerm && <button type="button" onClick={clearSearch} className="px-3 py-2 text-gray-500 hover:text-gray-700 text-sm">Limpar</button>}
        </form>
        {error && <div className="p-4 bg-red-50 border border-red-200 rounded-lg"><p className="text-sm text-red-700">{error}</p></div>}
        {loading && (
          <div className="flex justify-center py-12">
            <div className="flex items-center gap-3 text-gray-500">
              <svg className="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" /><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" /></svg>
              <span>Carregando...</span>
            </div>
          </div>
        )}
        {!loading && !error && (
          <>
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
              <table className="w-full">
                <thead>
                  <tr className="bg-gray-50 border-b border-gray-200">
                    <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Título</th>
                    <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Área</th>
                    <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Categoria</th>
                    <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Ativo</th>
                    <th className="text-right px-4 py-3 text-sm font-semibold text-gray-700">Ações</th>
                  </tr>
                </thead>
                <tbody>
                  {items.length === 0 ? (
                    <tr><td colSpan={5} className="px-4 py-8 text-center text-gray-500 text-sm">Nenhuma solução encontrada.</td></tr>
                  ) : (
                    items.map((item) => (
                      <tr key={item.id} className="border-b border-gray-100 hover:bg-gray-50">
                        <td className="px-4 py-3"><p className="text-sm font-medium text-gray-900">{item.titulo}</p></td>
                        <td className="px-4 py-3 text-sm text-gray-600">{item.areaResponsavel?.nome ?? '-'}</td>
                        <td className="px-4 py-3 text-center">
                          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${categoriaColors[item.categoria] ?? 'bg-gray-100 text-gray-600'}`}>{categoriaLabels[item.categoria] ?? item.categoria}</span>
                        </td>
                        <td className="px-4 py-3 text-center">
                          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${item.ativo ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-600'}`}>{item.ativo ? 'Ativo' : 'Inativo'}</span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <div className="flex justify-end gap-2">
                            <button onClick={() => navigate(`/solucoes/${item.id}`)} className="px-3 py-1.5 text-xs font-medium text-[#003087] bg-blue-50 rounded-lg hover:bg-blue-100">Editar</button>
                            <button onClick={() => handleToggleAtivo(item)} className={`px-3 py-1.5 text-xs font-medium rounded-lg ${item.ativo ? 'text-red-700 bg-red-50 hover:bg-red-100' : 'text-green-700 bg-green-50 hover:bg-green-100'}`}>{item.ativo ? 'Desativar' : 'Ativar'}</button>
                          </div>
                        </td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>
            {totalPages > 1 && (
              <div className="flex items-center justify-between pt-2">
                <p className="text-sm text-gray-500">Página {currentPage + 1} de {totalPages}</p>
                <div className="flex gap-2">
                  <button onClick={prev} disabled={currentPage === 0} className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">Anterior</button>
                  <button onClick={next} disabled={currentPage >= totalPages - 1} className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">Próximo</button>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </Layout>
  );
}
