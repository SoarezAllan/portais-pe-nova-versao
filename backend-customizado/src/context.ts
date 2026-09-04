import type { FastifyReply, FastifyRequest } from 'fastify';
import { prisma } from './prisma.js';
import { decodeSessionToken, getSessionToken, SESSION_COOKIE, type SessionData } from './auth/session.js';

export interface Context {
  req?: FastifyRequest;
  reply?: FastifyReply;
  prisma: typeof prisma;
  session: SessionData | null;
  isAdmin: boolean;
  isOperator: boolean;
  areaIds: string[];
}

export function extractToken(initialContext: any): string | null {
  // 1. Authorization ou Cookie do objeto Request padrão (graphql-yoga)
  const webReq = initialContext?.request;
  if (webReq?.headers) {
    const auth = typeof webReq.headers.get === 'function' ? webReq.headers.get('authorization') : webReq.headers['authorization'];
    if (auth?.startsWith('Bearer ')) return auth.slice(7).trim();

    const cookie = typeof webReq.headers.get === 'function' ? webReq.headers.get('cookie') : webReq.headers['cookie'];
    if (cookie) {
      const match = cookie.match(new RegExp(`(?:^|; )${SESSION_COOKIE}=([^;]*)`));
      if (match) return decodeURIComponent(match[1]);
    }
  }

  // 2. Fastify req / raw req
  const req = initialContext?.req || initialContext?.raw?.req;
  if (req) {
    const auth = req.headers?.authorization || req.raw?.headers?.authorization;
    if (auth?.startsWith('Bearer ')) return auth.slice(7).trim();

    const cookie = req.cookies?.[SESSION_COOKIE];
    if (cookie) return cookie;

    const rawCookie = req.headers?.cookie || req.raw?.headers?.cookie;
    if (rawCookie) {
      const match = rawCookie.match(new RegExp(`(?:^|; )${SESSION_COOKIE}=([^;]*)`));
      if (match) return decodeURIComponent(match[1]);
    }
  }

  return null;
}

/**
 * Cria o contexto GraphQL. A sessão é extraída do cookie HTTP-only JWT ou header Authorization.
 * Recebe o initialContext do graphql-yoga.
 * Sem token válido => session = null (acesso não autenticado).
 */
export async function createContext(initialContext: any): Promise<Context> {
  const req: FastifyRequest | undefined = initialContext?.req;
  const reply: FastifyReply | undefined = initialContext?.reply;
  const token = extractToken(initialContext);
  const session = token ? decodeSessionToken(token) : null;

  return {
    req,
    reply,
    prisma,
    session,
    isAdmin: session?.data?.role === 'admin',
    isOperator: session?.data?.role === 'operator',
    areaIds: session?.data?.areas?.map((a) => a?.id).filter(Boolean) ?? [],
  };
}
