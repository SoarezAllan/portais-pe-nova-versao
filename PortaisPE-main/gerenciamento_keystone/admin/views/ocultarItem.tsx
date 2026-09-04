import { useState } from 'react';

const OcultarItemView = ({ value, onChange, item }: any) => {
  const isOculto = !value;

  const handleToggle = () => {
    onChange?.(!value);
  };

  return (
    <div
      style={{
        padding: '12px',
        borderRadius: '4px',
        backgroundColor: isOculto ? '#ffe6e6' : '#e6ffe6',
        border: `2px solid ${isOculto ? '#dc3545' : '#28a745'}`,
        display: 'flex',
        alignItems: 'center',
        gap: '12px',
        marginBottom: '16px',
      }}
    >
      <div
        style={{
          flex: 1,
          display: 'flex',
          alignItems: 'center',
          gap: '8px',
        }}
      >
        <div
          style={{
            width: '12px',
            height: '12px',
            borderRadius: '50%',
            backgroundColor: isOculto ? '#dc3545' : '#28a745',
          }}
        />
        <span style={{ fontWeight: 'bold', color: isOculto ? '#dc3545' : '#28a745' }}>
          {isOculto ? '🔒 OCULTO - Não aparece no portal' : '👁️ VISÍVEL - Aparece no portal'}
        </span>
      </div>

      <button
        onClick={handleToggle}
        style={{
          padding: '8px 16px',
          borderRadius: '4px',
          border: 'none',
          backgroundColor: isOculto ? '#28a745' : '#dc3545',
          color: 'white',
          cursor: 'pointer',
          fontWeight: 'bold',
          fontSize: '12px',
        }}
        onMouseEnter={(e) => {
          (e.currentTarget as HTMLButtonElement).style.opacity = '0.8';
        }}
        onMouseLeave={(e) => {
          (e.currentTarget as HTMLButtonElement).style.opacity = '1';
        }}
      >
        {isOculto ? 'MOSTRAR' : 'OCULTAR'}
      </button>
    </div>
  );
};
// Keystone expects named exports for custom field views (e.g. `Field`).
// Export only the allowed named export `Field` and avoid a default export.
export const Field = OcultarItemView;
