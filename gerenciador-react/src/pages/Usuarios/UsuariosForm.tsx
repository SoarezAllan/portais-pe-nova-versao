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

export function UsuariosForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const isNew = !id || id === 'novo';
  const [saving, setSaving] = useState(false);

  const { data: areas } = useQuery({
    queryKey: ['areas'],
    queryFn: () => graphqlRequest<{ areas: { id: string; nome: string }[] }>(AREAS_QUERY),
  });

  const { data: itemData } = useQuery({
    queryKey: ['usuarios', 'get', id],
    queryFn: () =>
      graphqlRequest<{ item: any }>(
        `query GetUser($id: ID!) {
          item: user(where: { id: $id }) {
            id name email role areas { id nome }
          }
        }`,
        { id },
      ),
    enabled: !isNew && !!id,
  });

  const { register, handleSubmit, reset, watch, setValue } = useForm({
    defaultValues: {
      name: '',
      email: '',
      password: '',
      role: 'operator',
      areas: [] as string[],
    },
  });

  useEffect(() => {
    if (itemData?.item) {
      const item = itemData.item;
      reset({
        name: item.name || '',
        email: item.email || '',
        password: '',
        role: item.role || 'operator',
        areas: (item.areas || []).map((a: any) => a.id),
      });
    }
  }, [itemData, reset]);

  const selectedAreas = watch('areas') || [];

  const handleToggleArea = (areaId: string) => {
    const next = selectedAreas.includes(areaId)
      ? selectedAreas.filter((id) => id !== areaId)
      : [...selectedAreas, areaId];
    setValue('areas', next);
  };

  const onSubmit = async (formData: any) => {
    setSaving(true);
    try {
      const data: any = {
        name: formData.name,
        email: formData.email,
        role: formData.role,
      };

      if (formData.password) {
        data.password = formData.password;
      }

      if (formData.areas && formData.areas.length > 0) {
        data.areas = { set: formData.areas.map((id: string) => ({ id })) };
      } else {
        data.areas = { set: [] };
      }

      if (isNew) {
        await graphqlRequest(`mutation($data: UserCreateInput!) { createUser(data: $data) { id } }`, { data });
      } else {
        await graphqlRequest(`mutation($id: ID!, $data: UserUpdateInput!) { updateUser(where: { id: $id }, data: $data) { id } }`, { id, data });
      }
      navigate('/usuarios');
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
        <Button variant="ghost" size="icon" onClick={() => navigate('/usuarios')}>
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h2 className="text-2xl font-bold text-gray-800">
            {isNew ? 'Novo Usuário' : 'Editar Usuário'}
          </h2>
        </div>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <Card>
          <CardHeader><CardTitle>Dados do Usuário</CardTitle></CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="name">Nome Completo *</Label>
                <Input id="name" {...register('name', { required: true })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="email">E-mail *</Label>
                <Input id="email" type="email" {...register('email', { required: true })} />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="password">{isNew ? 'Senha *' : 'Nova Senha (deixe em branco para manter)'}</Label>
                <Input id="password" type="password" {...register('password', { required: isNew })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="role">Papel de Acesso *</Label>
                <select id="role" {...register('role')} className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm">
                  <option value="operator">Operador (Acesso às áreas vinculadas)</option>
                  <option value="admin">Administrador Geral</option>
                </select>
              </div>
            </div>

            <div className="space-y-2">
              <Label>Áreas de Acesso Permitidas</Label>
              <div className="grid grid-cols-2 gap-2 p-3 border rounded-lg bg-slate-50">
                {areas?.areas.map((area) => (
                  <label key={area.id} className="flex items-center gap-2 cursor-pointer text-sm">
                    <input
                      type="checkbox"
                      checked={selectedAreas.includes(area.id)}
                      onChange={() => handleToggleArea(area.id)}
                      className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                    />
                    <span>{area.nome}</span>
                  </label>
                ))}
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="flex items-center gap-3 justify-end">
          <Button type="button" variant="outline" onClick={() => navigate('/usuarios')}>Cancelar</Button>
          <Button type="submit" disabled={saving}>
            {saving ? <><Loader2 className="h-4 w-4 mr-2 animate-spin" /> Salvando...</> : <><Save className="h-4 w-4 mr-2" /> Salvar</>}
          </Button>
        </div>
      </form>
    </div>
  );
}

export default UsuariosForm;
