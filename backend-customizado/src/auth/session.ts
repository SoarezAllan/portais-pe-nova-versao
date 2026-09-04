import jwt from 'jsonwebtoken';
import type { FastifyRequest, FastifyReply } from 'fastify';

export const SESSION_COOKIE = 'keystonejs-session';

const SESSION_SECRET =
  process.env.SESSION_SECRET || 'uma-chave-secreta-muito-longa-e-segura';
const SESSION_MAX_AGE = Number(process.env.SESSION_MAX_AGE || 60 * 60 * 24 * 30); // 30 dias (segundos)

export interface SessionData {
  /** id do usuário autenticado */
  id: string;
  /** dados do usuário usados no controle de acesso */
  data: {
    id: string;
    name: string;
    email: string;
    role: string;
    areas: { id: string; nome: string }[];
  };
  /** expiração em ms (para compatibilidade) */
  exp: number;
}

/**
 * Cria um token JWT assinado que será armazenado em cookie HTTP-only.
 * O formato do payload imita o token stateless do Keystone (sessionData).
 */
export function createSessionToken(user: {
  id: string;
  name: string;
  email: string;
  role: string;
  areas: { id: string; nome: string }[];
}): string {
  const payload = {
    id: user.id,
    data: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role || 'operator',
      areas: user.areas || [],
    },
  };
  return jwt.sign(payload, SESSION_SECRET, { expiresIn: SESSION_MAX_AGE });
}

/** Decodifica e valida o token. Retorna null se inválido/expirado. */
export function decodeSessionToken(token: string): SessionData | null {
  try {
    const decoded = jwt.verify(token, SESSION_SECRET) as SessionData;
    return decoded;
  } catch {
    return null;
  }
}

/** Define o cookie de sessão HTTP-only na resposta. */
export function setSessionCookie(reply: any, token: string) {
  try {
    const isProd = process.env.NODE_ENV === 'production';
    const cookieStr = `${SESSION_COOKIE}=${token}; Path=/; Max-Age=${SESSION_MAX_AGE}; HttpOnly; SameSite=Lax${isProd ? '; Secure' : ''}`;

    if (typeof reply?.setCookie === 'function') {
      reply.setCookie(SESSION_COOKIE, token, {
        httpOnly: true,
        secure: isProd,
        sameSite: 'lax',
        path: '/',
        maxAge: SESSION_MAX_AGE,
      });
    }
    if (reply?.raw?.setHeader) {
      reply.raw.setHeader('Set-Cookie', cookieStr);
    } else if (reply?.headers?.append) {
      reply.headers.append('Set-Cookie', cookieStr);
    }
  } catch (err) {
    // Ignore cookie write errors if reply object does not support it
  }
}

/** Limpa o cookie de sessão (logout). */
export function clearSessionCookie(reply: any) {
  try {
    const cookieStr = `${SESSION_COOKIE}=; Path=/; Max-Age=0; HttpOnly; SameSite=Lax`;
    if (typeof reply?.clearCookie === 'function') {
      reply.clearCookie(SESSION_COOKIE, { path: '/' });
    }
    if (reply?.raw?.setHeader) {
      reply.raw.setHeader('Set-Cookie', cookieStr);
    } else if (reply?.headers?.append) {
      reply.headers.append('Set-Cookie', cookieStr);
    }
  } catch (err) {
    // Ignore
  }
}

/** Extrai o token do cookie da requisição. */
export function getSessionToken(req: FastifyRequest): string | null {
  const cookie = req.cookies?.[SESSION_COOKIE];
  if (cookie) return cookie;

  const rawCookie = (req as any).headers?.cookie || (req as any).raw?.headers?.cookie;
  if (rawCookie) {
    const match = rawCookie.match(new RegExp(`(?:^|; )${SESSION_COOKIE}=([^;]*)`));
    if (match) return decodeURIComponent(match[1]);
  }
  return null;
}
