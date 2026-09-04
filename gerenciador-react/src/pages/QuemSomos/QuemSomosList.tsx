import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';

const FIELDS = 'id tituloDaPagina areaResponsavel { id nome } createdAt';

export function QuemSomosList() {
const { list, remove } = useList('quemSomos', { fields: FIELDS });

  const columns = [
    { key: 'tituloDaPagina', header: 'Título da Página', render: (v: string) => <span className="font-medium">{v || '-'}</span> },
    { key: 'areaResponsavel', header: 'Área', render: (v: any) => v?.nome ?? '-' },
    { key: 'createdAt', header: 'Criado em', render: (v: string) => v ? new Date(v).toLocaleDateString('pt-BR') : '-' },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Sobre</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar página Sobre</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/quem-somos"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default QuemSomosList;
