// ARQUIVO: admin/components/CustomLogo.tsx
/** @jsxRuntime classic */
/** @jsx jsx */
import { jsx } from '@keystone-ui/core';
import { Link } from '@keystone-6/core/admin-ui/router';

export const CustomLogo = () => {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginBottom: '1rem' }}>
      {/* 1. O SEU LOGO AQUI */}
      <h3 style={{ 
        margin: 0, 
        color: '#3B82F6', // Azul
        fontSize: '24px',
        fontWeight: 'bold' 
      }}>
        Gestor Patrimônio
      </h3>

      {/* 2. O BOTÃO DE CADASTRO "INJETADO" */}
      <div style={{ marginTop: '15px' }}>
        <p style={{ fontSize: '14px', color: '#666', margin: '0 0 5px 0' }}>
          Não tem acesso?
        </p>
        <a 
          // 👇 Aqui colocamos o link para a página de cadastro que criamos no Frontend
          href="http://localhost:5173/cadastro" 
          target="_blank"
          style={{
            display: 'inline-block',
            textDecoration: 'none',
            backgroundColor: '#10B981', // Verde
            color: 'white',
            padding: '8px 16px',
            borderRadius: '6px',
            fontSize: '14px',
            fontWeight: 'bold',
            boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
          }}
        >
          Solicitar Cadastro
        </a>
      </div>
    </div>
  );
};