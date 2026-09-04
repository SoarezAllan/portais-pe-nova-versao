import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';

const FIELDS = 'id nome areaResponsavel { id nome }';

export function TagsList() {
  const { list, remove } = useList('tags', { fields: FIELDS });

  const columns = [
    { key: 'nome', header: 'Nome da Tag', render: (v: string) => <span className="font-medium text-blue-600">#{v}</span> },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? '-' },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Tags</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar marcadores de notícias e conteúdos</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/tags"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default TagsList;
