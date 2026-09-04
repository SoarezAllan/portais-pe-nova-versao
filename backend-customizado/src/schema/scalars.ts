import { GraphQLScalarType, Kind } from 'graphql';

export const DateTimeScalar = new GraphQLScalarType({
  name: 'DateTime',
  description: 'ISO 8601 date-time string',
  serialize(value: any): string {
    if (value instanceof Date) return value.toISOString();
    if (typeof value === 'string') return value;
    if (typeof value === 'number') return new Date(value).toISOString();
    return value;
  },
  parseValue(value: any): Date | null {
    if (!value) return null;
    return new Date(value);
  },
  parseLiteral(ast: any): Date | null {
    if (ast.kind === Kind.STRING || ast.kind === Kind.INT) {
      return new Date(ast.value);
    }
    return null;
  },
});

export const JSONScalar = new GraphQLScalarType({
  name: 'JSON',
  description: 'Arbitrary JSON value',
  serialize(value: any): any {
    return value;
  },
  parseValue(value: any): any {
    return value;
  },
  parseLiteral(ast: any): any {
    if (ast.kind === Kind.STRING) {
      try {
        return JSON.parse(ast.value);
      } catch {
        return ast.value;
      }
    }
    if (ast.kind === Kind.OBJECT) {
      const obj: Record<string, any> = {};
      for (const field of ast.fields) {
        obj[field.name.value] = parseLiteralValue(field.value);
      }
      return obj;
    }
    if (ast.kind === Kind.LIST) {
      return ast.values.map(parseLiteralValue);
    }
    return ast.value;
  },
});

function parseLiteralValue(ast: any): any {
  switch (ast.kind) {
    case Kind.STRING:
      return ast.value;
    case Kind.INT:
      return parseInt(ast.value, 10);
    case Kind.FLOAT:
      return parseFloat(ast.value);
    case Kind.BOOLEAN:
      return ast.value;
    case Kind.NULL:
      return null;
    case Kind.OBJECT: {
      const obj: Record<string, any> = {};
      for (const f of ast.fields) obj[f.name.value] = parseLiteralValue(f.value);
      return obj;
    }
    case Kind.LIST:
      return ast.values.map(parseLiteralValue);
    default:
      return ast.value;
  }
}

export const UploadScalar = new GraphQLScalarType({
  name: 'Upload',
  description: 'The Upload scalar type represents a file upload (multipart).',
  serialize(value: any): any {
    return value;
  },
  parseValue(value: any): any {
    return value;
  },
  parseLiteral(): any {
    throw new Error('Upload não suportado em literais');
  },
});
