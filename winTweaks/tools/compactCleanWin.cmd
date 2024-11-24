@echo off

REM Solicita permissao de administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
if '%errorlevel%' NEQ '0' (    echo Verificando persmissao de administrador...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    exit /B
:gotAdmin


REM Compactar a pasta WinSxS
Dism.exe /online /Cleanup-Image /StartComponentCleanup

REM Remover atualizações antigas
Dism.exe /online /Cleanup-Image /SPSuperseded

REM Limpar imagem do sistema e redefinir base de componentes
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

REM Compactar arquivos do sistema opercaional
compact.exe /CompactOS:always

REM Verificar e reparar arquivos do sistema
REM sfc /scannow

REM Comprimir pasta WinSXS
sc stop msiserver
sc stop TrustedInstaller
sc config msiserver start= disabled
sc config TrustedInstaller start= disabled
icacls "%WINDIR%\WinSxS" /save "%WINDIR%\WinSxS_NTFS.acl" /t
takeown /f "%WINDIR%\WinSxS" /r
icacls "%WINDIR%\WinSxS" /grant "%USERDOMAIN%\%USERNAME%":(F) /t
compact /s:"%WINDIR%\WinSxS" /c /a /i *
icacls "%WINDIR%\WinSxS" /setowner "NT SERVICE\TrustedInstaller" /t
icacls "%WINDIR%" /restore "%WINDIR%\WinSxS_NTFS.acl"
sc config msiserver start= demand
sc config TrustedInstaller start= demand


echo Rodando Limpeza de Disco...
REM Criar registro para limpeza automática
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Content Indexer Cleaner" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Device Driver Packages" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Diagnostic Data Viewer database files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\DownloadsFolder" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows ESD installation files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" /v "StateFlags13" /t REG_DWORD /d 2 /f >nul 2>&1
cleanmgr /sagerun:13
cleanmgr /sagerun:1
cleanmgr.exe /autoclean 
echo Concluido!
echo.


echo Limpando arquivos temporarios...
del /s /f /q "%tmp%\*" >nul 2>&1
rd /s /q "%tmp%" >nul 2>&1
del /s /f /q "%windir%\Temp\*" >nul 2>&1
rd /s /q "%windir%\Temp" >nul 2>&1
del /s /f /q "%windir%\Prefetch\*" >nul 2>&1
rd /s /q "%windir%\Prefetch" >nul 2>&1
del /s /q /f  %systemdrive%\$Recycle.bin\* >nul 2>&1
rd /s /q %systemdrive%\$Recycle.bin\* >nul 2>&1
del /s /f /q %LOCALAPPDATA%\Microsoft\Windows\Caches\*.* >nul 2>&1
rd /s /q %LOCALAPPDATA%\Microsoft\Windows\Caches\*.*  >nul 2>&1
del /s /f /q %programdata%\Microsoft\Windows\WER\Temp\*.* >nul 2>&1
rd /s /q %programdata%\Microsoft\Windows\WER\Temp\*.* >nul 2>&1
del /s /f /q %HomePath%\AppData\Local\Temp\*.* >nul 2>&1
rd /s /q %HomePath%\AppData\Local\Temp\*.* >nul 2>&1
echo Concluido!
echo.


echo Limpando cache do Windows Update...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1
cd %windir%\SoftwareDistribution
del /f /s /q *.* >nul 2>&1
for /d %%D in (*) do rd /s /q "%%D" >nul 2>&1
cd %windir%\System32\catroot2\
del /f /s /q *.* >nul 2>&1
for /d %%D in (*) do rd /s /q "%%D" >nul 2>&1
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1
echo Concluido!
echo.

pause
exit

