/// <reference types="vite/client" />

/**
 * Hook de autenticação para contexto administrativo.
 * Gerencia estado do usuário logado (admin/operator) no frontend.
 */

import { useState, useEffect, useCallback } from 'react';

export interface AuthUser {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'operator';
  areas?: { id: string; nome: string }[];
}

interface UseAuthReturn {
  user: AuthUser | null;
  isAdmin: boolean;
  isOperator: boolean;
  areaIds: string[];
  areaNames: string[];
  loading: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
}

/**
 * Hook que gerencia a autenticação do usuário no frontend.
 * Tenta restaurar sessão do sessionStorage ao montar.
 *
 * @returns Estado de autenticação e funções de login/logout
 */
export function useAuth(): UseAuthReturn {
  const [user, setUser] = useState<AuthUser | null>(() => {
    try {
      const stored = sessionStorage.getItem('auth_user');
      return stored ? JSON.parse(stored) : null;
    } catch {
      return null;
    }
  });

  const [loading, setLoading] = useState(false);

  // Salva no sessionStorage sempre que o user mudar
  useEffect(() => {
    if (user) {
      sessionStorage.setItem('auth_user', JSON.stringify(user));
    } else {
      sessionStorage.removeItem('auth_user');
    }
  }, [user]);

  const isAdmin = user?.role === 'admin';
  const isOperator = user?.role === 'operator';
  const areaIds: string[] = user?.areas?.map((a) => a.id) ?? [];
  const areaNames: string[] = user?.areas?.map((a) => a.nome) ?? [];

  const login = useCallback(async (email: string, password: string) => {
    setLoading(true);
    try {
      const API_URL = import.meta.env.VITE_API_BASE_URL
        ? `${import.meta.env.VITE_API_BASE_URL.replace(/\/$/, '')}/api/graphql`
        : '/api/graphql';

      const res = await fetch(API_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({
          query: `
            mutation($email: String!, $password: String!) {
              authenticateUserWithPassword(email: $email, password: $password) {
                ... on UserAuthenticationWithPasswordSuccess {
                  sessionToken
                  item {
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
                ... on UserAuthenticationWithPasswordFailure {
                  message
                }
              }
            }
          `,
          variables: { email, password },
        }),
      });

      const data = await res.json();
      const result = data?.data?.authenticateUserWithPassword;

      if (result?.item) {
        const authUser: AuthUser = {
          id: result.item.id,
          name: result.item.name,
          email: result.item.email,
          role: result.item.role,
          areas: result.item.areas,
        };
        setUser(authUser);
      } else {
        throw new Error(result?.message || 'Falha na autenticação');
      }
    } finally {
      setLoading(false);
    }
  }, []);

  const logout = useCallback(() => {
    setUser(null);
    sessionStorage.removeItem('auth_user');
  }, []);

  return {
    user,
    isAdmin,
    isOperator,
    areaIds,
    areaNames,
    loading,
    login,
    logout,
  };
}

export default useAuth;

