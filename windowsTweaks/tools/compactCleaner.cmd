@echo off
setlocal enabledelayedexpansion
REM Necessario executar como administrador

echo Limpando arquivos temporarios...
del /s /f /q "%tmp%\*" >nul 2>&1
rd /s /q "%tmp%" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*" >nul 2>&1
rd /s /q "C:\Windows\Temp" >nul 2>&1
del /s /f /q "C:\Windows\Prefetch\*" >nul 2>&1
rd /s /q "C:\Windows\Prefetch" >nul 2>&1
echo Concluido!
echo.

echo Limpando cache do Windows Update...
net stop wuauserv >nul 2>&1 & net stop cryptSvc >nul 2>&1 & net stop bits >nul 2>&1 & net stop msiserver >nul 2>&1
cd %windir%\SoftwareDistribution
del /f /s /q *.* >nul 2>&1
cd %windir%\System32\catroot2\
del /f /s /q *.* >nul 2>&1
net start wuauserv >nul 2>&1 & net start cryptSvc >nul 2>&1 & net start bits >nul 2>&1 & net start msiserver >nul 2>&1
echo Concluido!
echo.

echo Limpando cache do Winget
winget cache reset --force >nul 2>&1
echo Concluido!
echo.



echo Compactando pasta WinSXS...
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


REM Compactar a pasta WinSxS
Dism.exe /online /Cleanup-Image /StartComponentCleanup
echo Concluido!
echo.





echo Removendo atualizacoes antigas...
Dism.exe /online /Cleanup-Image /SPSuperseded
echo Concluido!
echo.




echo Limpando imagem do sistema...
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
echo Concluido!
echo.




echo Compactando arquivos do sistema operacional...
compact.exe /CompactOS:always
echo Concluido!
echo.




echo Verificando e reparando arquivos de sistema...
sfc /scannow
echo Concluido!
echo.



echo Rodando Limpeza de Disco...
%systemroot%\system32\cleanmgr.exe /dC
cleanmgr /sageset:65535 /sagerun:65535
%systemroot%\system32\cmd.exe /c Cleanmgr /sagerun:65535
cleanmgr /sagerun:1
echo Concluido!
echo.

pause
exit
