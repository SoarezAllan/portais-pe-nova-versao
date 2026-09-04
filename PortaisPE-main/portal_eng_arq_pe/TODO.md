# TODO - Correção de filtro de área no Portal Engenharia e Arquitetura

## Passos

- [x] 1. Analisar código e identificar causas raiz
- [ ] 2. Corrigir import ausente de `siteConfig` em `pages/home/index.jsx`
- [ ] 3. Adicionar debug logging no interceptor do `api/index.jsx` para diagnóstico
- [ ] 4. Remover `services/apiClient.js` (redundante - duplicata não utilizada)
- [ ] 5. Migrar páginas que usam `apiClient.post()` diretamente para funções centralizadas em `services/api.js`:
  - [ ] `pages/portifolio/index.jsx`
  - [ ] `pages/noticias_historico/index.jsx`
  - [ ] `pages/legislacao/index.jsx`
  - [ ] `pages/solucoes/index.jsx`
  - [ ] `pages/quem_somos/index.jsx`
- [ ] 6. Limpar cache do Vite e testar
</｜｜DSML｜｜parameter>
</create_file>
