import { useList } from '@/hooks/useList';
import { DataTable, ActiveBadge } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';

const FIELDS = 'id titulo slug dataPublicacao destaque ativo areaResponsavel { id nome } tags { id nome }';

export function NoticiasList() {
  const { list, remove } = useList('noticias', { fields: FIELDS });

  const columns = [
    { key: 'titulo', header: 'Título', render: (v: string) => <span className="font-medium">{v}</span> },
    { key: 'dataPublicacao', header: 'Data', render: (v: string) => v ? new Date(v).toLocaleDateString('pt-BR') : '-' },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? '-' },
    { key: 'destaque', header: 'Destaque', render: (v: boolean) => v ? '⭐ Sim' : '-' },
    { key: 'ativo', header: 'Status', render: (_: any, item: any) => <ActiveBadge active={item.ativo} /> },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Notícias</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar notícias do portal</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/noticias"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default NoticiasList;
