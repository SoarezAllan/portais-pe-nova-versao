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
  tituloDaPagina: string;
  muralTextoIntrodutorio: string;
  timeTitulo: string;
  areaResponsavelId: string;
  subareaId: string;
}

type FormMode = 'create' | 'edit';

export default function QuemSomosForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();
  const mode: FormMode = id ? 'edit' : 'create';
  const title = mode === 'create' ? 'Nova Página Quem Somos' : 'Editar Página Quem Somos';

  const [formData, setFormData] = useState<FormData>({
    tituloDaPagina: 'Quem Somos', muralTextoIntrodutorio: '', timeTitulo: 'Nosso Time', areaResponsavelId: '', subareaId: '',
  });
  const [areas, setAreas] = useState<Area[]>([]);
  const [subareas, setSubareas] = useState<Subarea[]>([]);
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
        const r = await graphqlRequest<any>(`query ($id: ID!) { paginaQuemSomos(where: { id: $id }) { id tituloDaPagina muralTextoIntrodutorio timeTitulo areaResponsavel { id } subarea { id } } }`, { id });
        if (r.paginaQuemSomos) {
          const p = r.paginaQuemSomos;
          setFormData({
            tituloDaPagina: p.tituloDaPagina ?? 'Quem Somos', muralTextoIntrodutorio: p.muralTextoIntrodutorio ?? '',
            timeTitulo: p.timeTitulo ?? 'Nosso Time', areaResponsavelId: p.areaResponsavel?.id ?? '', subareaId: p.subarea?.id ?? '',
          });
        } else setError('Página não encontrada');
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
    if (!formData.tituloDaPagina.trim()) errs.tituloDaPagina = 'Título é obrigatório';
    setFieldErrors(errs);
    return Object.keys(errs).length === 0;
  }, [formData]);

  const handleSave = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validate()) return;
    setSaving(true); setError(null);
    try {
      const data: Record<string, unknown> = {
        tituloDaPagina: formData.tituloDaPagina, muralTextoIntrodutorio: formData.muralTextoIntrodutorio, timeTitulo: formData.timeTitulo,
        areaResponsavel: formData.areaResponsavelId ? { connect: { id: formData.areaResponsavelId } } : undefined,
        subarea: formData.subareaId ? { connect: { id: formData.subareaId } } : undefined,
      };
      Object.keys(data).forEach((k) => data[k] === undefined && delete data[k]);

      if (mode === 'create') await graphqlRequest(`mutation ($d: PaginaQuemSomosCreateInput!) { createPaginaQuemSomos(data: $d) { id } }`, { d: data });
      else await graphqlRequest(`mutation ($i: ID!, $d: PaginaQuemSomosUpdateInput!) { updatePaginaQuemSomos(where: { id: $i }, data: $d) { id } }`, { i: id, d: data });

      navigate('/quem-somos');
    } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao salvar'); }
    finally { setSaving(false); }
  }, [formData, id, mode, navigate, validate]);

  const handleDelete = useCallback(async () => {
    if (!id || !window.confirm('Excluir esta página?')) return;
    setSaving(true);
    try { await graphqlRequest(`mutation { deletePaginaQuemSomos(where: { id: "${id}" }) { id } }`); navigate('/quem-somos'); }
    catch (err) { setError(err instanceof Error ? err.message : 'Erro ao excluir'); }
    finally { setSaving(false); }
  }, [id, navigate]);

  const inputClass = (f: string) => `w-full px-3 py-2 border rounded-lg text-sm outline-none transition-colors ${fieldErrors[f] ? 'border-red-400 focus:ring-2 focus:ring-red-300' : 'border-gray-300 focus:ring-2 focus:ring-[#003087] focus:border-transparent'}`;
  const errMsg = (f: string) => fieldErrors[f] ? <p className="text-xs text-red-600 mt-1">{fieldErrors[f]}</p> : null;

  if (loading) return <Layout title={title}><Loading message="Carregando página..." /></Layout>;

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {error && <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg"><p className="text-sm text-red-700">{error}</p></div>}

        <div className="mb-6 p-4 bg-blue-50 border border-blue-200 rounded-lg flex items-start gap-3">
          <svg className="w-5 h-5 text-blue-600 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
          <p className="text-sm text-blue-700">
            Gerenciamento dos cards internos (mural e time) será implementado na próxima fase.
          </p>
        </div>

        <form onSubmit={handleSave} className="space-y-6">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Título da Página <span className="text-red-500">*</span></label>
              <input type="text" value={formData.tituloDaPagina} onChange={(e) => handleChange('tituloDaPagina', e.target.value)} className={inputClass('tituloDaPagina')} />{errMsg('tituloDaPagina')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Texto Introdutório do Mural</label>
              <textarea value={formData.muralTextoIntrodutorio} onChange={(e) => handleChange('muralTextoIntrodutorio', e.target.value)} placeholder="Texto de introdução do mural" rows={4} className={inputClass('muralTextoIntrodutorio')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Título da Seção "Nosso Time"</label>
              <input type="text" value={formData.timeTitulo} onChange={(e) => handleChange('timeTitulo', e.target.value)} className={inputClass('timeTitulo')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Área Responsável</label>
              <select value={formData.areaResponsavelId} onChange={(e) => { handleChange('areaResponsavelId', e.target.value); handleChange('subareaId', ''); }} className={inputClass('areaResponsavelId')}>
                <option value="">Selecione</option>
                {areas.map((a) => <option key={a.id} value={a.id}>{a.nome}</option>)}
              </select>
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
