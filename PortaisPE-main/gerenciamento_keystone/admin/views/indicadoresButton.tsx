/** @jsxRuntime classic */
/** @jsx jsx */

import { jsx } from '@keystone-ui/core';
import { Button } from '@keystone-ui/button';

export const IndicadoresButton = () => {
  const handleClick = () => {
    window.open('/indicadores_de_acesso', '_blank');
  };

  return (
    <div style={{ padding: '20px', textAlign: 'center' }}>
      <Button
        onClick={handleClick}
        tone="positive"
        size="large"
      >
        📊 Ver Indicadores de Acesso
      </Button>
      <p style={{ marginTop: '10px', color: '#64748b', fontSize: '14px' }}>
        Clique para abrir a página de monitoramento de acessos
      </p>
    </div>
  );
};