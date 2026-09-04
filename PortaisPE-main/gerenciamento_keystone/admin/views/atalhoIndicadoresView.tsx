/** @jsxRuntime classic */
/** @jsx jsx */

import { jsx } from '@keystone-ui/core';
import { useEffect } from 'react';

export const AtalhoIndicadoresView = () => {
  useEffect(() => {
    // Redireciona automaticamente para a página de indicadores
    window.location.href = '/indicadores_de_acesso';
  }, []);

  return (
    <div style={{ 
      display: 'flex', 
      justifyContent: 'center', 
      alignItems: 'center', 
      minHeight: '100vh',
      flexDirection: 'column',
      gap: '20px'
    }}>
      <h1>Redirecionando...</h1>
      <p>Você será redirecionado para a página de indicadores em instantes.</p>
      <a 
        href="/indicadores_de_acesso" 
        style={{ 
          padding: '12px 24px', 
          background: '#3b82f6', 
          color: 'white', 
          textDecoration: 'none',
          borderRadius: '8px',
          fontSize: '16px'
        }}
      >
        Clique aqui se não for redirecionado automaticamente
      </a>
    </div>
  );
};
