import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import apiClient from '../../../api';
import Tag from '../tag/tag';
import './style.css';
import siteConfig from '../../../config/siteConfig';

const Carrossel = () => {
  const [slides, setSlides] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentSlide, setCurrentSlide] = useState(0);

  useEffect(() => {

    const fetchSlides = async () => {

      try {

        const query = `
          query GetCarrosselSlides {

            noticias(
              where: {
                destaque: {
                  equals: true
                }

                areaResponsavel: {
                  nome: {
                    equals: "${siteConfig.SITE_AREA}"
                  }
                }
              }

              orderBy: {
                dataPublicacao: desc
              }

              take: 5
            ) {

              id
              titulo
              resumo
              slug

              tags {
                id
                nome
              }

              imagemPrincipal {
                url
              }

              imagemPrincipalAlt
            }

          }
        `;

        const response = await apiClient.post(
          '/api/graphql',
          {
            query
          }
        );

        if (response.data?.errors) {

          throw new Error(
            response.data.errors
              .map(e => e.message)
              .join('\n')
          );

        }

        const data =
          response.data?.data?.noticias || [];

        const processedSlides = data.map(slide => ({

          ...slide,

          imagemUrl:
            slide.imagemPrincipal?.url || null,

          imagemAlt:
            slide.imagemPrincipalAlt ||
            slide.titulo,

          tag:
            slide.tags?.length > 0
              ? slide.tags[0].nome
              : null,

        }));

        setSlides(processedSlides);

      }

      catch (error) {

        console.error(
          'Erro ao buscar destaques do Keystone:',
          error
        );

      }

      finally {

        setLoading(false);

      }

    };

    fetchSlides();

  }, []);

  useEffect(() => {

    if (slides.length > 1) {

      const interval = setInterval(() => {

        setCurrentSlide(
          prev => (prev + 1) % slides.length
        );

      }, 10000);

      return () => clearInterval(interval);

    }

  }, [slides.length]);

  if (loading) {

    return (

      <section className="hero-loading">
        Carregando Notícias...
      </section>

    );

  }

  if (slides.length === 0) {

    return (

      <section className="hero hero-fallback">

        <div className="hero-content">

          <h1>
            {siteConfig.SITE_TITLE}
          </h1>

          <p>
            Nenhuma notícia publicada no momento.
          </p>

        </div>

      </section>

    );

  }

  return (

    <section
      id="hero"
      className="hero"
      style={{
        '--hero-bg':
          `url(${slides[currentSlide].imagemUrl})`
      }}
    >

      <div className="hero-content">

        {slides[currentSlide].tag && (

          <div style={{ marginBottom: '1rem' }}>

            <Tag
              label={slides[currentSlide].tag}
            />

          </div>

        )}

        <h1>
          {slides[currentSlide].titulo}
        </h1>

        <p>
          {slides[currentSlide].resumo}
        </p>

        <Link
          to={`/materias/${slides[currentSlide].slug}`}
        >

          <button className="saiba_mais">

            SAIBA MAIS

          </button>

        </Link>

      </div>

      {slides.length > 1 && (

        <div className="hero-dots">

          {slides.map((_, index) => (

            <span

              key={index}

              className={`dot ${
                currentSlide === index
                  ? 'active'
                  : ''
              }`}

              onClick={() =>
                setCurrentSlide(index)
              }

            />

          ))}

        </div>

      )}

    </section>

  );

};

export default Carrossel;