@echo off
:: Batch script to remove optional Windows features

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
    DISM.exe /Online /Disable-Feature /featurename:%%f /Remove
)

