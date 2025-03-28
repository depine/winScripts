@echo off
REM Script para ajustes diversos no Windows
REM Escrito por Gian Depiné (depine@gmail.com) em 17 de novembro de 2024.
REM Atualizado em 13/12/2024

REM Solicita permissao de administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
if '%errorlevel%' NEQ '0' (    echo Verificando persmissao de administrador...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    exit /B
:gotAdmin  


echo APLICANDO OTIMIZACOES NO SISTEMA
rem echo Ativando Windows Photo Viewer (legado)...
rem regedit /s "%~dp0.\modules\restorePhotoViewer.reg" >nul 2>&1

echo Desativando Armazenamento Reservado...
DISM /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1

echo Desativando Prefetch...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul 2>&1

echo Desativando Superfetch (SysMain)...
sc stop SysMain > NUL & sc config SysMain start=disabled > NUL

echo Desativando Fast Startup...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo.

echo Desativando animacao de boas vindas
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f >nul 2>&1
echo.

echo Removendo Provisioned Packages
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -AllUsers" >nul 2>&1
echo.

echo Desativando Windows Consumer Features
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
echo.


echo Desativando Widgets na Barra de Tarefas
reg add "HKLM\Software\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f >nul 2>&1




echo APLICANDO OTIMIZACOES NO WINDOWS EXPLORER
echo Iniciando Explorer em Este Computador...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1

echo Desativando Itens Recentes em Acesso Rapido...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f >nul 2>&1

echo Desativando Itens Frequentes em Acesso Rapido...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f >nul 2>&1

echo Desativando arquivos do Office.com em Acesso Rapido...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowCloudFilesInQuickAccess /t REG_DWORD /d 0 /f >nul 2>&1

echo Exibindo extensoes de arquivos no Explorer...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
echo.

echo APLICANDO OTIMIZACOES NA BARRA DE TAREFAS
REM echo Removendo icones padrao...
REM DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" >nul 2>&1
REM REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /F  >nul 2>&1

echo Ocultando Barra de Pesquisa...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1

echo Ocultando icone Visao de Tarefas...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1

echo Posicionando Menu Iniciar a esquerda...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul 2>&1
echo.

echo Ocultando Widgets da Barra de tarefas...
winget uninstall --purge --silent --force --disable-interactivity --accept-source-agreements "windows web experience pack" >nul 2>&1
echo.


echo APLICANDO OTIMIZACOES DE APARENCIA
echo Desativando transparencias...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1

echo Aplicanto tema escuro nos Apps...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1

echo Aplicando tema escuro no sistema...
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
echo.


echo APLICANDO OTIMIZACOES NA AREA DE TRABALHO
REM echo Exibindo icone da pasta do usuario...
REM REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {59031A47-3F72-44A7-89C5-5595FE6B30EE} /t REG_DWORD /d 0 /f >nul 2>&1

echo Exibindo icone Meu Computador...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f >nul 2>&1

REM echo - Auto organizando icones...
REM REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" /V FFLAGS /T REG_DWORD /D 1075839525 /f >nul 2>&1
REM echo.


:: Remover pastas, arquivos e atalhos
echo Removendo arquivos, pastas e atalhos obsoletos...
for /d %%u in (C:\Users\*) do (
    if exist "%%u\Documents\WindowsPowerShell" rmdir /s /q "%%u\Documents\WindowsPowerShell" >nul 2>&1
    if exist "%%u\Desktop\Microsoft Edge.lnk" del /q "%%u\Desktop\Microsoft Edge.lnk" >nul 2>&1
    if exist "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail" del /q "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail" >nul 2>&1
    if exist "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Fax Recipient.lnk" del /q "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Fax Recipient.lnk" >nul 2>&1
    if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessibility\Speech Recognition.lnk" del /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessibility\Speech Recognition.lnk" >nul 2>&1
    if exist "%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell (x86).lnk" del /q "%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell (x86).lnk" >nul 2>&1)
echo.


echo APLICANDO OTIMIZACOES NO MENU INICIAR
echo Desativando sugestoes...
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1

echo Desativando ContentDeliveryManager...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1

echo Desativando instalacao de apps sugeridos...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

echo Ocultando arquivos recomendados no menu iniciar, explorer e listas de atalhos:
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul 2>&1

REM echo Desativando apps adicionados recentemente no menu iniciar...
REM REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f >nul 2>&1

echo Desativando recomendacoes para dicas, atalhos, novos aplicativos e muito mais
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul 2>&1

echo Desativando notificacoes relacionadas a conta...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_AccountNotifications /t REG_DWORD /d 0 /f >nul 2>&1

echo Adicionando Explorer e Configuracoes ao Menu Iniciar...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Start" /v "VisiblePlaces" /t REG_BINARY /d 86087352aa5143429f7b2776584659d4bc248a140cd68942a0806ed9bba24882 /f

echo Desativando pesquisa Bing no menu iniciar
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo.



echo Alterando nome da unidade C: OS
label c: OS
echo.

echo Alteracoes aplicadas com sucesso!
echo.

echo Reiniciando Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe >nul 2>&1
echo.

:: Funcao Alterar Hostname
:changeHostname
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
