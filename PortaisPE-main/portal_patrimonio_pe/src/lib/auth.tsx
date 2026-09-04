/// <reference types="vite/client" />

import React, { createContext, useContext, useEffect, useState, useCallback, type ReactNode } from 'react';
import { useNavigate } from 'react-router-dom';

export interface AuthUser {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'operator';
  areas?: { id: string; nome: string }[];
}

interface AuthContextType {
  user: AuthUser | null;
  isAdmin: boolean;
  isOperator: boolean;
  areaIds: string[];
  areaNames: string[];
  loading: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  checkSession: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | null>(null);

const AUTH_STORAGE_KEY = 'auth_user';

/**
 * Provider de autenticação que gerencia sessão do usuário no frontend.
 * Usa sessionStorage para persistir dados entre reloads.
 */
export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(() => {
    try {
      const stored = sessionStorage.getItem(AUTH_STORAGE_KEY);
      return stored ? JSON.parse(stored) : null;
    } catch {
      return null;
    }
  });

  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (user) {
      sessionStorage.setItem(AUTH_STORAGE_KEY, JSON.stringify(user));
    } else {
      sessionStorage.removeItem(AUTH_STORAGE_KEY);
    }
  }, [user]);

  const isAdmin = user?.role === 'admin';
  const isOperator = user?.role === 'operator';
  const areaIds: string[] = user?.areas?.map((a) => a.id) ?? [];
  const areaNames: string[] = user?.areas?.map((a) => a.nome) ?? [];

  const checkSession = useCallback(async () => {
    const stored = sessionStorage.getItem(AUTH_STORAGE_KEY);
    if (!stored) {
      setUser(null);
      return;
    }
    try {
      setUser(JSON.parse(stored));
    } catch {
      setUser(null);
    }
  }, []);

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
    sessionStorage.removeItem(AUTH_STORAGE_KEY);
  }, []);

  return (
    <AuthContext.Provider
      value={{
        user,
        isAdmin,
        isOperator,
        areaIds,
        areaNames,
        loading,
        login,
        logout,
        checkSession,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

/**
 * Hook para acessar o contexto de autenticação.
 */
export function useAuth(): AuthContextType {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth deve ser usado dentro de um AuthProvider');
  }
  return context;
}

/**
 * Componente de rota protegida. Redireciona para /login se não autenticado.
 */
export function PrivateRoute({ children }: { children: ReactNode }) {
  const { user } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    if (!user) {
      navigate('/gerenciador-login', { replace: true });
    }
  }, [user, navigate]);

  if (!user) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-gray-500 text-lg">Redirecionando...</div>
      </div>
    );
  }

  return <>{children}</>;
}

export default AuthProvider;

