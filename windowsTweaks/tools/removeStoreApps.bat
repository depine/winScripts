@echo off
echo Desinstalando aplicativos da Loja
REM Para listar os recursos opcionais e adaptar o script: Get-AppxPackage | Select Name, PackageFullName
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *549981C3F5F10* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Appconnector* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *BingNews* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *BingWeather* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Copilot* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *DevHome* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *GetHelp* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Getstarted* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Messaging* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Microsoft3DViewer*| Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *MicrosoftOfficeHub* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *MicrosoftSolitaireCollection* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *MicrosoftStickyNotes* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *MixedReality* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *MSPaint* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *officehub* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *OneConnect* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *OneNote* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *People* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Photos* | Remove-AppxPackage"
REM powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *ScreenSketch* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *soundrecorder* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *SkypeApp* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *WindowsAlarms* | Remove-AppxPackage"
REM powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *WindowsCalculator* | Remove-AppxPackage"
REM powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *WindowsCamera* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *windowscommunicationsapps* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *WindowsFeedbackHub* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *WindowsMaps* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *WindowsSoundRecorder* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Wallet*| Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Xbox* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *YourPhone* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *ZuneMusic* | Remove-AppxPackage"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *ZuneVideo* | Remove-AppxPackage"
pause
exit
