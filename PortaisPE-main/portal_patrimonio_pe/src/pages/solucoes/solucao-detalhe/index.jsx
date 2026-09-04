import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { DocumentRenderer } from '@keystone-6/document-renderer';
import apiClient from '../../../api';
import Header from '../../../components/layout/header';
import Footer from '../../../components/layout/footer';
import siteConfig from '../../../config/siteConfig';
import './style.css';

const GQL_QUERY_DETALHE = `
  query GetSolucaoDetalhe($slug: String!, $siteArea: String!) {
    solucoes(where: { slug: { equals: $slug }, ativo: { equals: true } }) {
      id
      titulo
      resumo
      slug
      imagem { url }
      imagemAlt
      corpo { document }
      linkExterno
    }
    outrasSolucoes: solucoes(
      where: {
        slug: { not: { equals: $slug } }
        areaResponsavel: { nome: { equals: $siteArea } }
        ativo: { equals: true }
      }
      take: 5
      orderBy: { titulo: asc }
    ) {
      id
      titulo
      slug
      imagem { url }
    }
  }
`;

const BotaoLinkExterno = ({ link }) => {
  if (!link) return null;
  return React.createElement(
    'a',
    { href: link, target: '_blank', rel: 'noopener noreferrer', className: 'btn btn-green solucao-link-externo' },
    'Acessar a Solução'
  );
};

const ItemOutrasSolucoes = ({ item }) => {
  return (
    <li key={item.id} className="lateral-item">
      <Link to={'/solucoes/' + item.slug} className="lateral-link">
        {item.imagem?.url && (
          <img src={item.imagem.url} alt={item.titulo} className="lateral-thumb" />
        )}
        <div className="lateral-textos">
          <p className="lateral-item-titulo">{item.titulo}</p>
        </div>
      </Link>
    </li>
  );
};

const SolucaoDetalhe = () => {
  const { slug } = useParams();
  const [solucao, setSolucao] = useState(null);
  const [outrasSolucoes, setOutrasSolucoes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);

    const fetchData = async () => {
      if (!slug) {
        setError("Slug da solução não encontrado na URL.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setError(null);

        const response = await apiClient.post('/api/graphql', {
          query: GQL_QUERY_DETALHE,
          // siteArea vem do header x-site-area configurado no apiClient
          variables: { slug, siteArea: siteConfig.SITE_AREA },
        });


        if (response.data.errors) {
          throw new Error(response.data.errors.map(e => e.message).join('\n'));
        }

        const data = response.data.data;
        const item = data.solucoes && data.solucoes.length > 0 ? data.solucoes[0] : null;

        if (item) {
          setSolucao({ ...item, imagemUrl: item.imagem?.url });
          setOutrasSolucoes(data.outrasSolucoes || []);
        } else {
          setError("Solução não encontrada.");
        }

      } catch (err) {
        setError(err.message || "Não foi possível carregar os dados da solução.");
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [slug]);

  if (loading) {
    return (
      <div className="app-container">
        <Header />
        <main className="solucao-detalhe-loading">Carregando Solução...</main>
        <Footer />
      </div>
    );
  }

  if (error || !solucao) {
    return (
      <div className="app-container">
        <Header />
        <main className="solucao-detalhe-loading" style={{ padding: '40px' }}>
          <h1 style={{ color: 'red' }}>
            {error ? "Erro ao Carregar" : "Solução não encontrada"}
          </h1>
          <Link to="/solucoes">Voltar para Soluções</Link>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="app-container">
      <Header />

      <main className="solucao-detalhe-container">

        <article className="solucao-conteudo">
          <h1 className="solucao-titulo">{solucao.titulo}</h1>

          {solucao.resumo && (
            <p className="solucao-resumo">{solucao.resumo}</p>
          )}

          {solucao.imagemUrl && (
            <div className="solucao-hero-image-wrap">
              <img
                src={solucao.imagemUrl}
                alt={solucao.imagemAlt || solucao.titulo}
                className="solucao-hero-image"
              />
            </div>
          )}

          <BotaoLinkExterno link={solucao.linkExterno} />

          <div className="solucao-corpo">
            {solucao.corpo?.document
              ? <DocumentRenderer document={solucao.corpo.document} />
              : <p>Nenhuma descrição detalhada disponível.</p>
            }
          </div>
        </article>

        <aside className="solucao-lateral">
          {outrasSolucoes.length > 0 && (
            <div className="widget-lateral">
              <h3 className="lateral-titulo">Outras Soluções</h3>
              <ul className="widget-outros-lista">
                {outrasSolucoes.map(item => (
                  <ItemOutrasSolucoes key={item.id} item={item} />
                ))}
              </ul>
            </div>
          )}
        </aside>

      </main>
      <Footer />
    </div>
  );
};

export default SolucaoDetalhe;