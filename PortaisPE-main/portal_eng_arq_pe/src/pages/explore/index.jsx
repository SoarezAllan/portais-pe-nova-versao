import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import sanityClient from '../../services/sanityClient';
import { PortableText } from '@portabletext/react';

import Header from '../../components/layout/header';
import Footer from '../../components/layout/footer';
import './style.css';

const PaginaExplore = () => {
  const { slug } = useParams();
  const [exploreItem, setExploreItem] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    window.scrollTo(0, 0);
    const query = `*[_type == "explore" && slug.current == $slug][0]{
      titulo,
      resumo,
      "imagemUrl": imagem.asset->url,
      "imagemAlt": imagem.alt,
      descricao,
      linkExterno
    }`;

    sanityClient.fetch(query, { slug })
      .then(data => {
        setExploreItem(data);
        setLoading(false);
      })
      .catch(console.error);
  }, [slug]);

  if (loading) return <div>Carregando item Explore...</div>;
  if (!exploreItem) return (
    <div>
      <h1>Item não encontrado</h1>
      <p>Verifique se o item com slug "{slug}" está publicado no Sanity.</p>
      <Link to="/">Voltar</Link>
    </div>
  );

  return (
    <div>
      <Header />
      <main className="main-content">
        <article className="servico-article">
          <header className="servico-header">
            <h1>{exploreItem.titulo}</h1>
            {exploreItem.resumo && <p className="servico-summary">{exploreItem.resumo}</p>}
          </header>

          {exploreItem.imagemUrl && <img src={exploreItem.imagemUrl} alt={exploreItem.imagemAlt || exploreItem.titulo} className="servico-image" />}

          <div className="servico-body">
            {exploreItem.descricao ? (
              <PortableText value={exploreItem.descricao} />
            ) : (
              <p>Descrição detalhada não disponível.</p>
            )}
          </div>

          {exploreItem.linkExterno && (
            <a href={exploreItem.linkExterno} target="_blank" rel="noopener noreferrer">
              <button className="btn btn-green">Acessar item</button>
            </a>
          )}
        </article>
      </main>
      <Footer />
    </div>
  );
};

export default PaginaExplore;
