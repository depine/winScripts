@echo off
REM Script para atualização completa do Windows 10 e 11
REM Ativa atualização automática dos Apps da Windows Store
REM Instala atualizações do Windows Update
REM Instala o Winget e atualiza demais aplicativos
REM
REM
REM Escrito por Gian Depiné (depine@gmail.com)
REM em 17 de novembro de 2024

echo ATENCAO!!!
echo ==========
echo.
echo ESTE SCRIPT VAI REINICIAR O COMPUTADOR AUTOMATICAMENTE DURANTE AS ATUALIZACOES
echo SALVE E FECHE QUALQUER TRABALHO QUE TENHA ABERTO ANTES DE PROSSEGUIR
echo EXECUTE O SCRIPT NOVAMENTE ATE INSTALAR TODAS AS ATUALIZACOES DISPONIVEIS
echo.
pause

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

echo Ativando atualizacoes da Windows Store...
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /f  >nul 2>&1 ; Criar chave de registro usada abaixo
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 4 /f >nul 2>&1 ; Ativar downloads da WindowsStore
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v AutoDownload /t REG_DWORD /d 4 /f >nul 2>&1 ; Ativar downloads automaticos da WindowsStore
powershell -ExecutionPolicy Bypass -Command "Get-CimInstance -Namespace 'Root\cimv2\mdm\dmmap' -ClassName 'MDM_EnterpriseModernAppManagement_AppManagement01' | Invoke-CimMethod -MethodName UpdateScanMethod" >nul 2>&1 ; Ativar atualizadoes dos Apps da loja
echo Concluido!
echo.

echo Instalando NuGet...
powershell -ExecutionPolicy Bypass -Command "if (-not (Get-PackageSource -Name 'NuGet' -ErrorAction SilentlyContinue)) { Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force }" >nul 2>&1 ; Verifica se o NuGet já está instalado
echo Concluido!
echo.

echo Instalando atualizacoes do Windows Update...
:: Executa o Windows Update
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {if (!(Get-Module -ListAvailable -Name PSWindowsUpdate)) { Install-Module PSWindowsUpdate -Force; } Import-Module PSWindowsUpdate; Get-WindowsUpdate -AcceptAll -Install -AutoReboot;}"
echo Concluido!

timeout /t 30
echo.
echo Baixando e instalando atualizacoes do Winget...
echo.
:: Verifica se o comando winget está disponível
powershell -ExecutionPolicy Bypass -Command "if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { irm asheroto.com/winget | iex }" >nul 2>&1 ; Instala o winget
winget upgrade --force --recurse --nowarn --unknown --accept-package-agreements --accept-source-agreements --disable-interactivity ; Aplica atualizações via Winget
echo Concluido!
echo.
echo.
echo Todas atualizacoes concluidas!!
echo.
echo.


:: Funcao Alterar Hostname
echo O hostname atual do computador e: %ComputerName%
echo.
Set /P "AlterarHost=Deseja alterar o hostname do computador agora? (S/N): "
If /I "%AlterarHost%"=="S" (
GoTo AskHN
) Else (
    echo.
    GoTo restartComputer
    pause
    exit /b
)


:: Funcao Pergunta Hostname
:AskHN
Set "HN="
Set /P "HN=Entre com o novo hostname: "
echo.
If Not Defined HN (
    Echo Nao pode ficar em branco.
    GoTo AskHN
)
If /I "%NH%"=="%ComputerName%" Exit /B
If "%HN:~,1%"=="." (
    Echo Nao pode comecar com ponto.
    GoTo AskHN
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "Rename-Computer -NewName %HN%"
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
