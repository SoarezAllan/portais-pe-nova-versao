import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { ImageUpload } from '@/components/ImageUpload';
import { useForm, Controller } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save } from 'lucide-react';
import { graphqlRequest } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function EquipeForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['equipe', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetGestor($id: ID!) {
          item: gestores(where: { id: $id }) {
            id nome cargo descricao foto { id url }
            areaResponsavel { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, reset, control } = useForm({
    defaultValues: {
      nome: '',
      cargo: '',
      descricao: '',
      foto: null as any,
      areaResponsavel: '',
    },
  });

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        nome: item.nome || '',
        cargo: item.cargo || '',
        descricao: item.descricao || '',
        foto: item.foto || null,
        areaResponsavel: item.areaResponsavel?.id || '',
      });
    }
  }, [itemData, reset]);

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        nome: formData.nome,
        cargo: formData.cargo,
        descricao: formData.descricao,
      };

      if (formData.foto && formData.foto.id) {
        data.foto = {
          id: formData.foto.id,
          filesize: formData.foto.filesize || 0,
          width: formData.foto.width || 0,
          height: formData.foto.height || 0,
          extension: formData.foto.extension || 'png',
        };
      }

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }

      if (isNew) {
        const mutation = `mutation($data: GestoresCreateInput!) { item: createGestores(data: $data) { id } }`;
        await graphqlRequest(mutation, { data });
      } else {
        const mutation = `mutation($id: ID!, $data: GestoresUpdateInput!) { item: updateGestores(where: { id: $id }, data: $data) { id } }`;
        await graphqlRequest(mutation, { id, data });
      }
      navigate('/equipe');
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/equipe')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Novo Membro da Equipe' : 'Editar Membro da Equipe'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Informações do Membro</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="nome">Nome Completo *</Label>
                <Input id="nome" {...register('nome', { required: true })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="cargo">Cargo / Função *</Label>
                <Input id="cargo" {...register('cargo', { required: true })} />
              </div>
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

            <div className="space-y-2">
              <Label htmlFor="descricao">Mini Biografia / Descrição</Label>
              <Textarea id="descricao" rows={3} {...register('descricao')} placeholder="Breve descrição sobre a atuação ou formação..." />
            </div>

            <div className="space-y-2">
              <Label>Foto de Perfil</Label>
              <Controller
                control={control}
                name="foto"
                render={({ field }) => (
                  <ImageUpload value={field.value} onChange={field.onChange} />
                )}
              />
            </div>
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/equipe')}>
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

export default EquipeForm;
