import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Toaster } from 'react-hot-toast';
import { AuthProvider } from '@/hooks/useAuth';
import { Layout } from '@/components/Layout';
import { LoginPage } from '@/pages/Login/LoginPage';
import { DashboardPage } from '@/pages/Dashboard/DashboardPage';
import { ServicosList } from '@/pages/Servicos/ServicosList';
import { ServicosForm } from '@/pages/Servicos/ServicosForm';
import { NoticiasList } from '@/pages/Noticias/NoticiasList';
import { NoticiasForm } from '@/pages/Noticias/NoticiasForm';
import { LegislacaoList } from '@/pages/Legislacao/LegislacaoList';
import { LegislacaoForm } from '@/pages/Legislacao/LegislacaoForm';
import { CursosList } from '@/pages/Cursos/CursosList';
import { CursosForm } from '@/pages/Cursos/CursosForm';
import { LinksUteisList } from '@/pages/LinksUteis/LinksUteisList';
import { LinksUteisForm } from '@/pages/LinksUteis/LinksUteisForm';
import { QuemSomosList } from '@/pages/QuemSomos/QuemSomosList';
import { QuemSomosForm } from '@/pages/QuemSomos/QuemSomosForm';
import { EquipeList } from '@/pages/Equipe/EquipeList';
import { EquipeForm } from '@/pages/Equipe/EquipeForm';
import { AreasList } from '@/pages/Areas/AreasList';
import { AreasForm } from '@/pages/Areas/AreasForm';
import { SubareasList } from '@/pages/Subareas/SubareasList';
import { SubareasForm } from '@/pages/Subareas/SubareasForm';
import { SolucoesList } from '@/pages/Solucoes/SolucoesList';
import { SolucoesForm } from '@/pages/Solucoes/SolucoesForm';
import { TagsList } from '@/pages/Tags/TagsList';
import { TagsForm } from '@/pages/Tags/TagsForm';
import { PortfolioList } from '@/pages/Portfolio/PortfolioList';
import { PortfolioForm } from '@/pages/Portfolio/PortfolioForm';
import { UsuariosList } from '@/pages/Usuarios/UsuariosList';
import { UsuariosForm } from '@/pages/Usuarios/UsuariosForm';
import { AuditLogList } from '@/pages/AuditLog/AuditLogList';
import { IndicadoresPage } from '@/pages/Indicadores/IndicadoresPage';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 1,
      refetchOnWindowFocus: false,
      staleTime: 60_000,
    },
  },
});

function AppRoutes() {
  return (
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/" element={<Layout />}>
        <Route index element={<Navigate to="/dashboard" replace />} />
        <Route path="dashboard" element={<DashboardPage />} />
        <Route path="indicadores" element={<IndicadoresPage />} />
        
        {/* Áreas */}
        <Route path="areas" element={<AreasList />} />
        <Route path="areas/novo" element={<AreasForm />} />
        <Route path="areas/:id" element={<AreasForm />} />

        {/* Subáreas */}
        <Route path="subareas" element={<SubareasList />} />
        <Route path="subareas/novo" element={<SubareasForm />} />
        <Route path="subareas/:id" element={<SubareasForm />} />

        {/* Equipe */}
        <Route path="equipe" element={<EquipeList />} />
        <Route path="equipe/novo" element={<EquipeForm />} />
        <Route path="equipe/:id" element={<EquipeForm />} />
        <Route path="gestores" element={<Navigate to="/equipe" replace />} />
        <Route path="gestores/*" element={<Navigate to="/equipe" replace />} />

        {/* Serviços */}
        <Route path="servicos" element={<ServicosList />} />
        <Route path="servicos/novo" element={<ServicosForm />} />
        <Route path="servicos/:id" element={<ServicosForm />} />
        
        {/* Notícias */}
        <Route path="noticias" element={<NoticiasList />} />
        <Route path="noticias/novo" element={<NoticiasForm />} />
        <Route path="noticias/:id" element={<NoticiasForm />} />
        
        {/* Legislação */}
        <Route path="legislacao" element={<LegislacaoList />} />
        <Route path="legislacao/novo" element={<LegislacaoForm />} />
        <Route path="legislacao/:id" element={<LegislacaoForm />} />
        
        {/* Cursos */}
        <Route path="cursos" element={<CursosList />} />
        <Route path="cursos/novo" element={<CursosForm />} />
        <Route path="cursos/:id" element={<CursosForm />} />

        {/* Links Úteis */}
        <Route path="links-uteis" element={<LinksUteisList />} />
        <Route path="links-uteis/novo" element={<LinksUteisForm />} />
        <Route path="links-uteis/:id" element={<LinksUteisForm />} />

        {/* Soluções */}
        <Route path="solucoes" element={<SolucoesList />} />
        <Route path="solucoes/novo" element={<SolucoesForm />} />
        <Route path="solucoes/:id" element={<SolucoesForm />} />

        {/* Quem Somos */}
        <Route path="quem-somos" element={<QuemSomosList />} />
        <Route path="quem-somos/novo" element={<QuemSomosForm />} />
        <Route path="quem-somos/:id" element={<QuemSomosForm />} />

        {/* Tags */}
        <Route path="tags" element={<TagsList />} />
        <Route path="tags/novo" element={<TagsForm />} />
        <Route path="tags/:id" element={<TagsForm />} />

        {/* Portfólio */}
        <Route path="portfolio" element={<PortfolioList />} />
        <Route path="portfolio/novo" element={<PortfolioForm />} />
        <Route path="portfolio/:id" element={<PortfolioForm />} />

        {/* Usuários */}
        <Route path="usuarios" element={<UsuariosList />} />
        <Route path="usuarios/novo" element={<UsuariosForm />} />
        <Route path="usuarios/:id" element={<UsuariosForm />} />

        {/* Auditoria */}
        <Route path="auditoria" element={<AuditLogList />} />

        {/* Fallback */}
        <Route path="*" element={<Navigate to="/dashboard" replace />} />
      </Route>
    </Routes>
  );
}

export function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <BrowserRouter future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
        <AuthProvider>
          <AppRoutes />
          <Toaster
            position="top-right"
            toastOptions={{
              duration: 4000,
              style: {
                background: '#333',
                color: '#fff',
              },
              success: {
                duration: 3000,
                iconTheme: {
                  primary: '#10B981',
                  secondary: '#fff',
                },
              },
              error: {
                duration: 4000,
                iconTheme: {
                  primary: '#EF4444',
                  secondary: '#fff',
                },
              },
            }}
          />
        </AuthProvider>
      </BrowserRouter>
    </QueryClientProvider>
  );
}

export default App;
