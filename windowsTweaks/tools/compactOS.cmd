@echo off
REM Compactar a pasta WinSxS
Dism.exe /online /Cleanup-Image /StartComponentCleanup

REM Remover atualizações antigas
Dism.exe /online /Cleanup-Image /SPSuperseded

REM Limpar imagem do sistema e redefinir base de componentes
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

REM Compactar arquivos do sistema opercaional
compact.exe /CompactOS:always

REM Verificar e reparar arquivos do sistema
sfc /scannow

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
