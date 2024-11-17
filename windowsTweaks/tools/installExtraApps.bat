@echo off

:: Alterando nome da unidade de disco C:
label C: OS

:: Verifica se o comando winget está disponível
powershell -ExecutionPolicy Bypass -Command "if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { irm asheroto.com/winget | iex }" >nul 2>&1

echo Instalando aplicativos extras
winget install Google.Chrome --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Mozilla.Firefox --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Mozilla.Thunderbird.pt-BR --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install ONLYOFFICE.DesktopEditors --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install 7-Zip --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install Adobe.Acrobat.Reader.64-bit --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install CodecGuide.K-LiteCodecPack.Full --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install RevoUninstaller.RevoUninstaller --silent --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install AnyDeskSoftwareGmbH.AnyDesk --force --accept-package-agreements --accept-source-agreements --disable-interactivity
winget upgrade --silent --force --recurse --nowarn --unknown --accept-package-agreements --accept-source-agreements --disable-interactivity

echo Instalação concluída!
pause
