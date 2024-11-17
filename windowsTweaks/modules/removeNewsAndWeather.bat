@echo off
:: Verifica se o script já está rodando como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script precisa ser executado como administrador.
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb RunAs"
    exit /b
)

:: Caminho para o script .ps1 na mesma pasta do .bat
set SCRIPT_PATH=%~dp0RemoveNewsAndWeather.ps1

:: Executa o PowerShell como administrador
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"
pause

REM Reinicia o Windows Explorer para aplicar as alterações
taskkill /f /im explorer.exe
start explorer.exe