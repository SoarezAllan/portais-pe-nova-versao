/** @jsxRuntime classic */
/** @jsx jsx */
import { Fragment, type ReactNode, useEffect, useState } from 'react';
import { jsx } from '@keystone-ui/core';
import { type NavigationProps } from '@keystone-6/core/admin-ui/components';
import { useKeystone } from '@keystone-6/core/admin-ui/context';
import { Link, useRouter } from '@keystone-6/core/admin-ui/router';
import { gql, useMutation, useQuery } from '@keystone-6/core/admin-ui/apollo';

const CURRENT_USER = gql`
  query CurrentAdminUser($id: ID!) {
    user(where: { id: $id }) {
      id
      name
      email
      role
      areas {
        id
        nome
      }
    }
  }
`;

const END_SESSION = gql`
  mutation EndSession {
    endSession
  }
`;

const groups = [
  {
    label: 'Operacao',
    lists: ['AreaResponsavel', 'Gerencia', 'Subarea', 'Setor', 'Gestores'],
  },
  {
    label: 'Conteudo',
    lists: ['Servico', 'Noticia', 'Legislacao', 'Curso', 'Solucao', 'Tag'],
  },
  {
    label: 'Institucional',
    lists: ['PaginaQuemSomos', 'QuemSomosMuralItem', 'QuemSomosTimeItem', 'QuemSomosSubareaItem'],
  },
  {
    label: 'Sistema',
    lists: ['User', 'AuditLog'],
  },
];

// Chaves de listas que somem do menu lateral (Admin UI), mas continuam
// funcionando normalmente via schema/GraphQL/API — só não aparecem aqui.
const hiddenFromNavKeys: string[] = [
  'QuemSomosTimeItem',
  'QuemSomosMuralItem',
  'PortfolioImagem',
  'Acesso',
  'QuemSomosSubareaItem',
  'Tag',
  'Setor',
  'Gestores',
  'Gerencia',
  'Portfolio',
];

const indicadoresAcessoUrl = '/indicadores_de_acesso';
const indicadoresVoltarUrl = '/indicadores_de_acesso';
const indicadoresVoltarAdminLabel = 'Voltar para o Admin (keystone)';

const listAccent: Record<string, string> = {
  AreaResponsavel: '#2563eb',
  Gerencia: '#0f766e',
  Subarea: '#0891b2',
  Setor: '#16a34a',
  Gestores: '#7c3aed',
  Servico: '#dc2626',
  Noticia: '#ea580c',
  Legislacao: '#475569',
  Curso: '#9333ea',
  Solucao: '#0284c7',
  Tag: '#64748b',
  PaginaQuemSomos: '#0d9488',
  QuemSomosMuralItem: '#ca8a04',
  QuemSomosTimeItem: '#8b5cf6',
  QuemSomosSubareaItem: '#0891b2',
  User: '#1d4ed8',
  AuditLog: '#334155',
};

const translations: Record<string, string> = {
  'Create': 'Criar',
  'Create ': 'Criar ',
  'Save': 'Salvar',
  'Save changes': 'Salvar alterações',
  'Delete': 'Excluir',
  'Cancel': 'Cancelar',
  'Reset': 'Limpar',
  'Update': 'Atualizar',
  'Edit': 'Editar',
  'View': 'Visualizar',
  'Search': 'Pesquisar',
  'Filter': 'Filtro',
  'Filters': 'Filtros',
  'Columns': 'Colunas',
  'Clear': 'Limpar',
  'Add': 'Adicionar',
  'Remove': 'Remover',
  'Connect': 'Vincular',
  'Disconnect': 'Desvincular',
  'Sign out': 'Sair',
  'Signed in as': 'Logado como',
  'Dashboard': 'Início',
  'No access': 'Sem acesso',
  'Loading': 'Carregando',
  'Changes saved': 'Alterações salvas',
  'Create item': 'Criar item',
  'Delete item': 'Excluir item',
  'Add filter': 'Adicionar filtro',
  'Apply changes': 'Aplicar alterações',
  'Remove filter': 'Remover filtro',
  'Sort': 'Ordenar',
  'Selected fields': 'Campos selecionados',
  'Field': 'Campo',
  'Operator': 'Operador',
  'Value': 'Valor',
  'No results': 'Nenhum resultado',
  'No items found': 'Nenhum item encontrado',
  'Items': 'Itens',
  'items': 'itens',
  'item': 'item',
  'Showing': 'Mostrando',
  'of': 'de',
  'Next': 'Próximo',
  'Previous': 'Anterior',
  'Back': 'Voltar',
  'Confirm': 'Confirmar',
  'Yes': 'Sim',
  'No': 'Não',
  'More actions': 'Mais ações',
  'API Explorer': 'Explorador da API',
  'Links and signout': 'Links e sair',
  'Select...': 'Selecionar...',
};

const relatedLabels: Record<string, string> = {
  Area: 'Área',
  Areas: 'Áreas',
  AreaResponsavel: 'Área',
  Gerencia: 'Gerência',
  Gerencias: 'Gerências',
  Subarea: 'Subárea',
  Subareas: 'Subáreas',
  Setor: 'Setor',
  Setores: 'Setores',
  Gestores: 'Gestor',
  Gestor: 'Gestor',
  Servico: 'Serviço',
  Servicos: 'Serviços',
  Noticia: 'Notícia',
  Noticias: 'Notícias',
  Legislacao: 'Legislação',
  Legislacoes: 'Legislações',
  Curso: 'Curso',
  Cursos: 'Cursos',
  Solucao: 'Solução',
  Solucoes: 'Soluções',
  Tag: 'Tag',
  Tags: 'Tags',
  User: 'Usuário',
  Users: 'Usuários',
  Filter: 'Filtro',
};

function translateValue(value: string) {
  if (translations[value]) return translations[value];

  const createRelated = value.match(/^Create related (.+)$/);
  if (createRelated) {
    const label = relatedLabels[createRelated[1]] || createRelated[1];
    return `Criar ${label} relacionada`;
  }

  const createLabel = value.match(/^Create (.+)$/);
  if (createLabel) {
    const label = relatedLabels[createLabel[1]] || createLabel[1];
    return `Criar ${label}`;
  }

  const deleteLabel = value.match(/^Delete (.+)$/);
  if (deleteLabel) {
    const label = relatedLabels[deleteLabel[1]] || deleteLabel[1];
    return `Excluir ${label}`;
  }

  return null;
}

function translateKeystoneText() {
  const translate = () => {
    document
      .querySelectorAll('input, textarea, button, a, [aria-label], [title]')
      .forEach((node) => {
        ['placeholder', 'aria-label', 'title'].forEach((attribute) => {
          const value = node.getAttribute(attribute);
          const translated = value ? translateValue(value) : null;
          if (translated) node.setAttribute(attribute, translated);
        });
      });

    document.querySelectorAll('button, a, th, td, label, option').forEach((node) => {
      const txt = (node.textContent || '').trim();
      if (!txt) return;
      const translated = translateValue(txt);
      if (translated) node.textContent = translated;
    });

    const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
    const textNodes: Text[] = [];
    while (walker.nextNode()) textNodes.push(walker.currentNode as Text);

    textNodes.forEach((node) => {
      const value = node.nodeValue || '';
      const trimmed = value.trim();
      const translated = trimmed ? translateValue(trimmed) : null;
      if (!translated) return;
      const prefix = value.match(/^\s*/)?.[0] || '';
      const suffix = value.match(/\s*$/)?.[0] || '';
      node.nodeValue = `${prefix}${translated}${suffix}`;
    });
  };

  translate();
  const observer = new MutationObserver(translate);
  observer.observe(document.body, { childList: true, subtree: true });
  return () => observer.disconnect();
}

function KeystonePortugueseLayer() {
  useEffect(() => translateKeystoneText(), []);
  return null;
}

function CustomLogo() {
  const { authenticatedItem } = useKeystone();
  const userId = authenticatedItem.state === 'authenticated' ? authenticatedItem.id : undefined;
  const { data } = useQuery(CURRENT_USER, { variables: { id: userId }, skip: !userId });
  const user = data?.user;
  const isAdmin = user?.role === 'admin';
  const areas = user?.areas?.map((area: { nome: string }) => area.nome).filter(Boolean) || [];
  const subtitle = !isAdmin && areas.length ? `Portal de ${areas.join(' / ')}` : null;

  return (
    <Link
      href="/"
      aria-label="Portal de Gestão SAD Pernambuco"
      css={{
        alignItems: 'center',
        color: '#0f172a',
        display: 'flex',
        gap: 12,
        padding: '22px 28px 10px',
        textDecoration: 'none',
      }}
    >
      <span
        aria-hidden="true"
        css={{
          alignItems: 'center',
          background: '#0f172a',
          borderRadius: 8,
          color: '#fff',
          display: 'inline-flex',
          fontSize: 14,
          fontWeight: 800,
          height: 38,
          justifyContent: 'center',
          width: 38,
        }}
      >
        GP
      </span>
      <span css={{ display: 'grid', gap: 2 }}>
        <strong css={{ fontSize: 15, lineHeight: 1 }}>Portal de Gestão SAD Pernambuco</strong>
        {subtitle && (
          <span css={{ color: '#64748b', fontSize: 12, lineHeight: 1.2 }}>{subtitle}</span>
        )}
      </span>
    </Link>
  );
}

function DashboardLink() {
  const router = useRouter();
  const selected = router.pathname === '/';
  return (
    <li css={{ listStyle: 'none' }}>
      <Link
        href="/"
        aria-current={selected ? 'location' : false}
        css={{
          alignItems: 'center',
          background: selected ? '#eef2ff' : 'transparent',
          borderRadius: 8,
          color: selected ? '#1e1b4b' : '#334155',
          display: 'flex',
          fontSize: 14,
          fontWeight: 700,
          gap: 10,
          margin: '0 18px 6px',
          padding: '10px 12px',
          textDecoration: 'none',
          ':hover': { background: '#f1f5f9', color: '#0f172a' },
        }}
      >
        <span css={{ background: '#4f46e5', borderRadius: 6, height: 8, width: 8 }} />
        Inicio
      </Link>
    </li>
  );
}

function ListLink({ list }: { list: NavigationProps['lists'][number] }) {
  const router = useRouter();
  const href = `/${list.path}${list.isSingleton ? '/1' : ''}`;
  const selected = router.pathname.split('/')[1] === list.path.split('/')[0];
  const accent = listAccent[list.key] || '#64748b';

  return (
    <li css={{ listStyle: 'none' }}>
      <Link
        href={href}
        aria-current={selected ? 'location' : false}
        css={{
          alignItems: 'center',
          background: selected ? '#f8fafc' : 'transparent',
          border: selected ? '1px solid #e2e8f0' : '1px solid transparent',
          borderRadius: 8,
          color: selected ? '#0f172a' : '#475569',
          display: 'flex',
          fontSize: 13,
          fontWeight: selected ? 700 : 600,
          gap: 10,
          margin: '0 18px 4px',
          minHeight: 36,
          padding: '8px 10px',
          textDecoration: 'none',
          ':hover': { background: '#f8fafc', borderColor: '#e2e8f0', color: '#0f172a' },
        }}
      >
        <span
          aria-hidden="true"
          css={{
            background: accent,
            borderRadius: 999,
            height: 7,
            opacity: selected ? 1 : 0.65,
            width: 7,
          }}
        />
        <span css={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
          {list.label}
        </span>
      </Link>
    </li>
  );
}

function NavGroup({ title, children }: { title: string; children: ReactNode }) {
  return (
    <li css={{ listStyle: 'none', marginTop: 16 }}>
      <div
        css={{
          color: '#94a3b8',
          fontSize: 11,
          fontWeight: 800,
          letterSpacing: 0,
          margin: '0 28px 8px',
          textTransform: 'uppercase',
        }}
      >
        {title}
      </div>
      <ul css={{ margin: 0, padding: 0 }}>{children}</ul>
    </li>
  );
}

function NavigationShell({
  authenticatedItem,
  children,
}: Pick<NavigationProps, 'authenticatedItem'> & { children: ReactNode }) {
  return (
    <div css={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', position: 'relative' }}>
      <div css={{ margin: '18px 18px 0' }}>
        <div css={{ alignItems: 'flex-start', display: 'flex', gap: 10 }}>
          <div css={{ flex: 1, minWidth: 0 }}>
            <UserProfileCard authenticatedItem={authenticatedItem} />
          </div>
          <ActionsMenu />
        </div>
        <nav role="navigation" aria-label="Navegação lateral" css={{ marginTop: 12 }}>
          <ul css={{ padding: 0, margin: 0, li: { listStyle: 'none' } }}>
            {children}
          </ul>
        </nav>
      </div>
    </div>
  );
}

function IndicadoresAcessoItem() {
  return (
    <li css={{ listStyle: 'none' }}>
      <a
        href={indicadoresAcessoUrl}
        target="_self"
        rel="noreferrer"
        aria-label="Indicadores de Acesso"
        css={{
          alignItems: 'center',
          background: 'transparent',
          border: '1px solid transparent',
          borderRadius: 8,
          color: '#0f172a',
          display: 'flex',
          fontSize: 13,
          fontWeight: 700,
          gap: 10,
          margin: '0 18px 4px',
          minHeight: 36,
          padding: '8px 10px',
          textDecoration: 'none',
          ':hover': { background: '#f8fafc', borderColor: '#e2e8f0', color: '#0f172a' },
        }}
      >
        <span aria-hidden="true" css={{ background: '#2563eb', borderRadius: 999, height: 7, opacity: 0.95, width: 7 }} />
        <span css={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
          Indicadores de Acesso
        </span>
      </a>
    </li>
  );
}

function ActionsMenu() {
  const { apiPath } = useKeystone();
  const [isOpen, setIsOpen] = useState(false);
  const [endSession, { loading }] = useMutation(END_SESSION);

  return (
    <div css={{ flex: '0 0 auto', position: 'relative' }}>
      <button
        type="button"
        aria-label="Mais ações"
        onClick={() => setIsOpen((value) => !value)}
        css={{
          alignItems: 'center',
          background: '#f1f5f9',
          border: '1px solid #e2e8f0',
          borderRadius: 6,
          color: '#475569',
          cursor: 'pointer',
          display: 'inline-flex',
          fontSize: 18,
          fontWeight: 800,
          height: 34,
          justifyContent: 'center',
          lineHeight: 1,
          width: 36,
          ':hover': { background: '#e2e8f0', color: '#0f172a' },
        }}
      >
        ...
      </button>
      {isOpen && (
        <div
          css={{
            background: '#fff',
            border: '1px solid #e2e8f0',
            borderRadius: 8,
            boxShadow: '0 12px 24px rgba(15, 23, 42, 0.12)',
            display: 'grid',
            gap: 4,
            minWidth: 170,
            padding: 6,
            position: 'absolute',
            right: 0,
            top: 42,
            zIndex: 20,
          }}
        >
          {process.env.NODE_ENV !== 'production' && (
            <a
              href={apiPath}
              target="_blank"
              rel="noreferrer"
              css={{
                borderRadius: 6,
                color: '#334155',
                fontSize: 13,
                fontWeight: 600,
                padding: '8px 10px',
                textDecoration: 'none',
                ':hover': { background: '#f8fafc' },
              }}
            >
              Explorador da API
            </a>
          )}
          <button
            type="button"
            disabled={loading}
            onClick={async () => {
              const result = await endSession();
              if (result.data?.endSession) window.location.reload();
            }}
            css={{
              background: 'transparent',
              border: 0,
              borderRadius: 6,
              color: '#b91c1c',
              cursor: loading ? 'default' : 'pointer',
              fontSize: 13,
              fontWeight: 700,
              padding: '8px 10px',
              textAlign: 'left',
              ':hover': { background: '#fef2f2' },
            }}
          >
            {loading ? 'Saindo...' : 'Sair'}
          </button>
        </div>
      )}
    </div>
  );
}

function UserProfileCard({ authenticatedItem }: Pick<NavigationProps, 'authenticatedItem'>) {
  const [isOpen, setIsOpen] = useState(false);
  const userId = authenticatedItem.state === 'authenticated' ? authenticatedItem.id : undefined;
  const { data, loading } = useQuery(CURRENT_USER, { variables: { id: userId }, skip: !userId });

  if (authenticatedItem.state !== 'authenticated') return null;

  const user = data?.user;
  const role = user?.role === 'admin' ? 'Administrador' : 'Operador';
  const areas = user?.areas?.map((area: { nome: string }) => area.nome).filter(Boolean) || [];
  const initials = (user?.name || authenticatedItem.label || 'Usuario')
    .split(' ')
    .filter(Boolean)
    .slice(0, 2)
    .map((part: string) => part[0])
    .join('')
    .toUpperCase();

  return (
    <div>
      <button
        type="button"
        onClick={() => setIsOpen((value) => !value)}
        aria-expanded={isOpen}
        css={{
          alignItems: 'center',
          background: '#fff',
          border: '1px solid #e2e8f0',
          borderRadius: 8,
          color: '#0f172a',
          cursor: 'pointer',
          display: 'flex',
          gap: 10,
          minHeight: 48,
          padding: '8px 10px',
          textAlign: 'left',
          width: '100%',
          ':hover': { background: '#f8fafc', borderColor: '#cbd5e1' },
        }}
      >
        <span
          css={{
            alignItems: 'center',
            background: '#e0f2fe',
            borderRadius: 8,
            color: '#075985',
            display: 'inline-flex',
            flex: '0 0 auto',
            fontSize: 12,
            fontWeight: 800,
            height: 32,
            justifyContent: 'center',
            width: 32,
          }}
        >
          {initials}
        </span>
        <span css={{ display: 'grid', gap: 2, minWidth: 0 }}>
          <strong css={{ fontSize: 13, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
            {user?.name || authenticatedItem.label}
          </strong>
          <span css={{ color: '#64748b', fontSize: 12 }}>{loading ? 'Carregando' : role}</span>
        </span>
      </button>

      {isOpen && (
        <div
          css={{
            background: '#f8fafc',
            border: '1px solid #e2e8f0',
            borderRadius: 8,
            color: '#334155',
            fontSize: 12,
            marginTop: 8,
            padding: 12,
          }}
        >
          <ProfileLine label="Nome" value={user?.name || authenticatedItem.label} />
          <ProfileLine label="Email" value={user?.email || '-'} />
          <ProfileLine label="Função" value={loading ? 'Carregando' : role} />
          <ProfileLine label="Áreas" value={areas.length ? areas.join(', ') : 'Nenhuma área atribuída'} />
        </div>
      )}
    </div>
  );
}

function HideCreateRelatedForOperator() {
  const { authenticatedItem } = useKeystone();
  const userId = authenticatedItem.state === 'authenticated' ? authenticatedItem.id : undefined;
  const { data } = useQuery(CURRENT_USER, { variables: { id: userId }, skip: !userId });
  const isAdmin = data?.user?.role === 'admin';

  useEffect(() => {
    if (isAdmin) return;

    const hideButtons = () => {
      document.querySelectorAll('button, a, [role="button"]').forEach((node) => {
        const txt = (node.textContent || '').trim().toLowerCase();
        if (txt.includes('criar') && txt.includes('relacionada')) {
          (node as HTMLElement).style.display = 'none';
        }
      });
    };

    hideButtons();
    const observer = new MutationObserver(hideButtons);
    observer.observe(document.body, { childList: true, subtree: true });
    return () => observer.disconnect();
  }, [isAdmin]);

  return null;
}

function ProfileLine({ label, value }: { label: string; value: string }) {
  return (
    <div css={{ display: 'grid', gap: 2, marginBottom: 8 }}>
      <span css={{ color: '#64748b', fontSize: 11, fontWeight: 700 }}>{label}</span>
      <span css={{ lineHeight: 1.35, overflowWrap: 'anywhere' }}>{value}</span>
    </div>
  );
}

function CustomNavigation({ authenticatedItem, lists }: NavigationProps) {
  const userId = authenticatedItem.state === 'authenticated' ? authenticatedItem.id : undefined;
  const { data } = useQuery(CURRENT_USER, { variables: { id: userId }, skip: !userId });
  const isAdmin = data?.user?.role === 'admin';
  const visibleLists = lists.filter((list) => !hiddenFromNavKeys.includes(list.key));
  const listsByKey = new Map(visibleLists.map((list) => [list.key, list]));
  const groupedKeys = new Set(groups.flatMap((group) => group.lists));
  const ungrouped = visibleLists.filter((list) => !groupedKeys.has(list.key));

  return (
    <NavigationShell authenticatedItem={authenticatedItem}>
      <KeystonePortugueseLayer />
      <HideCreateRelatedForOperator />
      <DashboardLink />
      {isAdmin && (
        <NavGroup title="Indicadores de Acesso">
          <IndicadoresAcessoItem />
        </NavGroup>
      )}

      {groups.map((group) => {
        const groupLists = group.lists
          .map((key) => listsByKey.get(key))
          .filter((list): list is NavigationProps['lists'][number] => Boolean(list));
        if (!groupLists.length) return null;
        return (
          <NavGroup key={group.label} title={group.label}>
            {groupLists.map((list) => (
              <ListLink key={list.key} list={list} />
            ))}
          </NavGroup>
        );
      })}

      {ungrouped.length > 0 && (
        <NavGroup title="Outros">
          {ungrouped.map((list) => (
            <ListLink key={list.key} list={list} />
          ))}
        </NavGroup>
      )}
      <Fragment />
    </NavigationShell>
  );
}

export const components = {
  Logo: CustomLogo,
  Navigation: CustomNavigation,
};
