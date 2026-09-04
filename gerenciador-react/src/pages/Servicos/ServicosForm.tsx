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

const AREAS_QUERY = `query { areas { id nome subareas { id nome } } }`;

export function ServicosForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string; subareas: { id: string; nome: string }[] }[] }>(AREAS_QUERY),
  });

  const { data: itemData, isLoading } = useQuery({
    queryKey: ['servicos', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetServico($id: ID!) {
          item: servico(where: { id: $id }) {
            id
            titulo
            slug
            resumo
            imagem { id url }
            imagemAlt
            oQueE { document }
            quemPrecisa { document }
            comoSolicitar { document }
            maisInformacoes { document }
            ativo
            areaResponsavel { id nome }
            subarea { id nome }
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
      resumo: '',
      imagemAlt: '',
      ativo: true,
      areaResponsavel: '',
      subarea: '',
      oQueE: DEFAULT_DOCUMENT,
      quemPrecisa: DEFAULT_DOCUMENT,
      comoSolicitar: DEFAULT_DOCUMENT,
      maisInformacoes: DEFAULT_DOCUMENT,
    },
  });

  const titulo = watch('titulo');
  const selectedAreaId = watch('areaResponsavel');
  const availableSubareas = areas?.areas.find((a) => a.id === selectedAreaId)?.subareas || [];

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        titulo: item.titulo || '',
        slug: item.slug || '',
        resumo: item.resumo || '',
        imagemAlt: item.imagemAlt || '',
        ativo: item.ativo ?? true,
        areaResponsavel: item.areaResponsavel?.id || '',
        subarea: item.subarea?.id || '',
        oQueE: typeof item.oQueE?.document === 'string' ? item.oQueE.document : JSON.stringify(item.oQueE?.document || JSON.parse(DEFAULT_DOCUMENT)),
        quemPrecisa: typeof item.quemPrecisa?.document === 'string' ? item.quemPrecisa.document : JSON.stringify(item.quemPrecisa?.document || JSON.parse(DEFAULT_DOCUMENT)),
        comoSolicitar: typeof item.comoSolicitar?.document === 'string' ? item.comoSolicitar.document : JSON.stringify(item.comoSolicitar?.document || JSON.parse(DEFAULT_DOCUMENT)),
        maisInformacoes: typeof item.maisInformacoes?.document === 'string' ? item.maisInformacoes.document : JSON.stringify(item.maisInformacoes?.document || JSON.parse(DEFAULT_DOCUMENT)),
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
        slug: generateSlug(formData.titulo),
        resumo: formData.resumo,
        imagemAlt: formData.titulo,
        ativo: formData.ativo,
        oQueE: JSON.parse(formData.oQueE || DEFAULT_DOCUMENT),
        quemPrecisa: JSON.parse(formData.quemPrecisa || DEFAULT_DOCUMENT),
        comoSolicitar: JSON.parse(formData.comoSolicitar || DEFAULT_DOCUMENT),
        maisInformacoes: JSON.parse(formData.maisInformacoes || DEFAULT_DOCUMENT),
      };

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }
      if (formData.subarea) {
        data.subarea = { connect: { id: formData.subarea } };
      }

      if (isNew) {
        const mutation = `mutation($data: ServicoCreateInput!) { item: createServico(data: $data) { id } }`;
        await graphqlRequest(mutation, { data });
      } else {
        const mutation = `mutation($id: ID!, $data: ServicoUpdateInput!) { item: updateServico(where: { id: $id }, data: $data) { id } }`;
        await graphqlRequest(mutation, { id, data });
      }
      navigate('/servicos');
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/servicos')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Novo Serviço' : 'Editar Serviço'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Informações Básicas</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título *</Label>
              <Input id="titulo" {...register('titulo', { required: true })} placeholder="Ex: Gestão de Bens Móveis e Imóveis" />
              {titulo && (
                <p className="text-xs text-slate-500 font-mono">
                  Endereço (link da página) gerado automaticamente: <span className="text-blue-600 font-medium">/{generateSlug(titulo)}</span>
                </p>
              )}
            </div>
            <div className="space-y-2">
              <Label htmlFor="resumo">Resumo</Label>
              <Textarea id="resumo" rows={3} {...register('resumo')} />
            </div>
            <div className="grid grid-cols-2 gap-4">
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
              <div className="space-y-2">
                <Label htmlFor="subarea">Subárea</Label>
                <select
                  id="subarea"
                  {...register('subarea')}
                  className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm"
                >
                  <option value="">Selecione a subárea...</option>
                  {availableSubareas.map((sub) => (
                    <option key={sub.id} value={sub.id}>{sub.nome}</option>
                  ))}
                </select>
              </div>
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
            <ImageUpload
              value={itemData?.item?.imagem}
              onChange={(file) => {
                // Handle image upload
              }}
              label="Imagem do Serviço"
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>O que é?</CardTitle></CardHeader>
          <CardContent>
            <Controller
              name="oQueE"
              control={control}
              render={({ field }) => (
                <RichTextEditor
                  content={JSON.parse(field.value || DEFAULT_DOCUMENT)}
                  onChange={handleDocumentChange('oQueE')}
                  placeholder="Descreva o que é este serviço..."
                />
              )}
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>Quem precisa?</CardTitle></CardHeader>
          <CardContent>
            <Controller
              name="quemPrecisa"
              control={control}
              render={({ field }) => (
                <RichTextEditor
                  content={JSON.parse(field.value || DEFAULT_DOCUMENT)}
                  onChange={handleDocumentChange('quemPrecisa')}
                  placeholder="Quem precisa deste serviço..."
                />
              )}
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>Como solicitar?</CardTitle></CardHeader>
          <CardContent>
            <Controller
              name="comoSolicitar"
              control={control}
              render={({ field }) => (
                <RichTextEditor
                  content={JSON.parse(field.value || DEFAULT_DOCUMENT)}
                  onChange={handleDocumentChange('comoSolicitar')}
                  placeholder="Como solicitar este serviço..."
                />
              )}
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle>Mais Informações</CardTitle></CardHeader>
          <CardContent>
            <Controller
              name="maisInformacoes"
              control={control}
              render={({ field }) => (
                <RichTextEditor
                  content={JSON.parse(field.value || DEFAULT_DOCUMENT)}
                  onChange={handleDocumentChange('maisInformacoes')}
                  placeholder="Mais informações sobre o serviço..."
                />
              )}
            />
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/servicos')}>
            Cancelar
          </Button>
          <Button type="submit" disabled={saving}>
            {saving ? (
              <><Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...</>
            ) : (
              <><Save className="h-4 w-4 mr-2" /> Salvar Alterações</>
            )}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default ServicosForm;
