import 'dotenv/config';
import Fastify from 'fastify';
import fastifyCookie from '@fastify/cookie';
import fastifyCors from '@fastify/cors';
import fastifyMultipart from '@fastify/multipart';
import { createServerAdapter } from '@whatwg-node/server';
import { createYoga } from 'graphql-yoga';
import { makeExecutableSchema } from '@graphql-tools/schema';
import { typeDefs } from './schema/typeDefs.js';
import { inputTypeDefs } from './schema/inputs.js';
import { queryMutationTypeDefs } from './schema/query.mutation.js';
import { DateTimeScalar, JSONScalar, UploadScalar } from './schema/scalars.js';
import { resolvers } from './resolvers/index.js';
import { createContext } from './context.js';

const PORT = Number(process.env.PORT || 3001);

const schema = makeExecutableSchema({
  typeDefs: [typeDefs, inputTypeDefs, queryMutationTypeDefs],
  resolvers: {
    DateTime: DateTimeScalar,
    JSON: JSONScalar,
    Upload: UploadScalar,
    ...resolvers,
  },
});

function isOriginAllowed(origin?: string): boolean {
  if (!origin) return true;
  // Permite localhost, 127.0.0.1, domínios governamentais validados, hostnames locais e IPs de rede interna
  if (
    origin.startsWith('http://localhost:') ||
    origin.startsWith('https://localhost:') ||
    origin.startsWith('http://127.0.0.1:') ||
    origin.startsWith('https://127.0.0.1:') ||
    /^https?:\/\/([a-zA-Z0-9-]+\.)*pe\.gov\.br(:[0-9]+)?$/.test(origin) ||
    /^https?:\/\/([a-zA-Z0-9-]+\.)*gov\.br(:[0-9]+)?$/.test(origin) ||
    /^https?:\/\/[a-zA-Z0-9_-]+(:\d+)?$/.test(origin) || // Hostnames como http://GGPAE-027:5173
    /^https?:\/\/(\d{1,3}\.){3}\d{1,3}(:\d+)?$/.test(origin) // IPs locais
  ) {
    return true;
  }
  return false;
}

const yoga = createYoga({
  schema,
  context: createContext,
  graphqlEndpoint: '/api/graphql',
  maskedErrors: false,
  cors: (request) => {
    const origin = request.headers.get('origin') || '*';
    return {
      origin: isOriginAllowed(origin) ? (origin || '*') : undefined,
      credentials: true,
      methods: ['GET', 'POST', 'OPTIONS'],
      allowedHeaders: [
        'Content-Type',
        'Authorization',
        'Cookie',
        'apollo-require-preflight',
        'x-apollo-operation-name',
      ],
    };
  },
  // Habilita uploads via multipart
  multipart: true,
});

// Adaptador @whatwg-node/server para Fastify (converte req/res corretamente)
const yogaServer = createServerAdapter(yoga);

const app = Fastify({
  logger: {
    level: process.env.NODE_ENV === 'production' ? 'warn' : 'info',
  },
});

// Cabeçalhos de Segurança HTTP (OWASP)
app.addHook('onSend', async (request, reply) => {
  reply.header('X-Content-Type-Options', 'nosniff');
  reply.header('X-Frame-Options', 'SAMEORIGIN');
  reply.header('Referrer-Policy', 'strict-origin-when-cross-origin');
  reply.header('Permissions-Policy', 'geolocation=(), camera=(), microphone=()');
});

await app.register(fastifyCookie);
await app.register(fastifyCors, {
  origin: (origin, cb) => {
    if (isOriginAllowed(origin)) {
      cb(null, true);
      return;
    }
    cb(null, false);
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: [
    'Content-Type',
    'Authorization',
    'Cookie',
    'apollo-require-preflight',
    'x-apollo-operation-name',
  ],
});
await app.register(fastifyMultipart, { limits: { fileSize: 10 * 1024 * 1024 } });

// IMPORTANTE: Não deixar o Fastify consumir o corpo antes do adapter.
// O adapter (graphql-yoga) precisa ler o stream cru (req.raw).
app.removeAllContentTypeParsers();
app.addContentTypeParser(['application/json', 'multipart/form-data'], function (req, payload, done) {
  done(null, payload);
});

// Serve arquivos de upload estáticos e imagens com proteção contra Path Traversal
app.register(async (fastify) => {
  const { createReadStream, existsSync } = await import('node:fs');
  const { resolve, normalize } = await import('node:path');
  const imagesDir = resolve(process.cwd(), 'public', 'images');
  const filesDir = resolve(process.cwd(), 'public', 'files');

  const getMimeType = (filename: string) => {
    const ext = filename.split('.').pop()?.toLowerCase();
    if (ext === 'jpg' || ext === 'jpeg') return 'image/jpeg';
    if (ext === 'png') return 'image/png';
    if (ext === 'webp') return 'image/webp';
    if (ext === 'svg') return 'image/svg+xml';
    if (ext === 'gif') return 'image/gif';
    if (ext === 'pdf') return 'application/pdf';
    return 'application/octet-stream';
  };

  const FALLBACK_SVG = `<svg xmlns="http://www.w3.org/2000/svg" width="400" height="300" viewBox="0 0 400 300">
    <defs>
      <linearGradient id="peGrad" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" stop-color="#003087"/>
        <stop offset="100%" stop-color="#001845"/>
      </linearGradient>
    </defs>
    <rect width="400" height="300" fill="url(#peGrad)"/>
    <circle cx="200" cy="115" r="45" fill="#ffffff" opacity="0.12"/>
    <path d="M185 130 L200 100 L215 130 Z" fill="#FFCC00"/>
    <circle cx="200" cy="118" r="4" fill="#003087"/>
    <text x="200" y="185" fill="#ffffff" font-family="Montserrat, Arial, sans-serif" font-size="15" font-weight="bold" text-anchor="middle">GOVERNO DE PERNAMBUCO</text>
    <text x="200" y="208" fill="#ffffff" font-family="Montserrat, Arial, sans-serif" font-size="12" opacity="0.85" text-anchor="middle">Secretaria de Administração</text>
    <text x="200" y="232" fill="#FFCC00" font-family="Montserrat, Arial, sans-serif" font-size="11" font-weight="600" opacity="0.9" text-anchor="middle">Portal de Serviços</text>
  </svg>`;

  fastify.get('/images/*', async (req, reply) => {
    const rawFilename = (req.params as any)['*'];
    if (!rawFilename || rawFilename.includes('..')) {
      return reply.code(403).send({ error: 'Acesso negado' });
    }
    const safeFilename = normalize(rawFilename).replace(/^(\.\.[\/\\])+/, '');
    const filePath = resolve(imagesDir, safeFilename);

    if (!filePath.startsWith(imagesDir)) {
      return reply.code(403).send({ error: 'Acesso negado' });
    }

    reply.header('Access-Control-Allow-Origin', '*');
    reply.header('Cache-Control', 'public, max-age=31536000, immutable');
    reply.header('X-Content-Type-Options', 'nosniff');
    if (!existsSync(filePath)) {
      reply.type('image/svg+xml');
      return reply.code(200).send(FALLBACK_SVG);
    }
    reply.type(getMimeType(safeFilename));
    return createReadStream(filePath);
  });

  fastify.get('/files/*', async (req, reply) => {
    const rawFilename = (req.params as any)['*'];
    if (!rawFilename || rawFilename.includes('..')) {
      return reply.code(403).send({ error: 'Acesso negado' });
    }
    const safeFilename = normalize(rawFilename).replace(/^(\.\.[\/\\])+/, '');
    const filePath = resolve(filesDir, safeFilename);

    if (!filePath.startsWith(filesDir)) {
      return reply.code(403).send({ error: 'Acesso negado' });
    }

    if (!existsSync(filePath)) {
      return reply.code(404).send({ error: 'Arquivo não encontrado' });
    }
    reply.header('Access-Control-Allow-Origin', '*');
    reply.header('Cache-Control', 'public, max-age=31536000, immutable');
    reply.header('X-Content-Type-Options', 'nosniff');
    reply.type(getMimeType(safeFilename));
    return createReadStream(filePath);
  });

  // Analytics endpoints
  const handleAnalyticsTrack = async (req: any, reply: any) => {
    reply.header('Access-Control-Allow-Origin', '*');
    reply.header('Access-Control-Allow-Headers', 'Content-Type');
    try {
      let body = req.body;
      if (typeof body === 'string') {
        try { body = JSON.parse(body); } catch {}
      }
      const { type, ts, portal, area } = body || {};
      if (portal || area) {
        const ip = (req.headers['x-forwarded-for'] as string)?.split(',')?.[0]?.trim() || req.socket?.remoteAddress || '';
        await prisma.acesso.create({
          data: {
            portal: portal || 'Portal',
            area: area || portal || 'Geral',
            tipo: type || 'PAGE_VIEW',
            usuario: '',
            ip,
            dataAcesso: ts ? new Date(ts) : new Date(),
          },
        }).catch(() => {});
      }
      return reply.code(200).send({ ok: true });
    } catch (e: any) {
      return reply.code(200).send({ ok: false, error: e?.message });
    }
  };

  fastify.post('/analytics/track', handleAnalyticsTrack);
  fastify.post('/api/analytics/track', handleAnalyticsTrack);
  fastify.options('/analytics/track', async (req, reply) => {
    reply.header('Access-Control-Allow-Origin', '*');
    reply.header('Access-Control-Allow-Headers', 'Content-Type');
    return reply.code(204).send();
  });
});

// Middleware do graphql-yoga no Fastify.
// Configuramos um content-type parser para que o corpo não seja consumido
// pelo parser padrão do Fastify; o adapter lê o stream cru.
app.all('/api/graphql', async (req: any, reply: any) => {
  try {
    const response = await yogaServer.handleNodeRequest(req.raw, {
      req,
      reply,
    } as any);
    reply.raw.statusCode = response.status;
    for (const [key, value] of response.headers.entries()) {
      reply.raw.setHeader(key, value);
    }

    // Injeta cabeçalhos de segurança OWASP
    reply.raw.setHeader('X-Content-Type-Options', 'nosniff');
    reply.raw.setHeader('X-Frame-Options', 'SAMEORIGIN');
    reply.raw.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
    reply.raw.setHeader('Permissions-Policy', 'geolocation=(), camera=(), microphone=()');

    // Copia headers e cookies definidos no Fastify reply (ex: setSessionCookie)
    if (typeof reply.getHeaders === 'function') {
      const fastifyHeaders = reply.getHeaders();
      for (const [key, value] of Object.entries(fastifyHeaders)) {
        if (value !== undefined) {
          reply.raw.setHeader(key, value);
        }
      }
    }
    
    // Assegura cabeçalho CORS caso não tenha sido definido
    const reqOrigin = req.headers.origin;
    if (reqOrigin && !reply.raw.getHeader('access-control-allow-origin')) {
      reply.raw.setHeader('Access-Control-Allow-Origin', reqOrigin);
      reply.raw.setHeader('Access-Control-Allow-Credentials', 'true');
      reply.raw.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, Cookie, apollo-require-preflight, x-apollo-operation-name');
      reply.raw.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    }

    const contentType = response.headers.get('content-type') || '';
    if (contentType.includes('multipart')) {
      const reader = response.body?.getReader();
      if (reader) {
        const { value: chunk } = await reader.read();
        if (chunk) reply.raw.write(chunk);
      }
      reply.raw.end();
    } else {
      const text = await response.text();
      reply.raw.end(text);
    }
  } catch (err: any) {
    app.log.error(err);
    if (!reply.raw.writableEnded) {
      const reqOrigin = req.headers.origin;
      if (reqOrigin) {
        reply.raw.setHeader('Access-Control-Allow-Origin', reqOrigin);
        reply.raw.setHeader('Access-Control-Allow-Credentials', 'true');
      }
      reply.raw.statusCode = 500;
      reply.raw.end(JSON.stringify({ error: err?.message || 'Internal Server Error' }));
    }
  }
});

// Health check
app.get('/health', async () => {
  return { status: 'ok', service: 'backend-customizado' };
});

app.listen({ port: PORT, host: '0.0.0.0' }, (err) => {
  if (err) {
    app.log.error(err);
    process.exit(1);
  }
  app.log.info(`Backend customizado rodando em http://localhost:${PORT}/api/graphql`);
});
