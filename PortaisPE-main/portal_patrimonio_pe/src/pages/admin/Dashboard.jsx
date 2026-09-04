import { useAuth } from '../../lib/auth';
import Layout from '../../components/Layout';
import { useList } from '../../hooks/useList';
import Loading from '../../components/Loading';

export default function Dashboard() {
  const { user } = useAuth();

  const { total: servicosCount, loading: loadingServicos, error: errorServicos } = useList({
    queryName: 'servicos',
    fields: 'id',
    take: 1,
    skip: 0,
  });

  const { total: noticiasCount, loading: loadingNoticias, error: errorNoticias } = useList({
    queryName: 'noticias',
    fields: 'id',
    take: 1,
    skip: 0,
  });

  const { total: legislacoesCount, loading: loadingLegislacao, error: errorLegislacao } = useList({
    queryName: 'legislacoes',
    fields: 'id',
    take: 1,
    skip: 0,
  });

  const { total: cursosCount, loading: loadingCursos, error: errorCursos } = useList({
    queryName: 'cursos',
    fields: 'id',
    take: 1,
    skip: 0,
  });

  const { total: solucoesCount, loading: loadingSolucoes, error: errorSolucoes } = useList({
    queryName: 'solucoes',
    fields: 'id',
    take: 1,
    skip: 0,
  });

  const loading = loadingServicos || loadingNoticias || loadingLegislacao || loadingCursos || loadingSolucoes;

  const cards = [
    { label: 'Serviços', count: servicosCount, color: 'bg-blue-500', error: errorServicos },
    { label: 'Notícias', count: noticiasCount, color: 'bg-green-500', error: errorNoticias },
    { label: 'Legislação', count: legislacoesCount, color: 'bg-amber-500', error: errorLegislacao },
    { label: 'Cursos', count: cursosCount, color: 'bg-purple-500', error: errorCursos },
    { label: 'Soluções', count: solucoesCount, color: 'bg-teal-500', error: errorSolucoes },
  ];

  return (
    <Layout title="Dashboard">
      <div className="space-y-6">
        {/* Boas-vindas */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <h1 className="text-2xl font-bold text-gray-900">
            Bem-vindo, {user?.name?.split(' ')[0] ?? 'Usuário'}!
          </h1>
          <p className="text-sm text-gray-500 mt-1">
            {user?.role === 'admin' ? 'Administrador' : 'Operador'} &middot; {user?.email}
          </p>
        </div>

        {loading ? (
          <Loading message="Carregando dashboard..." />
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {cards.map((card) => (
              <div key={card.label} className="bg-white rounded-xl shadow-sm border border-gray-200 p-5">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-gray-500">{card.label}</p>
                    <p className="text-3xl font-bold text-gray-900 mt-1">
                      {card.error ? (
                        <span className="text-sm text-red-500 font-normal">Erro</span>
                      ) : (
                        card.count.toLocaleString('pt-BR')
                      )}
                    </p>
                  </div>
                  <div className={`w-10 h-10 rounded-lg ${card.color} flex items-center justify-center`}>
                    <span className="text-white font-bold text-lg">
                      {card.label.charAt(0)}
                    </span>
                  </div>
                </div>
                <p className="text-xs text-gray-400 mt-3">Total de registros cadastrados</p>
              </div>
            ))}
          </div>
        )}
      </div>
    </Layout>
  );
}
