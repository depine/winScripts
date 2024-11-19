@echo off
REM Script para ajustes diversos no Windows 10

REM Verifica se está sendo executado como administrador
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Por favor, execute o script como administrador.
    pause
    exit /b
)

:: SISTEMA
echo Ativando Windows Photo Viewer...
regedit /s "%~dp0.\modules\restorePhotoViewer.reg" >nul 2>&1

echo Desativando Armazenamento Reservado...
DISM /Online /Get-ReservedStorageState >nul 2>&1
DISM /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
REM Mesma alteração via registro:
REM REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v ShippedWithReserves /t REG_DWORD /d 0 /f >nul 2>&1

echo Desativando Prefetch...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul 2>&1
echo Desativando Superfetch (SysMain)...
sc stop SysMain > NUL & sc config SysMain start=disabled > NUL
echo.

:: WINDOWS EXPLORER
echo Aplicanto alteracoes no Windows Explorer:
echo - Iniciar em Este Computador;
echo - Desativar Itens Recentes em Acesso Rapido;
echo - Desativar Itens Frequentes em Acesso Rapido;
echo - Exibir extensoes de arquivos;
echo - Remover pasta Objetos 3D.
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
echo.

:: BARRA DE TAREFAS
echo Aplicando alteracoes na Barra de Tarefas...
echo - Ocultar Barra de Pesquisa;
echo - Ocultar icone Reunir Agora;
echo - Ocultar icone Visao de Tarefas;
echo - Ocultando Noticias e Clima.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0.\modules\removeNewsAndWeather.ps1" >nul 2>&1
echo.

:: APARENCIA
echo Aplicando alteracoes de aparencia...
echo - Desativar transparencias;
echo - Aplicar tema escuro nos Apps;
echo - Aplicar tema escuro no sistema.
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
echo.

:: DESKTOP
echo Aplicando alteracoes na Area de trabalho...
echo - Exibir icone da pasta do usuario;
echo - Exibir icone Meu Computador;
echo - Auto organizar icones.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {59031A47-3F72-44A7-89C5-5595FE6B30EE} /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" /V FFLAGS /T REG_DWORD /D 1075839525 /f >nul 2>&1
echo.

:: Remover pastas, arquivos e atalhos
echo Removendo pastas, arquivos e atalhos...
echo - Removendo pasta Objetos 3D;
echo - Removendo pasta Documentos\WindowsPowerShell;
echo - Removendo atalho Windows Power Shell (x86);
echo - Remover atalho Reconhecimento de Fala.
for /d %%u in (C:\Users\*) do (
    if exist "%%u\3D Objects" rmdir /s /q "%%u\3D Objects" >nul 2>&1
    if exist "%%u\Documents\WindowsPowerShell" rmdir /s /q "%%u\Documents\WindowsPowerShell" >nul 2>&1
    if exist "%%u\Desktop\Microsoft Edge.lnk" del /q "%%u\Desktop\Microsoft Edge.lnk" >nul 2>&1
    if exist "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail" del /q "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail" >nul 2>&1
    if exist "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Fax Recipient.lnk" del /q "%%u\AppData\Roaming\Microsoft\Windows\SendTo\Fax Recipient.lnk" >nul 2>&1
    if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessibility\Speech Recognition.lnk" del /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessibility\Speech Recognition.lnk" >nul 2>&1
    if exist "%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell (x86).lnk" del /q "%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell (x86).lnk" >nul 2>&1)
echo.

:: MENU INICIAR
echo Aplicanto alteracoes no Menu Iniciar:
echo - Desativar sugestoes;
echo - Desativar ContentDelivery;
echo - Desativar arquivos recentes;
echo - Desativar Apps recentes;
echo - Desativar pesquisa Bing;
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Este bloco precisa ficar por ultimo
:: Powershell script externo para remover Tiles do Menu Iniciar
echo - Removendo Tiles do Menu Iniciar.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0.\modules\removeTiles.ps1" >nul 2>&1
echo.

echo Alteracoes aplicadas com sucesso!
echo.

:: Função: removeComponents
:askUser
set /p userInput="Remover Apps da Microsoft Store e componentes opcionais do Windows? (S/N): "
if /i "%userInput%"=="S" goto removeComponents
if /i "%userInput%"=="N" goto restartComputer
echo Entrada invalida.
goto askUser

:removeComponents
echo Removendo App da Loja e componentes opcionais...
call %~dp0.\tools\removeOptionalAndStoreApps.bat
echo Concluido!
echo.



:restartComputer
Set /P "Reiniciar=E necessario reiniciar para aplicar. Reiniciar agora? (S/N): "
If /I "%Reiniciar%"=="S" (
    shutdown /r /f /t 0
) Else (
    echo.
    echo Reinicie o computador para aplicar as alteracoes!
)

echo.
pause
exit
