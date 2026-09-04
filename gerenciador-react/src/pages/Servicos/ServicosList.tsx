import { useList } from '@/hooks/useList';
import { DataTable, ActiveBadge } from '@/components/DataTable';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';

const FIELDS = 'id titulo slug resumo ativo areaResponsavel { id nome } subarea { id nome }';

export function ServicosList() {
  const { list, remove } = useList('servicos', { fields: FIELDS });

  const columns = [
    { key: 'titulo', header: 'Título', render: (v: string) => <span className="font-medium">{v}</span> },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? '-' },
    { key: 'ativo', header: 'Status', render: (_: any, item: any) => <ActiveBadge active={item.ativo} /> },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Serviços</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar serviços do portal</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/servicos"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default ServicosList;
