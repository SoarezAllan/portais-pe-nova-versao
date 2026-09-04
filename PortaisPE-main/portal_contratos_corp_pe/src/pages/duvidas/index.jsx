import React, { useState, useEffect } from "react";
import './style.css';
import Header from '../../components/layout/header';
import Footer from '../../components/layout/footer';
import apiClient from '../../api';
import { DocumentRenderer } from '@keystone-6/document-renderer';

const GET_FAQS_QUERY = `
query GetFaqs {
  faqs(orderBy: { pergunta: asc }) {
    id
    pergunta
    resposta {
      document
    }
  }
}
`;

function Duvidas() {
  const [activeIndex, setActiveIndex] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [searchTerm, setSearchTerm] = useState("");
  const [allFaqs, setAllFaqs] = useState([]); 
  const [filteredFaqs, setFilteredFaqs] = useState([]); 

  useEffect(() => {
    const fetchFaqs = async () => {
      try {
        setLoading(true);
        setError(null);

        const response = await apiClient.post('/api/graphql', {
          query: GET_FAQS_QUERY
        });

        if (response.data.errors) {
          console.error("Erro GraphQL:", response.data.errors);
          throw new Error('Erro ao buscar dados do GraphQL.');
        }

        const data = response.data.data.faqs || [];
        setAllFaqs(data);
        setFilteredFaqs(data);

      } catch (err) {
        let errorMessage = "Erro de rede ou servidor indisponível.";
        if (err.response) {
          errorMessage = `Erro do servidor: ${err.response.status}`;
        } else if (err.message) {
          errorMessage = err.message;
        }
        setError(errorMessage);
        console.error("Erro ao buscar FAQs:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchFaqs();
  }, []);

  useEffect(() => {
    const termo = searchTerm.toLowerCase();
    
    const faqsFiltradas = allFaqs.filter(faq => {
      const naPergunta = faq.pergunta.toLowerCase().includes(termo);
      
      let naResposta = false;
      if (faq.resposta?.document) {
        try {
          naResposta = JSON.stringify(faq.resposta.document).toLowerCase().includes(termo);
        } catch (e) {}
      }
      
      return naPergunta || naResposta;
    });

    setFilteredFaqs(faqsFiltradas);
    setActiveIndex(null); 

  }, [searchTerm, allFaqs]);

  const toggleFAQ = (index) => {
    setActiveIndex(activeIndex === index ? null : index);
  };

  return (
    <div className="app-container">
      <Header />

      <main className="faq-main-content">
        <section className="faq-section">
          
          {/* TÍTULO AJUSTADO E CORRIGIDO */}
          <h1 className="section-title duvidas-title">
            DÚVIDAS FREQUENTES
          </h1>
          
          <div className="search-bar-container">
            <input
              type="text"
              placeholder="Pesquisar nas perguntas ou respostas..."
              className="search-input"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>

          <div className="faq-container">
            {loading && <p>Carregando perguntas...</p>}
            
            {error && (
              <p style={{ color: 'red', fontWeight: 'bold', background: '#fff0f0', padding: '15px', border: '1px solid red', whiteSpace: 'pre-wrap' }}>
                <strong>Erro ao Carregar:</strong> {error}
              </p>
            )}
            
            {!loading && !error && filteredFaqs.length === 0 && (
              <p className="faq-no-results">
                {searchTerm
                  ? `Nenhum resultado encontrado para "${searchTerm}".`
                  : "Nenhuma pergunta frequente encontrada."
                }
              </p>
            )}
            
            {!loading && !error && filteredFaqs.map((item, index) => (
              <div key={item.id} className={`faq-item ${activeIndex === index ? 'active' : ''}`}>
                <button
                  className="faq-question"
                  onClick={() => toggleFAQ(index)}
                  aria-expanded={activeIndex === index}
                  aria-controls={`faq-answer-${index}`}
                >
                  {item.pergunta}
                  <span className="faq-toggle">{activeIndex === index ? '−' : '+'}</span>
                </button>
                
                {activeIndex === index && (
                  <div className="faq-answer" id={`faq-answer-${index}`}>
                    {item.resposta?.document ? (
                      <DocumentRenderer document={item.resposta.document} />
                    ) : (
                      <p>Sem resposta.</p>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        </section>
      </main>

      <Footer />
    </div>
  );
}

export default Duvidas;