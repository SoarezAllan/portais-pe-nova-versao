/**
 * Cache em memória ultra-rápido para consultas públicas do GraphQL.
 * Permite respostas em < 1ms e invalidação automática em mutações.
 */

interface CacheEntry<T = any> {
  data: T;
  expiresAt: number;
}

class MemoryCache {
  private cache = new Map<string, CacheEntry>();
  private defaultTtlMs: number;

  constructor(defaultTtlMs = 60 * 1000) {
    this.defaultTtlMs = defaultTtlMs;
  }

  get<T = any>(key: string): T | null {
    const entry = this.cache.get(key);
    if (!entry) return null;
    if (Date.now() > entry.expiresAt) {
      this.cache.delete(key);
      return null;
    }
    return entry.data as T;
  }

  set<T = any>(key: string, data: T, ttlMs?: number): void {
    const expiresAt = Date.now() + (ttlMs ?? this.defaultTtlMs);
    this.cache.set(key, { data, expiresAt });
  }

  invalidate(prefix?: string): void {
    if (!prefix) {
      this.cache.clear();
      return;
    }
    const lowerPrefix = prefix.toLowerCase();
    for (const key of this.cache.keys()) {
      if (key.toLowerCase().startsWith(lowerPrefix) || key.toLowerCase().includes(lowerPrefix)) {
        this.cache.delete(key);
      }
    }
  }

  size(): number {
    return this.cache.size;
  }
}

export const queryCache = new MemoryCache(60 * 1000); // 60 segundos
