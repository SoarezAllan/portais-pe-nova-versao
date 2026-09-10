import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Checkbox } from '@/components/ui/checkbox';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { PortfolioMultiImageUpload, type PortfolioImageItem } from '@/components/PortfolioMultiImageUpload';
import { useForm } from 'react-hook-form';
import { useEffect, useState, useMemo } from 'react';
import { Loader2, ArrowLeft, Save, Building } from 'lucide-react';
import { graphqlRequest, generateSlug } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function PortfolioForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);
  const [images, setImages] = useState<PortfolioImageItem[]>([]);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  // O portfólio pertence exclusivamente à Área de Engenharia e Arquitetura
  const engArea = useMemo(() => {
    return areas?.areas.find(
      (a) =>
        a.nome.toLowerCase().includes('engenharia') ||
        a.nome.toLowerCase().includes('arquitetura')
    );
  }, [areas]);

  const { data: itemData } = useQuery({
    queryKey: ['portfolios', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetPortfolio($id: ID!) {
          item: portfolio(where: { id: $id }) {
            id
            titulo
            slug
            resumo
            imagem {
              id
              url
              filesize
              width
              height
              extension
            }
            imagemAlt
            galeria {
              id
              titulo
              imagem {
                id
                url
                filesize
                width
                height
                extension
              }
              ativo
            }
            ativo
            areaResponsavel { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, reset, watch, setValue } = useForm({
    defaultValues: {
      titulo: '',
      slug: '',
      resumo: '',
      ativo: true,
      areaResponsavel: '',
    },
  });

  const titulo = watch('titulo');

  // Preenchimento inicial dos dados
  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        titulo: item.titulo || '',
        slug: item.slug || '',
        resumo: item.resumo || '',
        ativo: item.ativo ?? true,
        areaResponsavel: item.areaResponsavel?.id || engArea?.id || '',
      });

      // Reconstrói a lista unificada de imagens (Capa Principal na posição 0 + Galeria)
      const loadedImages: PortfolioImageItem[] = [];
      if (item.imagem && item.imagem.url) {
        loadedImages.push({
          id: item.imagem.id || `cover-${Date.now()}`,
          url: item.imagem.url,
          filesize: item.imagem.filesize,
          width: item.imagem.width,
          height: item.imagem.height,
          extension: item.imagem.extension,
          titulo: item.imagemAlt || item.titulo || 'Capa',
        });
      }

      if (Array.isArray(item.galeria)) {
        item.galeria.forEach((g: any) => {
          if (g.imagem && g.imagem.url) {
            loadedImages.push({
              id: g.imagem.id || g.id,
              url: g.imagem.url,
              filesize: g.imagem.filesize,
              width: g.imagem.width,
              height: g.imagem.height,
              extension: g.imagem.extension,
              titulo: g.titulo || '',
            });
          }
        });
      }

      setImages(loadedImages);
    } else if (isNew && engArea?.id) {
      setValue('areaResponsavel', engArea.id);
    }
  }, [itemData, engArea, isNew, reset, setValue]);

  // Geração automática do endereço
  useEffect(() => {
    if (isNew && titulo && !watch('slug')) {
      setValue('slug', generateSlug(titulo));
    }
  }, [titulo, isNew, setValue, watch]);

  const onSubmit = async (formData: any) => {
    // Verifica se ainda há imagens enviando
    const isStillUploading = images.some((img) => img.isUploading);
    if (isStillUploading) {
      alert('Por favor, aguarde a conclusão do envio das imagens antes de salvar o projeto.');
      return;
    }

    setSaving(true);
    try {
      const targetAreaId = formData.areaResponsavel || engArea?.id;
      const data: any = {
        titulo: formData.titulo,
        slug: generateSlug(formData.titulo),
        resumo: formData.resumo,
        imagemAlt: formData.titulo,
        ativo: formData.ativo,
      };

      // Foto principal do projeto (Posição 0)
      if (images.length > 0 && images[0].id && !images[0].id.startsWith('temp-')) {
        data.imagem = {
          id: images[0].id,
          filesize: images[0].filesize || 0,
          width: images[0].width || 0,
          height: images[0].height || 0,
          extension: images[0].extension || 'png',
        };
      } else if (images.length === 0) {
        data.imagem = null;
      }

      // Galeria de fotos adicionais (Posições 1..14)
      const galleryImages = images.slice(1).filter((img) => img.id && !img.id.startsWith('temp-'));
      data.galeria = {
        create: galleryImages.map((img) => ({
          imagem: {
            id: img.id,
            filesize: img.filesize || 0,
            width: img.width || 0,
            height: img.height || 0,
            extension: img.extension || 'png',
          },
          titulo: img.titulo || '',
          ativo: true,
        })),
      };

      if (targetAreaId) {
        data.areaResponsavel = { connect: { id: targetAreaId } };
      }

      if (isNew) {
        await graphqlRequest(`mutation($data: PortfolioCreateInput!) { createPortfolio(data: $data) { id } }`, { data });
      } else {
        await graphqlRequest(`mutation($id: ID!, $data: PortfolioUpdateInput!) { updatePortfolio(where: { id: $id }, data: $data) { id } }`, { id, data });
      }
      navigate('/portfolio');
    } catch (err) {
      console.error('Erro ao salvar projeto:', err);
      alert('Ocorreu um erro ao salvar o projeto. Verifique o console para mais detalhes.');
    } finally {
      setSaving(false);
    }
  };

  if (!isNew && itemData === undefined) {
    return (
      <div className="flex items-center justify-center py-12">
        <Loader2 className="h-8 w-8 animate-spin text-[#003087]" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" onClick={() => navigate('/portfolio')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Novo Item do Portfólio' : 'Editar Item do Portfólio'}
          </h2>
          <p className="text-sm text-gray-500 mt-0.5">Galeria institucional de obras e projetos</p>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card className="border-slate-200 shadow-sm">
          <CardHeader>
            <CardTitle className="text-lg">Informações do Projeto</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título do Projeto *</Label>
              <Input
                id="titulo"
                {...register('titulo', { required: true })}
                placeholder="Ex: Reforma e Restauro do Palácio do Campo das Princesas"
              />
              {titulo && (
                <p className="text-xs text-slate-500 font-mono">
                  Endereço (link da página) gerado automaticamente:{' '}
                  <span className="text-[#003087] font-semibold">/{generateSlug(titulo)}</span>
                </p>
              )}
            </div>

            {/* Seleção Exclusiva da Área de Engenharia e Arquitetura */}
            <div className="space-y-2">
              <Label htmlFor="areaResponsavel">Área Responsável</Label>
              <div className="relative">
                <select
                  id="areaResponsavel"
                  {...register('areaResponsavel')}
                  className="flex h-10 w-full rounded-md border border-slate-300 bg-slate-50 px-3 py-2 text-sm text-slate-800 font-medium cursor-not-allowed opacity-90"
                  disabled
                >
                  {engArea ? (
                    <option value={engArea.id}>{engArea.nome}</option>
                  ) : (
                    <option value="">Engenharia e Arquitetura</option>
                  )}
                </select>
              </div>
              <p className="text-xs text-slate-500 flex items-center gap-1.5 mt-1">
                <Building className="h-3.5 w-3.5 text-[#003087]" />
                O módulo de Portfólio é exclusivo do Portal de Engenharia e Arquitetura.
              </p>
            </div>

            <div className="space-y-2">
              <Label htmlFor="resumo">Resumo / Descrição da Obra</Label>
              <Textarea
                id="resumo"
                rows={3}
                {...register('resumo')}
                placeholder="Descreva brevemente o projeto, intervenções realizadas, localização..."
              />
            </div>

            <div className="flex items-center gap-2 pt-1">
              <Checkbox
                id="ativo"
                checked={watch('ativo')}
                onCheckedChange={(v) => setValue('ativo', !!v)}
              />
              <Label htmlFor="ativo" className="cursor-pointer font-medium text-slate-700">
                Publicar no portal (Ativo)
              </Label>
            </div>
          </CardContent>
        </Card>

        {/* Seção de Imagens: Capa Principal e Galeria com suporte a múltiplos arquivos (máx 15) */}
        <Card className="border-slate-200 shadow-sm">
          <CardHeader>
            <CardTitle className="text-lg">Imagem de Capa do Projeto e Fotos</CardTitle>
          </CardHeader>
          <CardContent>
            <PortfolioMultiImageUpload
              value={images}
              onChange={setImages}
              maxImages={15}
            />
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/portfolio')}>
            Cancelar
          </Button>
          <Button type="submit" disabled={saving} className="bg-[#003087] hover:bg-[#002266] text-white">
            {saving ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...
              </>
            ) : (
              <>
                <Save className="h-4 w-4 mr-2" /> Salvar Projeto
              </>
            )}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default PortfolioForm;

