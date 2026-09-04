// src/App.jsx
import React, { Suspense, lazy } from "react";
import { BrowserRouter, Routes, Route, useLocation } from "react-router-dom";
import { useTrackPortalView } from "./utils/useAnalytics";

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
const LoginAdmin = lazy(() => import("./pages/admin/LoginAdmin"));
const RecuperarSenha = lazy(() => import("./pages/admin/RecuperarSenha"));
const ResetSenha = lazy(() => import("./pages/admin/ResetSenha"));
const Dashboard = lazy(() => import("./pages/admin/Dashboard"));

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
      <AnalyticsInit />
      <ScrollToTop />
      <Suspense fallback={<PageLoading />}>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/sobre" element={<PaginaQuemSomos />} />
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
                fields={["id","titulo","slug","descricao","imagem { url }","instrutor { name }","corpo { document }"]}
              />
            }
          />
          <Route path="/gerenciador-login" element={<LoginAdmin />} />
          <Route path="/login" element={<LoginAdmin />} />
          <Route path="/gerenciador-recuperar-senha" element={<RecuperarSenha />} />
          <Route path="/recuperar-senha" element={<RecuperarSenha />} />
          <Route path="/reset-password" element={<ResetSenha />} />
          <Route path="/admin/dashboard" element={<Dashboard />} />
          <Route path="/operador/dashboard" element={<Dashboard />} />
          <Route path="*" element={<h1 style={{ padding: "2rem" }}>Página não encontrada</h1>} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}

export default App;
