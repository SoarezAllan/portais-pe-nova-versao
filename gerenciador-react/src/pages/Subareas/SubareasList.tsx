import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';

const FIELDS = 'id nome area { id nome }';

export function SubareasList() {
  const { list, remove } = useList('subareas', { fields: FIELDS });

  const columns = [
    { key: 'nome', header: 'Subárea', render: (v: string) => <span className="font-medium text-slate-900">{v}</span> },
    { key: 'area', header: 'Área Vinculada', render: (v: any) => v?.nome ?? '-' },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Subáreas</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar subáreas das áreas responsáveis</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/subareas"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default SubareasList;
