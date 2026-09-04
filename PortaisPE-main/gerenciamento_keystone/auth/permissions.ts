// auth/permissions.ts

export function isAdmin(session: any) {
  return session?.data?.role === 'admin';
}

export function isGlobalManager(session: any) {
  return session?.data?.role === 'global_manager';
}

export function isSetorialManager(session: any) {
  return session?.data?.role === 'setorial_manager';
}

export function isGerenciador(session: any) {
  return session?.data?.role === 'operator';
}

// Permissão para gerenciar usuários
export function canManageUsers(session: any) {
  return isAdmin(session);
}

// ----- PERMISSÕES ESPECÍFICAS PARA NOTICIA -----

export function canReadNoticias(session: any) {
  return isAdmin(session) || isGlobalManager(session) || isSetorialManager(session);
}

export function canCreateNoticias(session: any) {
  return isAdmin(session) || isGlobalManager(session) || isSetorialManager(session) || isGerenciador(session);
}

export function canUpdateAllNoticias(session: any) {
  return isAdmin(session) || isGlobalManager(session);
}

export function canUpdateOwnNoticias(session: any) {
  return isSetorialManager(session) || isGerenciador(session);
}
