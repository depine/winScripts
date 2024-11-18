@echo off
REM Necessario executar como administrador

echo Limpando arquivos temporarios...
del /s /f /q "%tmp%\*" >nul 2>&1
rd /s /q "%tmp%" >nul 2>&1
del /s /f /q "%windir%\Temp\*" >nul 2>&1
rd /s /q "%windir%\Temp" >nul 2>&1
del /s /f /q "%windir%\Prefetch\*" >nul 2>&1
rd /s /q "%windir%\Prefetch" >nul 2>&1
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

echo Rodando Limpeza de Disco...
%systemroot%\system32\cleanmgr.exe /dC
cleanmgr /sageset:65535 /sagerun:65535
%systemroot%\system32\cmd.exe /c Cleanmgr /sagerun:65535
cleanmgr /sagerun:1
echo Concluido!
echo.

pause
exit
