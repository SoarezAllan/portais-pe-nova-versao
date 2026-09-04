Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Limpeza de Cache - KeystoneJS" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Remove .keystone
Write-Host "1. Removendo diretorio .keystone..." -ForegroundColor Yellow
if (Test-Path ".keystone") {
    Remove-Item -Path ".keystone" -Recurse -Force
    Write-Host "   [OK] .keystone removido" -ForegroundColor Green
} else {
    Write-Host "   [INFO] .keystone nao encontrado" -ForegroundColor Gray
}

# Step 2: Remove .next
Write-Host "2. Removendo diretorio .next..." -ForegroundColor Yellow
if (Test-Path ".next") {
    Remove-Item -Path ".next" -Recurse -Force
    Write-Host "   [OK] .next removido" -ForegroundColor Green
} else {
    Write-Host "   [INFO] .next nao encontrado" -ForegroundColor Gray
}

# Step 3: Regenerate GraphQL types and Prisma Client
Write-Host "3. Regenerando tipos GraphQL e Prisma Client..." -ForegroundColor Yellow
try {
    npx keystone build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "   [ERRO] Falha ao executar 'keystone build'" -ForegroundColor Red
        Read-Host "Pressione Enter para sair"
        exit $LASTEXITCODE
    }
} catch {
    Write-Host "   [ERRO] $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Limpeza concluida com sucesso!" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Read-Host "Pressione Enter para sair"

