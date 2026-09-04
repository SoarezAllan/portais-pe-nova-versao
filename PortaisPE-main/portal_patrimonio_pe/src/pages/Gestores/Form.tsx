/// <reference types="vite/client" />

import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { graphqlRequest } from '../../lib/api';
import { useAuth } from '../../lib/auth';
import { uploadToKeystone } from '../../lib/upload';
import ImageUpload from '../../components/ImageUpload';
import Layout from '../../components/Layout';
import Loading from '../../components/Loading';

interface Area { id: string; nome: string; }

interface FormData {
  nome: string;
  cargo: string;
  descricao: string;
  areaResponsavelId: string;
}

type FormMode = 'create' | 'edit';

export default function GestoresForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();
  const mode: FormMode = id ? 'edit' : 'create';
  const title = mode === 'create' ? 'Novo Gestor' : 'Editar Gestor';

  const [formData, setFormData] = useState<FormData>({
    nome: '', cargo: '', descricao: '', areaResponsavelId: '',
  });
  const [areas, setAreas] = useState<Area[]>([]);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [existingImage, setExistingImage] = useState<{ id: string; url: string } | null>(null);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [fieldErrors, setFieldErrors] = useState<Record<string, string>>({});

  useEffect(() => {
    (async () => {
      const where = isAdmin ? '' : `where: { id: { in: ${JSON.stringify(areaIds)} } }`;
      const r = await graphqlRequest<{ areas: Area[] }>(`query { areas(${where} orderBy: { nome: asc }) { id nome } }`);
      setAreas(r.areas ?? []);
    })();
  }, [isAdmin, areaIds]);

  useEffect(() => {
    if (mode !== 'edit' || !id) return;
    (async () => {
      setLoading(true);
      try {
        const r = await graphqlRequest<any>(`query ($id: ID!) { gestor(where: { id: $id }) { id nome cargo descricao foto { id url } areaResponsavel { id } } }`, { id });
        if (r.gestor) {
          const g = r.gestor;
          setFormData({ nome: g.nome ?? '', cargo: g.cargo ?? '', descricao: g.descricao ?? '', areaResponsavelId: g.areaResponsavel?.id ?? '' });
          if (g.foto?.url) setExistingImage({ id: g.foto.id, url: g.foto.url });
        } else setError('Gestor não encontrado');
      } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao carregar'); }
      finally { setLoading(false); }
    })();
  }, [mode, id]);

  const handleChange = useCallback((field: keyof FormData, value: string) => {
    setFormData((p) => ({ ...p, [field]: value }));
    setFieldErrors((p) => { const n = { ...p }; delete n[field]; return n; });
  }, []);

  const handleImageChange = useCallback((file: File | null) => setImageFile(file), []);

  const validate = useCallback(() => {
    const errs: Record<string, string> = {};
    if (!formData.nome.trim()) errs.nome = 'Nome é obrigatório';
    if (!formData.cargo.trim()) errs.cargo = 'Cargo é obrigatório';
    setFieldErrors(errs);
    return Object.keys(errs).length === 0;
  }, [formData]);

  const handleSave = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validate()) return;
    setSaving(true); setError(null);
    try {
      const data: Record<string, unknown> = {
        nome: formData.nome, cargo: formData.cargo, descricao: formData.descricao,
        areaResponsavel: formData.areaResponsavelId ? { connect: { id: formData.areaResponsavelId } } : undefined,
      };

      if (imageFile) {
        const uploadMutation = `mutation ($file: Upload!) { temp: createGestor(data: { foto: { upload: $file }, nome: "temp" }) { id foto { id url } } }`;
        const uploaded = await uploadToKeystone(imageFile, uploadMutation);
        data.foto = { connect: { id: uploaded.id } };
        try { await graphqlRequest(`mutation { deleteGestor(where: { id: "${uploaded.id}" }) { id } }`); } catch { /* cleanup */ }
      }

      Object.keys(data).forEach((k) => data[k] === undefined && delete data[k]);

      if (mode === 'create') await graphqlRequest(`mutation ($d: GestorCreateInput!) { createGestor(data: $d) { id } }`, { d: data });
      else await graphqlRequest(`mutation ($i: ID!, $d: GestorUpdateInput!) { updateGestor(where: { id: $i }, data: $d) { id } }`, { i: id, d: data });

      navigate('/gestores');
    } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao salvar'); }
    finally { setSaving(false); }
  }, [formData, id, mode, navigate, validate, imageFile]);

  const handleDelete = useCallback(async () => {
    if (!id || !window.confirm('Excluir este gestor?')) return;
    setSaving(true);
    try { await graphqlRequest(`mutation { deleteGestor(where: { id: "${id}" }) { id } }`); navigate('/gestores'); }
    catch (err) { setError(err instanceof Error ? err.message : 'Erro ao excluir'); }
    finally { setSaving(false); }
  }, [id, navigate]);

  const inputClass = (f: string) => `w-full px-3 py-2 border rounded-lg text-sm outline-none transition-colors ${fieldErrors[f] ? 'border-red-400 focus:ring-2 focus:ring-red-300' : 'border-gray-300 focus:ring-2 focus:ring-[#003087] focus:border-transparent'}`;
  const errMsg = (f: string) => fieldErrors[f] ? <p className="text-xs text-red-600 mt-1">{fieldErrors[f]}</p> : null;

  if (loading) return <Layout title={title}><Loading message="Carregando gestor..." /></Layout>;

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {error && <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg"><p className="text-sm text-red-700">{error}</p></div>}
        <form onSubmit={handleSave} className="space-y-6">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Nome <span className="text-red-500">*</span></label>
              <input type="text" value={formData.nome} onChange={(e) => handleChange('nome', e.target.value)} placeholder="Nome do gestor" className={inputClass('nome')} />{errMsg('nome')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Cargo <span className="text-red-500">*</span></label>
              <input type="text" value={formData.cargo} onChange={(e) => handleChange('cargo', e.target.value)} placeholder="Cargo do gestor" className={inputClass('cargo')} />{errMsg('cargo')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Descrição</label>
              <textarea value={formData.descricao} onChange={(e) => handleChange('descricao', e.target.value)} placeholder="Breve descrição do gestor" rows={4} className={inputClass('descricao')} />
            </div>
            <ImageUpload value={existingImage} onChange={handleImageChange} label="Foto" />
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Área Responsável</label>
              <select value={formData.areaResponsavelId} onChange={(e) => handleChange('areaResponsavelId', e.target.value)} className={inputClass('areaResponsavelId')}>
                <option value="">Selecione</option>
                {areas.map((a) => <option key={a.id} value={a.id}>{a.nome}</option>)}
              </select>
            </div>
          </div>
          <div className="flex items-center justify-between gap-3">
            <div>{mode === 'edit' && <button type="button" onClick={handleDelete} disabled={saving} className="px-4 py-2 text-sm font-medium text-red-700 bg-red-50 border border-red-200 rounded-lg hover:bg-red-100 disabled:opacity-50">Excluir</button>}</div>
            <div className="flex gap-3">
              <button type="button" onClick={() => navigate(-1)} className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50">Voltar</button>
              <button type="submit" disabled={saving} className="px-6 py-2 text-sm font-medium text-white bg-[#003087] rounded-lg hover:bg-[#001f54] disabled:opacity-50">{saving ? 'Salvando...' : 'Salvar'}</button>
            </div>
          </div>
        </form>
      </div>
    </Layout>
  );
}
