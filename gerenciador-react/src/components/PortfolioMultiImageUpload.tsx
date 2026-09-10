import { useCallback, useState, useRef } from 'react';
import { Upload, X, Star, ArrowLeft, ArrowRight, Loader2, Image as ImageIcon, AlertCircle } from 'lucide-react';
import { Button } from './ui/button';
import { uploadFile } from '@/lib/api';

export interface PortfolioImageItem {
  id: string;
  url: string;
  filesize?: number;
  width?: number;
  height?: number;
  extension?: string;
  titulo?: string;
  isUploading?: boolean;
  tempUrl?: string;
  error?: string;
}

interface PortfolioMultiImageUploadProps {
  value: PortfolioImageItem[];
  onChange: React.Dispatch<React.SetStateAction<PortfolioImageItem[]>>;
  maxImages?: number;
}

export function PortfolioMultiImageUpload({
  value = [],
  onChange,
  maxImages = 15,
}: PortfolioMultiImageUploadProps) {
  const [isDragging, setIsDragging] = useState(false);
  const [warningMessage, setWarningMessage] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const processFiles = useCallback(
    async (files: FileList | File[]) => {
      setWarningMessage(null);
      const incomingFiles = Array.from(files).filter((f) => f.type.startsWith('image/'));

      if (incomingFiles.length === 0) {
        return;
      }

      const availableSlots = maxImages - value.length;

      if (availableSlots <= 0) {
        setWarningMessage(`Limite máximo de ${maxImages} imagens atingido.`);
        return;
      }

      let filesToUpload = incomingFiles;
      if (incomingFiles.length > availableSlots) {
        filesToUpload = incomingFiles.slice(0, availableSlots);
        setWarningMessage(
          `Você selecionou ${incomingFiles.length} imagens, mas só cabem mais ${availableSlots}. Apenas as primeiras ${availableSlots} imagens foram adicionadas.`
        );
      }

      // Cria itens temporários para feedback visual imediato
      const tempItems: PortfolioImageItem[] = filesToUpload.map((file) => {
        const tempId = `temp-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`;
        const tempUrl = URL.createObjectURL(file);
        return {
          id: tempId,
          url: tempUrl,
          tempUrl,
          titulo: file.name.replace(/\.[^/.]+$/, ''),
          isUploading: true,
        };
      });

      onChange((prev) => [...prev, ...tempItems]);

      // Executa os uploads em paralelo
      await Promise.all(
        filesToUpload.map(async (file, idx) => {
          const tempItem = tempItems[idx];
          try {
            const uploaded = await uploadFile(file);
            onChange((prev) =>
              prev.map((item) => {
                if (item.id === tempItem.id) {
                  return {
                    ...item,
                    id: uploaded.id,
                    url: uploaded.url,
                    filesize: uploaded.filesize || file.size,
                    width: uploaded.width || 0,
                    height: uploaded.height || 0,
                    extension: uploaded.extension || file.name.split('.').pop() || 'png',
                    isUploading: false,
                  };
                }
                return item;
              })
            );
          } catch (err: any) {
            console.error('Erro ao enviar imagem:', err);
            onChange((prev) =>
              prev.map((item) => {
                if (item.id === tempItem.id) {
                  return {
                    ...item,
                    isUploading: false,
                    error: err?.message || 'Falha no upload',
                  };
                }
                return item;
              })
            );
          }
        })
      );
    },
    [value, onChange, maxImages]
  );

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files.length > 0) {
      processFiles(e.target.files);
    }
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      processFiles(e.dataTransfer.files);
    }
  };

  const handleRemove = (index: number) => {
    setWarningMessage(null);
    const updated = value.filter((_, i) => i !== index);
    onChange(updated);
  };

  const handleSetCover = (index: number) => {
    if (index === 0) return;
    const target = value[index];
    const rest = value.filter((_, i) => i !== index);
    onChange([target, ...rest]);
  };

  const handleMove = (index: number, direction: 'left' | 'right') => {
    const targetIndex = direction === 'left' ? index - 1 : index + 1;
    if (targetIndex < 0 || targetIndex >= value.length) return;
    const listCopy = [...value];
    const temp = listCopy[index];
    listCopy[index] = listCopy[targetIndex];
    listCopy[targetIndex] = temp;
    onChange(listCopy);
  };

  const remaining = maxImages - value.length;

  return (
    <div className="space-y-4">
      {/* Header com contador e regras */}
      <div className="flex flex-wrap items-center justify-between gap-2 border-b border-slate-200 pb-3">
        <div>
          <div className="flex items-center gap-2">
            <h3 className="text-base font-semibold text-slate-800">
              Fotos do Projeto & Capa Principal
            </h3>
            <span
              className={`text-xs font-semibold px-2.5 py-0.5 rounded-full ${
                value.length >= maxImages
                  ? 'bg-amber-100 text-amber-800'
                  : 'bg-blue-100 text-[#003087]'
              }`}
            >
              {value.length} / {maxImages} fotos
            </span>
          </div>
          <p className="text-xs text-slate-500 mt-0.5">
            Selecione várias fotos ao mesmo tempo (máximo de {maxImages} fotos). A primeira foto será a{' '}
            <strong className="text-slate-700">Foto Principal (Capa)</strong>.
          </p>
        </div>

        {remaining > 0 && (
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={() => fileInputRef.current?.click()}
            className="border-[#003087] text-[#003087] hover:bg-blue-50 font-medium text-xs flex items-center gap-1.5"
          >
            <Upload className="h-3.5 w-3.5" />
            Adicionar Fotos (+{remaining} restantes)
          </Button>
        )}
      </div>

      {/* Aviso / Alerta se exceder limite */}
      {warningMessage && (
        <div className="flex items-center gap-2 p-3 bg-amber-50 border border-amber-200 rounded-lg text-amber-800 text-xs animate-in fade-in">
          <AlertCircle className="h-4 w-4 shrink-0 text-amber-600" />
          <span>{warningMessage}</span>
          <button
            type="button"
            onClick={() => setWarningMessage(null)}
            className="ml-auto text-amber-700 hover:text-amber-900 font-bold"
          >
            ×
          </button>
        </div>
      )}

      {/* Input de Arquivos Oculto com suporte a múltiplos arquivos */}
      <input
        ref={fileInputRef}
        type="file"
        multiple
        accept="image/jpeg,image/png,image/webp,image/gif"
        onChange={handleFileChange}
        className="hidden"
      />

      {/* Área de Dropzone quando não atingiu o limite */}
      {value.length < maxImages && (
        <div
          onDragOver={handleDragOver}
          onDragLeave={handleDragLeave}
          onDrop={handleDrop}
          onClick={() => fileInputRef.current?.click()}
          className={`border-2 border-dashed rounded-xl p-6 text-center cursor-pointer transition-all duration-200 ${
            isDragging
              ? 'border-[#003087] bg-blue-50/70 scale-[0.99]'
              : 'border-slate-300 hover:border-[#003087] hover:bg-slate-50/80 bg-white'
          }`}
        >
          <div className="flex flex-col items-center justify-center space-y-2">
            <div className="p-3 bg-blue-50 rounded-full text-[#003087]">
              <Upload className="h-6 w-6" />
            </div>
            <div>
              <p className="text-sm font-semibold text-slate-700">
                Clique aqui ou arraste várias imagens ao mesmo tempo
              </p>
              <p className="text-xs text-slate-500 mt-1">
                Formatos suportados: PNG, JPG, JPEG, WEBP • Seleção múltipla até {maxImages} imagens
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Galeria de Fotos Adicionadas */}
      {value.length > 0 && (
        <div className="space-y-2 pt-2">
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
            {value.map((item, index) => {
              const isCover = index === 0;
              return (
                <div
                  key={item.id || index}
                  className={`group relative rounded-xl border overflow-hidden transition-all duration-200 bg-white shadow-sm hover:shadow-md flex flex-col ${
                    isCover
                      ? 'border-2 border-[#003087] ring-2 ring-blue-100'
                      : 'border-slate-200'
                  }`}
                >
                  {/* Badge de Capa ou Posição */}
                  <div className="absolute top-2 left-2 z-10 flex items-center gap-1.5">
                    {isCover ? (
                      <span className="bg-[#003087] text-white text-[11px] font-bold px-2.5 py-1 rounded-md shadow-md flex items-center gap-1">
                        <Star className="h-3 w-3 fill-amber-300 text-amber-300" />
                        Foto Principal (Capa)
                      </span>
                    ) : (
                      <span className="bg-black/65 backdrop-blur-sm text-white text-[10px] font-medium px-2 py-0.5 rounded shadow">
                        Foto #{index + 1}
                      </span>
                    )}
                  </div>

                  {/* Botão de Excluir */}
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleRemove(index);
                    }}
                    title="Remover foto"
                    className="absolute top-2 right-2 z-10 bg-red-600/90 text-white rounded-full p-1.5 hover:bg-red-700 shadow-md transition-transform hover:scale-110"
                  >
                    <X className="h-3.5 w-3.5" />
                  </button>

                  {/* Imagem / Preview */}
                  <div className="relative w-full aspect-video bg-slate-100 overflow-hidden">
                    <img
                      src={item.url || item.tempUrl}
                      alt={item.titulo || `Foto ${index + 1}`}
                      className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                    />

                    {/* Overlay de Uploading */}
                    {item.isUploading && (
                      <div className="absolute inset-0 bg-black/50 backdrop-blur-[1px] flex flex-col items-center justify-center text-white z-20">
                        <Loader2 className="h-6 w-6 animate-spin text-white mb-1" />
                        <span className="text-[11px] font-medium">Enviando...</span>
                      </div>
                    )}

                    {/* Overlay de Erro */}
                    {item.error && (
                      <div className="absolute inset-0 bg-red-900/80 backdrop-blur-[1px] flex flex-col items-center justify-center text-white p-2 text-center z-20">
                        <AlertCircle className="h-5 w-5 text-red-200 mb-1" />
                        <span className="text-[10px] font-medium">{item.error}</span>
                      </div>
                    )}
                  </div>

                  {/* Barra de Ações Inferior */}
                  <div className="p-2.5 bg-slate-50 border-t border-slate-100 flex items-center justify-between gap-1 text-xs mt-auto">
                    {/* Botão Definir como Capa */}
                    {!isCover && (
                      <button
                        type="button"
                        onClick={() => handleSetCover(index)}
                        className="text-[#003087] hover:text-[#002266] font-semibold text-[11px] flex items-center gap-1 hover:underline"
                        title="Tornar esta a foto principal de capa"
                      >
                        <Star className="h-3 w-3" />
                        Tornar Principal
                      </button>
                    )}

                    {isCover && (
                      <span className="text-slate-500 text-[11px] italic">
                        Capa Atual
                      </span>
                    )}

                    {/* Controles de Ordenação */}
                    <div className="flex items-center gap-1 ml-auto">
                      <button
                        type="button"
                        disabled={index === 0}
                        onClick={() => handleMove(index, 'left')}
                        className={`p-1 rounded border ${
                          index === 0
                            ? 'text-slate-300 border-slate-200 cursor-not-allowed'
                            : 'text-slate-600 border-slate-300 hover:bg-white hover:text-[#003087]'
                        }`}
                        title="Mover para esquerda"
                      >
                        <ArrowLeft className="h-3 w-3" />
                      </button>
                      <button
                        type="button"
                        disabled={index === value.length - 1}
                        onClick={() => handleMove(index, 'right')}
                        className={`p-1 rounded border ${
                          index === value.length - 1
                            ? 'text-slate-300 border-slate-200 cursor-not-allowed'
                            : 'text-slate-600 border-slate-300 hover:bg-white hover:text-[#003087]'
                        }`}
                        title="Mover para direita"
                      >
                        <ArrowRight className="h-3 w-3" />
                      </button>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {value.length === 0 && (
        <div className="flex items-center justify-center gap-2 py-4 text-slate-400 text-xs">
          <ImageIcon className="h-4 w-4" />
          <span>Nenhuma imagem adicionada ainda ao projeto.</span>
        </div>
      )}
    </div>
  );
}
