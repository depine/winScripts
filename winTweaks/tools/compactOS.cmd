@echo off
REM Script para limpeza e compactação da instalação do Windows:
REM Compacta pasta WinSXS, remove atualizações já instaladas, limpa imagem do sistema e compacta arquivos do sistema operacional
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
exit
