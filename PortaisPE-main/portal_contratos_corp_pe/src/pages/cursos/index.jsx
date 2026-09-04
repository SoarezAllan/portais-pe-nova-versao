import React, { useState, useEffect, useRef } from 'react';
import { format } from 'date-fns';
import { fetchCursos } from '../../services/api';
import siteConfig from '../../config/siteConfig';
import Header from '../../components/layout/header';
import Footer from '../../components/layout/footer';
import PageHero from '../../components/layout/PageHero/PageHero';
import MobileNavigation from '../../components/mobile/layout/navegacao_areas/MobileNavigation';
import './style.css';

const defaultLinksUteis = [];

const PaginaCursos = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [allCursos, setAllCursos] = useState([]);
  const [cursosProgramados, setCursosProgramados] = useState([]);
  const [dynamicLinks, setDynamicLinks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [showModal, setShowModal] = useState(false);
  const modalCloseBtnRef = useRef(null);

  useEffect(() => {
    const carregarCursos = async () => {
      try {
        setLoading(true);
        setError(null);
        const data = await fetchCursos(siteConfig.SITE_AREA);
        setAllCursos(data || []);
      } catch (err) {
        console.error(err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    carregarCursos();
  }, []);

  useEffect(() => {
    const termo = searchTerm.toLowerCase();
    const filtrados = allCursos.filter((curso) => {
      const titulo = curso.titulo?.toLowerCase().includes(termo);
      const resumo = curso.resumo?.toLowerCase().includes(termo);
      const local = curso.local?.toLowerCase().includes(termo);
      return titulo || resumo || local;
    });

    const programados = filtrados
      .filter((curso) => curso.status === 'PROGRAMADO' || !curso.status)
      .sort((a, b) => new Date(a.dataDoCurso) - new Date(b.dataDoCurso));

    const linksDoBanco = filtrados
      .filter((curso) => curso.status === 'LINK_UTIL')
      .map((item) => ({
        titulo: item.titulo,
        descricao: item.resumo,
        categoria: item.modalidade || 'Capacitação',
        url: item.linkExterno,
        botao: 'Acessar Link',
      }));

    setCursosProgramados(programados);
    setDynamicLinks(linksDoBanco);
  }, [searchTerm, allCursos]);

  const getSubareaNome = (curso) => curso.subarea?.nome || '';

  const scrollToAnchor = (anchorId) => {
    const element = document.getElementById(anchorId);
    if (element) {
      const offset = 120;
      const bodyRect = document.body.getBoundingClientRect().top;
      const elementRect = element.getBoundingClientRect().top;
      const elementPosition = elementRect - bodyRect;
      const offsetPosition = elementPosition - offset;
      window.scrollTo({ top: offsetPosition, behavior: 'smooth' });
    }
  };

  const heroCards = [
    {
      icon: '📅',
      label: 'Cursos Programados',
      onClick: () => scrollToAnchor('cursos-programados'),
    },
    {
      icon: '🔗',
      label: 'Links Úteis',
      onClick: () => scrollToAnchor('links-uteis'),
    },
  ];

  useEffect(() => {
    const onKeyDown = (e) => {
      if (e.key === 'Escape') setShowModal(false);
    };

    if (showModal) {
      document.body.style.overflow = 'hidden';
      window.addEventListener('keydown', onKeyDown);
      setTimeout(() => modalCloseBtnRef.current?.focus?.(), 0);
    }

    return () => {
      document.body.style.overflow = '';
      window.removeEventListener('keydown', onKeyDown);
    };
  }, [showModal]);

  const finalLinks = [...dynamicLinks, ...defaultLinksUteis];

  return (
    <div className="cursos-page">
      <Header />
      <main className="cursos-main">
        <MobileNavigation pageTitle="CURSOS" items={heroCards} />
        <div className="desktop-only-hero">
          <PageHero
            title="CURSOS E CAPACITAÇÕES"
            bgImage="/slide2.jpg"
            cards={heroCards}
          />
        </div>
        <div className="page-main-content cursos-grid-container">
          <div className="search-bar-container">
            <input
              type="text"
              placeholder="Pesquisar por título ou resumo do curso..."
              className="search-input"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>

          {loading && <p>Carregando cursos...</p>}

          {error && (
            <p style={{ color: 'red', fontWeight: 'bold' }}>{error}</p>
          )}

          <div className="curso-fix-btn-wrapper">
            <button
              type="button"
              className="nao-encontrou-curso-btn"
              onClick={() => setShowModal(true)}
            >
              Dúvidas? Clique aqui
            </button>
          </div>

          {showModal && (
            <div
              className="modal-overlay"
              role="dialog"
              aria-modal="true"
              aria-labelledby="curso-modal-title"
              onMouseDown={(e) => {
                if (e.target === e.currentTarget) setShowModal(false);
              }}
            >
              <div className="modal-content">
                <button
                  type="button"
                  ref={modalCloseBtnRef}
                  className="modal-close-btn"
                  aria-label="Fechar"
                  onClick={() => setShowModal(false)}
                >
                  ×
                </button>

                <h3 id="curso-modal-title" style={{ marginTop: 0, fontFamily: 'Montserrat, sans-serif' }}>
                  Como achar seu curso
                </h3>

                <div className="passos-container">
                  <div className="passo-item">
                    <div className="passo-numero">1</div>
                    <div>
                      Use a busca acima (título, resumo ou local).
                    </div>
                  </div>

                  <div className="passo-item">
                    <div className="passo-numero">2</div>
                    <div>
                      Verifique as seções <b>Cursos Programados</b> e <b>Links Úteis</b>.
                    </div>
                  </div>

                  <div className="passo-item">
                    <div className="passo-numero">3</div>
                    <div>
                      Tente outras palavras-chave (por exemplo: área, modalidade ou município).
                    </div>
                  </div>
                </div>

                <div style={{ marginTop: '1.5rem' }}>
                  <p style={{ margin: 0 }}>
                    Se ainda assim você não encontrou, entre em contato com a área responsável.
                  </p>

                  <p style={{ margin: '0.75rem 0 0' }}>
                    <a className="curso-modal-contato-link" href="mailto:contato@seuportal.com">
                      contato@seuportal.com
                    </a>
                    <span style={{ display: 'block', marginTop: 6, fontSize: 14, color: '#555' }}>
                      (se preferir, informe o curso desejado e período/área)
                    </span>
                  </p>
                </div>
              </div>
            </div>
          )}

          {/* 1. SEÇÃO CURSOS PROGRAMADOS (SEMPRE VISÍVEL) */}
          <section id="cursos-programados" className="topic-section">
            <h2 className="topic-title">Cursos Programados</h2>
            {!loading && !error && cursosProgramados.length === 0 ? (
              <div
                style={{
                  background: '#f8fafc',
                  border: '1px solid #e2e8f0',
                  borderRadius: '12px',
                  padding: '2rem',
                  textAlign: 'center',
                  margin: '1rem 0',
                }}
              >
                <p style={{ margin: 0, fontWeight: 700, color: '#1e293b', fontSize: '1.05rem' }}>
                  Nenhum curso com inscrições abertas no momento.
                </p>
                <p style={{ margin: '0.5rem 0 0', color: '#64748b', fontSize: '0.9rem' }}>
                  Consulte abaixo as plataformas e links úteis recomendados para cursos e capacitações contínuas.
                </p>
              </div>
            ) : (
              <div className="programacao-cards-grid">
                {cursosProgramados.map((curso) => (
                  <div key={curso.id} className="programacao-card">
                    <div className="programacao-card-data">{getSubareaNome(curso) || siteConfig.SITE_AREA}</div>
                    <div className="programacao-card-content">
                      <h3>{curso.titulo}</h3>
                      <p className="curso-meta-line">
                        <strong>Modalidade:</strong> {curso.modalidade === 'EAD' ? 'EAD' : curso.modalidade || 'Presencial'}
                      </p>
                      {curso.local && (
                        <p className="curso-meta-line">
                          <strong>Local:</strong> {curso.local}
                        </p>
                      )}
                      <p className="curso-data-card">
                        Data: {curso.dataDoCurso ? format(new Date(curso.dataDoCurso), 'dd/MM/yyyy') : 'A definir'}
                      </p>
                      {curso.resumo && <p>{curso.resumo}</p>}
                    </div>
                    {curso.linkExterno && (
                      <a href={curso.linkExterno} target="_blank" rel="noopener noreferrer" className="programacao-card-link">
                        Inscrever-se
                      </a>
                    )}
                  </div>
                ))}
              </div>
            )}
          </section>

          {/* 2. SEÇÃO LINKS ÚTEIS (EXIBIDA SE HOUVER LINKS CADASTRADOS) */}
          {finalLinks.length > 0 && (
            <section id="links-uteis" className="topic-section">
              <h2 className="topic-title">Links Úteis</h2>
              <div className="programacao-cards-grid">
                {finalLinks.map((link, idx) => (
                  <div key={idx} className="programacao-card">
                    <div className="programacao-card-data">Link Útil</div>
                    <div className="programacao-card-content">
                      <h3>{link.titulo}</h3>
                      {link.descricao && <p>{link.descricao}</p>}
                    </div>
                    {link.url && (
                      <a
                        href={link.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="programacao-card-link"
                      >
                        Acessar Link →
                      </a>
                    )}
                  </div>
                ))}
              </div>
            </section>
          )}
        </div>
      </main>

      <Footer />
    </div>
  );
};

export default PaginaCursos;
