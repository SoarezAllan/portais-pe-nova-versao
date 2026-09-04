@echo off
echo ============================================
echo  Limpeza de Cache - KeystoneJS
echo ============================================
echo.
echo 1. Removendo diretorio .keystone...
if exist ".keystone" (
    rmdir /s /q ".keystone"
    echo    [OK] .keystone removido
) else (
    echo    [INFO] .keystone nao encontrado
)

echo 2. Removendo diretorio .next...
if exist ".next" (
    rmdir /s /q ".next"
    echo    [OK] .next removido
) else (
    echo    [INFO] .next nao encontrado
)

echo 3. Regenerando tipos GraphQL e Prisma Client...
call npx keystone build
if %errorlevel% neq 0 (
    echo    [ERRO] Falha ao executar 'keystone build'
    pause
    exit /b %errorlevel%
)

echo.
echo ============================================
echo  Limpeza concluida com sucesso!
echo ============================================
pause

