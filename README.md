# 🏛️ Portais PE — Governo do Estado de Pernambuco

Plataforma integrada de comunicação institucional e gestão de conteúdo da Secretaria de Administração (SAD/PE).

---

## 🏗️ Arquitetura do Projeto

O ecossistema é composto por 5 aplicações integradas:

1. **⚡ Backend Customizado (`backend-customizado`):**
   - Servidor Fastify + Yoga GraphQL de alta performance.
   - Prisma ORM para acesso ao banco de dados SQLite / PostgreSQL.
   - Cache em memória ultrarrápido com invalidação instantânea em mutações.
   - Autenticação com sessão JWT (Bearer) e rate-limiting de proteção contra força bruta.
   - Porta padrão: `3001` (`http://localhost:3001/api/graphql`)

2. **🎛️ Gerenciador Administrativo (`gerenciador-react`):**
   - Painel SPA moderno em React + TypeScript + Vite + Tailwind CSS + Lucide Icons.
   - Gestão completa de Áreas, Subáreas, Serviços, Notícias, Legislação, Cursos, Projetos/Soluções, Portfólio, Usuários e Log de Auditoria.
   - Porta padrão: `5173` (`http://localhost:5173`)

3. **🏛️ Portal Patrimônio (`PortaisPE-main/portal_patrimonio_pe`):**
   - Portal institucional da Secretaria Executiva de Patrimônio.
   - Porta padrão: `5174` (`http://localhost:5174`)

4. **📐 Portal Engenharia e Arquitetura (`PortaisPE-main/portal_eng_arq_pe`):**
   - Portal institucional com divisão em Arquitetura, Engenharia, Cartografia e Avaliação, e área comum de Portfólio de Obras e Projetos.
   - Porta padrão: `5175` (`http://localhost:5175`)

5. **📋 Portal Contratos Corporativos (`PortaisPE-main/portal_contratos_corp_pe`):**
   - Portal institucional de Serviços e Contratos Corporativos (Frota, Água e Energia, Telemática).
   - Porta padrão: `5176` (`http://localhost:5176`)

---

## 🚀 Como Executar

### Pré-requisitos
- **Node.js:** v18 ou superior.

### Inicialização Rápida (Todos os Serviços Juntos)
Basta executar na raiz do projeto:

```bash
# Via Node.js
node start-all.js

# Ou no Windows
start-all.cmd
```

---

## 🌐 Acesso em Rede Local

Todos os serviços escutam em `0.0.0.0` e podem ser acessados na mesma rede através do nome do computador ou IP da máquina:

- **Gerenciador:** `http://NOME_DA_MAQUINA:5173`
- **Portal Patrimônio:** `http://NOME_DA_MAQUINA:5174`
- **Portal Engenharia:** `http://NOME_DA_MAQUINA:5175`
- **Portal Contratos:** `http://NOME_DA_MAQUINA:5176`
