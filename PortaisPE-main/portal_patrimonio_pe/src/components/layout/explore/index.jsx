// src/components/layout/explore/index.jsx
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import sanityClient from '../../../services/sanityClient';
import './style.css';

const Explore = () => {
  const [itens, setItens] = useState([]);
  const [loading, setLoading] = useState(true); // Adicionado

  useEffect(() => {
    const query = `*[_type == "explore"] | order(titulo asc) {
      _id, // Adicionado para uma key única e mais robusta
      titulo,
      resumo,
      "slug": slug.current,
      "imagemUrl": imagem.asset->url,
      "imagemAlt": imagem.alt
    }`;

    sanityClient.fetch(query)
      .then(data => {
        setItens(data || []);
        setLoading(false); // Adicionado
      })
      .catch(err => {
        console.error("Erro ao buscar itens de Explore:", err);
        setLoading(false); // Adicionado
      });
  }, []);

  if (loading) return <p className="explore-loading">Carregando...</p>;
  if (itens.length === 0) return <p className="explore-fallback">Nenhum item cadastrado.</p>;

  return (
    // Adicionada a section wrapper para consistência e especificidade do CSS
    <section id="explore" className="explore-section">
      <div className="cards">
        {itens.map((item) => (
          // O link agora envolve todo o card
          <Link key={item._id} to={`/explore/${item.slug}`} className="card-link">
            <div className="card">
              <img src={item.imagemUrl} alt={item.imagemAlt || item.titulo} className="card-image-background" />
              <div className="card-content">
                <h3>{item.titulo}</h3>
                {item.resumo && <p>{item.resumo}</p>}
              </div>
            </div>
          </Link>
        ))}
      </div>
    </section>
  );
};

export default Explore;