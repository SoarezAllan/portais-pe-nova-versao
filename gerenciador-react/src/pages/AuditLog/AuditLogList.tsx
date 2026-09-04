import { useList } from '@/hooks/useList';
import { Card, CardContent } from '@/components/ui/card';
import { Loader2 } from 'lucide-react';
import { Badge } from '@/components/ui/badge';

const FIELDS = 'id dataAcao usuario operacao tabela itemId itemTitulo mudancas';

export function AuditLogList() {
  const { list } = useList('auditLogs', { fields: FIELDS, orderBy: { dataAcao: 'desc' } });

  const items = list.data?.items ?? [];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-800">Trilha de Auditoria (Audit Log)</h2>
        <p className="text-sm text-gray-500 mt-1">Registro de ações, alterações e criações realizadas no sistema</p>
      </div>

      <Card>
        <CardContent className="p-6">
          {list.isLoading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
            </div>
          ) : items.length === 0 ? (
            <div className="text-center py-12 text-slate-500 text-sm">
              Nenhum registro de auditoria encontrado.
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm text-left">
                <thead className="bg-slate-50 text-slate-700 font-semibold border-b">
                  <tr>
                    <th className="px-4 py-3">Data / Hora</th>
                    <th className="px-4 py-3">Usuário</th>
                    <th className="px-4 py-3">Operação</th>
                    <th className="px-4 py-3">Tabela</th>
                    <th className="px-4 py-3">Item</th>
                    <th className="px-4 py-3">Detalhes</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {items.map((log: any) => (
                    <tr key={log.id} className="hover:bg-slate-50">
                      <td className="px-4 py-3 text-slate-500 text-xs whitespace-nowrap">
                        {log.dataAcao ? new Date(log.dataAcao).toLocaleString('pt-BR') : '-'}
                      </td>
                      <td className="px-4 py-3 font-medium text-slate-900">{log.usuario || 'Sistema'}</td>
                      <td className="px-4 py-3">
                        <Badge variant="outline" className="text-xs">
                          {log.operacao || 'ALTERAÇÃO'}
                        </Badge>
                      </td>
                      <td className="px-4 py-3 text-slate-600">{log.tabela}</td>
                      <td className="px-4 py-3 text-slate-900">{log.itemTitulo || log.itemId}</td>
                      <td className="px-4 py-3 text-slate-500 text-xs font-mono max-w-xs truncate">{log.mudancas || '-'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

export default AuditLogList;
