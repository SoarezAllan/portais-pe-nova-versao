declare module 'graphql-tag' {
  import { DocumentNode } from 'graphql';
  export function gql(
    strings: TemplateStringsArray | string,
    ...values: any[]
  ): DocumentNode;
  export default gql;
}
