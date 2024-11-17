@echo off
REM Necessario executar como administrador

REM Compactar a pasta WinSxS
Dism.exe /online /Cleanup-Image /StartComponentCleanup

REM Remover atualizações antigas
Dism.exe /online /Cleanup-Image /SPSuperseded

REM Limpar imagem do sistema e redefinir base de componentes
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

REM Compactar arquivos do sistema opercaional
compact.exe /CompactOS:always



REM Ferramenta de limpeza de disco do Windows:
%systemroot%\system32\cleanmgr.exe /dC
cleanmgr /sageset:65535 /sagerun:65535
%systemroot%\system32\cmd.exe /c Cleanmgr /sagerun:65535

pause
exit