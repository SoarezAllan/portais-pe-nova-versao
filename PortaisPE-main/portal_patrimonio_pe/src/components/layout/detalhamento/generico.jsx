import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import apiClient from "../../../api";
import { format } from "date-fns";
import Header from "../header";
import Footer from "../footer";

/*
  props:
    - listName: "noticias" | "solucoes" | "servicos" | "cursos" | ...
    - singleName: opcional, por padrão retira o "s" final (usado em algumas queries)
    - fields: array de strings com os campos GraphQL a buscar (ex: ["id", "titulo", "slug", "dataPublicacao", "imagem { url }", "corpo { document }", "autor { name }"])
*/
export default function DetalheGenerico({ listName, singleName, fields = [] }) {
  const { slug } = useParams();
  const [item, setItem] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const typeSingle = singleName || listName.replace(/s$/, "");

  useEffect(() => {
    window.scrollTo(0, 0);
    const fetchItem = async () => {
      try {
        setLoading(true);
        setError(null);

        // montar a query dinamicamente — filtrando por slug.
        // Para listas que suportam o campo `ativo`, adicionamos o filtro
        const listsWithAtivo = ['servicos', 'noticias', 'solucoes', 'legislacoes'];
        const whereExtra = listsWithAtivo.includes(listName) ? `, ativo: { equals: true }` : '';
        // montando a query dinamicamente — filtrando por slug
        const query = `
          query GetItemBySlug($slug: String!) {
            ${listName}(where: { slug: { equals: $slug }${whereExtra} }) {
              ${fields.join("\n")}
            }
          }
        `;

        const res = await apiClient.post("/api/graphql", {
          query,
          variables: { slug },
        });

        if (res.data?.errors) {
          throw new Error(res.data.errors.map(e => e.message).join("\n"));
        }

        const data = res.data?.data?.[listName]?.[0];
        if (!data) throw new Error("Item não encontrado");

        setItem(data);
      } catch (err) {
        console.error("Erro ao buscar item:", err);
        setError(err.message || "Erro ao buscar item.");
      } finally {
        setLoading(false);
      }
    };

    fetchItem();
  }, [listName, fields, slug, singleName]);

  // Renderizador recursivo simples para o document do Keystone (Slate-like)
  const renderDocument = (doc) => {
    if (!doc) return null;
    // se receber { document: [...] } ou já o array
    const nodes = Array.isArray(doc) ? doc : doc.document || doc;

    const renderNode = (node, idx) => {
      const childrenText = (node.children || []).map((c, i) => {
        if (typeof c === "string") return c;
        if (c.text) return c.text;
        // mais casos podem ser adicionados
        return "";
      }).join("");

      switch (node.type) {
        case "paragraph":
        case "paragraph_block":
          return <p key={idx}>{(node.children || []).map((c, i) => c.text || "")}</p>;
        case "heading":
        case "heading-one":
        case "heading-two":
          {
            const level = node.level || 2;
            const Tag = `h${Math.min(Math.max(level,1),6)}`;
            return <Tag key={idx}>{(node.children || []).map((c) => c.text || "")}</Tag>;
          }
        case "image":
        case "image_block":
          // Keystone pode trazer dados de imagem em node; tentamos várias chaves
          const url = node.url || node.src || (node?.data?.image?.url) || (node?.value?.src);
          const alt = node.alt || node.title || "";
          return url ? <img key={idx} src={url} alt={alt} style={{ maxWidth: "100%" }} /> : null;
        case "bulleted-list":
        case "numbered-list":
        case "list":
          return (
            <ul key={idx}>
              {(node.children || []).map((li, i) => <li key={i}>{(li.children||[]).map(c => c.text || "").join("")}</li>)}
            </ul>
          );
        case "link":
          return <a key={idx} href={node.url || node.href} target="_blank" rel="noopener noreferrer">{(node.children||[]).map(c => c.text||"")}</a>;
        default:
          // fallback: renderizar filhos caso existam
          if (node.children && node.children.length > 0) {
            return <div key={idx}>{node.children.map((ch, i) => typeof ch === "string" ? ch : (ch.text || ""))}</div>;
          }
          return null;
      }
    };

    return nodes.map((n, i) => renderNode(n, i));
  };

  if (loading) {
    return (
      <div className="app-container">
        <Header />
        <main style={{ padding: 40 }}><h1>Carregando...</h1></main>
        <Footer />
      </div>
    );
  }

  if (error) {
    return (
      <div className="app-container">
        <Header />
        <main style={{ padding: 40 }}>
          <h1 style={{ color: "red" }}>Erro</h1>
          <p>{error}</p>
          <Link to={`/${listName}`}>Voltar</Link>
        </main>
        <Footer />
      </div>
    );
  }

  // item pronto — render básico: título, data, autor, imagem e corpo
  const title = item.titulo || item.title || item.nome || item.name;
  const dateVal = item.dataPublicacao || item.createdAt || item.publishedAt;
  const authorName = item?.autor?.name || item?.author?.name;

  return (
    <div className="app-container">
      <Header />
      <main style={{ padding: "40px 20px" }}>
        <Link to={`/${listName}`}>← Voltar</Link>
        <h1>{title}</h1>
        {item.subtitulo && <h2>{item.subtitulo}</h2>}
        <div style={{ color: "#666", marginBottom: 12 }}>
          {dateVal && <span>{format(new Date(dateVal), "dd/MM/yyyy")}</span>}
          {authorName && <span style={{ marginLeft: 12 }}>• {authorName}</span>}
        </div>

        {item.imagemPrincipal?.url || item.imagem?.url ? (
          <img src={(item.imagemPrincipal?.url || item.imagem?.url)} alt={title} style={{ width: "100%", maxHeight: 500, objectFit: "cover" }} />
        ) : null}

        <div style={{ marginTop: 20 }}>
          { renderDocument(item.corpo || item.body || item.content) }
        </div>
      </main>
      <Footer />
    </div>
  );
}
