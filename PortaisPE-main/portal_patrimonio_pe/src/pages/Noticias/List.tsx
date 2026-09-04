/// <reference types="vite/client" />

import React, { useState, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useList } from '../../hooks/useList';
import { graphqlRequest } from '../../lib/api';
import Layout from '../../components/Layout';

interface NoticiaItem {
  id: string;
  titulo: string;
  subtitulo: string;
  slug: string;
  ativo: boolean;
  destaque: boolean;
  dataPublicacao: string;
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
}

/**
 * Formata data ISO para dd/mm/aaaa HH:mm
 */
function formatDate(iso: string | null | undefined): string {
  if (!iso) return '-';
  try {
    const d = new Date(iso);
    const pad = (n: number) => n.toString().padStart(2, '0');
    return `${pad(d.getDate())}/${pad(d.getMonth() + 1)}/${d.getFullYear()} ${pad(d.getHours())}:${pad(d.getMinutes())}`;
  } catch {
    return iso;
  }
}

/**
 * Página de listagem de Notícias com tabela, busca e paginação.
 */
export default function NoticiaList() {
  const navigate = useNavigate();
  const [searchTerm, setSearchTerm] = useState('');
  const [searchInput, setSearchInput] = useState('');

  const baseWhere = searchTerm
    ? { titulo: { contains: searchTerm, mode: 'insensitive' as const } }
    : undefined;

  const {
    data,
    loading,
    error,
    total,
    refetch,
    setSkip,
  } = useList({
    queryName: 'noticias',
    fields: 'id titulo subtitulo slug ativo destaque dataPublicacao areaResponsavel { id nome } subarea { id nome }',
    baseWhere,
    take: 10,
    skip: 0,
  });

  const noticias = (data as NoticiaItem[]) ?? [];
  const totalPages = Math.ceil(total / 10);
  const [currentPage, setCurrentPage] = useState(0);

  const handleSearch = useCallback(
    (e: React.FormEvent) => {
      e.preventDefault();
      setSearchTerm(searchInput);
      setSkip(0);
      setCurrentPage(0);
    },
    [searchInput, setSkip]
  );

  const handleClearSearch = useCallback(() => {
    setSearchInput('');
    setSearchTerm('');
    setSkip(0);
    setCurrentPage(0);
  }, [setSkip]);

  const handlePreviousPage = useCallback(() => {
    const newSkip = Math.max(0, currentPage - 1) * 10;
    setSkip(newSkip);
    setCurrentPage((prev) => Math.max(0, prev - 1));
  }, [currentPage, setSkip]);

  const handleNextPage = useCallback(() => {
    const newSkip = Math.min(totalPages - 1, currentPage + 1) * 10;
    setSkip(newSkip);
    setCurrentPage((prev) => Math.min(totalPages - 1, prev + 1));
  }, [currentPage, totalPages, setSkip]);

  const handleDelete = useCallback(
    async (noticia: NoticiaItem) => {
      if (!window.confirm(`Tem certeza que deseja excluir "${noticia.titulo}"?`)) return;
      try {
        await graphqlRequest(
          `mutation DeleteNoticia($id: ID!) {
            deleteNoticia(where: { id: $id }) { id }
          }`,
          { id: noticia.id }
        );
        refetch();
      } catch (err) {
        console.error('Erro ao excluir notícia:', err);
        alert('Erro ao excluir notícia');
      }
    },
    [refetch]
  );

  return (
    <Layout title="Notícias">
      <div className="space-y-6">
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm text-gray-500 mt-1">
              Total de {total} notícia(s) cadastrada(s)
            </p>
          </div>
          <button
            onClick={() => navigate('/noticias/novo')}
            className="inline-flex items-center gap-2 px-4 py-2 bg-[#003087] text-white font-medium rounded-lg hover:bg-[#001f54] transition-colors text-sm"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
            Nova Notícia
          </button>
        </div>

        {/* Search */}
        <form onSubmit={handleSearch} className="flex gap-2">
          <input
            type="text"
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            placeholder="Buscar por título..."
            className="flex-1 px-4 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-[#003087] focus:border-transparent outline-none"
          />
          <button
            type="submit"
            className="px-4 py-2 bg-gray-200 text-gray-700 font-medium rounded-lg hover:bg-gray-300 transition-colors text-sm"
          >
            Buscar
          </button>
          {searchTerm && (
            <button
              type="button"
              onClick={handleClearSearch}
              className="px-3 py-2 text-gray-500 hover:text-gray-700 text-sm"
            >
              Limpar
            </button>
          )}
        </form>

        {/* Error State */}
        {error && (
          <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
            <p className="text-sm text-red-700">{error}</p>
          </div>
        )}

        {/* Loading State */}
        {loading && (
          <div className="flex justify-center py-12">
            <div className="flex items-center gap-3 text-gray-500">
              <svg className="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
              </svg>
              <span>Carregando...</span>
            </div>
          </div>
        )}

        {/* Table */}
        {!loading && !error && (
          <>
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
              <table className="w-full">
                <thead>
                  <tr className="bg-gray-50 border-b border-gray-200">
                    <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Título</th>
                    <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Área</th>
                    <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Destaque</th>
                    <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Publicação</th>
                    <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Ativo</th>
                    <th className="text-right px-4 py-3 text-sm font-semibold text-gray-700">Ações</th>
                  </tr>
                </thead>
                <tbody>
                  {noticias.length === 0 ? (
                    <tr>
                      <td colSpan={6} className="px-4 py-8 text-center text-gray-500 text-sm">
                        Nenhuma notícia encontrada.
                      </td>
                    </tr>
                  ) : (
                    noticias.map((noticia) => (
                      <tr key={noticia.id} className="border-b border-gray-100 hover:bg-gray-50 transition-colors">
                        <td className="px-4 py-3">
                          <div>
                            <p className="text-sm font-medium text-gray-900">{noticia.titulo}</p>
                            {noticia.subtitulo && (
                              <p className="text-xs text-gray-500 mt-0.5 line-clamp-1">{noticia.subtitulo}</p>
                            )}
                          </div>
                        </td>
                        <td className="px-4 py-3 text-sm text-gray-600">
                          {noticia.areaResponsavel?.nome ?? '-'}
                        </td>
                        <td className="px-4 py-3 text-center">
                          {noticia.destaque ? (
                            <svg className="w-5 h-5 text-yellow-400 mx-auto" fill="currentColor" viewBox="0 0 20 20">
                              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                            </svg>
                          ) : (
                            <svg className="w-5 h-5 text-gray-300 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                            </svg>
                          )}
                        </td>
                        <td className="px-4 py-3 text-center text-sm text-gray-600 whitespace-nowrap">
                          {formatDate(noticia.dataPublicacao)}
                        </td>
                        <td className="px-4 py-3 text-center">
                          <span
                            className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                              noticia.ativo
                                ? 'bg-green-100 text-green-800'
                                : 'bg-gray-100 text-gray-600'
                            }`}
                          >
                            {noticia.ativo ? 'Ativo' : 'Inativo'}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <div className="flex items-center justify-end gap-2">
                            <button
                              onClick={() => navigate(`/noticias/${noticia.id}`)}
                              className="px-3 py-1.5 text-xs font-medium text-[#003087] bg-blue-50 rounded-lg hover:bg-blue-100 transition-colors"
                            >
                              Editar
                            </button>
                            <button
                              onClick={() => handleDelete(noticia)}
                              className="px-3 py-1.5 text-xs font-medium text-red-700 bg-red-50 rounded-lg hover:bg-red-100 transition-colors"
                            >
                              Excluir
                            </button>
                          </div>
                        </td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>

            {/* Pagination */}
            {totalPages > 1 && (
              <div className="flex items-center justify-between pt-2">
                <p className="text-sm text-gray-500">
                  Página {currentPage + 1} de {totalPages}
                </p>
                <div className="flex gap-2">
                  <button
                    onClick={handlePreviousPage}
                    disabled={currentPage === 0}
                    className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                  >
                    Anterior
                  </button>
                  <button
                    onClick={handleNextPage}
                    disabled={currentPage >= totalPages - 1}
                    className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                  >
                    Próximo
                  </button>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </Layout>
  );
}

