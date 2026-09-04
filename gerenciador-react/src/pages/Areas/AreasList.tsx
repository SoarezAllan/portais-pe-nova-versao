import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';

const FIELDS = 'id nome';

export function AreasList() {
  const { list, remove } = useList('areas', { fields: FIELDS });

  const columns = [
    { key: 'nome', header: 'Nome da Área', render: (v: string) => <span className="font-medium text-slate-900">{v}</span> },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Áreas Responsáveis</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar áreas e secretarias</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/areas"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default AreasList;
