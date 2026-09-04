import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { useForm } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save } from 'lucide-react';
import { graphqlRequest } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function TagsForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['tags', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetTag($id: ID!) {
          item: tag(where: { id: $id }) {
            id nome areaResponsavel { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, reset } = useForm({
    defaultValues: {
      nome: '',
      areaResponsavel: '',
    },
  });

  useEffect(() => {
    if (itemData?.item) {
      reset({
        nome: itemData.item.nome || '',
        areaResponsavel: itemData.item.areaResponsavel?.id || '',
      });
    }
  }, [itemData, reset]);

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = { nome: formData.nome };
      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }
      if (isNew) {
        await graphqlRequest(`mutation($data: TagCreateInput!) { createTag(data: $data) { id } }`, { data });
      } else {
        await graphqlRequest(`mutation($id: ID!, $data: TagUpdateInput!) { updateTag(where: { id: $id }, data: $data) { id } }`, { id, data });
      }
      navigate('/tags');
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/tags')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Nova Tag' : 'Editar Tag'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Dados da Tag</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="nome">Nome da Tag *</Label>
              <Input id="nome" {...register('nome', { required: true })} placeholder="Ex: GestaoPublica, Imoveis..." />
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
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/tags')}>Cancelar</Button>
          <Button type="submit" disabled={saving}>
            {saving ? <><Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...</> : <><Save className="h-4 w-4 mr-2" /> Salvar</>}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default TagsForm;
