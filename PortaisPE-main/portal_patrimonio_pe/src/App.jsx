// src/App.jsx
import React, { Suspense, lazy } from "react";
import { BrowserRouter, Routes, Route, Navigate, useLocation } from "react-router-dom";
import { AuthProvider, PrivateRoute } from "./lib/auth";
import { useTrackPortalView } from "./utils/useAnalytics";

// Lazy loading de páginas públicas
const Home = lazy(() => import("./pages/home"));
const PaginaQuemSomos = lazy(() => import("./pages/quem_somos"));
const PaginaDuvidas = lazy(() => import("./pages/duvidas"));
const NoticiasHistorico = lazy(() => import("./pages/noticias_historico"));
const PaginaServicos = lazy(() => import("./pages/servicos"));
const PaginaSolucoes = lazy(() => import("./pages/solucoes"));
const PaginaCursos = lazy(() => import("./pages/cursos"));
const PaginaLegislacao = lazy(() => import("./pages/legislacao"));
const DetalheGenerico = lazy(() => import("./components/layout/detalhamento/generico"));
const MateriaDetalhe = lazy(() => import("./pages/materia-detalhe"));
const ServicoDetalhe = lazy(() => import("./pages/servicos/servico-detalhe"));
const SolucaoDetalhe = lazy(() => import("./pages/solucoes/solucao-detalhe"));

// Lazy loading de Admin
const LoginAdmin = lazy(() => import("./pages/admin/LoginAdmin"));
const RecuperarSenha = lazy(() => import("./pages/admin/RecuperarSenha"));
const ResetSenha = lazy(() => import("./pages/admin/ResetSenha"));
const Dashboard = lazy(() => import("./pages/admin/Dashboard"));

// Lazy loading de Admin CRUD
const ServicoList = lazy(() => import("./pages/Servicos/List"));
const ServicoForm = lazy(() => import("./pages/Servicos/Form"));
const NoticiaList = lazy(() => import("./pages/Noticias/List"));
const NoticiaForm = lazy(() => import("./pages/Noticias/Form"));
const LegislacaoList = lazy(() => import("./pages/Legislacao/List"));
const LegislacaoForm = lazy(() => import("./pages/Legislacao/Form"));
const CursoList = lazy(() => import("./pages/Curso/List"));
const CursoForm = lazy(() => import("./pages/Curso/Form"));
const SolucaoList = lazy(() => import("./pages/Solucoes/List"));
const SolucaoForm = lazy(() => import("./pages/Solucoes/Form"));
const GestoresList = lazy(() => import("./pages/Gestores/List"));
const GestoresForm = lazy(() => import("./pages/Gestores/Form"));
const QuemSomosList = lazy(() => import("./pages/QuemSomos/List"));
const QuemSomosForm = lazy(() => import("./pages/QuemSomos/Form"));
const Indicadores = lazy(() => import("./pages/Indicadores"));

function ScrollToTop() {
  const { pathname } = useLocation();
  React.useEffect(() => { window.scrollTo(0, 0); }, [pathname]);
  return null;
}

function AnalyticsInit() {
  useTrackPortalView();
  return null;
}

function PageLoading() {
  return (
    <div style={{ minHeight: '60vh', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#004d99', fontFamily: 'Inter, Segoe UI, sans-serif' }}>
      <div style={{ textAlign: 'center' }}>
        <p style={{ marginTop: '10px', fontSize: '15px', color: '#64748b' }}>Carregando...</p>
      </div>
    </div>
  );
}

function App() {
  return (
    <BrowserRouter future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
      <AuthProvider>
        <AnalyticsInit />
        <ScrollToTop />
        <Suspense fallback={<PageLoading />}>
          <Routes>
            {/* Rotas públicas */}
            <Route path="/" element={<Home />} />
            <Route path="/quem-somos" element={<PaginaQuemSomos />} />
            <Route path="/duvidas" element={<PaginaDuvidas />} />
            <Route path="/legislacao" element={<PaginaLegislacao />} />
            <Route path="/cursos" element={<PaginaCursos />} />
            <Route path="/materias" element={<NoticiasHistorico />} />
            <Route path="/materias/:slug" element={<MateriaDetalhe />} />
            <Route path="/servicos" element={<PaginaServicos />} />
            <Route path="/servicos/:slug" element={<ServicoDetalhe />} />
            <Route path="/solucoes" element={<PaginaSolucoes />} />
            <Route path="/solucoes/:slug" element={<SolucaoDetalhe />} />
            <Route
              path="/cursos/:slug"
              element={
                <DetalheGenerico
                  listName="cursos"
                  fields={[
                    "id","titulo","slug","descricao","imagem { url }","instrutor { name }","corpo { document }"
                  ]}
                />
              }
            />

            {/* Autenticação */}
            <Route path="/gerenciador-login" element={<LoginAdmin />} />
            <Route path="/login" element={<LoginAdmin />} />
            <Route path="/gerenciador-recuperar-senha" element={<RecuperarSenha />} />
            <Route path="/recuperar-senha" element={<RecuperarSenha />} />
            <Route path="/reset-password" element={<ResetSenha />} />

            {/* Admin - protegidas */}
            <Route path="/admin/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
            <Route path="/operador/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />

            {/* CRUD Serviços */}
            <Route path="/servicos" element={<PrivateRoute><ServicoList /></PrivateRoute>} />
            <Route path="/servicos/novo" element={<PrivateRoute><ServicoForm /></PrivateRoute>} />
            <Route path="/servicos/:id" element={<PrivateRoute><ServicoForm /></PrivateRoute>} />

            {/* CRUD Notícias */}
            <Route path="/noticias" element={<PrivateRoute><NoticiaList /></PrivateRoute>} />
            <Route path="/noticias/novo" element={<PrivateRoute><NoticiaForm /></PrivateRoute>} />
            <Route path="/noticias/:id" element={<PrivateRoute><NoticiaForm /></PrivateRoute>} />

            {/* CRUD Legislação */}
            <Route path="/legislacao" element={<PrivateRoute><LegislacaoList /></PrivateRoute>} />
            <Route path="/legislacao/novo" element={<PrivateRoute><LegislacaoForm /></PrivateRoute>} />
            <Route path="/legislacao/:id" element={<PrivateRoute><LegislacaoForm /></PrivateRoute>} />

            {/* CRUD Cursos */}
            <Route path="/cursos" element={<PrivateRoute><CursoList /></PrivateRoute>} />
            <Route path="/cursos/novo" element={<PrivateRoute><CursoForm /></PrivateRoute>} />
            <Route path="/cursos/:id" element={<PrivateRoute><CursoForm /></PrivateRoute>} />

            {/* CRUD Soluções */}
            <Route path="/solucoes" element={<PrivateRoute><SolucaoList /></PrivateRoute>} />
            <Route path="/solucoes/novo" element={<PrivateRoute><SolucaoForm /></PrivateRoute>} />
            <Route path="/solucoes/:id" element={<PrivateRoute><SolucaoForm /></PrivateRoute>} />

            {/* CRUD Gestores */}
            <Route path="/gestores" element={<PrivateRoute><GestoresList /></PrivateRoute>} />
            <Route path="/gestores/novo" element={<PrivateRoute><GestoresForm /></PrivateRoute>} />
            <Route path="/gestores/:id" element={<PrivateRoute><GestoresForm /></PrivateRoute>} />

            {/* CRUD Quem Somos */}
            <Route path="/quem-somos" element={<PrivateRoute><QuemSomosList /></PrivateRoute>} />
            <Route path="/quem-somos/novo" element={<PrivateRoute><QuemSomosForm /></PrivateRoute>} />
            <Route path="/quem-somos/:id" element={<PrivateRoute><QuemSomosForm /></PrivateRoute>} />

            {/* Indicadores de Acesso - Admin */}
            <Route path="/indicadores" element={<PrivateRoute><Indicadores /></PrivateRoute>} />

            {/* 404 - redireciona para home */}
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </Suspense>
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
