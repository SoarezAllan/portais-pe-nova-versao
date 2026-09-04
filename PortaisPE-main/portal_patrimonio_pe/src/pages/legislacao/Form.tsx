/// <reference types="vite/client" />

import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { graphqlRequest } from '../../lib/api';
import { useAuth } from '../../lib/auth';
import Layout from '../../components/Layout';
import Loading from '../../components/Loading';

interface Area { id: string; nome: string; }
interface Subarea { id: string; nome: string; }

interface FormData {
  titulo: string;
  linkExterno: string;
  categoria: string;
  resumo: string;
  areaResponsavelId: string;
  subareaId: string;
}

const CATEGORIAS = ['federal', 'estadual', 'municipal', 'normativa_interna'];
const CATEGORIA_LABELS: Record<string, string> = { federal: 'Federal', estadual: 'Estadual', municipal: 'Municipal', normativa_interna: 'Normativa Interna' };

type FormMode = 'create' | 'edit';

export default function LegislacaoForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();
  const mode: FormMode = id ? 'edit' : 'create';
  const title = mode === 'create' ? 'Nova Legislação' : 'Editar Legislação';

  const [formData, setFormData] = useState<FormData>({
    titulo: '', linkExterno: '', categoria: 'federal', resumo: '', areaResponsavelId: '', subareaId: '',
  });
  const [areas, setAreas] = useState<Area[]>([]);
  const [subareas, setSubareas] = useState<Subarea[]>([]);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [fieldErrors, setFieldErrors] = useState<Record<string, string>>({});

  useEffect(() => {
    async function load() {
      const where = isAdmin ? '' : `where: { id: { in: ${JSON.stringify(areaIds)} } }`;
      const r = await graphqlRequest<{ areas: Area[] }>(`query { areas(${where} orderBy: { nome: asc }) { id nome } }`);
      setAreas(r.areas ?? []);
    }
    load();
  }, [isAdmin, areaIds]);

  useEffect(() => {
    if (!formData.areaResponsavelId) { setSubareas([]); return; }
    (async () => {
      const r = await graphqlRequest<{ subareas: Subarea[] }>(
        `query ($id: ID!) { subareas(where: { area: { id: { equals: $id } } }, orderBy: { nome: asc }) { id nome } }`,
        { id: formData.areaResponsavelId }
      );
      setSubareas(r.subareas ?? []);
    })();
  }, [formData.areaResponsavelId]);

  useEffect(() => {
    if (mode !== 'edit' || !id) return;
    (async () => {
      setLoading(true);
      try {
        const r = await graphqlRequest<{ legislacao?: { titulo: string; linkExterno: string; categoria: string; resumo: string; areaResponsavel?: { id: string }; subarea?: { id: string } } }>(
          `query ($id: ID!) { legislacao(where: { id: $id }) { titulo linkExterno categoria resumo areaResponsavel { id } subarea { id } } }`, { id }
        );
        if (r.legislacao) {
          const l = r.legislacao;
          setFormData({ titulo: l.titulo ?? '', linkExterno: l.linkExterno ?? '', categoria: l.categoria ?? 'federal', resumo: l.resumo ?? '', areaResponsavelId: l.areaResponsavel?.id ?? '', subareaId: l.subarea?.id ?? '' });
        } else setError('Legislação não encontrada');
      } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao carregar'); }
      finally { setLoading(false); }
    })();
  }, [mode, id]);

  const handleChange = useCallback((field: keyof FormData, value: string) => {
    setFormData((p) => ({ ...p, [field]: value }));
    setFieldErrors((p) => { const n = { ...p }; delete n[field]; return n; });
  }, []);

  const validate = useCallback(() => {
    const errs: Record<string, string> = {};
    if (!formData.titulo.trim()) errs.titulo = 'Título é obrigatório';
    if (!formData.linkExterno.trim()) errs.linkExterno = 'Link externo é obrigatório';
    else if (!formData.linkExterno.startsWith('http')) errs.linkExterno = 'Link deve começar com http:// ou https://';
    if (!formData.areaResponsavelId) errs.areaResponsavelId = 'Área é obrigatória';
    setFieldErrors(errs);
    return Object.keys(errs).length === 0;
  }, [formData]);

  const handleSave = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validate()) return;
    setSaving(true); setError(null);
    try {
      const data: Record<string, unknown> = {
        titulo: formData.titulo, linkExterno: formData.linkExterno, categoria: formData.categoria, resumo: formData.resumo,
        areaResponsavel: formData.areaResponsavelId ? { connect: { id: formData.areaResponsavelId } } : undefined,
        subarea: formData.subareaId ? { connect: { id: formData.subareaId } } : undefined,
      };
      Object.keys(data).forEach((k) => data[k] === undefined && delete data[k]);

      if (mode === 'create') await graphqlRequest(`mutation ($d: LegislacaoCreateInput!) { createLegislacao(data: $d) { id } }`, { d: data });
      else await graphqlRequest(`mutation ($id: ID!, $d: LegislacaoUpdateInput!) { updateLegislacao(where: { id: $id }, data: $d) { id } }`, { id, d: data });

      navigate('/legislacao');
    } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao salvar'); }
    finally { setSaving(false); }
  }, [formData, id, mode, navigate, validate]);

  const handleDelete = useCallback(async () => {
    if (!id || !window.confirm('Excluir esta legislação?')) return;
    setSaving(true);
    try { await graphqlRequest(`mutation { deleteLegislacao(where: { id: "${id}" }) { id } }`); navigate('/legislacao'); }
    catch (err) { setError(err instanceof Error ? err.message : 'Erro ao excluir'); }
    finally { setSaving(false); }
  }, [id, navigate]);

  const inputClass = (f: string) => `w-full px-3 py-2 border rounded-lg text-sm outline-none transition-colors ${fieldErrors[f] ? 'border-red-400 focus:ring-2 focus:ring-red-300' : 'border-gray-300 focus:ring-2 focus:ring-[#003087] focus:border-transparent'}`;
  const errMsg = (f: string) => fieldErrors[f] ? <p className="text-xs text-red-600 mt-1">{fieldErrors[f]}</p> : null;

  if (loading) return <Layout title={title}><Loading message="Carregando legislação..." /></Layout>;

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {error && <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg"><p className="text-sm text-red-700">{error}</p></div>}
        <form onSubmit={handleSave} className="space-y-6">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Título <span className="text-red-500">*</span></label>
              <input type="text" value={formData.titulo} onChange={(e) => handleChange('titulo', e.target.value)} placeholder="Título da legislação" className={inputClass('titulo')} />
              {errMsg('titulo')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Link Externo <span className="text-red-500">*</span></label>
              <input type="url" value={formData.linkExterno} onChange={(e) => handleChange('linkExterno', e.target.value)} placeholder="https://..." className={inputClass('linkExterno')} />
              {errMsg('linkExterno')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Categoria <span className="text-red-500">*</span></label>
              <select value={formData.categoria} onChange={(e) => handleChange('categoria', e.target.value)} className={inputClass('categoria')}>
                {CATEGORIAS.map((c) => <option key={c} value={c}>{CATEGORIA_LABELS[c]}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Resumo</label>
              <textarea value={formData.resumo} onChange={(e) => handleChange('resumo', e.target.value)} placeholder="Breve descrição" rows={3} className={inputClass('resumo')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Área Responsável <span className="text-red-500">*</span></label>
              <select value={formData.areaResponsavelId} onChange={(e) => { handleChange('areaResponsavelId', e.target.value); handleChange('subareaId', ''); }} className={inputClass('areaResponsavelId')}>
                <option value="">Selecione</option>
                {areas.map((a) => <option key={a.id} value={a.id}>{a.nome}</option>)}
              </select>
              {errMsg('areaResponsavelId')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Subárea</label>
              <select value={formData.subareaId} onChange={(e) => handleChange('subareaId', e.target.value)} className={inputClass('subareaId')} disabled={!formData.areaResponsavelId}>
                <option value="">{formData.areaResponsavelId ? (subareas.length === 0 ? 'Nenhuma' : 'Selecione') : 'Selecione área primeiro'}</option>
                {subareas.map((s) => <option key={s.id} value={s.id}>{s.nome}</option>)}
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
