param(
    [string]$PbixPath = ".\reports\dashboard.pbix",  # Chemin par défaut
    [string]$WorkspaceName = "MonWorkspace"          # Nom de votre workspace
)

# === 1. Vérifier que Power BI Desktop est installé ===
$pbiExe = "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe"
if (-not (Test-Path $pbiExe)) {
    Write-Host "❌ Power BI Desktop n'est pas installé ou le chemin est incorrect." -ForegroundColor Red
    exit 1
}

# === 2. Vérifier que le fichier .pbix existe ===
if (-not (Test-Path $PbixPath)) {
    Write-Host "❌ Fichier Power BI introuvable : $PbixPath" -ForegroundColor Red
    exit 1
}

# === 3. Ouvrir Power BI Desktop avec le fichier ===
Write-Host "⌛ Ouverture de $PbixPath..." -ForegroundColor Cyan
Start-Process $pbiExe -ArgumentList "/import `"$(Resolve-Path $PbixPath)`""

# === 4. Attendre 15 secondes (temps de chargement) ===
Write-Host "⏳ Attente du chargement (15 secondes)..." -ForegroundColor Cyan
Start-Sleep -Seconds 15

# === 5. Automatiser la publication avec raccourcis clavier ===
Write-Host "🚀 Tentative de publication vers le workspace '$WorkspaceName'..." -ForegroundColor Cyan

# Charger l'assembly pour envoyer des touches clavier
Add-Type -AssemblyName System.Windows.Forms

# Envoyer Alt+P (ouvrir la fenêtre de publication)
[System.Windows.Forms.SendKeys]::SendWait("%p")
Start-Sleep -Seconds 2

# Envoyer Entrée pour confirmer la publication (ajustez si nécessaire)
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 5  # Attendre la fin de la publication

Write-Host "✅ Publication terminée ! Vérifiez dans le service Power BI." -ForegroundColor Green