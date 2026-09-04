import React, { useEffect, useState } from 'react';
import apiClient from '../../api';
import Header from '../../components/layout/header';
import Footer from '../../components/layout/footer';
import siteConfig from '../../config/siteConfig';
import './style.css';

const GQL_QUERY = `
query GetPaginaQuemSomos($siteArea: String!) {
  paginasQuemSomos(
    where: {
      areaResponsavel: {
        nome: { equals: $siteArea }
      }
    }
  ) {
    id
    tituloDaPagina
    timeTitulo
    timeDescricao
    muralTextoIntrodutorio

    muralItens(where: { ativo: { equals: true } }) {
      id
      valor
      titulo
      descricao
    }

    conteudosPorSubarea(where: { ativo: { equals: true } }) {
      id
      subarea {
        id
        nome
      }
      conteudo
    }

    time(where: { ativo: { equals: true } }) {
      id
      nome
      cargo
      descricao
      foto {
        url
      }
    }
  }
}
`;

const PaginaQuemSomos = () => {
  const [mural, setMural] = useState(null);
  const [secoes, setSecoes] = useState([]);
  const [time, setTime] = useState([]);
  const [timeTitulo, setTimeTitulo] = useState('Nosso Time');
  const [timeDescricao, setTimeDescricao] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);

    const fetchData = async () => {
      try {
        setLoading(true);
        setError(null);

        const response = await apiClient.post('/api/graphql', {
          query: GQL_QUERY,
          variables: { siteArea: siteConfig.SITE_AREA },
        });

        if (response.data.errors) {
          throw new Error(
            response.data.errors.map((e) => e.message).join('\n')
          );
        }

        const primeiro = response.data?.data?.paginasQuemSomos?.[0];

        if (!primeiro) return;

        setMural({
          tituloDaPagina: primeiro.tituloDaPagina,
          texto: primeiro.muralTextoIntrodutorio,
          itens: primeiro.muralItens || [],
        });

        setTimeTitulo(primeiro.timeTitulo || 'Nosso Time');
        setTimeDescricao(primeiro.timeDescricao || '');
        setTime(primeiro.time || []);

        setSecoes(
          primeiro.conteudosPorSubarea?.map((item) => ({
            id: item.id,
            titulo: item.subarea?.nome || 'Seção',
            conteudo: item.conteudo || null,
          })) || []
        );
      } catch (err) {
        console.error(err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return (
      <div>
        <Header />
        <h2 style={{ textAlign: 'center', marginTop: '50px' }}>Carregando...</h2>
        <Footer />
      </div>
    );
  }

  if (error) {
    return (
      <div>
        <Header />
        <h2 style={{ textAlign: 'center', marginTop: '50px' }}>{error}</h2>
        <Footer />
      </div>
    );
  }

  return (
    <div className="quem-somos-page">
      <Header />

      <main>
        <section className="mural-section">
          <div className="mural-intro">
            <h2>{mural?.tituloDaPagina || 'Quem Somos'}</h2>
            {mural?.texto && <p>{mural.texto}</p>}
          </div>

          {mural?.itens?.length > 0 && (
            <div className="mural-grid-wrapper">
              <div className="mural-grid">
                {mural.itens.map((item, index) => (
                  <div key={item.id || index} className={`mural-item item-${index + 1}`}>
                    {item.valor && (
                      <span className="mural-item-valor">{item.valor}</span>
                    )}
                    {item.titulo && (
                      <h3 className="mural-item-titulo">{item.titulo}</h3>
                    )}
                    {item.descricao && (
                      <p className="mural-item-descricao">{item.descricao}</p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </section>

        <div className="quem-somos-grid-container page-main-content">
          {secoes.map((secao) => (
            <section key={secao.id} className="topic-section">
              <h2 className="topic-title">{secao.titulo}</h2>
              <div className="intro-text">
                {secao.conteudo ? (
                  <p>{secao.conteudo}</p>
                ) : (
                  <p>Conteúdo não disponível.</p>
                )}
              </div>
            </section>
          ))}

          {(time.length > 0 || timeDescricao) && (
            <section className="topic-section">
              <h2 className="topic-title">{timeTitulo}</h2>
              {time.length > 0 && (
                <div className="time-grid">
                  {time.map((membro) => (
                    <div key={membro.id} className="time-card">
                      {membro.foto?.url && (
                        <img
                          src={membro.foto.url}
                          alt={membro.nome}
                          className="time-card-foto"
                          onError={(e) => { if (e.target.src !== "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='120' height='120' viewBox='0 0 120 120'%3E%3Crect width='120' height='120' fill='%23003087'/%3E%3Ccircle cx='60' cy='45' r='20' fill='%23ffffff' opacity='0.7'/%3E%3Cpath d='M30 95 C30 75 45 70 60 70 C75 70 90 75 90 95 Z' fill='%23ffffff' opacity='0.7'/%3E%3C/svg%3E") e.target.src = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='120' height='120' viewBox='0 0 120 120'%3E%3Crect width='120' height='120' fill='%23003087'/%3E%3Ccircle cx='60' cy='45' r='20' fill='%23ffffff' opacity='0.7'/%3E%3Cpath d='M30 95 C30 75 45 70 60 70 C75 70 90 75 90 95 Z' fill='%23ffffff' opacity='0.7'/%3E%3C/svg%3E"; }}
                        />
                      )}
                      <h3 className="time-card-nome">{membro.nome}</h3>
                      <p className="time-card-cargo">{membro.cargo}</p>
                      {membro.descricao && (
                        <p className="time-card-descricao">{membro.descricao}</p>
                      )}
                    </div>
                  ))}
                </div>
              )}
              {timeDescricao && (
                <div className="time-descricao-geral" style={{ marginTop: '2rem', background: '#f8fafc', border: '1px solid #e2e8f0', borderRadius: '12px', padding: '1.5rem', fontSize: '1rem', lineHeight: '1.7', color: '#334155' }}>
                  <p style={{ margin: 0, whiteSpace: 'pre-line' }}>{timeDescricao}</p>
                </div>
              )}
            </section>
          )}
        </div>
      </main>

      <Footer />
    </div>
  );
};

export default PaginaQuemSomos;