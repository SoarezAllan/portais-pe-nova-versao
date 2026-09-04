@echo off
title PORTAIS PE — TODOS OS SERVIÇOS
echo.
echo ======================================================================
echo   PORTAIS PE - TODOS OS SERVIÇOS
echo ======================================================================
echo.
echo   [1] Backend Customizado    http://localhost:3001/api/graphql
echo   [2] Gerenciador React      http://localhost:5173
echo   [3] Portal Patrimônio      http://localhost:5174
echo   [4] Portal Eng/Arq         http://localhost:5175
echo   [5] Portal Contratos      http://localhost:5176
echo.
echo ======================================================================
echo.
start "BACKEND" cmd /k "cd /d %~dp0backend-customizado && npm run dev"
start "GERENCIADOR" cmd /k "cd /d %~dp0gerenciador-react && npm run dev"
start "PORTAL PATRIMONIO" cmd /k "cd /d %~dp0PortaisPE-main\portal_patrimonio_pe && npm run dev"
start "PORTAL ENG/ARQ" cmd /k "cd /d %~dp0PortaisPE-main\portal_eng_arq_pe && npm run dev"
start "PORTAL CONTRATOS" cmd /k "cd /d %~dp0PortaisPE-main\portal_contratos_corp_pe && npm run dev"
echo Todos os serviços iniciados em janelas separadas.
echo Pressione qualquer tecla para fechar esta janela...
pause > nul