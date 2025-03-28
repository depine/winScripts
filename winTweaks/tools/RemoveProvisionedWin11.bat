@echo off
REM Script para remoção automatica dos Provisioned Packages do Windows 11
REM
REM Escrito por Gian Depiné (depine@gmail.com) em 20 de março de 2025.
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

echo.

echo Removendo provisioned packages...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.GamingApp_2502.1001.6.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.GetHelp_10.2302.10601.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.MicrosoftOfficeHub_18.2503.1122.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.MicrosoftSolitaireCollection_4.21.12110.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.MicrosoftStickyNotes_6.1.4.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.OutlookForWindows_1.2025.312.200_x64__8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.PowerAutomateDesktop_11.2502.260.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.Todos_2.114.7122.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.Windows.DevHome_0.2001.758.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.WindowsAlarms_2021.2501.7.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.WindowsCamera_2022.2501.1.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.WindowsFeedbackHub_2024.1118.608.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.WindowsSoundRecorder_2021.2408.6.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.XboxGamingOverlay_7.225.2131.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.XboxIdentityProvider_12.115.1001.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.XboxSpeechToTextOverlay_1.97.17002.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.YourPhone_1.25021.67.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "Microsoft.ZuneMusic_11.2501.9.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "MicrosoftCorporationII.QuickAssist_2024.309.159.0_neutral_~_8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "MSTeams_25044.2208.3471.2155_x64__8wekyb3d8bbwe"} | Remove-AppxProvisionedPackage –online" >nul 2>&1
exit

