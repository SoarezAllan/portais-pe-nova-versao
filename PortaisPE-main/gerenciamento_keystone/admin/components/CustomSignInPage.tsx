// gerenciamento_keystone/admin/components/CustomSignInPage.tsx

import React from 'react';
import { SigninPage } from '@keystone-6/auth/components';
import { Button } from '@keystone-ui/button';
import { Box } from '@keystone-ui/core';

// Componente que renderiza a página de login padrão e adiciona um botão
export const CustomSignInPage = ({ identityField, secretField }) => {
  return (
    <>
      {/* Renderiza a página de login padrão do Keystone */}
      <SigninPage identityField={identityField} secretField={secretField} />

      {/* Adiciona o botão de Solicitar Cadastro */}
      <Box css={{ 
        marginTop: '16px', 
        textAlign: 'center',
        maxWidth: '380px', // Mesma largura do formulário de login
        margin: '16px auto 0 auto',
      }}>
        <Button
          // O link deve apontar para a página do seu frontend onde está o formulário
          // de criação de item na lista SolicitacaoCadastro.
          // Como o formulário não está no Admin UI, você deve apontar para o seu frontend.
          href="http://localhost:5173/solicitar-cadastro" // Mude esta URL para a URL do seu frontend
          target="_blank" // Abre em uma nova aba
          tone="active"
          size="large"
          css={{ width: '100%' }}
        >
          Solicitar Cadastro
        </Button>
      </Box>
    </>
   );
};
