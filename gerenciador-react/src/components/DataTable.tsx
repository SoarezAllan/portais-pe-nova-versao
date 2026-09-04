import React, { useState, useMemo } from 'react';
import { Table, TableHeader, TableBody, TableRow, TableHead, TableCell } from './ui/table';
import { Button } from './ui/button';
import { Badge } from './ui/badge';
import {
  Loader2,
  Plus,
  Pencil,
  Trash2,
  Eye,
  EyeOff,
  Search,
  Filter,
  X,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  ChevronLeft,
  ChevronRight,
  ChevronsLeft,
  ChevronsRight,
  Layers,
  AlertTriangle,
} from 'lucide-react';
import { Link } from 'react-router-dom';

export interface Column {
  key: string;
  header: string;
  sortable?: boolean;
  render?: (value: any, item: any) => React.ReactNode;
}

export interface DataTableProps {
  columns: Column[];
  data: any[];
  loading?: boolean;
  total?: number;
  basePath: string;
  onDelete?: (id: string) => void;
  filterPlaceholder?: string;
  customFilters?: React.ReactNode;
}

export function DataTable({
  columns,
  data,
  loading,
  total,
  basePath,
  onDelete,
  filterPlaceholder = 'Buscar por texto...',
  customFilters,
}: DataTableProps) {
  // Estados de Filtros
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedArea, setSelectedArea] = useState('ALL');
  const [selectedSubarea, setSelectedSubarea] = useState('ALL');
  const [selectedStatus, setSelectedStatus] = useState('ALL');
  const [selectedCategoria, setSelectedCategoria] = useState('ALL');
  const [selectedRole, setSelectedRole] = useState('ALL');

  // Modal de Confirmação de Exclusão
  const [itemToDelete, setItemToDelete] = useState<{ id: string; title: string } | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  // Estados de Ordenação e Paginação
  const [sortKey, setSortKey] = useState<string | null>(null);
  const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('asc');
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(15);

  // Extrair opções únicas dinâmicas a partir dos dados
  const { areas, subareas, categorias, roles, hasArea, hasSubarea, hasStatus, hasCategoria, hasRole } =
    useMemo(() => {
      const areaSet = new Set<string>();
      const subareaSet = new Set<string>();
      const catSet = new Set<string>();
      const roleSet = new Set<string>();

      let hArea = false;
      let hSub = false;
      let hStatus = false;
      let hCat = false;
      let hRole = false;

      data.forEach((item) => {
        // Área
        const areaNome = item.areaResponsavel?.nome || item.area?.nome;
        if (areaNome) {
          hArea = true;
          areaSet.add(areaNome);
        }

        // Subárea
        const subNome = item.subarea?.nome;
        if (subNome) {
          hSub = true;
          if (selectedArea === 'ALL' || areaNome === selectedArea) {
            subareaSet.add(subNome);
          }
        }

        // Status
        if (typeof item.ativo === 'boolean') {
          hStatus = true;
        }

        // Categoria / Modalidade / Operação
        const cat = item.categoria || item.modalidade || item.operacao || item.tabela;
        if (cat) {
          hCat = true;
          catSet.add(String(cat));
        }

        // Papel / Role
        if (item.role) {
          hRole = true;
          roleSet.add(String(item.role));
        }
      });

      return {
        areas: Array.from(areaSet).sort(),
        subareas: Array.from(subareaSet).sort(),
        categorias: Array.from(catSet).sort(),
        roles: Array.from(roleSet).sort(),
        hasArea: hArea,
        hasSubarea: hSub,
        hasStatus: hStatus,
        hasCategoria: hCat,
        hasRole: hRole,
      };
    }, [data, selectedArea]);

  // Filtragem dos dados
  const filteredData = useMemo(() => {
    return data.filter((item) => {
      // 1. Busca textual
      if (searchTerm.trim()) {
        const query = searchTerm.toLowerCase().trim();
        const matches = Object.values(item).some((val) => {
          if (val === null || val === undefined) return false;
          if (typeof val === 'object') {
            const obj = val as Record<string, any>;
            if (obj.nome) return String(obj.nome).toLowerCase().includes(query);
            if (obj.titulo) return String(obj.titulo).toLowerCase().includes(query);
            return false;
          }
          return String(val).toLowerCase().includes(query);
        });
        if (!matches) return false;
      }

      // 2. Filtro de Área
      if (hasArea && selectedArea !== 'ALL') {
        const itemArea = item.areaResponsavel?.nome || item.area?.nome;
        if (itemArea !== selectedArea) return false;
      }

      // 3. Filtro de Subárea
      if (hasSubarea && selectedSubarea !== 'ALL') {
        const itemSub = item.subarea?.nome;
        if (itemSub !== selectedSubarea) return false;
      }

      // 4. Filtro de Status (Ativo / Inativo)
      if (hasStatus && selectedStatus !== 'ALL') {
        const isAtivo = selectedStatus === 'ATIVO';
        if (item.ativo !== isAtivo) return false;
      }

      // 5. Filtro de Categoria / Modalidade / Operação
      if (hasCategoria && selectedCategoria !== 'ALL') {
        const itemCat = item.categoria || item.modalidade || item.operacao || item.tabela;
        if (String(itemCat) !== selectedCategoria) return false;
      }

      // 6. Filtro de Role
      if (hasRole && selectedRole !== 'ALL') {
        if (String(item.role) !== selectedRole) return false;
      }

      return true;
    });
  }, [
    data,
    searchTerm,
    selectedArea,
    selectedSubarea,
    selectedStatus,
    selectedCategoria,
    selectedRole,
    hasArea,
    hasSubarea,
    hasStatus,
    hasCategoria,
    hasRole,
  ]);

  // Ordenação dos dados
  const sortedData = useMemo(() => {
    if (!sortKey) return filteredData;
    return [...filteredData].sort((a, b) => {
      let aVal = a[sortKey];
      let bVal = b[sortKey];

      if (aVal && typeof aVal === 'object') aVal = aVal.nome || aVal.titulo || '';
      if (bVal && typeof bVal === 'object') bVal = bVal.nome || bVal.titulo || '';

      if (typeof aVal === 'string') aVal = aVal.toLowerCase();
      if (typeof bVal === 'string') bVal = bVal.toLowerCase();

      if (aVal < bVal) return sortDirection === 'asc' ? -1 : 1;
      if (aVal > bVal) return sortDirection === 'asc' ? 1 : -1;
      return 0;
    });
  }, [filteredData, sortKey, sortDirection]);

  // Paginação
  const totalPages = Math.ceil(sortedData.length / pageSize) || 1;
  const paginatedData = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return sortedData.slice(start, start + pageSize);
  }, [sortedData, currentPage, pageSize]);

  // Contador de filtros ativos
  const activeFiltersCount =
    (searchTerm ? 1 : 0) +
    (selectedArea !== 'ALL' ? 1 : 0) +
    (selectedSubarea !== 'ALL' ? 1 : 0) +
    (selectedStatus !== 'ALL' ? 1 : 0) +
    (selectedCategoria !== 'ALL' ? 1 : 0) +
    (selectedRole !== 'ALL' ? 1 : 0);

  const resetFilters = () => {
    setSearchTerm('');
    setSelectedArea('ALL');
    setSelectedSubarea('ALL');
    setSelectedStatus('ALL');
    setSelectedCategoria('ALL');
    setSelectedRole('ALL');
    setCurrentPage(1);
  };

  const handleSort = (key: string) => {
    if (sortKey === key) {
      if (sortDirection === 'asc') setSortDirection('desc');
      else {
        setSortKey(null);
        setSortDirection('asc');
      }
    } else {
      setSortKey(key);
      setSortDirection('asc');
    }
  };

  const handleConfirmDelete = async () => {
    if (!itemToDelete || !onDelete) return;
    try {
      setIsDeleting(true);
      await onDelete(itemToDelete.id);
      setItemToDelete(null);
    } finally {
      setIsDeleting(false);
    }
  };

  const getItemDisplayName = (item: any) => {
    return (
      item.titulo ||
      item.name ||
      item.nome ||
      item.tituloDaPagina ||
      item.itemTitulo ||
      item.email ||
      `registro #${item.id}`
    );
  };

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-slate-500">
        <Loader2 className="h-8 w-8 animate-spin text-[#003087] mb-2" />
        <span className="text-sm font-medium">Carregando registros...</span>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {/* Barra de Filtros e Busca */}
      <div className="bg-slate-50/80 p-3.5 rounded-xl border border-slate-200/80 space-y-3">
        <div className="flex flex-col md:flex-row items-stretch md:items-center justify-between gap-3">
          {/* Busca por Texto */}
          <div className="relative flex-1 min-w-[240px]">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
            <input
              type="text"
              value={searchTerm}
              onChange={(e) => {
                setSearchTerm(e.target.value);
                setCurrentPage(1);
              }}
              placeholder={filterPlaceholder}
              className="w-full pl-9 pr-8 py-2 bg-white border border-slate-200 rounded-lg text-sm placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-[#003087] focus:border-transparent transition-all"
            />
            {searchTerm && (
              <button
                type="button"
                onClick={() => setSearchTerm('')}
                className="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 p-0.5"
              >
                <X className="h-3.5 w-3.5" />
              </button>
            )}
          </div>

          {/* Botão Novo */}
          <Link to={`${basePath}/novo`}>
            <Button size="sm" className="bg-[#003087] hover:bg-[#002266] text-white shadow-sm w-full md:w-auto">
              <Plus className="h-4 w-4 mr-1.5" />
              Novo Registro
            </Button>
          </Link>
        </div>

        {/* Dropdowns de Filtros Rápidos */}
        {(hasArea || hasSubarea || hasStatus || hasCategoria || hasRole || customFilters) && (
          <div className="flex flex-wrap items-center gap-2 pt-1 border-t border-slate-200/60">
            <div className="flex items-center gap-1.5 text-xs font-semibold text-slate-500 uppercase tracking-wider mr-1">
              <Filter className="h-3.5 w-3.5 text-[#003087]" />
              Filtros:
            </div>

            {/* Filtro de Área */}
            {hasArea && areas.length > 0 && (
              <select
                value={selectedArea}
                onChange={(e) => {
                  setSelectedArea(e.target.value);
                  setSelectedSubarea('ALL');
                  setCurrentPage(1);
                }}
                className="text-xs bg-white border border-slate-200 rounded-lg px-2.5 py-1.5 text-slate-700 font-medium focus:ring-2 focus:ring-[#003087] focus:outline-none transition-all shadow-sm cursor-pointer"
              >
                <option value="ALL">🏛️ Todas as Áreas</option>
                {areas.map((a) => (
                  <option key={a} value={a}>
                    {a}
                  </option>
                ))}
              </select>
            )}

            {/* Filtro de Subárea */}
            {hasSubarea && subareas.length > 0 && (
              <select
                value={selectedSubarea}
                onChange={(e) => {
                  setSelectedSubarea(e.target.value);
                  setCurrentPage(1);
                }}
                className="text-xs bg-white border border-slate-200 rounded-lg px-2.5 py-1.5 text-slate-700 font-medium focus:ring-2 focus:ring-[#003087] focus:outline-none transition-all shadow-sm cursor-pointer"
              >
                <option value="ALL">📁 Todas as Subáreas</option>
                {subareas.map((s) => (
                  <option key={s} value={s}>
                    {s}
                  </option>
                ))}
              </select>
            )}

            {/* Filtro de Status */}
            {hasStatus && (
              <select
                value={selectedStatus}
                onChange={(e) => {
                  setSelectedStatus(e.target.value);
                  setCurrentPage(1);
                }}
                className="text-xs bg-white border border-slate-200 rounded-lg px-2.5 py-1.5 text-slate-700 font-medium focus:ring-2 focus:ring-[#003087] focus:outline-none transition-all shadow-sm cursor-pointer"
              >
                <option value="ALL">🔘 Todos os Status</option>
                <option value="ATIVO">🟢 Apenas Ativos</option>
                <option value="INATIVO">🔴 Apenas Inativos</option>
              </select>
            )}

            {/* Filtro de Categoria / Modalidade */}
            {hasCategoria && categorias.length > 0 && (
              <select
                value={selectedCategoria}
                onChange={(e) => {
                  setSelectedCategoria(e.target.value);
                  setCurrentPage(1);
                }}
                className="text-xs bg-white border border-slate-200 rounded-lg px-2.5 py-1.5 text-slate-700 font-medium focus:ring-2 focus:ring-[#003087] focus:outline-none transition-all shadow-sm cursor-pointer"
              >
                <option value="ALL">📑 Todas as Categorias</option>
                {categorias.map((c) => (
                  <option key={c} value={c}>
                    {c}
                  </option>
                ))}
              </select>
            )}

            {/* Filtro de Papel (Role) */}
            {hasRole && roles.length > 0 && (
              <select
                value={selectedRole}
                onChange={(e) => {
                  setSelectedRole(e.target.value);
                  setCurrentPage(1);
                }}
                className="text-xs bg-white border border-slate-200 rounded-lg px-2.5 py-1.5 text-slate-700 font-medium focus:ring-2 focus:ring-[#003087] focus:outline-none transition-all shadow-sm cursor-pointer"
              >
                <option value="ALL">🛡️ Todos os Papéis</option>
                {roles.map((r) => (
                  <option key={r} value={r}>
                    {r === 'admin' ? 'Administrador' : r}
                  </option>
                ))}
              </select>
            )}

            {customFilters}

            {/* Botão de Limpar Filtros */}
            {activeFiltersCount > 0 && (
              <Button
                variant="ghost"
                size="sm"
                onClick={resetFilters}
                className="h-7 text-xs text-rose-600 hover:text-rose-700 hover:bg-rose-50 px-2 ml-auto"
              >
                <X className="h-3.5 w-3.5 mr-1" />
                Limpar ({activeFiltersCount})
              </Button>
            )}
          </div>
        )}
      </div>

      {/* Estatísticas e Informação de Exibição */}
      <div className="flex items-center justify-between px-1 text-xs text-slate-500">
        <div>
          Exibindo <span className="font-semibold text-slate-700">{filteredData.length}</span> de{' '}
          <span className="font-semibold text-slate-700">{total !== undefined ? total : data.length}</span> registro(s)
          {activeFiltersCount > 0 && (
            <span className="ml-1 text-[#003087] font-medium">(filtrado)</span>
          )}
        </div>

        {/* Itens por página */}
        <div className="flex items-center gap-1.5">
          <span>Exibir:</span>
          <select
            value={pageSize}
            onChange={(e) => {
              setPageSize(Number(e.target.value));
              setCurrentPage(1);
            }}
            className="text-xs bg-white border border-slate-200 rounded px-1.5 py-0.5 text-slate-700 focus:outline-none focus:ring-1 focus:ring-[#003087]"
          >
            <option value={10}>10</option>
            <option value={15}>15</option>
            <option value={25}>25</option>
            <option value={50}>50</option>
            <option value={100}>100</option>
          </select>
        </div>
      </div>

      {/* Tabela de Dados */}
      {paginatedData.length === 0 ? (
        <div className="text-center py-16 border rounded-xl bg-slate-50/40 text-slate-500">
          <Layers className="h-10 w-10 mx-auto text-slate-300 mb-2" />
          <p className="font-medium text-slate-700">Nenhum registro encontrado</p>
          <p className="text-xs text-slate-400 mt-0.5">
            {activeFiltersCount > 0
              ? 'Tente alterar os filtros aplicados ou termo de busca.'
              : 'Clique em "Novo Registro" para cadastrar o primeiro item.'}
          </p>
          {activeFiltersCount > 0 ? (
            <Button variant="outline" size="sm" onClick={resetFilters} className="mt-3 text-xs">
              Limpar Filtros
            </Button>
          ) : (
            <Link to={`${basePath}/novo`} className="mt-3 inline-block">
              <Button size="sm" className="bg-[#003087] hover:bg-[#002266] text-white text-xs">
                <Plus className="h-3.5 w-3.5 mr-1" />
                Criar primeiro registro
              </Button>
            </Link>
          )}
        </div>
      ) : (
        <div className="rounded-xl border border-slate-200 bg-white overflow-hidden shadow-sm">
          <div className="overflow-x-auto">
            <Table>
              <TableHeader className="bg-slate-50/90 border-b border-slate-200">
                <TableRow>
                  {columns.map((col) => {
                    const isSorted = sortKey === col.key;
                    return (
                      <TableHead
                        key={col.key}
                        onClick={() => handleSort(col.key)}
                        className="text-xs font-bold uppercase tracking-wider text-slate-600 cursor-pointer select-none hover:bg-slate-100/80 transition-colors py-3"
                      >
                        <div className="flex items-center gap-1.5">
                          {col.header}
                          {isSorted ? (
                            sortDirection === 'asc' ? (
                              <ArrowUp className="h-3.5 w-3.5 text-[#003087]" />
                            ) : (
                              <ArrowDown className="h-3.5 w-3.5 text-[#003087]" />
                            )
                          ) : (
                            <ArrowUpDown className="h-3 w-3 text-slate-300 opacity-60 hover:opacity-100" />
                          )}
                        </div>
                      </TableHead>
                    );
                  })}
                  <TableHead className="w-[100px] text-right text-xs font-bold uppercase tracking-wider text-slate-600 py-3">
                    Ações
                  </TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {paginatedData.map((item) => (
                  <TableRow key={item.id} className="hover:bg-slate-50/70 transition-colors">
                    {columns.map((col) => (
                      <TableCell key={col.key} className="py-3 text-sm">
                        {col.render ? col.render(item[col.key], item) : item[col.key] ?? '-'}
                      </TableCell>
                    ))}
                    <TableCell className="text-right py-3">
                      <div className="flex items-center justify-end gap-1">
                        <Link to={`${basePath}/${item.id}`}>
                          <Button
                            variant="ghost"
                            size="icon"
                            className="h-8 w-8 text-slate-600 hover:text-[#003087] hover:bg-slate-100"
                            title="Editar"
                          >
                            <Pencil className="h-4 w-4" />
                          </Button>
                        </Link>
                        {onDelete && (
                          <Button
                            variant="ghost"
                            size="icon"
                            className="h-8 w-8 text-slate-400 hover:text-rose-600 hover:bg-rose-50"
                            onClick={() =>
                              setItemToDelete({
                                id: item.id,
                                title: getItemDisplayName(item),
                              })
                            }
                            title="Excluir"
                          >
                            <Trash2 className="h-4 w-4" />
                          </Button>
                        )}
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>

          {/* Paginação */}
          {totalPages > 1 && (
            <div className="flex flex-col sm:flex-row items-center justify-between gap-2 p-3 bg-slate-50/50 border-t border-slate-100 text-xs text-slate-600">
              <div>
                Página <span className="font-semibold text-slate-800">{currentPage}</span> de{' '}
                <span className="font-semibold text-slate-800">{totalPages}</span>
              </div>
              <div className="flex items-center gap-1">
                <Button
                  variant="outline"
                  size="icon"
                  className="h-7 w-7"
                  disabled={currentPage === 1}
                  onClick={() => setCurrentPage(1)}
                  title="Primeira página"
                >
                  <ChevronsLeft className="h-3.5 w-3.5" />
                </Button>
                <Button
                  variant="outline"
                  size="icon"
                  className="h-7 w-7"
                  disabled={currentPage === 1}
                  onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
                  title="Página anterior"
                >
                  <ChevronLeft className="h-3.5 w-3.5" />
                </Button>

                {/* Indicador de página atual */}
                <span className="px-2.5 py-1 font-semibold text-xs text-slate-700 bg-white border rounded">
                  {currentPage}
                </span>

                <Button
                  variant="outline"
                  size="icon"
                  className="h-7 w-7"
                  disabled={currentPage === totalPages}
                  onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
                  title="Próxima página"
                >
                  <ChevronRight className="h-3.5 w-3.5" />
                </Button>
                <Button
                  variant="outline"
                  size="icon"
                  className="h-7 w-7"
                  disabled={currentPage === totalPages}
                  onClick={() => setCurrentPage(totalPages)}
                  title="Última página"
                >
                  <ChevronsRight className="h-3.5 w-3.5" />
                </Button>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Modal de Confirmação de Exclusão */}
      {itemToDelete && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-in fade-in duration-200">
          <div
            className="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl border border-slate-100 space-y-4 animate-in zoom-in-95 duration-200"
            role="dialog"
            aria-modal="true"
          >
            <div className="flex items-center gap-3 text-rose-600">
              <div className="p-3 bg-rose-50 rounded-xl">
                <AlertTriangle className="h-6 w-6 text-rose-600" />
              </div>
              <div>
                <h3 className="text-lg font-bold text-slate-900">Confirmar Exclusão</h3>
                <p className="text-xs text-slate-500">Esta ação é irreversível</p>
              </div>
            </div>

            <div className="p-3.5 bg-slate-50 rounded-xl border border-slate-100 text-sm text-slate-700 leading-relaxed">
              Tem certeza que deseja excluir{' '}
              <span className="font-bold text-slate-900 break-words">"{itemToDelete.title}"</span>?
              <br />
              <span className="text-xs text-rose-600 font-medium mt-1 inline-block">
                ⚠️ Isso não poderá ser desfeito e o item será removido permanentemente.
              </span>
            </div>

            <div className="flex items-center justify-end gap-2.5 pt-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setItemToDelete(null)}
                disabled={isDeleting}
                className="text-slate-600 hover:bg-slate-100"
              >
                Cancelar
              </Button>
              <Button
                size="sm"
                onClick={handleConfirmDelete}
                disabled={isDeleting}
                className="bg-rose-600 hover:bg-rose-700 text-white shadow-sm"
              >
                {isDeleting ? (
                  <>
                    <Loader2 className="h-4 w-4 animate-spin mr-1.5" /> Excluindo...
                  </>
                ) : (
                  <>
                    <Trash2 className="h-4 w-4 mr-1.5" /> Sim, Excluir
                  </>
                )}
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export function ActiveBadge({ active }: { active: boolean }) {
  return (
    <Badge variant={active ? 'success' : 'secondary'} className="text-[11px] font-semibold py-0.5">
      {active ? (
        <>
          <Eye className="h-3 w-3 mr-1 text-emerald-600" /> Ativo
        </>
      ) : (
        <>
          <EyeOff className="h-3 w-3 mr-1 text-slate-400" /> Inativo
        </>
      )}
    </Badge>
  );
}
