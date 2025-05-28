$pbixPath = "$PSScriptRoot\..\dashboards\amen_bank.pbix"
$powerBIPath = "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe"

if ((Test-Path $powerBIPath) -and (Test-Path $pbixPath)) {
    Write-Host "Ouverture de amen_bank.pbix dans Power BI Desktop..."
    Start-Process -FilePath $powerBIPath -ArgumentList "`"$pbixPath`""
} else {
    Write-Error "Power BI Desktop ou le fichier PBIX est introuvable."
    exit 1
}

