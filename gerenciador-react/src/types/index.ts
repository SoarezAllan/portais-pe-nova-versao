export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'operator';
  areas?: { id: string; nome: string }[];
}

export interface AreaResponsavel {
  id: string;
  nome: string;
}

export interface Subarea {
  id: string;
  nome: string;
}

export interface Servico {
  id: string;
  titulo: string;
  slug: string;
  resumo: string;
  imagem?: { id: string; url: string } | null;
  imagemAlt?: string;
  oQueE: any;
  quemPrecisa: any;
  comoSolicitar: any;
  maisInformacoes: any;
  ativo: boolean;
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
  createdAt?: string;
  updatedAt?: string;
}

export interface Noticia {
  id: string;
  titulo: string;
  subtitulo?: string;
  slug: string;
  resumo: string;
  corpo: any;
  imagemPrincipal?: { id: string; url: string } | null;
  imagemPrincipalAlt?: string;
  dataPublicacao: string;
  destaque: boolean;
  ativo: boolean;
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
  tags?: { id: string; nome: string }[];
  createdAt?: string;
}

export interface Legislacao {
  id: string;
  titulo: string;
  linkExterno?: string;
  categoria?: string;
  resumo?: string;
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
  createdAt?: string;
  createdBy?: string;
  updatedAt?: string;
  updatedBy?: string;
}

export interface Curso {
  id: string;
  titulo: string;
  status: string;
  resumo?: string;
  linkExterno?: string;
  dataDoCurso?: string;
  modalidade?: string;
  local?: string;
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
  createdAt?: string;
  createdBy?: string;
  updatedAt?: string;
  updatedBy?: string;
}

export interface QuemSomos {
  id: string;
  tituloDaPagina: string;
  muralTextoIntrodutorio: string;
  timeTitulo: string;
  muralItens?: QuemSomosMuralItem[];
  conteudosPorSubarea?: QuemSomosSubareaItem[];
  time?: QuemSomosTimeItem[];
  areaResponsavel?: { id: string; nome: string } | null;
  subarea?: { id: string; nome: string } | null;
  createdAt?: string;
  createdBy?: string;
}

export interface QuemSomosMuralItem {
  id: string;
  valor: string;
  titulo: string;
  descricao: string;
  ativo: boolean;
}

export interface QuemSomosSubareaItem {
  id: string;
  subarea?: { id: string; nome: string } | null;
  conteudo: any;
  ativo: boolean;
}

export interface QuemSomosTimeItem {
  id: string;
  nome: string;
  cargo: string;
  descricao: string;
  foto?: { id: string; url: string } | null;
  ativo: boolean;
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
}
