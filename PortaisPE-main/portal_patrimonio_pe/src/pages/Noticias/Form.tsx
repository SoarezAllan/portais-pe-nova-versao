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

// ============================
// Interfaces
// ============================

interface Area {
  id: string;
  nome: string;
}

interface Subarea {
  id: string;
  nome: string;
}

interface Tag {
  id: string;
  nome: string;
}

interface NoticiaFormData {
  titulo: string;
  subtitulo: string;
  slug: string;
  resumo: string;
  dataPublicacao: string;
  destaque: boolean;
  ativo: boolean;
  areaResponsavelId: string;
  subareaId: string;
  imagemPrincipalAlt: string;
  corpo: string;
  tagIds: string[];
}

interface NoticiaQueryResult {
  noticia?: {
    id: string;
    titulo: string;
    subtitulo: string;
    slug: string;
    resumo: string;
    dataPublicacao: string;
    destaque: boolean;
    ativo: boolean;
    imagemPrincipal?: { id: string; url: string } | null;
    imagemPrincipalAlt: string;
    corpo?: { document?: unknown } | null;
    areaResponsavel?: { id: string; nome: string } | null;
    subarea?: { id: string; nome: string } | null;
    tags?: { id: string; nome: string }[];
  };
}

interface AreasResult {
  areas: Area[];
}

interface SubareasResult {
  subareas: Subarea[];
}

interface TagsResult {
  tags: Tag[];
}

type FormMode = 'create' | 'edit';

// ============================
// Helpers
// ============================

/**
 * Converte data ISO para o formato aceito por input datetime-local (YYYY-MM-DDTHH:mm)
 */
function toDatetimeLocal(iso: string | null | undefined): string {
  if (!iso) {
    // Default para agora
    const now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    return now.toISOString().slice(0, 16);
  }
  try {
    const d = new Date(iso);
    d.setMinutes(d.getMinutes() - d.getTimezoneOffset());
    return d.toISOString().slice(0, 16);
  } catch {
    return new Date().toISOString().slice(0, 16);
  }
}

/**
 * Formata datetime-local para ISO string
 */
function toISO(datetimeLocal: string): string {
  if (!datetimeLocal) return new Date().toISOString();
  return new Date(datetimeLocal).toISOString();
}

// ============================
// Componente
// ============================

export default function NoticiaForm() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAdmin, areaIds } = useAuth();

  const mode: FormMode = id ? 'edit' : 'create';
  const title = mode === 'create' ? 'Nova Notícia' : 'Editar Notícia';

  // --- Estado do formulário ---
  const [formData, setFormData] = useState<NoticiaFormData>({
    titulo: '',
    subtitulo: '',
    slug: '',
    resumo: '',
    dataPublicacao: toDatetimeLocal(null),
    destaque: false,
    ativo: true,
    areaResponsavelId: '',
    subareaId: '',
    imagemPrincipalAlt: '',
    corpo: '',
    tagIds: [],
  });

  // --- Estados de loading ---
  const [areas, setAreas] = useState<Area[]>([]);
  const [subareas, setSubareas] = useState<Subarea[]>([]);
  const [tags, setTags] = useState<Tag[]>([]);
  const [areasLoading, setAreasLoading] = useState(false);
  const [subareasLoading, setSubareasLoading] = useState(false);
  const [tagsLoading, setTagsLoading] = useState(false);

  // --- Imagem ---
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [existingImage, setExistingImage] = useState<{ id: string; url: string } | null>(null);

  // --- Estados gerais ---
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [fieldErrors, setFieldErrors] = useState<Record<string, string>>({});

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
        const result = await graphqlRequest<AreasResult>(query);
        setAreas(result.areas ?? []);
      } catch (err) {
        console.error('Erro ao carregar áreas:', err);
      } finally {
        setAreasLoading(false);
      }
    }
    loadAreas();
  }, [isAdmin, areaIds]);

  // ============================
  // Carregar tags filtradas por área
  // ============================
  useEffect(() => {
    async function loadTags() {
      setTagsLoading(true);
      try {
        let query: string;
        if (formData.areaResponsavelId) {
          query = `query GetTags {
            tags(where: { areaResponsavel: { id: { equals: "${formData.areaResponsavelId}" } } }, orderBy: { nome: asc }) {
              id nome
            }
          }`;
        } else if (!isAdmin && areaIds.length > 0) {
          query = `query GetTags {
            tags(where: { areaResponsavel: { id: { in: ${JSON.stringify(areaIds)} } } }, orderBy: { nome: asc }) {
              id nome
            }
          }`;
        } else {
          query = `query GetTags {
            tags(orderBy: { nome: asc }) { id nome }
          }`;
        }
        const result = await graphqlRequest<TagsResult>(query);
        setTags(result.tags ?? []);
      } catch (err) {
        console.error('Erro ao carregar tags:', err);
      } finally {
        setTagsLoading(false);
      }
    }
    loadTags();
  }, [formData.areaResponsavelId, isAdmin, areaIds]);

  // ============================
  // Carregar subáreas quando área mudar
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
            id nome
          }
        }`;
        const result = await graphqlRequest<SubareasResult>(query, {
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
  // Carregar dados da notícia em modo edição
  // ============================
  useEffect(() => {
    if (mode !== 'edit' || !id) return;

    async function loadNoticia() {
      setLoading(true);
      setError(null);
      try {
        const query = `query GetNoticia($id: ID!) {
          noticia(where: { id: $id }) {
            id
            titulo
            subtitulo
            slug
            resumo
            dataPublicacao
            destaque
            ativo
            imagemPrincipal { id url }
            imagemPrincipalAlt
            corpo { document }
            areaResponsavel { id nome }
            subarea { id nome }
            tags { id nome }
          }
        }`;
        const result = await graphqlRequest<NoticiaQueryResult>(query, { id });

        if (!result.noticia) {
          setError('Notícia não encontrada');
          return;
        }

        const n = result.noticia;

        setFormData({
          titulo: n.titulo ?? '',
          subtitulo: n.subtitulo ?? '',
          slug: n.slug ?? '',
          resumo: n.resumo ?? '',
          dataPublicacao: toDatetimeLocal(n.dataPublicacao),
          destaque: n.destaque ?? false,
          ativo: n.ativo ?? true,
          areaResponsavelId: n.areaResponsavel?.id ?? '',
          subareaId: n.subarea?.id ?? '',
          imagemPrincipalAlt: n.imagemPrincipalAlt ?? '',
          corpo: '',
          tagIds: n.tags?.map((t) => t.id) ?? [],
        });

        if (n.imagemPrincipal?.url) {
          setExistingImage({ id: n.imagemPrincipal.id, url: n.imagemPrincipal.url });
        }
      } catch (err) {
        console.error('Erro ao carregar notícia:', err);
        setError(err instanceof Error ? err.message : 'Erro ao carregar notícia');
      } finally {
        setLoading(false);
      }
    }
    loadNoticia();
  }, [mode, id]);

  // ============================
  // Handlers
  // ============================
  const handleChange = useCallback(
    (field: keyof NoticiaFormData, value: string | boolean | string[]) => {
      setFormData((prev) => ({ ...prev, [field]: value }));
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

  const handleImageChange = useCallback((file: File | null) => {
    setImageFile(file);
  }, []);

  const handleTagToggle = useCallback(
    (tagId: string) => {
      setFormData((prev) => {
        const exists = prev.tagIds.includes(tagId);
        return {
          ...prev,
          tagIds: exists
            ? prev.tagIds.filter((id) => id !== tagId)
            : [...prev.tagIds, tagId],
        };
      });
    },
    []
  );

  // ============================
  // Validação
  // ============================
  const validate = useCallback((): boolean => {
    const errors: Record<string, string> = {};

    if (!formData.titulo.trim()) errors.titulo = 'Título é obrigatório';
    if (!formData.slug.trim()) errors.slug = 'Slug é obrigatório';
    if (!formData.areaResponsavelId) errors.areaResponsavelId = 'Área responsável é obrigatória';
    if (formData.resumo.length > 250) errors.resumo = 'Resumo deve ter no máximo 250 caracteres';

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
        // Monta dados para a mutation (sem imagem)
        const dataInput: Record<string, unknown> = {
          titulo: formData.titulo,
          subtitulo: formData.subtitulo,
          slug: formData.slug,
          resumo: formData.resumo,
          dataPublicacao: toISO(formData.dataPublicacao),
          destaque: formData.destaque,
          ativo: formData.ativo,
          imagemPrincipalAlt: formData.imagemPrincipalAlt,
          areaResponsavel: formData.areaResponsavelId
            ? { connect: { id: formData.areaResponsavelId } }
            : undefined,
          subarea: formData.subareaId
            ? { connect: { id: formData.subareaId } }
            : undefined,
          tags: formData.tagIds.length
            ? { connect: formData.tagIds.map((id) => ({ id })) }
            : undefined,
        };

        // Remove undefined
        Object.keys(dataInput).forEach(
          (key) => dataInput[key] === undefined && delete dataInput[key]
        );

        // Upload de imagem se houver novo arquivo
        if (imageFile) {
          // Usa uploadToKeystone com mutation específica para Noticia
          const uploadMutation = `mutation ($file: Upload!) {
            temp: createNoticia(data: { imagemPrincipal: { upload: $file }, titulo: "temp" }) {
              id
              imagemPrincipal { id url }
            }
          }`;
          const uploaded = await uploadToKeystone(imageFile, uploadMutation);

          // Conecta a imagem enviada
          dataInput.imagemPrincipal = { connect: { id: uploaded.id } };

          // Remove a notícia temporária criada pelo upload
          try {
            await graphqlRequest(
              `mutation { deleteNoticia(where: { id: "${uploaded.id}" }) { id } }`
            );
          } catch {
            // Ignora erro de cleanup
          }
        }

        // Executa mutation
        if (mode === 'create') {
          const query = `mutation CreateNoticia($data: NoticiaCreateInput!) {
            createNoticia(data: $data) { id titulo }
          }`;
          await graphqlRequest(query, { data: dataInput });
        } else {
          const query = `mutation UpdateNoticia($id: ID!, $data: NoticiaUpdateInput!) {
            updateNoticia(where: { id: $id }, data: $data) { id titulo }
          }`;
          await graphqlRequest(query, { id, data: dataInput });
        }

        navigate('/noticias');
      } catch (err) {
        console.error('Erro ao salvar notícia:', err);
        setError(err instanceof Error ? err.message : 'Erro ao salvar notícia');
      } finally {
        setSaving(false);
      }
    },
    [formData, id, mode, navigate, validate, imageFile]
  );

  // ============================
  // Excluir
  // ============================
  const handleDelete = useCallback(async () => {
    if (!id) return;
    if (!window.confirm('Tem certeza que deseja excluir esta notícia?')) return;

    setSaving(true);
    setError(null);

    try {
      const query = `mutation DeleteNoticia($id: ID!) {
        deleteNoticia(where: { id: $id }) { id }
      }`;
      await graphqlRequest(query, { id });
      navigate('/noticias');
    } catch (err) {
      console.error('Erro ao excluir notícia:', err);
      setError(err instanceof Error ? err.message : 'Erro ao excluir notícia');
    } finally {
      setSaving(false);
    }
  }, [id, navigate]);

  // ============================
  // Render helpers
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
        <Loading message="Carregando notícia..." />
      </Layout>
    );
  }

  return (
    <Layout title={title}>
      <div className="max-w-2xl mx-auto">
        {error && (
          <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
            <p className="text-sm text-red-700">{error}</p>
          </div>
        )}

        <form onSubmit={handleSave} className="space-y-6">
          {/* Card principal */}
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
                placeholder="Título da notícia"
                className={inputClass('titulo')}
              />
              {renderFieldError('titulo')}
            </div>

            {/* Subtítulo */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Subtítulo
              </label>
              <input
                type="text"
                value={formData.subtitulo}
                onChange={(e) => handleChange('subtitulo', e.target.value)}
                placeholder="Subtítulo da notícia"
                className={inputClass('subtitulo')}
              />
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
                placeholder="url-da-noticia"
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
                placeholder="Breve resumo da notícia (máx. 250 caracteres)"
                rows={3}
                maxLength={250}
                className={inputClass('resumo')}
              />
              <div className="flex justify-between mt-1">
                <p className="text-xs text-gray-400">Máximo de 250 caracteres</p>
                <p className="text-xs text-gray-400">{formData.resumo.length}/250</p>
              </div>
              {renderFieldError('resumo')}
            </div>

            {/* Data de Publicação */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Data de Publicação
              </label>
              <input
                type="datetime-local"
                value={formData.dataPublicacao}
                onChange={(e) => handleChange('dataPublicacao', e.target.value)}
                className={inputClass('dataPublicacao')}
              />
            </div>

            {/* Linha: Destaque + Ativo */}
            <div className="flex items-center gap-6">
              {/* Destaque */}
              <div className="flex items-center gap-3">
                <input
                  type="checkbox"
                  id="destaque"
                  checked={formData.destaque}
                  onChange={(e) => handleChange('destaque', e.target.checked)}
                  className="w-4 h-4 text-yellow-500 border-gray-300 rounded focus:ring-yellow-500"
                />
                <label htmlFor="destaque" className="text-sm font-medium text-gray-700">
                  Em destaque
                </label>
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
                  Notícia ativa
                </label>
              </div>
            </div>

            {/* Imagem Principal */}
            <ImageUpload
              value={existingImage}
              onChange={handleImageChange}
              label="Imagem Principal"
            />

            {/* Texto Alternativo */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Texto Alternativo (Alt)
              </label>
              <input
                type="text"
                value={formData.imagemPrincipalAlt}
                onChange={(e) => handleChange('imagemPrincipalAlt', e.target.value)}
                placeholder="Descrição da imagem para acessibilidade"
                className={inputClass('imagemPrincipalAlt')}
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

            {/* Tags (select múltiplo via checkboxes) */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Tags
              </label>
              {tagsLoading ? (
                <p className="text-sm text-gray-400">Carregando tags...</p>
              ) : tags.length === 0 ? (
                <p className="text-sm text-gray-400">
                  {formData.areaResponsavelId
                    ? 'Nenhuma tag disponível para esta área'
                    : 'Selecione uma área para carregar as tags'}
                </p>
              ) : (
                <div className="flex flex-wrap gap-2 mt-1">
                  {tags.map((tag) => {
                    const selected = formData.tagIds.includes(tag.id);
                    return (
                      <button
                        key={tag.id}
                        type="button"
                        onClick={() => handleTagToggle(tag.id)}
                        className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-medium transition-colors ${
                          selected
                            ? 'bg-[#003087] text-white'
                            : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                        }`}
                      >
                        {selected && (
                          <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                          </svg>
                        )}
                        {tag.nome}
                      </button>
                    );
                  })}
                </div>
              )}
              {formData.tagIds.length > 0 && (
                <p className="text-xs text-gray-400 mt-1">
                  {formData.tagIds.length} tag(s) selecionada(s)
                </p>
              )}
            </div>

            {/* Corpo (textarea temporário) */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Corpo da Notícia
              </label>
              <textarea
                value={formData.corpo}
                onChange={(e) => handleChange('corpo', e.target.value)}
                placeholder="Conteúdo da notícia (futuramente editor rich text)"
                rows={8}
                className={inputClass('corpo')}
              />
              <p className="text-xs text-gray-400 mt-1">
                Editor rich text será implementado em breve
              </p>
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
                  Excluir Notícia
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

