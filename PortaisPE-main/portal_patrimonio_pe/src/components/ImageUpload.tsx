/// <reference types="vite/client" />

import React, { useRef, useState, useCallback, type ChangeEvent } from 'react';

interface ImageUploadProps {
  /** URL da imagem atual (para preview em edição) */
  value?: { url?: string } | null;
  /** Callback chamado quando um arquivo é selecionado ou removido */
  onChange: (file: File | null) => void;
  /** Label do campo (opcional) */
  label?: string;
  /** ID único para o input (opcional) */
  id?: string;
}

/**
 * Componente de upload de imagem com preview e suporte a Tailwind.
 *
 * - Mostra preview da imagem atual (value.url) se existir
 * - Permite selecionar um novo arquivo
 * - Chama onChange com o File selecionado (ou null se removido)
 * - Aceita drag & drop básico
 */
export default function ImageUpload({
  value,
  onChange,
  label = 'Imagem',
  id,
}: ImageUploadProps) {
  const inputRef = useRef<HTMLInputElement>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);
  const [isDragging, setIsDragging] = useState(false);

  const inputId = id ?? `image-upload-${Math.random().toString(36).slice(2, 9)}`;

  /**
   * Manipula a seleção de arquivo via input ou drag & drop.
   */
  const handleFileSelect = useCallback(
    (file: File | null) => {
      if (!file) {
        // Remove preview local, mantém o value original se existir
        setPreviewUrl(null);
        onChange(null);
        return;
      }

      // Valida se é imagem
      if (!file.type.startsWith('image/')) {
        alert('Por favor, selecione apenas arquivos de imagem.');
        return;
      }

      // Valida tamanho (max 10MB)
      const maxSize = 10 * 1024 * 1024; // 10MB
      if (file.size > maxSize) {
        alert('A imagem deve ter no máximo 10MB.');
        return;
      }

      // Gera preview local
      const objectUrl = URL.createObjectURL(file);
      setPreviewUrl(objectUrl);

      // Notifica o componente pai
      onChange(file);
    },
    [onChange]
  );

  /**
   * Handler para o input type=file.
   */
  const handleInputChange = useCallback(
    (e: ChangeEvent<HTMLInputElement>) => {
      const file = e.target.files?.[0] ?? null;
      handleFileSelect(file);

      // Reset do input para permitir selecionar o mesmo arquivo novamente
      e.target.value = '';
    },
    [handleFileSelect]
  );

  /**
   * Handler para clique no botão de remover.
   */
  const handleRemove = useCallback(() => {
    setPreviewUrl(null);
    onChange(null);
    if (inputRef.current) {
      inputRef.current.value = '';
    }
  }, [onChange]);

  /**
   * Handler para clique no botão de selecionar.
   */
  const handleSelectClick = useCallback(() => {
    inputRef.current?.click();
  }, []);

  // ============================
  // Drag & Drop handlers
  // ============================
  const handleDragOver = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragging(true);
  }, []);

  const handleDragLeave = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragging(false);
  }, []);

  const handleDrop = useCallback(
    (e: React.DragEvent) => {
      e.preventDefault();
      e.stopPropagation();
      setIsDragging(false);

      const file = e.dataTransfer.files?.[0] ?? null;
      handleFileSelect(file);
    },
    [handleFileSelect]
  );

  // Determina qual URL mostrar no preview
  const displayUrl = previewUrl ?? value?.url ?? null;
  const hasImage = !!displayUrl;

  return (
    <div>
      {/* Label */}
      {label && (
        <label
          htmlFor={inputId}
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          {label}
        </label>
      )}

      {/* Input file oculto */}
      <input
        ref={inputRef}
        type="file"
        id={inputId}
        accept="image/*"
        onChange={handleInputChange}
        className="hidden"
      />

      {/* Área de upload / preview */}
      <div
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onDrop={handleDrop}
        className={`relative border-2 border-dashed rounded-lg p-4 transition-colors ${
          isDragging
            ? 'border-[#003087] bg-blue-50'
            : hasImage
            ? 'border-gray-300 bg-gray-50'
            : 'border-gray-300 hover:border-gray-400 bg-white'
        }`}
      >
        {hasImage ? (
          /* Preview da imagem */
          <div className="space-y-3">
            <div className="relative w-full max-w-xs mx-auto">
              <img
                src={displayUrl!}
                alt="Preview"
                className="w-full h-40 object-cover rounded-lg border border-gray-200"
                onError={(e) => {
                  // Se a URL falhar, mostra placeholder
                  (e.target as HTMLImageElement).style.display = 'none';
                }}
              />
            </div>
            <div className="flex items-center justify-center gap-2">
              <button
                type="button"
                onClick={handleSelectClick}
                className="px-3 py-1.5 text-xs font-medium text-[#003087] bg-blue-50 rounded-lg hover:bg-blue-100 transition-colors"
              >
                Trocar imagem
              </button>
              <button
                type="button"
                onClick={handleRemove}
                className="px-3 py-1.5 text-xs font-medium text-red-700 bg-red-50 rounded-lg hover:bg-red-100 transition-colors"
              >
                Remover
              </button>
            </div>
          </div>
        ) : (
          /* Placeholder de upload */
          <div
            onClick={handleSelectClick}
            className="flex flex-col items-center justify-center py-6 cursor-pointer"
          >
            {/* Ícone de upload */}
            <svg
              className="w-10 h-10 text-gray-400 mb-2"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={1.5}
                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
              />
            </svg>
            <p className="text-sm text-gray-500 font-medium">
              {isDragging
                ? 'Solte a imagem aqui'
                : 'Clique para selecionar ou arraste uma imagem'}
            </p>
            <p className="text-xs text-gray-400 mt-1">
              PNG, JPG, WebP até 10MB
            </p>
          </div>
        )}
      </div>

      {/* Instrução adicional quando já existe imagem via value */}
      {!previewUrl && value?.url && (
        <p className="text-xs text-gray-400 mt-1">
          Clique em "Trocar imagem" para substituir. Deixe vazio para manter a atual.
        </p>
      )}
    </div>
  );
}

