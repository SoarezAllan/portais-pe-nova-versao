import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Checkbox } from '@/components/ui/checkbox';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { RichTextEditor } from '@/components/RichTextEditor';
import { ImageUpload } from '@/components/ImageUpload';
import { useForm, Controller } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save } from 'lucide-react';
import { graphqlRequest, generateSlug, DEFAULT_DOCUMENT } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function NoticiasForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData, isLoading } = useQuery({
    queryKey: ['noticias', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetNoticia($id: ID!) {
          item: noticia(where: { id: $id }) {
            id titulo subtitulo slug resumo corpo { document } imagemPrincipal { id url } imagemPrincipalAlt dataPublicacao destaque ativo areaResponsavel { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, control, reset, watch, setValue } = useForm({
    defaultValues: {
      titulo: '',
      subtitulo: '',
      slug: '',
      resumo: '',
      imagemPrincipalAlt: '',
      dataPublicacao: new Date().toISOString().split('T')[0],
      destaque: false,
      ativo: true,
      areaResponsavel: '',
      corpo: DEFAULT_DOCUMENT,
    },
  });

  const titulo = watch('titulo');

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        titulo: item.titulo || '',
        subtitulo: item.subtitulo || '',
        slug: item.slug || '',
        resumo: item.resumo || '',
        imagemPrincipalAlt: item.imagemPrincipalAlt || '',
        dataPublicacao: item.dataPublicacao ? item.dataPublicacao.split('T')[0] : new Date().toISOString().split('T')[0],
        destaque: item.destaque ?? false,
        ativo: item.ativo ?? true,
        areaResponsavel: item.areaResponsavel?.id || '',
        corpo: typeof item.corpo?.document === 'string' ? item.corpo.document : JSON.stringify(item.corpo?.document || JSON.parse(DEFAULT_DOCUMENT)),
      });
    }
  }, [itemData, reset]);

  useEffect(() => {
    if (isNew && titulo && !watch('slug')) {
      setValue('slug', generateSlug(titulo));
    }
  }, [titulo, isNew, setValue, watch]);

  const handleDocumentChange = (field: string) => (json: any) => {
    setValue(field as any, JSON.stringify(json));
  };

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        titulo: formData.titulo,
        subtitulo: formData.subtitulo,
        slug: generateSlug(formData.titulo),
        resumo: formData.resumo,
        imagemPrincipalAlt: formData.titulo,
        dataPublicacao: formData.dataPublicacao,
        destaque: formData.destaque,
        ativo: formData.ativo,
        corpo: JSON.parse(formData.corpo),
      };

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }

      if (isNew) {
        const mutation = `mutation($data: NoticiaCreateInput!) { item: createNoticia(data: $data) { id } }`;
        await graphqlRequest(mutation, { data });
      } else {
        const mutation = `mutation($id: ID!, $data: NoticiaUpdateInput!) { item: updateNoticia(where: { id: $id }, data: $data) { id } }`;
        await graphqlRequest(mutation, { id, data });
      }
      navigate('/noticias');
    } catch (err) {
      console.error(err);
    } finally {
      setSaving(false);
    }
  };

  if (!isNew && (isLoading || itemData === undefined)) {
    return (
      <div className="flex items-center justify-center py-12">
        <Loader2 className="h-8 w-8 animate-spin text-[#003087]" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" onClick={() => navigate('/noticias')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Nova Notícia' : 'Editar Notícia'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Informações Básicas</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título *</Label>
              <Input id="titulo" {...register('titulo', { required: true })} placeholder="Ex: SAD divulga novo cronograma de leilões" />
              {titulo && (
                <p className="text-xs text-slate-500 font-mono">
                  Endereço (link da página) gerado automaticamente: <span className="text-blue-600 font-medium">/{generateSlug(titulo)}</span>
                </p>
              )}
            </div>
            <div className="space-y-2">
              <Label htmlFor="subtitulo">Subtítulo</Label>
              <Input id="subtitulo" {...register('subtitulo')} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="resumo">Resumo</Label>
              <Textarea id="resumo" rows={3} {...register('resumo')} />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="dataPublicacao">Data de Publicação</Label>
                <Input id="dataPublicacao" type="date" {...register('dataPublicacao')} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="areaResponsavel">Área Responsável</Label>
                <select
                  id="areaResponsavel"
                  {...register('areaResponsavel')}
                  className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm"
                >
                  <option value="">Selecione...</option>
                  {areas?.areas.map((area) => (
                    <option key={area.id} value={area.id}>{area.nome}</option>
                  ))}
                </select>
              </div>
            </div>
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Checkbox id="destaque" checked={watch('destaque')} onCheckedChange={(v) => setValue('destaque', !!v)} />
                <Label htmlFor="destaque">Destaque</Label>
              </div>
              <div className="flex items-center gap-2">
                <Checkbox id="ativo" checked={watch('ativo')} onCheckedChange={(v) => setValue('ativo', !!v)} />
                <Label htmlFor="ativo">Ativo</Label>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>Imagem Principal</CardTitle></CardHeader>
          <CardContent>
            <ImageUpload
              value={itemData?.item?.imagemPrincipal}
              onChange={(file) => {}}
              label="Imagem Principal"
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>Corpo da Notícia</CardTitle></CardHeader>
          <CardContent>
            <Controller
              name="corpo"
              control={control}
              render={({ field }) => (
                <RichTextEditor
                  content={JSON.parse(field.value || DEFAULT_DOCUMENT)}
                  onChange={handleDocumentChange('corpo')}
                  placeholder="Escreva o conteúdo da notícia aqui..."
                />
              )}
            />
          </CardContent>
        </Card>

        <div className="flex items-center justify-end gap-3">
          <Button type="button" variant="outline" onClick={() => navigate('/noticias')}>
            Cancelar
          </Button>
          <Button type="submit" className="bg-[#003087] hover:bg-[#002060] text-white" disabled={saving}>
            {saving ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : <Save className="mr-2 h-4 w-4" />}
            {isNew ? 'Criar Notícia' : 'Salvar Alterações'}
          </Button>
        </div>
      </form>
    </div>
  );
}
