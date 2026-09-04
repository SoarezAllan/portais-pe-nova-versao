import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { graphqlRequest } from '@/lib/api';
import type { User } from '@/types';

interface AuthContextType {
  user: User | null;
  loading: boolean;
  isAdmin: boolean;
  areaIds: string[];
  login: (email: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  checkSession: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | null>(null);

const AUTHENTICATED_ITEM_QUERY = `
  query {
    authenticatedItem {
      ... on User {
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
  }
`;

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const isAdmin = user?.role === 'admin';
  const areaIds = user?.areas?.map((a) => a.id) ?? [];

  const checkSession = useCallback(async () => {
    try {
      const result = await graphqlRequest<{ authenticatedItem: User | null }>(AUTHENTICATED_ITEM_QUERY);
      if (result.authenticatedItem) {
        setUser(result.authenticatedItem);
      } else {
        setUser(null);
      }
    } catch {
      setUser(null);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    checkSession();
  }, [checkSession]);

  const login = useCallback(async (email: string, password: string) => {
    const LOGIN_MUTATION = `
      mutation ($email: String!, $password: String!) {
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
    `;

    const result = await graphqlRequest<{ authenticateUserWithPassword: any }>(LOGIN_MUTATION, { email, password });

    if (result.authenticateUserWithPassword.message) {
      throw new Error(result.authenticateUserWithPassword.message);
    }

    const { sessionToken, item } = result.authenticateUserWithPassword;
    if (sessionToken && typeof window !== 'undefined') {
      localStorage.setItem('keystone_token', sessionToken);
    }

    setUser(item);
    navigate('/dashboard');
  }, [navigate]);

  const logout = useCallback(async () => {
    try {
      await graphqlRequest(`mutation { endSession }`);
    } catch {
      // ignore
    } finally {
      if (typeof window !== 'undefined') {
        localStorage.removeItem('keystone_token');
      }
      setUser(null);
      navigate('/login');
    }
  }, [navigate]);

  return (
    <AuthContext.Provider value={{ user, loading, isAdmin, areaIds, login, logout, checkSession }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}
