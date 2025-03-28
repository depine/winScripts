@echo off
REM Script para instalacao automatica de aplicativos no Windows
REM 7-zip, Adobe Acrobat Reader, AnyDesk, Google Chrome, Firefox, Thunderbird, OnlyOffice, Revo Uninstaller. 
REM
REM Escrito por Gian Depiné (depine@gmail.com) em 20 de novembro de 2024.
REM Atualizado em 12/12/2024

REM Solicita permissao de administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
if '%errorlevel%' NEQ '0' (    echo Verificando persmissao de administrador...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    exit /B
:gotAdmin  

:: Verifica se o comando winget esta disponível, e instala se for necessario
powershell -ExecutionPolicy Bypass -Command "if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { irm asheroto.com/winget | iex }" >nul 2>&1

echo Instalando aplicativos extras
winget install 7-Zip --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Adobe.Acrobat.Reader.64-bit --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
REM winget install AnyDeskSoftwareGmbH.AnyDesk --force --accept-package-agreements --accept-source-agreements --disable-interactivity
REM winget install CodecGuide.K-LiteCodecPack.Full --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Google.Chrome --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Mozilla.Firefox --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Mozilla.Thunderbird.pt-BR --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install ONLYOFFICE.DesktopEditors --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install RevoUninstaller.RevoUninstaller --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install TeamViewer.TeamViewer --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
REM winget upgrade --silent --force --recurse --nowarn --unknown --accept-package-agreements --accept-source-agreements --disable-interactivity

echo Instalacao concluida!
pause
