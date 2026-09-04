/// <reference types="vite/client" />

import React from 'react';

interface LoadingProps {
  /** Texto opcional exibido ao lado do spinner */
  message?: string;
}

/**
 * Spinner SVG animado com texto opcional.
 * Substitui strings "Carregando..." soltas nos componentes.
 */
export default function Loading({ message = 'Carregando...' }: LoadingProps) {
  return (
    <div className="flex justify-center py-12">
      <div className="flex items-center gap-3 text-gray-500">
        <svg className="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
        </svg>
        <span>{message}</span>
      </div>
    </div>
  );
}
