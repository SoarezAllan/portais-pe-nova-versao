import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { useForm } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save, GraduationCap } from 'lucide-react';
import { graphqlRequest } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;
const SUBAREAS_QUERY = `query { subareas { id nome area { id } } }`;

export function CursosForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: subareasData } = useQuery({
    queryKey: ['subareas'],
    queryFn: () => graphqlRequest<{ subareas: { id: string; nome: string; area?: { id: string } }[] }>(SUBAREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['cursos', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetCurso($id: ID!) {
          item: curso(where: { id: $id }) {
            id titulo status resumo linkExterno dataDoCurso modalidade local
            areaResponsavel { id nome }
            subarea { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, reset, watch } = useForm({
    defaultValues: {
      titulo: '',
      resumo: '',
      linkExterno: '',
      dataDoCurso: '',
      modalidade: 'PRESENCIAL',
      local: '',
      areaResponsavel: '',
      subarea: '',
    },
  });

  const selectedArea = watch('areaResponsavel');
  const availableSubareas = (subareasData?.subareas || []).filter(
    (s) => !selectedArea || !s.area || s.area.id === selectedArea
  );

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        titulo: item.titulo || '',
        resumo: item.resumo || '',
        linkExterno: item.linkExterno || '',
        dataDoCurso: item.dataDoCurso ? item.dataDoCurso.split('T')[0] : '',
        modalidade: item.modalidade || 'PRESENCIAL',
        local: item.local || '',
        areaResponsavel: item.areaResponsavel?.id || '',
        subarea: item.subarea?.id || '',
      });
    }
  }, [itemData, reset]);

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        titulo: formData.titulo,
        status: 'PROGRAMADO',
        resumo: formData.resumo,
        linkExterno: formData.linkExterno || null,
        dataDoCurso: formData.dataDoCurso ? new Date(formData.dataDoCurso).toISOString() : new Date().toISOString(),
        modalidade: formData.modalidade || 'PRESENCIAL',
        local: formData.local || '',
      };

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }
      if (formData.subarea) {
        data.subarea = { connect: { id: formData.subarea } };
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
            {isNew ? 'Novo Curso Programado' : 'Editar Curso'}
          </h2>
          <p className="text-sm text-gray-500 mt-1">Cadastre cursos com datas, modalidades e links de inscrição</p>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <GraduationCap className="h-5 w-5 text-blue-600" />
              Informações do Curso
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="titulo">Título do Curso *</Label>
              <Input
                id="titulo"
                {...register('titulo', { required: true })}
                placeholder="Ex: Gestão e Fiscalização de Contratos Administrativos"
              />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="space-y-2">
                <Label htmlFor="modalidade">Modalidade *</Label>
                <select
                  id="modalidade"
                  {...register('modalidade')}
                  className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm"
                >
                  <option value="PRESENCIAL">Presencial</option>
                  <option value="EAD">EAD</option>
                  <option value="HÍBRIDO">Híbrido</option>
                </select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="dataDoCurso">Data de Início *</Label>
                <Input id="dataDoCurso" type="date" {...register('dataDoCurso', { required: true })} />
              </div>

              <div className="space-y-2">
                <Label htmlFor="local">Local / Plataforma</Label>
                <Input id="local" {...register('local')} placeholder="Ex: Auditório SAD / Teams" />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="areaResponsavel">Área Responsável *</Label>
                <select
                  id="areaResponsavel"
                  {...register('areaResponsavel')}
                  className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm"
                >
                  <option value="">Selecione a área...</option>
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
                  <option value="">Geral / Nenhuma</option>
                  {availableSubareas.map((sub) => (
                    <option key={sub.id} value={sub.id}>{sub.nome}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="linkExterno">Link de Inscrição / Mais Informações</Label>
              <Input
                id="linkExterno"
                type="url"
                {...register('linkExterno')}
                placeholder="https://exemplo.pe.gov.br/inscricao"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="resumo">Resumo / Ementa do Curso</Label>
              <Textarea
                id="resumo"
                rows={3}
                {...register('resumo')}
                placeholder="Breve descrição dos objetivos e conteúdo programático do curso..."
              />
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
              <><Save className="h-4 w-4 mr-2" /> Salvar Curso</>
            )}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default CursosForm;
