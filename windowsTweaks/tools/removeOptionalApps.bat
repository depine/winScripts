@echo off

echo Removendo componentes opcionais do Windows (Painel de Controle)
REM Para listar os recursos opcionais e adaptar o script: dism /Online /Get-Capabilities
dism /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:App.Support.QuickAssist~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:DirectX.Configuration.Database~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Hello.Face.18967~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Language.Language.Basic~~~pt-BR~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Language.Handwriting~~~pt-BR~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Language.OCR~~~pt-BR~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Language.Speech~~~pt-BR~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Language.TextToSpeech~~~pt-BR~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Media.WindowsMediaPlayer~~~~0.0.12.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:OneCoreUAP.OneSync~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:OpenSSH.Client~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Print.Fax.Scan~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Print.Management.Console~~~~0.0.1.0 /NoRestart
REM dism /Online /Remove-Capability /CapabilityName:Windows.Client.ShellComponents~~~~0.0.1.0 /NoRestart
echo Concluido!
echo.

echo Removendo componentes opcionais do Windows (Configurações)
REM Para listar os recursos opcionais e adaptar o script: Get-WindowsOptionalFeature -Online
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WCF-Services45' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WCF-TCP-PortSharing45' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'MediaPlayback' -Online -NoRestart"
REM powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WindowsMediaPlayer' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'SmbDirect' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Printing-PrintToPDFServices-Features' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Printing-XPSServices-Features' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'SearchEngine-Client-Package' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'MSRDC-Infrastructure' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WorkFolders-Client' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Printing-Foundation-Features' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Printing-Foundation-InternetPrinting-Client' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'MicrosoftWindowsPowerShellV2Root' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'MicrosoftWindowsPowerShellV2' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'NetFx4-AdvSrvs' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Internet-Explorer-Optional-amd64' -Online -NoRestart"
echo concluido!
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
echo concluido!
echo.

echo.
:Reiniciar
Set /P "Reiniciar=E necessario reiniciar para aplicar. Reiniciar agora? (S/N): "
If /I "%Reiniciar%"=="S" (
    shutdown /r /f /t 0
) Else (
    echo.
    echo Reinicie o computador para aplicar as alteracoes!
)

echo.
echo.
pause
exit
