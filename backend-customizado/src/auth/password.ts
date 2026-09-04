import bcrypt from 'bcryptjs';

/**
 * Hash de senha compatível com o Keystone (bcrypt).
 * Keystone usa bcrypt com prefixo $2a$/$2b$; bcryptjs gera $2a$,
 * então é totalmente compatível com senhas já existentes no banco.
 */
export async function hashPassword(plain: string): Promise<string> {
  const salt = await bcrypt.genSalt(10);
  return bcrypt.hash(plain, salt);
}

/**
 * Verifica uma senha em texto puro contra o hash armazenado.
 * Aceita hashes $2a$/$2b$/$2y$ gerados pelo Keystone.
 */
export async function verifyPassword(plain: string, hashed: string): Promise<boolean> {
  if (!hashed) return false;
  try {
    return await bcrypt.compare(plain, hashed);
} catch {
    return false;
  }
}
