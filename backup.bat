@echo off
setlocal
set DESTINO=G:\Meu Drive\backup
set LOG=%TEMP%\backup_log_acs.txt
rem ==== Garante que o Drive existe ====
if not exist "G:\" (
  echo ERRO: Unidade G nao encontrada - Google Drive nao esta sincronizando.
  echo ERRO: Unidade G nao encontrada >> "%LOG%"
  pause
  exit /b 1
)
rem ==== Cria destino se nao existir ====
if not exist "%DESTINO%" mkdir "%DESTINO%"

echo =============================
echo BACKUP INICIADO: %DATE% %TIME%
echo DESTINO GERAL: %DESTINO%
echo =============================
echo.
>> "%LOG%" 2>&1

rem ==== LISTA DE BACKUPS ====
call :COPIAR "C:\ACS_Sinapse\Servidor\Util" "ACS_Sinapse"
call :COPIAR "C:\ACS\Sintese" "ACS_Sintese"

echo.
echo =============================
echo BACKUP FINALIZADO: %DATE% %TIME%
echo =============================
type "%LOG%"
pause
endlocal
exit /b 0

:COPIAR
set ORIGEM=%~1
set PASTA=%~2
set DEST=%DESTINO%\%PASTA%
if not exist "%ORIGEM%" (
  echo AVISO: Pasta origem nao encontrada: %ORIGEM%
  echo AVISO: Pasta origem nao encontrada: %ORIGEM% >> "%LOG%"
  exit /b
)
if not exist "%DEST%" mkdir "%DEST%"
echo.
echo Iniciando backup de: %ORIGEM%
robocopy "%ORIGEM%" "%DEST%" /E /XO /R:3 /W:5 /TEE /NP /LOG+:"%LOG%"
exit /b
