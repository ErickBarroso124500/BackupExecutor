# backup.ps1 — versão PowerShell do seu .bat original
$destino = "G:\Meu Drive\backup"
$log = "$env:TEMP\backup_log_acs.txt"

if (-not (Test-Path "G:\")) {
    "ERRO: Google Drive (G:) não encontrado!" | Out-File -FilePath $log -Encoding UTF8
    exit 1
}

if (-not (Test-Path $destino)) { New-Item -Path $destino -ItemType Directory | Out-Null }

"===================================" | Tee-Object -FilePath $log -Append
"BACKUP INICIADO: $(Get-Date)" | Tee-Object -FilePath $log -Append
"DESTINO: $destino" | Tee-Object -FilePath $log -Append
"===================================" | Tee-Object -FilePath $log -Append

function Copiar-Pasta($origem, $pasta) {
    if (-not (Test-Path $origem)) {
        "AVISO: Origem não encontrada: $origem" | Tee-Object -FilePath $log -Append
        return
    }
    $dest = "$destino\$pasta"
    if (-not (Test-Path $dest)) { New-Item -Path $dest -ItemType Directory | Out-Null }
    "Iniciando backup: $origem" | Tee-Object -FilePath $log -Append
    robocopy "$origem" "$dest" /E /XO /R:3 /W:5 /TEE /NP | Out-File -FilePath $log -Append -Encoding UTF8
}

Copiar-Pasta "C:\ACS_Sinapse\Servidor\Util" "ACS_Sinapse"
Copiar-Pasta "C:\ACS\Sintese"               "ACS_Sintese"
Copiar-Pasta "C:\ACS_NFe"                   "ACS_NFe"
Copiar-Pasta "C:\ACS_MDFe"                  "ACS_MDFe"
Copiar-Pasta "C:\ACS_CTe"                   "ACS_CTe"
Copiar-Pasta "C:\ACS_Backup1"               "ACS_Backup1"

"===================================" | Tee-Object -FilePath $log -Append
"BACKUP FINALIZADO: $(Get-Date)" | Tee-Object -FilePath $log -Append
"===================================" | Tee-Object -FilePath $log -Append
