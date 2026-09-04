import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { graphqlRequest } from '@/lib/api';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Globe,
  Newspaper,
  Gavel,
  GraduationCap,
  Loader2,
  Building2,
  Lightbulb,
  Tag,
  Shield,
  BarChart3,
  ArrowRight,
  TrendingUp,
} from 'lucide-react';
import { useAuth } from '@/hooks/useAuth';

export function DashboardPage() {
  const { user, isAdmin } = useAuth();

  const { data, isLoading } = useQuery({
    queryKey: ['dashboard-counts'],
    queryFn: async () => {
      const results = await Promise.all([
        graphqlRequest<{ count: number }>('query { count: servicosCount }'),
        graphqlRequest<{ count: number }>('query { count: noticiasCount }'),
        graphqlRequest<{ count: number }>('query { count: legislacoesCount }'),
        graphqlRequest<{ count: number }>('query { count: cursosCount }'),
        graphqlRequest<{ count: number }>('query { count: areasCount }'),
        graphqlRequest<{ count: number }>('query { count: solucoesCount }'),
        graphqlRequest<{ count: number }>('query { count: tagsCount }'),
        graphqlRequest<{ count: number }>('query { count: usersCount }'),
        graphqlRequest<{ count: number }>('query { count: acessosCount }').catch(() => ({ count: 0 })),
      ]);
      return {
        servicos: results[0].count,
        noticias: results[1].count,
        legislacao: results[2].count,
        cursos: results[3].count,
        areas: results[4].count,
        solucoes: results[5].count,
        tags: results[6].count,
        usuarios: results[7].count,
        acessos: results[8].count,
      };
    },
  });

  const stats = [
    { label: 'Acessos Registrados', value: data?.acessos ?? 0, icon: BarChart3, color: 'bg-indigo-50 text-indigo-600', ring: 'ring-indigo-100', link: '/indicadores' },
    { label: 'Serviços', value: data?.servicos ?? 0, icon: Globe, color: 'bg-blue-50 text-blue-600', ring: 'ring-blue-100', link: '/servicos' },
    { label: 'Notícias', value: data?.noticias ?? 0, icon: Newspaper, color: 'bg-emerald-50 text-emerald-600', ring: 'ring-emerald-100', link: '/noticias' },
    { label: 'Legislação', value: data?.legislacao ?? 0, icon: Gavel, color: 'bg-purple-50 text-purple-600', ring: 'ring-purple-100', link: '/legislacao' },
    { label: 'Cursos', value: data?.cursos ?? 0, icon: GraduationCap, color: 'bg-orange-50 text-orange-600', ring: 'ring-orange-100', link: '/cursos' },
    { label: 'Áreas', value: data?.areas ?? 0, icon: Building2, color: 'bg-cyan-50 text-cyan-600', ring: 'ring-cyan-100', link: '/areas' },
    { label: 'Soluções', value: data?.solucoes ?? 0, icon: Lightbulb, color: 'bg-amber-50 text-amber-600', ring: 'ring-amber-100', link: '/solucoes' },
    { label: 'Tags', value: data?.tags ?? 0, icon: Tag, color: 'bg-slate-50 text-slate-600', ring: 'ring-slate-100', link: '/tags' },
    { label: 'Usuários', value: data?.usuarios ?? 0, icon: Shield, color: 'bg-rose-50 text-rose-600', ring: 'ring-rose-100', link: '/usuarios' },
  ];

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900">Dashboard</h2>
          <p className="text-sm text-slate-500 mt-1">
            Bem-vindo, {user?.name}! Aqui está o resumo do conteúdo do portal.
          </p>
        </div>
        <Link to="/indicadores">
          <Button className="bg-indigo-600 hover:bg-indigo-700 text-white gap-2 shadow-sm">
            <BarChart3 className="h-4 w-4" />
            Ver Indicadores de Acesso
            <ArrowRight className="h-4 w-4" />
          </Button>
        </Link>
      </div>

      {isLoading ? (
        <div className="flex items-center justify-center py-12">
          <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {stats.map((stat) => (
            <Card key={stat.label} className="hover:shadow-md transition-shadow">
              <CardContent className="p-5">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-slate-500">{stat.label}</p>
                    <p className="text-3xl font-bold text-slate-900 mt-1">{stat.value}</p>
                  </div>
                  <div className={`p-3 rounded-xl ring-1 ${stat.color} ${stat.ring}`}>
                    <stat.icon className="h-6 w-6" />
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}

export default DashboardPage;
