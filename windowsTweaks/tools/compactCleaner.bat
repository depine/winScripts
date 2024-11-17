@echo off

echo Executando Limpador de disco...
%systemroot%\system32\cleanmgr.exe /d C
cleanmgr /sageset:65535
cleanmgr /sagerun:65535
echo Concluido!
echo.

setlocal enabledelayedexpansion
echo Limpando caches, arquivos temporários e lixeira...
net stop wuauserv
net stop bits
del /f /s /q %windir%\SoftwareDistribution\*.*
net start wuauserv
net start bits
ipconfig /flushdns
del /q /f /s C:\Windows\Prefetch\*
timeout /t 5 /nobreak >nul
del /q /f /s C:\Windows\Temp\*
timeout /t 5 /nobreak >nul
rd /s /q C:\$Recycle.Bin
timeout /t 5 /nobreak >nul
for /d %%u in (C:\Users\*) do (
    if exist "%%u\AppData\Local\Temp" (
        for /D %%i in (%%u\AppData\Local\Temp\*) do (
            rd /s /q "%%i"
            del /q /f /s %%u\AppData\Local\Temp\*
        )
    )
)
for /d %%u in (C:\Users\*) do (
    set "userProfileDir=%%u\AppData\Local\Microsoft\Windows\Explorer"
    if exist "!userProfileDir!" (
        del /s /q "!userProfileDir!\*.db"
    )
)
echo Concluido!
echo.

echo Executando limpeza profunda do Windows...
REM Remover arquivos antigos
Dism.exe /online /Cleanup-Image /StartComponentCleanup
REM Remover atualizacoes antigas
Dism.exe /online /Cleanup-Image /SPSuperseded
REM Remover versoes antigas de todos os componentes
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
echo Concluido!
echo.

echo Compactando Sistema Operacional
compact.exe /CompactOS:always
echo Concluido!
echo.

pause
exit
