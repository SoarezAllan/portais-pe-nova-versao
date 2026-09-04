import { useParams, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Checkbox } from '@/components/ui/checkbox';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { ImageUpload } from '@/components/ImageUpload';
import { useForm, useFieldArray, Controller } from 'react-hook-form';
import { useEffect, useState } from 'react';
import { Loader2, ArrowLeft, Save, Plus, Trash2 } from 'lucide-react';
import { graphqlRequest, uploadFile } from '@/lib/api';

const AREAS_QUERY = `query { areas { id nome } }`;

interface MuralItem {
  valor: string;
  titulo: string;
  descricao: string;
  ativo: boolean;
}

interface TimeItem {
  nome: string;
  cargo: string;
  descricao: string;
  foto?: { id: string; url: string; extension?: string } | null;
  ativo: boolean;
}

export function QuemSomosForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['quem-somos', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetPaginaQuemSomos($id: ID!) {
          item: paginaQuemSomos(where: { id: $id }) {
            id tituloDaPagina muralTextoIntrodutorio timeTitulo timeDescricao areaResponsavel { id nome }
            muralItens { id valor titulo descricao ativo }
            time { id nome cargo descricao foto { id url } }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, control, reset, watch, setValue } = useForm({
    defaultValues: {
      tituloDaPagina: '',
      muralTextoIntrodutorio: '',
      timeTitulo: 'Nosso Time',
      timeDescricao: '',
      areaResponsavel: '',
      muralItens: [] as MuralItem[],
      time: [] as TimeItem[],
    },
  });

  const { fields: muralFields, append: appendMural, remove: removeMural } = useFieldArray({
    control,
    name: 'muralItens',
  });

  const { fields: timeFields, append: appendTime, remove: removeTime } = useFieldArray({
    control,
    name: 'time',
  });

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        tituloDaPagina: item.tituloDaPagina || '',
        muralTextoIntrodutorio: item.muralTextoIntrodutorio || '',
        timeTitulo: item.timeTitulo || 'Nosso Time',
        timeDescricao: item.timeDescricao || '',
        areaResponsavel: item.areaResponsavel?.id || '',
        muralItens: (item.muralItens || []).map((mi: any) => ({
          valor: mi.valor || '',
          titulo: mi.titulo || '',
          descricao: mi.descricao || '',
          ativo: mi.ativo ?? true,
        })),
        time: (item.time || []).map((t: any) => ({
          nome: t.nome || '',
          cargo: t.cargo || '',
          descricao: t.descricao || '',
          foto: t.foto ? { id: t.foto.id, url: t.foto.url } : null,
          ativo: true,
        })),
      });
    }
  }, [itemData, reset]);

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        tituloDaPagina: formData.tituloDaPagina,
        muralTextoIntrodutorio: formData.muralTextoIntrodutorio,
        timeTitulo: 'Nosso Time',
        timeDescricao: formData.timeDescricao || '',
      };

      if (formData.areaResponsavel) {
        data.areaResponsavel = { connect: { id: formData.areaResponsavel } };
      }

      if (formData.muralItens !== undefined) {
        data.muralItens = {
          create: (formData.muralItens || []).map((mi: MuralItem) => ({
            valor: mi.valor,
            titulo: mi.titulo,
            descricao: mi.descricao,
            ativo: mi.ativo,
          })),
        };
      }

      if (formData.time !== undefined) {
        data.time = {
          create: (formData.time || []).map((t: TimeItem) => {
            const item: any = {
              nome: t.nome,
              cargo: t.cargo,
              descricao: t.descricao,
            };
            if (t.foto && t.foto.id) {
              item.foto = {
                id: t.foto.id,
                filesize: 0,
                width: 0,
                height: 0,
                extension: t.foto.extension || 'png',
              };
            }
            return item;
          }),
        };
      }

      if (isNew) {
        const mutation = `mutation($data: PaginaQuemSomosCreateInput!) { item: createPaginaQuemSomos(data: $data) { id } }`;
        await graphqlRequest(mutation, { data });
      } else {
        const mutation = `mutation($id: ID!, $data: PaginaQuemSomosUpdateInput!) { item: updatePaginaQuemSomos(where: { id: $id }, data: $data) { id } }`;
        await graphqlRequest(mutation, { id, data });
      }
      navigate('/quem-somos');
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/quem-somos')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Nova Página Sobre' : 'Editar Página Sobre'}
          </h2>
          <p className="text-sm text-gray-500 mt-1">Gerencie a página institucional, itens do mural e equipe da área</p>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Configuração Geral</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="tituloDaPagina">Título da Página *</Label>
                <Input id="tituloDaPagina" {...register('tituloDaPagina', { required: true })} placeholder="Ex: Sobre" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="areaResponsavel">Área Responsável *</Label>
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
              <Label htmlFor="muralTextoIntrodutorio">Texto Introdutório do Mural</Label>
              <Textarea id="muralTextoIntrodutorio" rows={3} {...register('muralTextoIntrodutorio')} placeholder="Texto de destaque exibido no topo da página..." />
            </div>
          </CardContent>
        </Card>

        {/* Itens do Mural */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <div>
              <CardTitle>Itens do Mural</CardTitle>
              <p className="text-xs text-gray-500 mt-1">Destaques numéricos ou pilares institucionais</p>
            </div>
            <Button type="button" size="sm" variant="outline" onClick={() => appendMural({ valor: '', titulo: '', descricao: '', ativo: true })}>
              <Plus className="h-4 w-4 mr-1" /> Adicionar Item
            </Button>
          </CardHeader>
          <CardContent className="space-y-4">
            {muralFields.map((field, index) => (
              <div key={field.id} className="p-4 border rounded-lg space-y-3">
                <div className="flex items-center justify-between">
                  <span className="text-sm font-medium text-gray-500">Item #{index + 1}</span>
                  <Button type="button" variant="ghost" size="sm" className="text-red-600 hover:bg-red-50" onClick={() => removeMural(index)}>
                    <Trash2 className="h-4 w-4" />
                  </Button>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                  <div className="space-y-1">
                    <Label>Valor / Destaque</Label>
                    <Input {...register(`muralItens.${index}.valor` as const)} placeholder="Ex: +5.000 ou 100%" />
                  </div>
                  <div className="space-y-1">
                    <Label>Título</Label>
                    <Input {...register(`muralItens.${index}.titulo` as const)} placeholder="Ex: Imóveis Cadastrados" />
                  </div>
                  <div className="space-y-1">
                    <Label>Descrição</Label>
                    <Input {...register(`muralItens.${index}.descricao` as const)} placeholder="Breve explicação..." />
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Checkbox
                    id={`mural-${index}-ativo`}
                    checked={watch(`muralItens.${index}.ativo` as const)}
                    onCheckedChange={(v) => setValue(`muralItens.${index}.ativo` as const, !!v)}
                  />
                  <Label htmlFor={`mural-${index}-ativo`}>Ativo</Label>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>

        {/* Membros da Equipe (Nosso Time) */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <div>
              <CardTitle>Nosso Time</CardTitle>
              <p className="text-xs text-gray-500 mt-1">Membros e lideranças da equipe exibidos na seção "Nosso Time"</p>
            </div>
            <Button
              type="button"
              size="sm"
              variant="outline"
              onClick={() => appendTime({ nome: '', cargo: '', descricao: '', foto: null, ativo: true })}
            >
              <Plus className="h-4 w-4 mr-1" /> Adicionar Membro
            </Button>
          </CardHeader>
          <CardContent className="space-y-6">
            {timeFields.map((field, index) => (
              <div key={field.id} className="p-4 border rounded-lg space-y-4 bg-slate-50/50">
                <div className="flex items-center justify-between">
                  <span className="text-sm font-semibold text-slate-700">Membro #{index + 1}</span>
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    className="text-red-600 hover:bg-red-50"
                    onClick={() => removeTime(index)}
                  >
                    <Trash2 className="h-4 w-4 mr-1" /> Remover Membro
                  </Button>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div className="space-y-1">
                    <Label>Nome *</Label>
                    <Input {...register(`time.${index}.nome` as const, { required: true })} placeholder="Nome do membro" />
                  </div>
                  <div className="space-y-1">
                    <Label>Cargo / Função</Label>
                    <Input {...register(`time.${index}.cargo` as const)} placeholder="Ex: Gestor de Patrimônio" />
                  </div>
                  <div className="space-y-1">
                    <Label>Descrição Breve</Label>
                    <Input {...register(`time.${index}.descricao` as const)} placeholder="Formação ou atribuição..." />
                  </div>
                </div>

                {/* Upload da Foto */}
                <div className="pt-2">
                  <Controller
                    control={control}
                    name={`time.${index}.foto` as const}
                    render={({ field: photoField }) => (
                      <ImageUpload
                        label="Foto do Membro da Equipe"
                        value={photoField.value}
                        onChange={async (file) => {
                          if (!file) {
                            photoField.onChange(null);
                            return;
                          }
                          try {
                            const uploaded = await uploadFile(file);
                            photoField.onChange({
                              id: uploaded.id,
                              url: uploaded.url,
                              extension: file.name.split('.').pop() || 'png',
                            });
                          } catch (err) {
                            console.error('Erro no upload da foto:', err);
                          }
                        }}
                      />
                    )}
                  />
                </div>
              </div>
            ))}

            {/* Descrição Geral da Equipe */}
            <div className="space-y-2 pt-4 border-t">
              <Label htmlFor="timeDescricao" className="font-semibold text-slate-800">
                Descrição Geral da Equipe (exibida abaixo dos membros)
              </Label>
              <Textarea
                id="timeDescricao"
                rows={4}
                {...register('timeDescricao')}
                placeholder="Insira aqui o texto institucional sobre o time da área como um todo (composição, atribuições coletivas, dinamismo e atuação do setor)..."
              />
              <p className="text-xs text-gray-500">
                Este texto será exibido na seção "Nosso Time" logo abaixo dos cards dos membros da equipe.
              </p>
            </div>
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/quem-somos')}>
            Cancelar
          </Button>
          <Button type="submit" disabled={saving} className="bg-[#003087] hover:bg-[#002266] text-white">
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

export default QuemSomosForm;
