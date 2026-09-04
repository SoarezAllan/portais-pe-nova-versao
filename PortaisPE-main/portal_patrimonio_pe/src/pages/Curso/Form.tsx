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
  status: string;
  resumo: string;
  linkExterno: string;
  dataDoCurso: string;
  areaResponsavelId: string;
  subareaId: string;
  modalidade: string;
  local: string;
}

function toDTLocal(iso: string | null | undefined): string {
  if (!iso) { const n = new Date(); n.setMinutes(n.getMinutes() - n.getTimezoneOffset()); return n.toISOString().slice(0, 16); }
  try { const d = new Date(iso); d.setMinutes(d.getMinutes() - d.getTimezoneOffset()); return d.toISOString().slice(0, 16); }
  catch { return new Date().toISOString().slice(0, 16); }
}

function toISO(dt: string): string { return dt ? new Date(dt).toISOString() : new Date().toISOString(); }

type FormMode = 'create' | 'edit';

export default function CursoForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();
  const mode: FormMode = id ? 'edit' : 'create';
  const title = mode === 'create' ? 'Novo Curso' : 'Editar Curso';

  const [formData, setFormData] = useState<FormData>({
    titulo: '', status: 'PROGRAMADO', resumo: '', linkExterno: '', dataDoCurso: toDTLocal(null),
    areaResponsavelId: '', subareaId: '', modalidade: 'PRESENCIAL', local: '',
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
        const r = await graphqlRequest<any>(`query ($id: ID!) { curso(where: { id: $id }) { titulo status resumo linkExterno dataDoCurso areaResponsavel { id } subarea { id } modalidade local } }`, { id });
        if (r.curso) {
          const c = r.curso;
          setFormData({
            titulo: c.titulo ?? '', status: c.status ?? 'PROGRAMADO', resumo: c.resumo ?? '', linkExterno: c.linkExterno ?? '',
            dataDoCurso: toDTLocal(c.dataDoCurso), areaResponsavelId: c.areaResponsavel?.id ?? '', subareaId: c.subarea?.id ?? '',
            modalidade: c.modalidade ?? 'PRESENCIAL', local: c.local ?? '',
          });
        } else setError('Curso não encontrado');
      } catch (err) { setError(err instanceof Error ? err.message : 'Erro'); }
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
    if (!formData.areaResponsavelId) errs.areaResponsavelId = 'Área é obrigatória';
    if (formData.resumo.length > 300) errs.resumo = 'Máximo 300 caracteres';
    if (formData.linkExterno && !formData.linkExterno.startsWith('http')) errs.linkExterno = 'Link deve começar com http:// ou https://';
    setFieldErrors(errs);
    return Object.keys(errs).length === 0;
  }, [formData]);

  const handleSave = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validate()) return;
    setSaving(true); setError(null);
    try {
      const data: Record<string, unknown> = {
        titulo: formData.titulo, status: formData.status, resumo: formData.resumo, linkExterno: formData.linkExterno,
        dataDoCurso: toISO(formData.dataDoCurso), modalidade: formData.modalidade, local: formData.local,
        areaResponsavel: formData.areaResponsavelId ? { connect: { id: formData.areaResponsavelId } } : undefined,
        subarea: formData.subareaId ? { connect: { id: formData.subareaId } } : undefined,
      };
      Object.keys(data).forEach((k) => data[k] === undefined && delete data[k]);
      if (mode === 'create') await graphqlRequest(`mutation ($d: CursoCreateInput!) { createCurso(data: $d) { id } }`, { d: data });
      else await graphqlRequest(`mutation ($i: ID!, $d: CursoUpdateInput!) { updateCurso(where: { id: $i }, data: $d) { id } }`, { i: id, d: data });
      navigate('/cursos');
    } catch (err) { setError(err instanceof Error ? err.message : 'Erro ao salvar'); }
    finally { setSaving(false); }
  }, [formData, id, mode, navigate, validate]);

  const handleDelete = useCallback(async () => {
    if (!id || !window.confirm('Excluir este curso?')) return;
    setSaving(true);
    try { await graphqlRequest(`mutation { deleteCurso(where: { id: "${id}" }) { id } }`); navigate('/cursos'); }
    catch (err) { setError(err instanceof Error ? err.message : 'Erro ao excluir'); }
    finally { setSaving(false); }
  }, [id, navigate]);

  const inputClass = (f: string) => `w-full px-3 py-2 border rounded-lg text-sm outline-none transition-colors ${fieldErrors[f] ? 'border-red-400 focus:ring-2 focus:ring-red-300' : 'border-gray-300 focus:ring-2 focus:ring-[#003087] focus:border-transparent'}`;
  const errMsg = (f: string) => fieldErrors[f] ? <p className="text-xs text-red-600 mt-1">{fieldErrors[f]}</p> : null;

  if (loading) return <Layout title={title}><Loading message="Carregando curso..." /></Layout>;

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {error && <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg"><p className="text-sm text-red-700">{error}</p></div>}
        <form onSubmit={handleSave} className="space-y-6">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Título <span className="text-red-500">*</span></label>
              <input type="text" value={formData.titulo} onChange={(e) => handleChange('titulo', e.target.value)} placeholder="Título do curso" className={inputClass('titulo')} />
              {errMsg('titulo')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
              <select value={formData.status} onChange={(e) => handleChange('status', e.target.value)} className={inputClass('status')}>
                <option value="PROGRAMADO">Programado</option>
                <option value="REALIZADO">Realizado</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Modalidade</label>
              <select value={formData.modalidade} onChange={(e) => handleChange('modalidade', e.target.value)} className={inputClass('modalidade')}>
                <option value="PRESENCIAL">Presencial</option>
                <option value="EAD">EAD</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Local</label>
              <input type="text" value={formData.local} onChange={(e) => handleChange('local', e.target.value)} placeholder="Local do curso" className={inputClass('local')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Data do Curso</label>
              <input type="datetime-local" value={formData.dataDoCurso} onChange={(e) => handleChange('dataDoCurso', e.target.value)} className={inputClass('dataDoCurso')} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Resumo (máx. 300 caracteres)</label>
              <textarea value={formData.resumo} onChange={(e) => handleChange('resumo', e.target.value)} placeholder="Breve descrição do curso" rows={3} maxLength={300} className={inputClass('resumo')} />
              <p className="text-xs text-gray-400 text-right mt-1">{formData.resumo.length}/300</p>
              {errMsg('resumo')}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Link Externo</label>
              <input type="url" value={formData.linkExterno} onChange={(e) => handleChange('linkExterno', e.target.value)} placeholder="https://..." className={inputClass('linkExterno')} />
              {errMsg('linkExterno')}
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
