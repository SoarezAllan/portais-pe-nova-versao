import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { useForm } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save, Link2 } from 'lucide-react';
import { graphqlRequest } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

export function LinksUteisForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['cursos', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetCurso($id: ID!) {
          item: curso(where: { id: $id }) {
            id titulo status resumo linkExterno
            areaResponsavel { id nome }
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
        status: 'LINK_UTIL',
        resumo: formData.resumo,
        linkExterno: formData.linkExterno || null,
        modalidade: 'Capacitação',
        dataDoCurso: new Date().toISOString(),
        local: '',
      };

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }

      if (isNew) {
        const mutation = `mutation($data: CursoCreateInput!) { item: createCurso(data: $data) { id } }`;
        await graphqlRequest(mutation, { data });
      } else {
        const mutation = `mutation($id: ID!, $data: CursoUpdateInput!) { item: updateCurso(where: { id: $id }, data: $data) { id } }`;
        await graphqlRequest(mutation, { id, data });
      }
      navigate('/cursos');
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/cursos')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Novo Link Útil de Capacitação' : 'Editar Link Útil'}
          </h2>
          <p className="text-sm text-gray-500 mt-1">Cadastre links externos permanentes para escolas de governo e plataformas</p>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Link2 className="h-5 w-5 text-purple-600" />
              Informações do Link Útil
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título / Nome da Plataforma *</Label>
              <Input
                id="titulo"
                {...register('titulo', { required: true })}
                placeholder="Ex: CEFOSPE - Centro de Formação dos Servidores de PE"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="linkExterno">Link / URL Externa *</Label>
              <Input
                id="linkExterno"
                type="url"
                {...register('linkExterno', { required: true })}
                placeholder="https://www.cefospe.pe.gov.br/"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="resumo">Descrição / Resumo</Label>
              <Textarea
                id="resumo"
                rows={3}
                {...register('resumo')}
                placeholder="Breve descrição dos cursos ou serviços oferecidos pela plataforma..."
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="areaResponsavel">Área Responsável</Label>
              <select
                id="areaResponsavel"
                {...register('areaResponsavel')}
                className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm"
              >
                <option value="">Todas as Áreas (Geral / Todos os Portais)</option>
                {areas?.areas.map((area) => (
                  <option key={area.id} value={area.id}>{area.nome}</option>
                ))}
              </select>
            </div>
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/cursos')}>
            Cancelar
          </Button>
          <Button type="submit" disabled={saving} className="bg-[#003087] hover:bg-[#002266] text-white">
            {saving ? (
              <><Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...</>
            ) : (
              <><Save className="h-4 w-4 mr-2" /> Salvar Link Útil</>
            )}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default LinksUteisForm;
