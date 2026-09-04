import { getListConfig, getDelegate } from '../config/lists.js';
import { convertInputData } from './input.js';
import { buildDeleteFilter, canAccessList, canCreateUpdate, canDelete } from '../auth/permissions.js';
import { prisma } from '../prisma.js';
import { hashPassword, verifyPassword } from '../auth/password.js';
import { createSessionToken, setSessionCookie, clearSessionCookie } from '../auth/session.js';
import { queryCache } from '../cache.js';
import type { Context } from '../context.js';
import type { ListConfig } from '../config/lists.js';

/**
 * Retorna o sufixo EXATO da mutation plural conforme o schema GraphQL.
 * A maioria usa o plural em minúsculas (ex.: createservicos), mas algumas
 * (ex.: Tag) usam forma capitalizada (createTags). Montamos o mapa manualmente
 * para garantir compatibilidade com o schema.
 */
const PLURAL_MUTATION_SUFFIX: Record<string, string> = {
  user: 'users',
  auditLog: 'auditLogs',
  servico: 'servicos',
  solucao: 'solucoes',
  noticia: 'noticias',
  legislacao: 'legislacoes',
  curso: 'cursos',
  tag: 'Tags',
  areaResponsavel: 'areas',
  gerencia: 'gerencias',
  setor: 'setores',
  subarea: 'subareas',
  gestores: 'gestores',
  paginaQuemSomos: 'paginasQuemSomos',
  quemSomosMuralItem: 'quemSomosMuralItens',
  quemSomosTimeItem: 'quemSomosTimeItens',
  quemSomosSubareaItem: 'quemSomosSubareaItens',
  portfolio: 'portfolios',
  portfolioImagem: 'portfolioImagens',
  acesso: 'acessos',
};

function pluralMutationSuffix(cfg: ListConfig): string {
  return PLURAL_MUTATION_SUFFIX[cfg.prisma] ?? cfg.list;
}

/**
 * Gera os resolvers de Mutation genéricos (create/update/delete) para todas as listas.
 */
export function buildMutationResolvers() {
  const listKeys = [
    'user', 'auditLog', 'servico', 'solucao', 'noticia', 'legislacao', 'curso',
    'tag', 'areaResponsavel', 'gerencia', 'setor', 'subarea', 'gestores',
    'paginaQuemSomos', 'quemSomosMuralItem', 'quemSomosTimeItem',
    'quemSomosSubareaItem', 'portfolio', 'portfolioImagem', 'acesso',
  ];

  const resolvers: Record<string, any> = {};

  for (const key of listKeys) {
    const cfg = getListConfig(key)!;
    const delegate = getDelegate(cfg.prisma);
    const typeName = cfg.type;

function slugify(text: string): string {
  if (!text) return '';
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

    // create<T>(data): T
    resolvers[`create${typeName}`] = async (parent: any, args: any, ctx: Context) => {
      if (!canCreateUpdate(typeName, ctx.session)) {
        throw new Error('Acesso negado');
      }
      const data = convertInputData(args.data, cfg);
      if (typeName === 'User' && data.password) {
        data.password = await hashPassword(data.password);
      }
      if (data.titulo && !data.slug && ['Servico', 'Solucao', 'Noticia', 'Portfolio'].includes(typeName)) {
        data.slug = slugify(data.titulo);
      }
      if (data.titulo && data.imagemAlt === undefined && ['Servico', 'Solucao', 'Portfolio'].includes(typeName)) {
        data.imagemAlt = data.titulo;
      }
      if (data.titulo && data.imagemPrincipalAlt === undefined && typeName === 'Noticia') {
        data.imagemPrincipalAlt = data.titulo;
      }
      if (typeName === 'Solucao' && !data.categoria) {
        data.categoria = 'Geral';
      }
      // Autor/otimista
      const listsWithCreatedTracking = [
        'Servico', 'Solucao', 'Noticia', 'Legislacao', 'Curso', 'Tag',
        'AreaResponsavel', 'Gerencia', 'Setor', 'Subarea', 'Portfolio', 'PortfolioImagem', 'PaginaQuemSomos'
      ];
      if (ctx.session?.data?.id && listsWithCreatedTracking.includes(typeName)) {
        data.createdBy = ctx.session.data.name || ctx.session.data.email;
      }
      if (typeName === 'PaginaQuemSomos') {
        if (data.time?.create && Array.isArray(data.time.create)) {
          data.time.create = data.time.create.map((t: any) => {
            const item: any = {
              nome: t.nome || '',
              cargo: t.cargo || '',
              descricao: t.descricao || '',
              ativo: t.ativo !== undefined ? t.ativo : true,
            };
            if (t.foto) {
              if (typeof t.foto === 'object') {
                item.foto_id = t.foto.id || t.foto.upload || null;
                item.foto_extension = t.foto.extension || t.foto._extension || 'png';
                item.foto_filesize = t.foto.filesize || t.foto._filesize || 0;
                item.foto_width = t.foto.width || t.foto._width || 0;
                item.foto_height = t.foto.height || t.foto._height || 0;
              } else if (typeof t.foto === 'string') {
                item.foto_id = t.foto;
              }
            } else if (t.foto === null) {
              item.foto_id = null;
            }
            return item;
          });
        }
      }
      const created = await delegate.create({ data });
      queryCache.invalidate(typeName);
      return created;
    };

    // createMany: create<plural> (data: [T]): [T]
    // O schema usa a forma plural EXATA (ex.: createTags, createservicos).
    resolvers[`create${pluralMutationSuffix(cfg)}`] = async (
      parent: any,
      args: any,
      ctx: Context
    ) => {
      if (!canCreateUpdate(typeName, ctx.session)) throw new Error('Acesso negado');
      const items = await Promise.all(
        args.data.map(async (d: any) => {
          const data = convertInputData(d, cfg);
          if (typeName === 'User' && data.password) {
            data.password = await hashPassword(data.password);
          }
          if (data.titulo && !data.slug && ['Servico', 'Solucao', 'Noticia', 'Portfolio'].includes(typeName)) {
            data.slug = slugify(data.titulo);
          }
          if (data.titulo && data.imagemAlt === undefined && ['Servico', 'Solucao', 'Portfolio'].includes(typeName)) {
            data.imagemAlt = data.titulo;
          }
          if (data.titulo && data.imagemPrincipalAlt === undefined && typeName === 'Noticia') {
            data.imagemPrincipalAlt = data.titulo;
          }
          return data;
        })
      );
      const created = await Promise.all(items.map((d: any) => delegate.create({ data: d })));
      queryCache.invalidate(typeName);
      return created;
    };

    // update<T>(where, data): T
    resolvers[`update${typeName}`] = async (parent: any, args: any, ctx: Context) => {
      if (!canCreateUpdate(typeName, ctx.session)) throw new Error('Acesso negado');
      const data = convertInputData(args.data, cfg);
      if (typeName === 'User') {
        if (data.password) {
          data.password = await hashPassword(data.password);
        } else {
          delete data.password;
        }
      }
      if (data.titulo && !data.slug && ['Servico', 'Solucao', 'Noticia', 'Portfolio'].includes(typeName)) {
        data.slug = slugify(data.titulo);
      }
      if (data.titulo && data.imagemAlt === undefined && ['Servico', 'Solucao', 'Portfolio'].includes(typeName)) {
        data.imagemAlt = data.titulo;
      }
      if (data.titulo && data.imagemPrincipalAlt === undefined && typeName === 'Noticia') {
        data.imagemPrincipalAlt = data.titulo;
      }
      const listsWithUpdatedTracking = [
        'Servico', 'Solucao', 'Noticia', 'Legislacao', 'Curso', 'Tag',
        'AreaResponsavel', 'Gerencia', 'Setor', 'Subarea', 'Portfolio', 'PortfolioImagem'
      ];
      if (ctx.session?.data?.id && listsWithUpdatedTracking.includes(typeName)) {
        data.updatedBy = ctx.session.data.name || ctx.session.data.email;
        data.updatedAt = new Date();
      }

      if (typeName === 'PaginaQuemSomos') {
        if (args.data.muralItens !== undefined) {
          await ctx.prisma.quemSomosMuralItem.deleteMany({ where: { paginaId: args.where.id } });
        }
        if (args.data.time !== undefined) {
          await ctx.prisma.quemSomosTimeItem.deleteMany({ where: { paginaId: args.where.id } });
        }
        if (args.data.conteudosPorSubarea !== undefined) {
          await ctx.prisma.quemSomosSubareaItem.deleteMany({ where: { paginaId: args.where.id } });
        }
        if (data.time?.create && Array.isArray(data.time.create)) {
          data.time.create = data.time.create.map((t: any) => {
            const item: any = {
              nome: t.nome || '',
              cargo: t.cargo || '',
              descricao: t.descricao || '',
              ativo: t.ativo !== undefined ? t.ativo : true,
            };
            if (t.foto) {
              if (typeof t.foto === 'object') {
                item.foto_id = t.foto.id || t.foto.upload || null;
                item.foto_extension = t.foto.extension || t.foto._extension || 'png';
                item.foto_filesize = t.foto.filesize || t.foto._filesize || 0;
                item.foto_width = t.foto.width || t.foto._width || 0;
                item.foto_height = t.foto.height || t.foto._height || 0;
              } else if (typeof t.foto === 'string') {
                item.foto_id = t.foto;
              }
            } else if (t.foto === null) {
              item.foto_id = null;
            }
            return item;
          });
        }
      }

      const updated = await delegate.update({ where: { id: args.where.id }, data });
      queryCache.invalidate(typeName);
      return updated;
    };

    // updateMany: update<plural> (data: [UpdateArgs!]): [T]
    resolvers[`update${pluralMutationSuffix(cfg)}`] = async (
      parent: any,
      args: any,
      ctx: Context
    ) => {
      if (!canCreateUpdate(typeName, ctx.session)) throw new Error('Acesso negado');
      const updated = await Promise.all(
        args.data.map((d: any) =>
          delegate.update({
            where: { id: d.where.id },
            data: convertInputData(d.data, cfg),
          })
        )
      );
      queryCache.invalidate(typeName);
      return updated;
    };

    // delete<T>(where): T
    resolvers[`delete${typeName}`] = async (parent: any, args: any, ctx: Context) => {
      if (!canDelete(typeName, ctx.session)) throw new Error('Acesso negado');
      const filter = buildDeleteFilter(typeName, ctx.session);
      if (filter !== true) {
        const existing = await delegate.findUnique({ where: { id: args.where.id } });
        if (!existing) return null;
        // Valida se o item pertence à área do operador
        const allowed = await delegate.count({ where: { id: args.where.id, ...filter } });
        if (!allowed) throw new Error('Acesso negado');
      }
      const deleted = await delegate.delete({ where: { id: args.where.id } });
      queryCache.invalidate(typeName);
      return deleted;
    };

    // deleteMany: delete<plural> (where: [WhereUniqueInput!]!): [T]
    resolvers[`delete${pluralMutationSuffix(cfg)}`] = async (
      parent: any,
      args: any,
      ctx: Context
    ) => {
      if (!canDelete(typeName, ctx.session)) throw new Error('Acesso negado');
      const ids = args.where?.map((w: any) => w.id) || [];
      const deleted = await Promise.all(ids.map((id: string) => delegate.delete({ where: { id } })));
      queryCache.invalidate(typeName);
      return deleted;
    };
  }

  return resolvers;
}

// Controle de tentativas de login (proteção contra força bruta em memória)
interface LoginAttempt {
  count: number;
  firstAttempt: number;
  lockedUntil: number;
}
const loginAttempts = new Map<string, LoginAttempt>();
const MAX_FAILED_ATTEMPTS = 5;
const LOCKOUT_MS = 15 * 60 * 1000; // 15 minutos
const WINDOW_MS = 15 * 60 * 1000;

function cleanupOldLoginAttempts() {
  const now = Date.now();
  for (const [key, val] of loginAttempts.entries()) {
    if (val.lockedUntil < now && now - val.firstAttempt > WINDOW_MS) {
      loginAttempts.delete(key);
    }
  }
}
setInterval(cleanupOldLoginAttempts, 5 * 60 * 1000).unref();

/**
 * Resolvers de autenticação (authenticateUserWithPassword, endSession, authenticatedItem, etc.)
 */
export function buildAuthResolvers() {
  return {
    authenticateUserWithPassword: async (parent: any, args: any, ctx: Context) => {
      try {
        const { email, password } = args;
        const normalizedEmail = (email || '').toLowerCase().trim();
        const clientIp =
          (ctx.req?.headers?.['x-forwarded-for'] as string)?.split(',')?.[0]?.trim() ||
          ctx.req?.socket?.remoteAddress ||
          'local';
        const clientKey = `${clientIp}::${normalizedEmail}`;

        const now = Date.now();
        const attempt = loginAttempts.get(clientKey);
        if (attempt && attempt.lockedUntil > now) {
          const remainingMinutes = Math.ceil((attempt.lockedUntil - now) / 60000);
          return {
            __typename: 'UserAuthenticationWithPasswordFailure',
            message: `Muitas tentativas incorretas. Conta bloqueada temporariamente. Tente novamente em ${remainingMinutes} minuto(s).`,
          };
        }

        const user = await prisma.user.findUnique({ where: { email: normalizedEmail } });
        if (!user) {
          // Registra tentativa falha
          const cur = loginAttempts.get(clientKey) || { count: 0, firstAttempt: now, lockedUntil: 0 };
          if (now - cur.firstAttempt > WINDOW_MS) {
            cur.count = 1;
            cur.firstAttempt = now;
          } else {
            cur.count += 1;
          }
          if (cur.count >= MAX_FAILED_ATTEMPTS) {
            cur.lockedUntil = now + LOCKOUT_MS;
          }
          loginAttempts.set(clientKey, cur);
          return { __typename: 'UserAuthenticationWithPasswordFailure', message: 'Credenciais inválidas' };
        }

        const valid = await verifyPassword(password, user.password);
        if (!valid) {
          // Registra tentativa falha
          const cur = loginAttempts.get(clientKey) || { count: 0, firstAttempt: now, lockedUntil: 0 };
          if (now - cur.firstAttempt > WINDOW_MS) {
            cur.count = 1;
            cur.firstAttempt = now;
          } else {
            cur.count += 1;
          }
          if (cur.count >= MAX_FAILED_ATTEMPTS) {
            cur.lockedUntil = now + LOCKOUT_MS;
          }
          loginAttempts.set(clientKey, cur);
          return { __typename: 'UserAuthenticationWithPasswordFailure', message: 'Credenciais inválidas' };
        }

        // Login bem-sucedido: limpa contador de tentativas
        loginAttempts.delete(clientKey);

        const areas = await prisma.areaResponsavel.findMany({
          where: { from_User_areas: { some: { id: user.id } } },
        });

        const token = createSessionToken({
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role || 'operator',
          areas: areas.map((a) => ({ id: a.id, nome: a.nome })),
        });

        if (ctx.reply) setSessionCookie(ctx.reply, token);

        return {
          __typename: 'UserAuthenticationWithPasswordSuccess',
          sessionToken: token,
          item: { ...user, areas },
        };
      } catch (err: any) {
        console.error('AUTHENTICATE ERROR:', err);
        throw err;
      }
    },

    endSession: async (parent: any, args: any, ctx: Context) => {
      if (ctx.reply) clearSessionCookie(ctx.reply);
      return true;
    },

    sendUserPasswordResetLink: async () => {
      // TODO: implementar envio de e-mail
      return true;
    },

    redeemUserPasswordResetToken: async (parent: any, args: any, ctx: Context) => {
      const { email, token, password } = args;
      const user = await prisma.user.findUnique({ where: { email: (email || '').toLowerCase().trim() } });
      if (!user || user.passwordResetToken !== token) {
        return { code: 'FAILURE', message: 'Token inválido' };
      }
      if (user.passwordResetRedeemedAt) {
        return { code: 'TOKEN_REDEEMED', message: 'Token já utilizado' };
      }
      const hashed = await hashPassword(password);
      await prisma.user.update({
        where: { id: user.id },
        data: {
          password: hashed,
          passwordResetToken: null,
          passwordResetRedeemedAt: new Date(),
        },
      });
      return { code: 'TOKEN_REDEEMED', message: 'Senha redefinida com sucesso' };
    },

    forgotPassword: async (parent: any, args: any) => {
      // TODO: gerar token e enviar e-mail
      return true;
    },

    resetPassword: async (parent: any, args: any) => {
      const { email, tempPassword, newPassword } = args;
      const user = await prisma.user.findUnique({ where: { email: (email || '').toLowerCase().trim() } });
      if (!user) return false;
      const ok = await verifyPassword(tempPassword, user.password);
      if (!ok) return false;
      const hashed = await hashPassword(newPassword);
      await prisma.user.update({ where: { id: user.id }, data: { password: hashed } });
      return true;
    },
  };
}

const ALLOWED_IMAGE_EXTENSIONS = new Set(['jpg', 'jpeg', 'png', 'webp', 'gif', 'svg', 'bmp', 'ico']);
const MAX_IMAGE_SIZE_BYTES = 10 * 1024 * 1024; // 10MB

/**
 * Resolver de uploadImage — valida tipos, autenticação e grava a imagem em disco.
 */
export function buildUploadResolver() {
  return {
    uploadImage: async (parent: any, args: any, ctx: Context) => {
      // 1. Exige autenticação
      if (!ctx.session) {
        throw new Error('Acesso negado: autenticação necessária para envio de imagens');
      }

      const { file } = args;
      if (!file) throw new Error('Nenhum arquivo enviado');

      const nodeFs = await import('node:fs');
      const nodePath = await import('node:path');

      const imagesDir = nodePath.default.resolve(process.cwd(), 'public', 'images');
      nodeFs.mkdirSync(imagesDir, { recursive: true });

      let filename = 'image.png';
      let buffer: Buffer;
      let mimetype = 'image/png';

      // 2. Extrai buffer conforme tipo de objeto recebido
      if (file && typeof file.arrayBuffer === 'function') {
        const ab = await file.arrayBuffer();
        buffer = Buffer.from(ab);
        filename = file.name || 'image.png';
        mimetype = file.type || 'image/png';
      } else if (file && file.then) {
        const resolved = await file;
        filename = resolved.filename || resolved.name || 'image.png';
        mimetype = resolved.mimetype || resolved.type || 'image/png';
        if (typeof resolved.arrayBuffer === 'function') {
          buffer = Buffer.from(await resolved.arrayBuffer());
        } else if (typeof resolved.createReadStream === 'function') {
          const stream = resolved.createReadStream();
          const chunks: Buffer[] = [];
          for await (const chunk of stream) {
            chunks.push(typeof chunk === 'string' ? Buffer.from(chunk) : chunk);
          }
          buffer = Buffer.concat(chunks);
        } else {
          throw new Error('Formato de stream não suportado');
        }
      } else if (file && typeof file.createReadStream === 'function') {
        const stream = file.createReadStream();
        const chunks: Buffer[] = [];
        for await (const chunk of stream) {
          chunks.push(typeof chunk === 'string' ? Buffer.from(chunk) : chunk);
        }
        buffer = Buffer.concat(chunks);
        filename = file.filename || 'image.png';
        mimetype = file.mimetype || 'image/png';
      } else {
        throw new Error('Objeto de arquivo não reconhecido');
      }

      // 3. Validação de tamanho
      if (buffer.length > MAX_IMAGE_SIZE_BYTES) {
        throw new Error('O arquivo excede o limite máximo permitido de 10MB');
      }

      // 4. Validação de extensão (whitelist estrita)
      const ext = (filename.split('.').pop() || mimetype.split('/')[1] || '').toLowerCase();
      if (!ALLOWED_IMAGE_EXTENSIONS.has(ext)) {
        throw new Error(`Extensão de arquivo não permitida (.${ext}). Apenas imagens (${Array.from(ALLOWED_IMAGE_EXTENSIONS).join(', ')}) são aceitas.`);
      }

      // 5. Gera ID seguro e grava em disco
      const id = `${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 10)}`;
      const finalFileName = `${id}.${ext}`;
      const filePath = nodePath.default.join(imagesDir, finalFileName);

      nodeFs.writeFileSync(filePath, buffer);

      return {
        id,
        filesize: buffer.length,
        width: 0,
        height: 0,
        extension: ext,
        url: `/images/${finalFileName}`,
      };
    },
  };
}
