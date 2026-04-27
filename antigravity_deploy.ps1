# Command for VSCode Terminal (PowerShell)
# Perform export, commit, and push in one execution chain

$LS_PROC = Get-Process -Name "languageserver" -ErrorAction SilentlyContinue
if ($LS_PROC) { $LS_STATUS = "Active" } else { $LS_STATUS = "Not Found" }
Write-Host "--- Antigravity Environment Check ---" -ForegroundColor Cyan;
Write-Host "R Language Server: $LS_STATUS";
Write-Host "Node Version: $(node -v)";

if (Test-Path "./app") {
    Write-Host "Exporting Shinylive App (R-based exporter)..." -ForegroundColor Yellow;
    $RSCRIPT_PATH = "C:\Program Files\R\R-4.2.2\bin\Rscript.exe"
    if (Test-Path $RSCRIPT_PATH) {
        & $RSCRIPT_PATH export_app.R
    } else {
        Rscript export_app.R
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Staging and Committing..." -ForegroundColor Green;
        git add .;
        git commit -m "Antigravity Deployment: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')";
        git push origin main;
        Write-Host "Deployment Flow Triggered Successfully!" -ForegroundColor Green;
    } else {
        Write-Host "Export failed. Aborting git flow." -ForegroundColor Red;
    }
} else {
    Write-Host "Error: /app folder not found." -ForegroundColor Red;
}
