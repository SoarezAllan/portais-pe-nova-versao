import { Link } from 'react-router-dom';
import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Link2, ExternalLink } from 'lucide-react';

const FIELDS = 'id titulo status linkExterno resumo areaResponsavel { id nome }';

export function LinksUteisList() {
  const { list, remove } = useList('linksUteis', {
    fields: FIELDS,
    where: { status: { equals: 'LINK_UTIL' } },
  });

  const columns = [
    { key: 'titulo', header: 'Plataforma / Título', render: (v: string) => <span className="font-semibold text-slate-900">{v}</span> },
    {
      key: 'linkExterno',
      header: 'Link / URL',
      render: (v: string) => v ? (
        <a href={v} target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline flex items-center gap-1 text-xs">
          {v.length > 50 ? v.substring(0, 50) + '...' : v}
          <ExternalLink className="h-3 w-3" />
        </a>
      ) : '-',
    },
    { key: 'resumo', header: 'Descrição', render: (v: string) => <span className="text-xs text-slate-600 line-clamp-2">{v || '-'}</span> },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? 'Todas as Áreas' },
  ];

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h2 className="text-2xl font-bold text-gray-800">Links Úteis de Capacitação</h2>
          <p className="text-sm text-gray-500 mt-1">Gerencie plataformas, escolas de governo e links permanentes de capacitação</p>
        </div>
        <Link to="/links-uteis/novo">
          <Button className="gap-1.5 bg-[#003087] hover:bg-[#002266] text-white">
            <Link2 className="h-4 w-4" />
            + Novo Link Útil
          </Button>
        </Link>
      </div>

      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/links-uteis"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default LinksUteisList;
