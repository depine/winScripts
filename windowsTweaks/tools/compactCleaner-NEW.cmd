@echo off
REM Script de limpeza automatica Windows
REM >nul 2>&1 suprime saída na tela

REM Verifica privilegios de administrador...
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Rodando Limpeza de Disco...
%systemroot%\system32\cleanmgr.exe /dC
cleanmgr /sageset:65535 /sagerun:65535
%systemroot%\system32\cmd.exe /c Cleanmgr /sagerun:65535
cleanmgr /sagerun:1
echo Concluido!
echo.
pause

echo Rodando System File Checker...
sfc /scannow
echo Concluido!
echo.
pause

echo Limpando WindowsUpdate...
net stop wuauserv & net stop cryptSvc & net stop bits &net stop msiserver
cd %windir%\SoftwareDistribution
del /f /s /q *.*
cd %windir%\System32\catroot2\
del /f /s /q *.*
net start wuauserv & net start cryptSvc & net start bits & net start msiserver
echo Concluido!
echo.
pause


echo Limpando arquivos temporarios...
del /s /f /q "%tmp%\*"
rd /s /q "%tmp%"
del /s /f /q "C:\Windows\Temp\*"
rd /s /q "C:\Windows\Temp"
del /s /f /q "C:\Windows\Prefetch\*"
rd /s /q "C:\Windows\Prefetch"
echo Concluido!
echo.
pause

echo Limpando lixeira...
powershell -Command "Clear-RecycleBin -Force"
echo Concluido!
echo.
pause
exit