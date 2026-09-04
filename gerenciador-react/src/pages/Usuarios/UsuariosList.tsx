import { useList } from '@/hooks/useList';
import { DataTable } from '@/components/DataTable';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';

const FIELDS = 'id name email role areas { id nome }';

export function UsuariosList() {
  const { list, remove } = useList('usuarios', { fields: FIELDS });

  const columns = [
    { key: 'name', header: 'Nome', render: (v: string) => <span className="font-medium text-slate-900">{v}</span> },
    { key: 'email', header: 'E-mail' },
    {
      key: 'role',
      header: 'Papel',
      render: (v: string) => (
        <Badge variant={v === 'admin' ? 'default' : 'secondary'} className={v === 'admin' ? 'bg-blue-600' : ''}>
          {v === 'admin' ? 'Administrador' : 'Operador'}
        </Badge>
      ),
    },
    {
      key: 'areas',
      header: 'Áreas de Acesso',
      render: (areas: any[]) =>
        areas && areas.length > 0 ? (
          <div className="flex flex-wrap gap-1">
            {areas.map((a) => (
              <span key={a.id} className="text-xs bg-slate-100 px-2 py-0.5 rounded text-slate-700">
                {a.nome}
              </span>
            ))}
          </div>
        ) : (
          <span className="text-xs text-slate-400">Todas / Nenhuma</span>
        ),
    },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Usuários</h2>
        <p className="text-sm text-gray-500 mt-1">Gerenciar usuários com acesso ao painel administrativo</p>
      </div>
      <Card>
        <CardContent className="p-6">
          <DataTable
            columns={columns}
            data={list.data?.items ?? []}
            total={list.data?.total}
            loading={list.isLoading}
            basePath="/usuarios"
            onDelete={(id) => remove.mutate(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}

export default UsuariosList;
