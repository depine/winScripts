@echo off
REM Script para limpeza de arquivos temporarios e cache do Windows
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

echo Limpando arquivos temporarios...
del /s /f /q "%tmp%\*" >nul 2>&1
rd /s /q "%tmp%" >nul 2>&1
del /s /f /q "%windir%\Temp\*" >nul 2>&1
rd /s /q "%windir%\Temp" >nul 2>&1
del /s /f /q "%windir%\Prefetch\*" >nul 2>&1
rd /s /q "%windir%\Prefetch" >nul 2>&1
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
