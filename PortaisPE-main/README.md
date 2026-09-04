## Produção - Portal (dev)

Este repositório contém três portais frontend e o backend Keystone.

Rápido (comandos):

- Iniciar tudo (backend + 3 frontends) e ver links de rede:

```powershell
cd producao_portal_patrimonio_pe
node start-all.js
```

- Iniciar apenas um portal (ex.: Patrimônio):

```powershell
cd producao_portal_patrimonio_pe/portal_patrimonio_pe
npm install
copy .env.example .env
npm run dev
```

- Iniciar backend (Keystone):

```powershell
cd producao_portal_patrimonio_pe/gerenciamento_keystone
npm install
copy .env.example .env
npm run dev
```

Arquivos .env.example criados:

- portal_patrimonio_pe/.env.example
- portal_eng_arq_pe/.env.example
- portal_contratos_corp_pe/.env.example
- gerenciamento_keystone/.env.example

Variáveis importantes (frontends):

- VITE_API_BASE_URL — URL do backend (ex.: http://172.31.104.30:3001)
- VITE_SITE_AREA — nome da área do portal (ex.: Patrimônio)
- VITE_SITE_SUBAREAS — subáreas separadas por | (ex.: Patrimônio Imobiliário|Patrimônio Móvel)
- VITE_SITE_TITLE — título do site

Variáveis importantes (backend):

- DATABASE_URL — string de conexão do Prisma/DB
- FRONTEND_URL — URL do frontend para links em e-mails
- BACKEND_PORT — porta onde o Keystone rodará (padrão 3001)

Observações:

- O launcher start-all.js usa as variáveis de ambiente DEV_HOST e BACKEND_PORT se definidas para ajustar as URLs exibidas.

Exemplo (PowerShell):

```powershell
$env:DEV_HOST='192.168.1.100'
$env:BACKEND_PORT='3001'
node start-all.js
```

Os frontends lêem siteConfig e VITE_SITE_SUBAREAS para montar menus e filtrar Serviços/Legislação por subárea.

Posso adicionar docker-compose ou scripts de serviço se quiser.
