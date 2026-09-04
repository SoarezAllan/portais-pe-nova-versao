// src/components/layout/video/index.jsx

import React, { useState, useEffect } from 'react';
import sanityClient from '../../../services/sanityClient';
import './style.css';

// O componente agora aceita props com valores padrão
const VideoSection = ({ height = '50vh', showTitle = true }) => {
  const [videoData, setVideoData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Query atualizada para pegar o vídeo mais recente, caso haja mais de um
    const query = `*[_type == "video"] | order(_createdAt desc)[0] {
      _id,
      titulo,
      "videoUrl": videoFile.asset->url
    }`;

    sanityClient.fetch(query)
      .then((data) => {
        setVideoData(data);
        setLoading(false);
      })
      .catch((err) => {
        console.error('Erro ao buscar vídeo do Sanity:', err);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return <section className="video-loading">Carregando vídeo...</section>;
  }

  if (!videoData || !videoData.videoUrl) {
    return null;
  }

  return (
    // A altura da seção agora é controlada pela prop 'height'
    <section id="video-destaque" className="video-section" style={{ height: height }}>
      <div className="video-container">
        <video 
          className="video-player"
          src={videoData.videoUrl} 
          autoPlay
          loop
          muted
          playsInline
          aria-label={videoData.titulo}
        />
        {/* O título só será renderizado se a prop 'showTitle' for true */}
        {showTitle && (
          <div className="video-overlay">
            <h2>{videoData.titulo}</h2>
          </div>
        )}
      </div>
    </section>
  );
};

export default VideoSection;