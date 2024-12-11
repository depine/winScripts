@echo off
REM Script para atualização completa do Windows 10 e 11
REM Ativa atualização automática dos Apps da Windows Store
REM Instala atualizações do Windows Update
REM Instala o Winget e atualiza demais aplicativos
REM
REM Escrito por Gian Depiné (depine@gmail.com) em 17 de novembro de 2024.
REM Atualizado em 22/11/2024


echo ATENCAO!!!
echo ==========
echo.
echo ESTE SCRIPT VAI REINICIAR SEU COMPUTADOR AUTOMATICAMENTE, SALVE SEU TRABALHO ANTES DE PROSSEGUIR...
echo.
pause
echo.

REM Solicita permissao de administrador
:: BatchGotAdmin        
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
if '%errorlevel%' NEQ '0' (    echo Verificando persmissao de administrador...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    exit /B
:gotAdmin

REM Remover todos Provisioned Packages para evitar bloatware em novos usuarios
REM echo Removendo Provisioned Packages
REM powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -AllUsers"
REM echo.

echo Reinstalando Windows Store e ativando atualizacoes...
REM Criar chave de registro:
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /f  >nul 2>&1
REM Definir politica de downloads automaticos da WindowsStore:
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 4 /f >nul 2>&1
REM Ativar atualizacoes automaticas da WindowsStore:
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v AutoDownload /t REG_DWORD /d 4 /f >nul 2>&1
REM Ativar atualizadoes dos Apps da WindowsStore:
powershell -ExecutionPolicy Bypass -Command "Get-CimInstance -Namespace 'Root\cimv2\mdm\dmmap' -ClassName 'MDM_EnterpriseModernAppManagement_AppManagement01' | Invoke-CimMethod -MethodName UpdateScanMethod" >nul 2>&1
echo Concluido!
echo.

echo Instalando NuGet...
REM Verifica se o NuGet está instalado:
powershell -ExecutionPolicy Bypass -Command "if (-not (Get-PackageSource -Name 'NuGet' -ErrorAction SilentlyContinue)) { Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force }" >nul 2>&1
echo Concluido!
echo.

echo Instalando atualizacoes do Windows Update...
REM Executa o Windows Update:
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {if (!(Get-Module -ListAvailable -Name PSWindowsUpdate)) { Install-Module PSWindowsUpdate -Force; } Import-Module PSWindowsUpdate; Get-WindowsUpdate -AcceptAll -Install -AutoReboot;}"
echo Concluido!

timeout /t 30
echo.
echo Baixando e instalando atualizacoes do Winget...
echo.
REM Verifica se o comando winget está disponível:
powershell -ExecutionPolicy Bypass -Command "if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { irm asheroto.com/winget | iex }" >nul 2>&1
REM Aplica atualizacoes via WinGet:
winget upgrade --force --recurse --nowarn --unknown --accept-package-agreements --accept-source-agreements --disable-interactivity
echo Concluido!
echo.
echo.
echo Todas atualizacoes concluidas!!
echo.
echo.

:: Funcao Reiniciar Computador
:restartComputer
Set /P "Reiniciar=E necessario reiniciar para aplicar. Reiniciar agora? (S/N): "
If /I "%Reiniciar%"=="S" (
    shutdown /r /f /t 0
) Else (
    echo.
    echo Reinicie o computador para aplicar as alteracoes!
)

echo.
echo.
pause
exit
