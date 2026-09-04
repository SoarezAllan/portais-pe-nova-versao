import apiClient from '../api';

async function gql(query, variables) {
  const resp = await apiClient.post('/api/graphql', { query, variables });
  if (resp.data && resp.data.errors) throw new Error(resp.data.errors.map(e => e.message).join('\n'));
  return resp.data.data;
}

export async function fetchServicos(areaNome, subareaNome) {
  const whereParts = [`areaResponsavel: { nome: { equals: "${areaNome}" } }`, `ativo: { equals: true }`];
  if (subareaNome) whereParts.push(`subarea: { nome: { equals: "${subareaNome}" } }`);
  const where = `{ ${whereParts.join(', ')} }`;
  const query = `query FetchServicos { servicos(where: ${where}, orderBy: { titulo: asc }) { id titulo slug resumo imagem { url } imagemAlt subarea { id nome } areaResponsavel { id nome } } }`;
  const data = await gql(query);
  return data.servicos || [];
}

export async function fetchNoticias(areaNome) {
  const where = `{ areaResponsavel: { nome: { equals: "${areaNome}" } }, ativo: { equals: true } }`;
  const query = `query FetchNoticias { noticias(where: ${where}, orderBy: [{ dataPublicacao: desc }]) { id titulo slug resumo imagemPrincipal { url } imagemPrincipalAlt dataPublicacao tags { id nome } subarea { id nome } areaResponsavel { id nome } } }`;
  const data = await gql(query);
  return data.noticias || [];
}

export async function fetchLegislacoes(areaNome, subareaNome) {
  const whereParts = [`areaResponsavel: { nome: { equals: "${areaNome}" } }`];
  if (subareaNome) whereParts.push(`subarea: { nome: { equals: "${subareaNome}" } }`);
  const where = `{ ${whereParts.join(', ')} }`;
  const query = `query FetchLegislacoes { legislacoes(where: ${where}, orderBy: { titulo: asc }) { id titulo linkExterno resumo categoria areaResponsavel { id nome } subarea { id nome } } }`;
  const data = await gql(query);
  return data.legislacoes || [];
}

export async function fetchCursos(areaNome) {
  const query = `
    query FetchCursos($areaNome: String!) {
      cursos(
        where: {
          areaResponsavel: { nome: { equals: $areaNome } }
        }
      ) {
        id titulo resumo status linkExterno dataDoCurso modalidade local
        subarea { id nome }
        areaResponsavel { id nome }
      }
    }
  `;
  const data = await gql(query, { areaNome });
  return data.cursos || [];
}

export async function fetchSolucoes(areaNome) {
  const where = `{ areaResponsavel: { nome: { equals: "${areaNome}" } }, ativo: { equals: true } }`;
  const query = `query FetchSolucoes { solucoes(where: ${where}, orderBy: { titulo: asc }) { id titulo slug resumo imagem { url } imagemAlt linkExterno subarea { id nome } areaResponsavel { id nome } } }`;
  const data = await gql(query);
  return data.solucoes || [];
}

export async function fetchPortfolios(areaNome) {
  const where = `{ areaResponsavel: { nome: { equals: "${areaNome}" } }, ativo: { equals: true } }`;
  const query = `query FetchPortfolios { portfolios(where: ${where}, orderBy: { titulo: asc }) { id titulo slug resumo imagem { url } imagemAlt subarea { id nome } areaResponsavel { id nome } } }`;
  const data = await gql(query);
  return data.portfolios || [];
}

export async function fetchPaginaQuemSomos(areaNome) {
  const query = `
    query GetPaginaQuemSomos($siteArea: String!) {
      paginasQuemSomos(where: { areaResponsavel: { nome: { equals: $siteArea } } }) {
        id tituloDaPagina timeTitulo timeDescricao muralTextoIntrodutorio
        muralItens(where: { ativo: { equals: true } }) {
          id valor titulo descricao
        }
        time(where: { ativo: { equals: true } }) {
          id nome cargo descricao
          foto { url }
        }
      }
    }
  `;
  const data = await gql(query, { siteArea: areaNome });
  return data.paginasQuemSomos || [];
}

export async function fetchSubareas(areaNome) {
  try {
    const where = areaNome ? `{ area: { nome: { equals: "${areaNome}" } } }` : `{}`;
    const query = `query FetchSubareas { subareas(where: ${where}, orderBy: { nome: asc }) { id nome } }`;
    const data = await gql(query);
    return (data.subareas || []).map(s => s.nome.trim()).filter(Boolean);
  } catch (e) {
    return [];
  }
}

export default {
  fetchSubareas,
  fetchServicos,
  fetchNoticias,
  fetchLegislacoes,
  fetchCursos,
  fetchSolucoes,
  fetchPortfolios,
  fetchPaginaQuemSomos,
};
