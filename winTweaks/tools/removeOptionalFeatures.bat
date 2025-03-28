@echo off
REM Script para remoção automatica de TODOS os componentes opcionais do Windows
REM Escrito por Gian Depiné (depine@gmail.com) em 20 de novembro de 2024

REM Solicita permissao de administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
if '%errorlevel%' NEQ '0' (    echo Verificando persmissao de administrador...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    exit /B
:gotAdmin  

set features=TFTP LegacyComponents DirectPlay SimpleTCP Windows-Identity-Foundation ^
WCF-HTTP-Activation WCF-NonHTTP-Activation WCF-Services45 WCF-HTTP-Activation45 ^
WCF-TCP-Activation45 WCF-Pipe-Activation45 WCF-MSMQ-Activation45 WCF-TCP-PortSharing45 ^
MediaPlayback DataCenterBridging SmbDirect AppServerClient Printing-PrintToPDFServices-Features ^
Printing-XPSServices-Features MSRDC-Infrastructure TelnetClient TIFFIFilter Printing-Foundation-Features ^
Printing-Foundation-InternetPrinting-Client Printing-Foundation-LPDPrintService ^
Printing-Foundation-LPRPortMonitor MicrosoftWindowsPowerShellV2Root MicrosoftWindowsPowerShellV2 ^
Client-ProjFS Client-DeviceLockdown Client-EmbeddedShellLauncher Client-EmbeddedBootExp ^
Client-EmbeddedLogon Client-KeyboardFilter Client-UnifiedWriteFilter DirectoryServices-ADAM-Client ^
NetFx3 IIS-WebServerRole IIS-WebServer IIS-CommonHttpFeatures IIS-HttpErrors IIS-HttpRedirect ^
IIS-ApplicationDevelopment IIS-Security IIS-RequestFiltering IIS-NetFxExtensibility IIS-NetFxExtensibility45 ^
IIS-HealthAndDiagnostics IIS-HttpLogging IIS-LoggingLibraries IIS-RequestMonitor IIS-HttpTracing ^
IIS-URLAuthorization IIS-IPSecurity IIS-Performance IIS-HttpCompressionDynamic ^
IIS-WebServerManagementTools IIS-ManagementScriptingTools IIS-IIS6ManagementCompatibility IIS-Metabase ^
WAS-WindowsActivationService WAS-ProcessModel WAS-NetFxEnvironment WAS-ConfigurationAPI ^
IIS-HostableWebCore IIS-StaticContent IIS-DefaultDocument IIS-DirectoryBrowsing IIS-WebDAV IIS-WebSockets ^
IIS-ApplicationInit IIS-ASPNET IIS-ASPNET45 IIS-ASP IIS-CGI IIS-ISAPIExtensions IIS-ISAPIFilter ^
IIS-ServerSideIncludes IIS-CustomLogging IIS-BasicAuthentication IIS-HttpCompressionStatic ^
IIS-ManagementConsole IIS-ManagementService IIS-WMICompatibility IIS-LegacyScripts IIS-LegacySnapIn ^
IIS-FTPServer IIS-FTPSvc IIS-FTPExtensibility MSMQ-Container MSMQ-DCOMProxy MSMQ-Server ^
MSMQ-ADIntegration MSMQ-HTTP MSMQ-Multicast MSMQ-Triggers IIS-CertProvider IIS-WindowsAuthentication ^
IIS-DigestAuthentication IIS-ClientCertificateMappingAuthentication IIS-IISCertificateMappingAuthentication ^
IIS-ODBCLogging NetFx4-AdvSrvs NetFx4Extended-ASPNET45 ServicesForNFS-ClientOnly ^
ClientForNFS-Infrastructure NFS-Administration HostGuardian SMB1Protocol SMB1Protocol-Client ^
SMB1Protocol-Server SMB1Protocol-Deprecation MultiPoint-Connector MultiPoint-Connector-Services ^
MultiPoint-Tools WorkFolders-Client Microsoft-Windows-Subsystem-Linux HypervisorPlatform ^
VirtualMachinePlatform Containers-DisposableClientVM Microsoft-Hyper-V-All Microsoft-Hyper-V ^
Microsoft-Hyper-V-Tools-All Microsoft-Hyper-V-Management-PowerShell Microsoft-Hyper-V-Hypervisor ^
Microsoft-Hyper-V-Services Microsoft-Hyper-V-Management-Clients Windows-Defender-ApplicationGuard Containers

for %%f in (%features%) do (
    echo Removing feature: %%f
    DISM.exe /Online /Disable-Feature /featurename:%%f /Remove /NoRestart
)


echo Removendo componentes opcionais do Windows (Painel de Controle)
REM Para listar os recursos opcionais e adaptar o script: dism /Online /Get-Capabilities
dism /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:App.Support.QuickAssist~~~~0.0.1.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart
dism /Online /Remove-Capability /CapabilityName:DirectX.Configuration.Database~~~~0.0.1.0 /NoRestart
REM dism /Online /Remove-Capability /CapabilityName:Hello.Face.18967~~~~0.0.1.0 /NoRestart
REM dism /Online /Remove-Capability /CapabilityName:Language.Language.Basic~~~pt-BR~0.0.1.0 /NoRestart
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

echo Removendo componentes opcionais do Windows (Configuracoes)
REM Para listar os recursos opcionais e adaptar o script: Get-WindowsOptionalFeature -Online
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WCF-Services45' -Online -NoRestart"
REM powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WCF-TCP-PortSharing45' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'MediaPlayback' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'WindowsMediaPlayer' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'SmbDirect' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Printing-PrintToPDFServices-Features' -Online -NoRestart"
powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'Printing-XPSServices-Features' -Online -NoRestart"
REM powershell -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -FeatureName 'SearchEngine-Client-Package' -Online -NoRestart"
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

echo concluido!
echo.
