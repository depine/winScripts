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

echo.
echo Desinstalando Microsoft OneDrive
taskkill /f /im OneDrive.exe
IF EXIST %SystemRoot%\SysWOW64\OneDriveSetup.exe %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
IF EXIST %SystemRoot%\System32\OneDriveSetup.exe %SystemRoot%\System32\OneDriveSetup.exe /uninstall
REG ADD "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
REG ADD "HKCR\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f

:: Remover pastas do OneDrive globalmente
rmdir /s /q "C:\ProgramData\Microsoft OneDrive" >nul 2>&1
for /d %%u in (C:\Users\*) do (if exist "%%u\OneDrive" rmdir /s /q "%%u\OneDrive")
pause
exit
