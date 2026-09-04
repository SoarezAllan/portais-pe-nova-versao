import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import apiClient from '../../../api';
import Header from '../../../components/layout/header';
import Footer from '../../../components/layout/footer';
import siteConfig from '../../../config/siteConfig';
import { trackServicoView } from '../../../utils/analytics';
import './style.css';
 
const renderDocument = (doc) => {
  if (!doc) return null;
  const nodes = Array.isArray(doc) ? doc : doc.document || doc;

  const normalizeHref = (href) => {
    if (!href) return href;
    const trimmed = href.trim();
    if (/^(#|\/|mailto:|tel:|https?:\/\/|\/\/)/i.test(trimmed)) {
      return trimmed;
    }
    return `https://${trimmed}`;
  };

  const applyTextMarks = (text, node) => {
    let content = <>{text}</>;
    if (node.code) content = <code>{content}</code>;
    if (node.underline) content = <u>{content}</u>;
    if (node.strikethrough) content = <s>{content}</s>;
    if (node.italic) content = <em>{content}</em>;
    if (node.bold) content = <strong>{content}</strong>;
    return content;
  };

  const renderNode = (node, key) => {
    if (!node) return null;
    if (typeof node.text === 'string') {
      const renderText = (segment, index) => (
        <React.Fragment key={`${key}-text-${index}`}>
          {applyTextMarks(segment, node)}
        </React.Fragment>
      );

      if (node.text.includes('\n')) {
        return node.text.split('\n').flatMap((segment, index) =>
          index === 0
            ? [renderText(segment, index)]
            : [<br key={`${key}-nl-${index}`} />, renderText(segment, index)]
        );
      }
      return applyTextMarks(node.text, node);
    }

    const children = (node.children || []).map((child, index) => (
      <React.Fragment key={index}>{renderNode(child, index)}</React.Fragment>
    ));

    switch (node.type) {
      case 'paragraph':
        return <p key={key}>{children}</p>;
      case 'heading': {
        const level = node.level || 2;
        const Tag = `h${Math.min(Math.max(level, 1), 6)}`;
        return <Tag key={key}>{children}</Tag>;
      }
      case 'blockquote':
        return <blockquote key={key}>{children}</blockquote>;
      case 'code':
        return <pre key={key}>{node.children?.[0]?.text || ''}</pre>;
      case 'divider':
        return <hr key={key} />;
      case 'ordered-list':
        return <ol key={key}>{children}</ol>;
      case 'unordered-list':
        return <ul key={key}>{children}</ul>;
      case 'list-item':
      case 'listItem':
        return <li key={key}>{children}</li>;
      case 'link': {
        const href = normalizeHref(node.href || '');
        return (
          <a key={key} href={href} target="_blank" rel="noopener noreferrer">
            {children}
          </a>
        );
      }
      case 'relationship':
        return <span key={key}>{node.data?.label || node.data?.id || ''}</span>;
      case 'softBreak':
      case 'soft-break':
      case 'break':
      case 'line-break':
        return <br key={key} />;
      default:
        return <React.Fragment key={key}>{children}</React.Fragment>;
    }
  };

  return nodes.map((node, index) => renderNode(node, index));
};
 
  const GQL_QUERY_DETALHE = `
  query GetServicoDetalhe($slug: String!, $siteArea: String!) {
    servicos(where: { slug: { equals: $slug }, ativo: { equals: true } }) {
      id
      titulo
      resumo
      slug
      imagem { url }
      imagemAlt

      oQueE { document }
      quemPrecisa { document }
      comoSolicitar { document }
      maisInformacoes { document }

      subarea {
        nome
      }

    }

    outrosServicos: servicos(
      where: {
        slug: { not: { equals: $slug } }
        deletedAt: { equals: null }
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
 
export default function ServicoDetalhe() {
  const { slug } = useParams();
  const [servico, setServico] = useState(null);
  const [outrosServicos, setOutrosServicos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
 
  useEffect(() => {
    window.scrollTo(0, 0);
 
    const fetchData = async () => {
      try {
        const response = await apiClient.post('/api/graphql', {
          query: GQL_QUERY_DETALHE,
          variables: { slug, siteArea: siteConfig.SITE_AREA },
        });
 
        if (response.data.errors) {
          console.error('GraphQL Errors:', response.data.errors);
          throw new Error('Erro na consulta de dados do servidor.');
        }
 
        const data = response.data.data;
 
        const item = data.servicos && data.servicos.length > 0 ? data.servicos[0] : null;
        if (!item) {
          setError('Serviço não encontrado.');
          return;
        }

        setServico({
          ...item,
          imagemUrl: item.imagem?.url,
        });
        trackServicoView(slug);

        setOutrosServicos(data.outrosServicos || []);
      } catch (err) {
        console.error('Erro ao buscar serviço:', err);
        setError('Não foi possível carregar o serviço.');
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
        <main className="servico-detalhe-loading">
          Carregando Serviço...
        </main>
        <Footer />
      </div>
    );
  }
 
  if (error || !servico) {
    return (
      <div className="app-container">
        <Header />
        <main className="servico-detalhe-loading" style={{ padding: '40px' }}>
          <h1 style={{ color: 'red' }}>Erro</h1>
          <p>{error}</p>
          <Link to="/servicos">Voltar para Serviços</Link>
        </main>
        <Footer />
      </div>
    );
  }
 
  return (
    <div className="app-container">
      <Header />
 
      <main className="servico-detalhe-container">
        {/* ===== CONTEÚDO PRINCIPAL ===== */}
        <article className="servico-conteudo">
          <h1 className="servico-titulo">{servico.titulo}</h1>
 
          {servico.resumo && (
            <p className="servico-resumo">{servico.resumo}</p>
          )}
 
          {servico.imagemUrl && (
            <div className="servico-hero-image-wrap">
              <img
                src={servico.imagemUrl}
                alt={servico.imagemAlt || servico.titulo}
                className="servico-hero-image"
              />
            </div>
          )}
 
          <div className="servico-corpo">
            <h2>O que é este serviço?</h2>
            {renderDocument(servico.oQueE?.document)}
 
            <h2>Quem precisa / Quando é necessário?</h2>
            {renderDocument(servico.quemPrecisa?.document)}
 
            <h2>Como solicitar</h2>
            {renderDocument(servico.comoSolicitar?.document)}
 
            {servico.maisInformacoes?.document?.length > 0 && (
              <>
                <h2>Mais Informações</h2>
                {renderDocument(servico.maisInformacoes?.document)}
              </>
            )}
 
          </div>
        </article>
 
        {/* ===== BARRA LATERAL ===== */}
        <aside className="servico-lateral">
          {outrosServicos.length > 0 && (
            <div className="widget-lateral">
              <h3 className="lateral-titulo">Outros Serviços</h3>
              <ul className="widget-outros-lista">
                {outrosServicos.map(item => (
                  <li key={item.id} className="lateral-item">
                    <Link
                      to={`/servicos/${item.slug}`}
                      className="lateral-link"
                    >
                      {item.imagem?.url && (
                        <img
                          src={item.imagem.url}
                          alt={item.titulo}
                          className="lateral-thumb"
                        />
                      )}
                      <div className="lateral-textos">
                        <p className="lateral-item-titulo">
                          {item.titulo}
                        </p>
                      </div>
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </aside>
      </main>
 
      <Footer />
    </div>
  );
}
 