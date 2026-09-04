import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { useForm } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save } from 'lucide-react';
import { graphqlRequest } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function LegislacaoForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
queryKey: ['legislacoes', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetLegislacao($id: ID!) {
          item: legislacao(where: { id: $id }) {
            id titulo linkExterno categoria resumo areaResponsavel { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, reset } = useForm({
    defaultValues: {
      titulo: '',
      linkExterno: '',
      categoria: '',
      resumo: '',
      areaResponsavel: '',
    },
  });

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        titulo: item.titulo || '',
        linkExterno: item.linkExterno || '',
        categoria: item.categoria || '',
        resumo: item.resumo || '',
        areaResponsavel: item.areaResponsavel?.id || '',
      });
    }
  }, [itemData, reset]);

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        titulo: formData.titulo,
        linkExterno: formData.linkExterno,
        categoria: formData.categoria,
        resumo: formData.resumo,
      };

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }

      if (isNew) {
        const mutation = `mutation($data: LegislacaoCreateInput!) { item: createLegislacao(data: $data) { id } }`;
        await graphqlRequest(mutation, { data });
      } else {
        const mutation = `mutation($id: ID!, $data: LegislacaoUpdateInput!) { item: updateLegislacao(where: { id: $id }, data: $data) { id } }`;
        await graphqlRequest(mutation, { id, data });
      }
      navigate('/legislacao');
    } catch (err) {
      console.error(err);
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/legislacao')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Nova Legislação' : 'Editar Legislação'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Informações</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título</Label>
              <Input id="titulo" {...register('titulo', { required: true })} />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="categoria">Categoria</Label>
                <Input id="categoria" {...register('categoria')} />
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
            <div className="space-y-2">
              <Label htmlFor="linkExterno">Link Externo</Label>
              <Input id="linkExterno" type="url" {...register('linkExterno')} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="resumo">Resumo</Label>
              <Textarea id="resumo" rows={3} {...register('resumo')} />
            </div>
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/legislacao')}>
            Cancelar
          </Button>
          <Button type="submit" disabled={saving}>
            {saving ? (
              <><Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...</>
            ) : (
              <><Save className="h-4 w-4 mr-2" /> Salvar</>
            )}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default LegislacaoForm;
