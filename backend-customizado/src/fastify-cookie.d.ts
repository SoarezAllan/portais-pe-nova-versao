import '@fastify/cookie';

declare module 'fastify' {
  interface FastifyReply {
    setCookie(
      name: string,
      value: string,
      options?: {
        httpOnly?: boolean;
        secure?: boolean;
        sameSite?: boolean | 'lax' | 'strict' | 'none';
        path?: string;
        maxAge?: number;
        expires?: Date;
        domain?: string;
      }
    ): FastifyReply;
    clearCookie(name: string, options?: { path?: string }): FastifyReply;
  }

  interface FastifyRequest {
    cookies?: Record<string, string>;
  }
}
