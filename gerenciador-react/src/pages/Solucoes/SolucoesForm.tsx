import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Checkbox } from '@/components/ui/checkbox';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { ImageUpload } from '@/components/ImageUpload';
import { useForm, Controller } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save } from 'lucide-react';
import { graphqlRequest, generateSlug } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function SolucoesForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['solucoes', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetSolucao($id: ID!) {
          item: solucao(where: { id: $id }) {
            id titulo slug categoria resumo linkExterno imagem { id url } imagemAlt ativo areaResponsavel { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, control, reset, watch, setValue } = useForm({
    defaultValues: {
      titulo: '',
      slug: '',
      categoria: 'SISTEMAS',
      resumo: '',
      linkExterno: '',
      imagemAlt: '',
      ativo: true,
      areaResponsavel: '',
      imagem: null as any,
    },
  });

  const titulo = watch('titulo');

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        titulo: item.titulo || '',
        slug: item.slug || '',
        categoria: item.categoria || 'SISTEMAS',
        resumo: item.resumo || '',
        linkExterno: item.linkExterno || '',
        imagemAlt: item.imagemAlt || '',
        ativo: item.ativo ?? true,
        areaResponsavel: item.areaResponsavel?.id || '',
        imagem: item.imagem || null,
      });
    }
  }, [itemData, reset]);

  useEffect(() => {
    if (isNew && titulo && !watch('slug')) {
      setValue('slug', generateSlug(titulo));
    }
  }, [titulo, isNew, setValue, watch]);

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        titulo: formData.titulo,
        slug: generateSlug(formData.titulo),
        categoria: formData.categoria,
        resumo: formData.resumo,
        linkExterno: formData.linkExterno,
        imagemAlt: formData.titulo,
        ativo: formData.ativo,
      };

      if (formData.imagem && formData.imagem.id) {
        data.imagem = {
          id: formData.imagem.id,
          filesize: formData.imagem.filesize || 0,
          width: formData.imagem.width || 0,
          height: formData.imagem.height || 0,
          extension: formData.imagem.extension || 'png',
        };
      }

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }

      if (isNew) {
        await graphqlRequest(`mutation($data: SolucaoCreateInput!) { createSolucao(data: $data) { id } }`, { data });
      } else {
        await graphqlRequest(`mutation($id: ID!, $data: SolucaoUpdateInput!) { updateSolucao(where: { id: $id }, data: $data) { id } }`, { id, data });
      }
      navigate('/solucoes');
    } catch (err) {
      console.error(err);
    } finally {
      setSaving(false);
    }
  };

  if (!isNew && itemData === undefined) {
    return (
      <div className="flex items-center justify-center py-12">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" onClick={() => navigate('/solucoes')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Nova Solução' : 'Editar Solução'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Informações Básicas</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título *</Label>
              <Input id="titulo" {...register('titulo', { required: true })} placeholder="Ex: Sistema de Gestão Patrimonial" />
              {titulo && (
                <p className="text-xs text-slate-500 font-mono">
                  Slug gerado automaticamente: <span className="text-blue-600 font-medium">/{generateSlug(titulo)}</span>
                </p>
              )}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="categoria">Categoria *</Label>
                <select id="categoria" {...register('categoria')} className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm">
                  <option value="SISTEMAS">Sistemas</option>
                  <option value="PROCESSOS">Processos</option>
                  <option value="FERRAMENTAS">Ferramentas</option>
                </select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="areaResponsavel">Área Responsável</Label>
                <select id="areaResponsavel" {...register('areaResponsavel')} className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm">
                  <option value="">Selecione...</option>
                  {areas?.areas.map((a) => (
                    <option key={a.id} value={a.id}>{a.nome}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="linkExterno">Link Externo</Label>
              <Input id="linkExterno" type="url" {...register('linkExterno')} placeholder="https://..." />
            </div>

            <div className="space-y-2">
              <Label htmlFor="resumo">Resumo</Label>
              <Textarea id="resumo" rows={3} {...register('resumo')} />
            </div>

            <div className="flex items-center gap-2">
              <Checkbox id="ativo" checked={watch('ativo')} onCheckedChange={(v) => setValue('ativo', !!v)} />
              <Label htmlFor="ativo">Ativo</Label>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>Imagem</CardTitle></CardHeader>
          <CardContent>
            <Controller control={control} name="imagem" render={({ field }) => (
              <ImageUpload value={field.value} onChange={field.onChange} label="Imagem da Solução" />
            )} />
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/solucoes')}>Cancelar</Button>
          <Button type="submit" disabled={saving}>
            {saving ? <><Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...</> : <><Save className="h-4 w-4 mr-2" /> Salvar</>}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default SolucoesForm;
