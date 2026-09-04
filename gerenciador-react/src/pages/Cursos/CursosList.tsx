import { useState } from 'react';
import { Link } from 'react-router-dom';
import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { GraduationCap, Link2, ExternalLink, Plus } from 'lucide-react';

const CURSOS_FIELDS = 'id titulo modalidade dataDoCurso linkExterno local areaResponsavel { id nome } subarea { id nome }';
const LINKS_FIELDS = 'id titulo status linkExterno resumo areaResponsavel { id nome }';

export function CursosList() {
  const [activeTab, setActiveTab] = useState<'cursos' | 'links'>('cursos');

  const cursosList = useList('cursos', {
    fields: CURSOS_FIELDS,
    where: { status: { not: { equals: 'LINK_UTIL' } } },
  });

  const linksList = useList('linksUteis', {
    fields: LINKS_FIELDS,
    where: { status: { equals: 'LINK_UTIL' } },
  });

  const cursoColumns = [
    {
      key: 'titulo',
      header: 'Título do Curso',
      render: (v: string) => <span className="font-semibold text-slate-900">{v}</span>,
    },
    {
      key: 'modalidade',
      header: 'Modalidade',
      render: (v: string) => (
        <Badge variant="outline" className="font-normal text-xs">
          {v || 'Presencial'}
        </Badge>
      ),
    },
    {
      key: 'dataDoCurso',
      header: 'Data de Início',
      render: (v: string) => (v ? new Date(v).toLocaleDateString('pt-BR') : '-'),
    },
    { key: 'local', header: 'Local', render: (v: string) => v || '-' },
    { key: 'subarea', header: 'Subárea', render: (v: any) => v?.nome ?? '-' },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? '-' },
  ];

  const linkColumns = [
    {
      key: 'titulo',
      header: 'Plataforma / Título',
      render: (v: string) => <span className="font-semibold text-slate-900">{v}</span>,
    },
    {
      key: 'linkExterno',
      header: 'Link / URL',
      render: (v: string) =>
        v ? (
          <a
            href={v}
            target="_blank"
            rel="noopener noreferrer"
            className="text-blue-600 hover:underline flex items-center gap-1 text-xs"
          >
            {v.length > 45 ? v.substring(0, 45) + '...' : v}
            <ExternalLink className="h-3 w-3 flex-shrink-0" />
          </a>
        ) : (
          '-'
        ),
    },
    {
      key: 'resumo',
      header: 'Descrição',
      render: (v: string) => <span className="text-xs text-slate-600 line-clamp-2">{v || '-'}</span>,
    },
    {
      key: 'areaResponsavel',
      header: 'Área',
      render: (v: any) => v?.nome ?? 'Todas as Áreas',
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h2 className="text-2xl font-bold text-gray-800">Cursos e Capacitações</h2>
          <p className="text-sm text-gray-500 mt-1">
            Gerencie os cursos programados com turmas e os links úteis de capacitação
          </p>
        </div>

        {activeTab === 'cursos' ? (
          <Link to="/cursos/novo">
            <Button className="gap-1.5 bg-[#003087] hover:bg-[#002266] text-white">
              <Plus className="h-4 w-4" />
              Novo Curso
            </Button>
          </Link>
        ) : (
          <Link to="/links-uteis/novo">
            <Button className="gap-1.5 bg-[#003087] hover:bg-[#002266] text-white">
              <Plus className="h-4 w-4" />
              Novo Link Útil
            </Button>
          </Link>
        )}
      </div>

      {/* Tabs */}
      <div className="flex items-center gap-2 border-b border-gray-200">
        <button
          type="button"
          onClick={() => setActiveTab('cursos')}
          className={`flex items-center gap-2 px-4 py-3 text-sm font-semibold border-b-2 transition-colors ${
            activeTab === 'cursos'
              ? 'border-[#003087] text-[#003087]'
              : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
          }`}
        >
          <GraduationCap className="h-4 w-4" />
          Cursos Programados ({cursosList.list.data?.total ?? 0})
        </button>

        <button
          type="button"
          onClick={() => setActiveTab('links')}
          className={`flex items-center gap-2 px-4 py-3 text-sm font-semibold border-b-2 transition-colors ${
            activeTab === 'links'
              ? 'border-[#003087] text-[#003087]'
              : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
          }`}
        >
          <Link2 className="h-4 w-4" />
          Links Úteis ({linksList.list.data?.total ?? 0})
        </button>
      </div>

      {/* Conteúdo da Tab */}
      {activeTab === 'cursos' ? (
        <Card>
          <CardContent className="p-6">
            <DataTable
              columns={cursoColumns}
              data={cursosList.list.data?.items ?? []}
              total={cursosList.list.data?.total}
              loading={cursosList.list.isLoading}
              basePath="/cursos"
              onDelete={(id) => cursosList.remove.mutate(id)}
            />
          </CardContent>
        </Card>
      ) : (
        <Card>
          <CardContent className="p-6">
            <DataTable
              columns={linkColumns}
              data={linksList.list.data?.items ?? []}
              total={linksList.list.data?.total}
              loading={linksList.list.isLoading}
              basePath="/links-uteis"
              onDelete={(id) => linksList.remove.mutate(id)}
            />
          </CardContent>
        </Card>
      )}
    </div>
  );
}

export default CursosList;
