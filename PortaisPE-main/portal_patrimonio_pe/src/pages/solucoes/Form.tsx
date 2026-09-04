/// <reference types="vite/client" />

import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { graphqlRequest } from '../../lib/api';
import { useAuth } from '../../lib/auth';
import { generateSlug } from '../../utils/slugify';
import { uploadToKeystone } from '../../lib/upload';
import ImageUpload from '../../components/ImageUpload';
import Layout from '../../components/Layout';
import Loading from '../../components/Loading';

interface Area { id: string; nome: string; }
interface Subarea { id: string; nome: string; }

interface FormData {
  titulo: string;
  slug: string;
  categoria: string;
  imagemAlt: string;
  resumo: string;
  corpo: string;
  linkExterno: string;
  ativo: boolean;
  areaResponsavelId: string;
  subareaId: string;
}

const CATEGORIAS = ['geo', 'bi', 'aplicacoes', 'projetos', 'outros'];
const CATEGORIA_LABELS: Record<string, string> = { geo: 'Geo', bi: 'BI', aplicacoes: 'Aplicações', projetos: 'Projetos', outros: 'Outros' };

type FormMode = 'create' | 'edit';

export default function SolucaoForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();
  const mode: FormMode = id ? 'edit' : 'create';
  const title = mode === 'create' ? 'Nova Solução' : 'Editar Solução';

  const [formData, setFormData] = useState<FormData>({
    titulo: '', slug: '', categoria: 'geo', imagemAlt: '', resumo: '', corpo: '', linkExterno: '', ativo: true, areaResponsavelId: '', subareaId: '',
  });
  const [areas, setAreas] = useState<Area[]>([]);
  const [subareas, setSubareas] = useState<Subarea[]>([]);
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
    if (!formData.areaResponsavelId) { setSubareas([]); return; }
    (async () => {
      const r = await graphqlRequest<{ subareas: Subarea[] }>(`query ($id: ID!) { subareas(where: { area: { id: { equals: $id } } }, orderBy: { nome: asc }) { id nome } }`, { id: formData.areaResponsavelId });
      setSubareas(r.subareas ?? []);
    })();
  }, [formData.areaResponsavelId]);

  useEffect(() => {
    if (mode !== 'edit' || !id) return;
    (async () => {
      setLoading(true);
      try {
        const r = await graphqlRequest<any>(`query ($id: ID!) { solucao(where: { id: $id }) { id titulo slug categoria imagemAlt resumo corpo { document } linkExterno ativo imagem { id url } areaResponsavel { id } subarea { id } } }`, { id });
        if (r.solucao) {
          const s = r.solucao;
          setFormData({ titulo: s.titulo ?? '', slug: s.slug ?? '', categoria: s.categoria ?? 'geo', imagemAlt: s.imagemAlt ?? '', resumo: s.resumo ?? '', corpo: '', linkExterno: s.linkExterno ?? '', ativo: s.ativo ?? true, areaResponsavelId: s.areaResponsavel?.id ?? '', subareaId: s.subarea?.id ?? '' });
          if (s.imagem?.url) setExistingImage({ id: s.imagem.id, url: s.imagem.url });
        } else setError('Solução não encontrada');
      } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao carregar'); }
      finally { setLoading(false); }
    })();
  }, [mode, id]);

  const handleChange = useCallback((field: keyof FormData, value: string | boolean) => {
    setFormData((p) => ({ ...p, [field]: value }));
    setFieldErrors((p) => { const n = { ...p }; delete n[field]; return n; });
  }, []);

  const handleTituloBlur = useCallback(() => {
    if (mode === 'create' || !formData.slug) handleChange('slug', generateSlug(formData.titulo));
  }, [formData.titulo, formData.slug, mode, handleChange]);

  const handleImageChange = useCallback((file: File | null) => setImageFile(file), []);

  const validate = useCallback(() => {
    const errs: Record<string, string> = {};
    if (!formData.titulo.trim()) errs.titulo = 'Título é obrigatório';
    if (!formData.slug.trim()) errs.slug = 'Slug é obrigatório';
    if (!formData.areaResponsavelId) errs.areaResponsavelId = 'Área é obrigatória';
    if (formData.resumo.length > 300) errs.resumo = 'Máximo 300 caracteres';
    setFieldErrors(errs);
    return Object.keys(errs).length === 0;
  }, [formData]);

  const handleSave = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validate()) return;
    setSaving(true); setError(null);
    try {
      const data: Record<string, unknown> = {
        titulo: formData.titulo, slug: formData.slug, categoria: formData.categoria, imagemAlt: formData.imagemAlt,
        resumo: formData.resumo, linkExterno: formData.linkExterno, ativo: formData.ativo,
        areaResponsavel: formData.areaResponsavelId ? { connect: { id: formData.areaResponsavelId } } : undefined,
        subarea: formData.subareaId ? { connect: { id: formData.subareaId } } : undefined,
      };

      // Upload de imagem se houver novo arquivo
      if (imageFile) {
        const uploadMutation = `mutation ($file: Upload!) { temp: createSolucao(data: { imagem: { upload: $file }, titulo: "temp" }) { id imagem { id url } } }`;
        const uploaded = await uploadToKeystone(imageFile, uploadMutation);
        data.imagem = { connect: { id: uploaded.id } };
        try { await graphqlRequest(`mutation { deleteSolucao(where: { id: "${uploaded.id}" }) { id } }`); } catch { /* cleanup */ }
      }

      Object.keys(data).forEach((k) => data[k] === undefined && delete data[k]);

      if (mode === 'create') await graphqlRequest(`mutation ($d: SolucaoCreateInput!) { createSolucao(data: $d) { id } }`, { d: data });
      else await graphqlRequest(`mutation ($i: ID!, $d: SolucaoUpdateInput!) { updateSolucao(where: { id: $i }, data: $d) { id } }`, { i: id, d: data });

      navigate('/solucoes');
    } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao salvar'); }
    finally { setSaving(false); }
  }, [formData, id, mode, navigate, validate, imageFile]);

  const handleDelete = useCallback(async () => {
    if (!id || !window.confirm('Excluir esta solução?')) return;
    setSaving(true);
    try { await graphqlRequest(`mutation { deleteSolucao(where: { id: "${id}" }) { id } }`); navigate('/solucoes'); }
    catch (err) { setError(err instanceof Error ? err.message : 'Erro ao excluir'); }
    finally { setSaving(false); }
  }, [id, navigate]);

  const inputClass = (f: string) => `w-full px-3 py-2 border rounded-lg text-sm outline-none transition-colors ${fieldErrors[f] ? 'border-red-400 focus:ring-2 focus:ring-red-300' : 'border-gray-300 focus:ring-2 focus:ring-[#003087] focus:border-transparent'}`;
  const errMsg = (f: string) => fieldErrors[f] ? <p className="text-xs text-red-600 mt-1">{fieldErrors[f]}</p> : null;

  if (loading) return <Layout title={title}><Loading message="Carregando solução..." /></Layout>;

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {error && <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg"><p className="text-sm text-red-700">{error}</p></div>}
        <form onSubmit={handleSave} className="space-y-6">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Título <span className="text-red-500">*</span></label>
              <input type="text" value={formData.titulo} onChange={(e) => handleChange('titulo', e.target.value)} onBlur={handleTituloBlur} placeholder="Título da solução" className={inputClass('titulo')} />{errMsg('titulo')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Slug <span className="text-red-500">*</span></label>
              <input type="text" value={formData.slug} onChange={(e) => handleChange('slug', e.target.value)} placeholder="url-da-solucao" className={inputClass('slug')} />
              <p className="text-xs text-gray-400 mt-1">Gerado automaticamente</p>{errMsg('slug')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Categoria <span className="text-red-500">*</span></label>
              <select value={formData.categoria} onChange={(e) => handleChange('categoria', e.target.value)} className={inputClass('categoria')}>
                {CATEGORIAS.map((c) => <option key={c} value={c}>{CATEGORIA_LABELS[c]}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Resumo (máx. 300)</label>
              <textarea value={formData.resumo} onChange={(e) => handleChange('resumo', e.target.value)} placeholder="Breve descrição" rows={3} maxLength={300} className={inputClass('resumo')} />
              <p className="text-xs text-gray-400 text-right mt-1">{formData.resumo.length}/300</p>{errMsg('resumo')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Corpo</label>
              <textarea value={formData.corpo} onChange={(e) => handleChange('corpo', e.target.value)} placeholder="Conteúdo da solução (futuramente editor rich text)" rows={6} className={inputClass('corpo')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Link Externo</label>
              <input type="url" value={formData.linkExterno} onChange={(e) => handleChange('linkExterno', e.target.value)} placeholder="https://..." className={inputClass('linkExterno')} />
            </div>
            <ImageUpload value={existingImage} onChange={handleImageChange} label="Imagem" />
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Texto Alternativo (Alt)</label>
              <input type="text" value={formData.imagemAlt} onChange={(e) => handleChange('imagemAlt', e.target.value)} placeholder="Descrição da imagem" className={inputClass('imagemAlt')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Área Responsável <span className="text-red-500">*</span></label>
              <select value={formData.areaResponsavelId} onChange={(e) => { handleChange('areaResponsavelId', e.target.value); handleChange('subareaId', ''); }} className={inputClass('areaResponsavelId')}>
                <option value="">Selecione</option>
                {areas.map((a) => <option key={a.id} value={a.id}>{a.nome}</option>)}
              </select>{errMsg('areaResponsavelId')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Subárea</label>
              <select value={formData.subareaId} onChange={(e) => handleChange('subareaId', e.target.value)} className={inputClass('subareaId')} disabled={!formData.areaResponsavelId}>
                <option value="">{formData.areaResponsavelId ? (subareas.length === 0 ? 'Nenhuma' : 'Selecione') : 'Selecione área primeiro'}</option>
                {subareas.map((s) => <option key={s.id} value={s.id}>{s.nome}</option>)}
              </select>
            </div>
            <div className="flex items-center gap-3">
              <input type="checkbox" id="ativo" checked={formData.ativo} onChange={(e) => handleChange('ativo', e.target.checked)} className="w-4 h-4 text-[#003087] border-gray-300 rounded focus:ring-[#003087]" />
              <label htmlFor="ativo" className="text-sm font-medium text-gray-700">Solução ativa</label>
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
