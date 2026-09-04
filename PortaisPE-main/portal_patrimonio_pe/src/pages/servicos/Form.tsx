/// <reference types="vite/client" />

import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { graphqlRequest } from '../../lib/api';
import { useAuth } from '../../lib/auth';
import { generateSlug } from '../../utils/slugify';
import Layout from '../../components/Layout';
import Loading from '../../components/Loading';

interface Area {
  id: string;
  nome: string;
}

interface Subarea {
  id: string;
  nome: string;
}

interface ServicoFormData {
  titulo: string;
  slug: string;
  resumo: string;
  imagemAlt: string;
  ativo: boolean;
  areaResponsavelId: string;
  subareaId: string;
}

interface ServicoQueryResult {
  servico?: {
    id: string;
    titulo: string;
    slug: string;
    resumo: string;
    imagemAlt: string;
    ativo: boolean;
    imagem?: { id: string; url: string } | null;
    areaResponsavel?: { id: string; nome: string } | null;
    subarea?: { id: string; nome: string } | null;
  };
}

interface AreasQueryResult {
  areas: Area[];
}

interface SubareasQueryResult {
  subareas: Subarea[];
}

type FormMode = 'create' | 'edit';

/**
 * Formulário de criação/edição de Serviço.
 */
export default function ServicoForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();

  const mode: FormMode = id ? 'edit' : 'create';

  const [formData, setFormData] = useState<ServicoFormData>({
    titulo: '',
    slug: '',
    resumo: '',
    imagemAlt: '',
    ativo: true,
    areaResponsavelId: '',
    subareaId: '',
  });

  const [areas, setAreas] = useState<Area[]>([]);
  const [subareas, setSubareas] = useState<Subarea[]>([]);
  const [areasLoading, setAreasLoading] = useState(false);
  const [subareasLoading, setSubareasLoading] = useState(false);

  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);

  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [fieldErrors, setFieldErrors] = useState<Record<string, string>>({});

  const title = mode === 'create' ? 'Novo Serviço' : 'Editar Serviço';

  // ============================
  // Carregar áreas
  // ============================
  useEffect(() => {
    async function loadAreas() {
      setAreasLoading(true);
      try {
        const whereClause = isAdmin
          ? ''
          : `where: { id: { in: ${JSON.stringify(areaIds)} } }`;

        const query = `query GetAreas { areas(${whereClause} orderBy: { nome: asc }) { id nome } }`;
        const result = await graphqlRequest<AreasQueryResult>(query);
        setAreas(result.areas ?? []);
      } catch (err) {
        console.error('Erro ao carregar áreas:', err);
        setError('Erro ao carregar áreas');
      } finally {
        setAreasLoading(false);
      }
    }
    loadAreas();
  }, [isAdmin, areaIds]);

  // ============================
  // Carregar subáreas quando area mudar
  // ============================
  useEffect(() => {
    if (!formData.areaResponsavelId) {
      setSubareas([]);
      return;
    }

    async function loadSubareas() {
      setSubareasLoading(true);
      try {
        const query = `query GetSubareas($areaId: ID!) {
          subareas(where: { area: { id: { equals: $areaId } } }, orderBy: { nome: asc }) {
            id
            nome
          }
        }`;
        const result = await graphqlRequest<SubareasQueryResult>(query, {
          areaId: formData.areaResponsavelId,
        });
        setSubareas(result.subareas ?? []);
      } catch (err) {
        console.error('Erro ao carregar subáreas:', err);
      } finally {
        setSubareasLoading(false);
      }
    }
    loadSubareas();
  }, [formData.areaResponsavelId]);

  // ============================
  // Carregar dados do serviço em modo edição
  // ============================
  useEffect(() => {
    if (mode !== 'edit' || !id) return;

    async function loadServico() {
      setLoading(true);
      setError(null);
      try {
        const query = `query GetServico($id: ID!) {
          servico(where: { id: $id }) {
            id
            titulo
            slug
            resumo
            imagemAlt
            ativo
            imagem { id url }
            areaResponsavel { id nome }
            subarea { id nome }
          }
        }`;
        const result = await graphqlRequest<ServicoQueryResult>(query, { id });

        if (!result.servico) {
          setError('Serviço não encontrado');
          return;
        }

        const s = result.servico;

        setFormData({
          titulo: s.titulo ?? '',
          slug: s.slug ?? '',
          resumo: s.resumo ?? '',
          imagemAlt: s.imagemAlt ?? '',
          ativo: s.ativo ?? true,
          areaResponsavelId: s.areaResponsavel?.id ?? '',
          subareaId: s.subarea?.id ?? '',
        });

        if (s.imagem?.url) {
          setImagePreview(s.imagem.url);
        }
      } catch (err) {
        console.error('Erro ao carregar serviço:', err);
        setError(err instanceof Error ? err.message : 'Erro ao carregar serviço');
      } finally {
        setLoading(false);
      }
    }
    loadServico();
  }, [mode, id]);

  // ============================
  // Handlers
  // ============================
  const handleChange = useCallback(
    (field: keyof ServicoFormData, value: string | boolean) => {
      setFormData((prev) => ({ ...prev, [field]: value }));
      // Limpa erro do campo ao modificar
      setFieldErrors((prev) => {
        const next = { ...prev };
        delete next[field];
        return next;
      });
    },
    []
  );

  const handleTituloBlur = useCallback(() => {
    if (mode === 'create' || !formData.slug) {
      handleChange('slug', generateSlug(formData.titulo));
    }
  }, [formData.titulo, formData.slug, mode, handleChange]);

  const handleImageChange = useCallback(
    (e: React.ChangeEvent<HTMLInputElement>) => {
      const file = e.target.files?.[0];
      if (!file) return;
      setImageFile(file);
      setImagePreview(URL.createObjectURL(file));
    },
    []
  );

  // ============================
  // Validação
  // ============================
  const validate = useCallback((): boolean => {
    const errors: Record<string, string> = {};

    if (!formData.titulo.trim()) {
      errors.titulo = 'Título é obrigatório';
    }
    if (!formData.slug.trim()) {
      errors.slug = 'Slug é obrigatório';
    }
    if (!formData.areaResponsavelId) {
      errors.areaResponsavelId = 'Área responsável é obrigatória';
    }
    if (formData.resumo.length > 300) {
      errors.resumo = 'Resumo deve ter no máximo 300 caracteres';
    }

    setFieldErrors(errors);
    return Object.keys(errors).length === 0;
  }, [formData]);

  // ============================
  // Salvar
  // ============================
  const handleSave = useCallback(
    async (e: React.FormEvent) => {
      e.preventDefault();
      if (!validate()) return;

      setSaving(true);
      setError(null);

      try {
        const dataInput: Record<string, unknown> = {
          titulo: formData.titulo,
          slug: formData.slug,
          resumo: formData.resumo,
          imagemAlt: formData.imagemAlt,
          ativo: formData.ativo,
          areaResponsavel: formData.areaResponsavelId
            ? { connect: { id: formData.areaResponsavelId } }
            : undefined,
          subarea: formData.subareaId
            ? { connect: { id: formData.subareaId } }
            : undefined,
          // oQueE, quemPrecisa, comoSolicitar, maisInformacoes serão adicionados depois
        };

        // Remove undefined fields
        Object.keys(dataInput).forEach(
          (key) => dataInput[key] === undefined && delete dataInput[key]
        );

        if (mode === 'create') {
          const query = `mutation CreateServico($data: ServicoCreateInput!) {
            createServico(data: $data) {
              id
              titulo
            }
          }`;
          await graphqlRequest(query, { data: dataInput });
        } else {
          const query = `mutation UpdateServico($id: ID!, $data: ServicoUpdateInput!) {
            updateServico(where: { id: $id }, data: $data) {
              id
              titulo
            }
          }`;
          await graphqlRequest(query, { id, data: dataInput });
        }

        navigate('/servicos');
      } catch (err) {
        console.error('Erro ao salvar serviço:', err);
        setError(
          err instanceof Error ? err.message : 'Erro ao salvar serviço'
        );
      } finally {
        setSaving(false);
      }
    },
    [formData, id, mode, navigate, validate]
  );

  // ============================
  // Excluir
  // ============================
  const handleDelete = useCallback(async () => {
    if (!id) return;
    if (!window.confirm('Tem certeza que deseja excluir este serviço?')) return;

    setSaving(true);
    setError(null);

    try {
      const query = `mutation DeleteServico($id: ID!) {
        deleteServico(where: { id: $id }) {
          id
        }
      }`;
      await graphqlRequest(query, { id });
      navigate('/servicos');
    } catch (err) {
      console.error('Erro ao excluir serviço:', err);
      setError(err instanceof Error ? err.message : 'Erro ao excluir serviço');
    } finally {
      setSaving(false);
    }
  }, [id, navigate]);

  // ============================
  // Render
  // ============================
  const renderFieldError = (field: string) => {
    if (!fieldErrors[field]) return null;
    return <p className="text-xs text-red-600 mt-1">{fieldErrors[field]}</p>;
  };

  const inputClass = (field: string) =>
    `w-full px-3 py-2 border rounded-lg text-sm outline-none transition-colors ${
      fieldErrors[field]
        ? 'border-red-400 focus:ring-2 focus:ring-red-300'
        : 'border-gray-300 focus:ring-2 focus:ring-[#003087] focus:border-transparent'
    }`;

  if (loading) {
    return (
      <Layout title={title}>
        <Loading message="Carregando serviço..." />
      </Layout>
    );
  }

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {/* Error alert */}
        {error && (
          <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
            <p className="text-sm text-red-700">{error}</p>
          </div>
        )}

        <form onSubmit={handleSave} className="space-y-6">
          {/* Card do formulário */}
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6 space-y-5">
            {/* Título */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Título <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.titulo}
                onChange={(e) => handleChange('titulo', e.target.value)}
                onBlur={handleTituloBlur}
                placeholder="Digite o título do serviço"
                className={inputClass('titulo')}
              />
              {renderFieldError('titulo')}
            </div>

            {/* Slug */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Slug <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={formData.slug}
                onChange={(e) => handleChange('slug', e.target.value)}
                placeholder="url-do-servico"
                className={inputClass('slug')}
              />
              <p className="text-xs text-gray-400 mt-1">
                Gerado automaticamente a partir do título
              </p>
              {renderFieldError('slug')}
            </div>

            {/* Resumo */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Resumo
              </label>
              <textarea
                value={formData.resumo}
                onChange={(e) => handleChange('resumo', e.target.value)}
                placeholder="Breve descrição do serviço (máx. 300 caracteres)"
                rows={3}
                maxLength={300}
                className={inputClass('resumo')}
              />
              <div className="flex justify-between mt-1">
                <p className="text-xs text-gray-400">
                  Máximo de 300 caracteres
                </p>
                <p className="text-xs text-gray-400">
                  {formData.resumo.length}/300
                </p>
              </div>
              {renderFieldError('resumo')}
            </div>

            {/* Imagem */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Imagem
              </label>
              {imagePreview && (
                <div className="mb-2">
                  <img
                    src={imagePreview}
                    alt="Preview"
                    className="w-48 h-32 object-cover rounded-lg border border-gray-200"
                  />
                </div>
              )}
              <input
                type="file"
                accept="image/*"
                onChange={handleImageChange}
                className="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-blue-50 file:text-[#003087] hover:file:bg-blue-100"
              />
              {mode === 'edit' && imagePreview && !imageFile && (
                <p className="text-xs text-gray-400 mt-1">
                  Deixe vazio para manter a imagem atual
                </p>
              )}
            </div>

            {/* Texto Alternativo da Imagem */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Texto Alternativo (Alt)
              </label>
              <input
                type="text"
                value={formData.imagemAlt}
                onChange={(e) => handleChange('imagemAlt', e.target.value)}
                placeholder="Descrição da imagem para acessibilidade"
                className={inputClass('imagemAlt')}
              />
            </div>

            {/* Área Responsável */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Área Responsável <span className="text-red-500">*</span>
              </label>
              <select
                value={formData.areaResponsavelId}
                onChange={(e) => {
                  handleChange('areaResponsavelId', e.target.value);
                  handleChange('subareaId', '');
                }}
                className={inputClass('areaResponsavelId')}
                disabled={areasLoading}
              >
                <option value="">
                  {areasLoading ? 'Carregando...' : 'Selecione uma área'}
                </option>
                {areas.map((area) => (
                  <option key={area.id} value={area.id}>
                    {area.nome}
                  </option>
                ))}
              </select>
              {renderFieldError('areaResponsavelId')}
            </div>

            {/* Subárea */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Subárea
              </label>
              <select
                value={formData.subareaId}
                onChange={(e) => handleChange('subareaId', e.target.value)}
                className={inputClass('subareaId')}
                disabled={!formData.areaResponsavelId || subareasLoading}
              >
                <option value="">
                  {!formData.areaResponsavelId
                    ? 'Selecione uma área primeiro'
                    : subareasLoading
                    ? 'Carregando...'
                    : subareas.length === 0
                    ? 'Nenhuma subárea disponível'
                    : 'Selecione uma subárea'}
                </option>
                {subareas.map((sub) => (
                  <option key={sub.id} value={sub.id}>
                    {sub.nome}
                  </option>
                ))}
              </select>
            </div>

            {/* Ativo */}
            <div className="flex items-center gap-3">
              <input
                type="checkbox"
                id="ativo"
                checked={formData.ativo}
                onChange={(e) => handleChange('ativo', e.target.checked)}
                className="w-4 h-4 text-[#003087] border-gray-300 rounded focus:ring-[#003087]"
              />
              <label htmlFor="ativo" className="text-sm font-medium text-gray-700">
                Serviço ativo
              </label>
            </div>
          </div>

          {/* Ações */}
          <div className="flex items-center justify-between gap-3">
            <div>
              {mode === 'edit' && (
                <button
                  type="button"
                  onClick={handleDelete}
                  disabled={saving}
                  className="px-4 py-2 text-sm font-medium text-red-700 bg-red-50 border border-red-200 rounded-lg hover:bg-red-100 disabled:opacity-50 transition-colors"
                >
                  Excluir Serviço
                </button>
              )}
            </div>
            <div className="flex items-center gap-3">
              <button
                type="button"
                onClick={() => navigate(-1)}
                className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
              >
                Voltar
              </button>
              <button
                type="submit"
                disabled={saving}
                className="px-6 py-2 text-sm font-medium text-white bg-[#003087] rounded-lg hover:bg-[#001f54] disabled:opacity-50 transition-colors"
              >
                {saving ? 'Salvando...' : 'Salvar'}
              </button>
            </div>
          </div>
        </form>
      </div>
    </Layout>
  );
}

