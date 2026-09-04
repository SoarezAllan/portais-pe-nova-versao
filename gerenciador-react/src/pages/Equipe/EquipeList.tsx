import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';

const FIELDS = 'id nome cargo descricao foto { id url } areaResponsavel { id nome }';

export function EquipeList() {
  const { list, remove } = useList('equipe' as any, { fields: FIELDS });

  const columns = [
    {
      key: 'foto',
      header: 'Foto',
      render: (v: any) =>
        v?.url ? (
          <img src={v.url} alt="" className="h-10 w-10 rounded-full object-cover border" />
        ) : (
          <div className="h-10 w-10 rounded-full bg-slate-200 flex items-center justify-center text-slate-500 text-xs font-bold">
            -
          </div>
        ),
    },
    { key: 'nome', header: 'Nome', render: (v: string) => <span className="font-medium">{v}</span> },
    { key: 'cargo', header: 'Cargo' },
    { key: 'descricao', header: 'Descrição', render: (v: string) => <span className="text-slate-500 line-clamp-1">{v || '-'}</span> },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? '-' },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Equipe</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar membros da equipe e gestores do portal</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/equipe"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default EquipeList;
