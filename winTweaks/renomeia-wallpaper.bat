@echo off
REM Script para renomear arquivo de wallpaper diariamente
REM Colocar no agendados de tarefas do windows para rodar todas as noites
REM Escrito por Gian Depiné - 29/01/2025

setlocal enabledelayedexpansion

REM Defina o diretório onde estão os arquivos
set "diretorio=\\srv-ad01\Wallpaper$"

REM Navegue até o diretório
cd /d "%diretorio%"

REM Renomeie os arquivos na ordem inversa para evitar sobreposição
ren "Wallpaper4.jpg" "temp.jpg"
ren "Wallpaper3.jpg" "Wallpaper4.jpg"
ren "Wallpaper2.jpg" "Wallpaper3.jpg"
ren "Wallpaper1.jpg" "Wallpaper2.jpg"
ren "Wallpaper.jpg" "Wallpaper1.jpg"
ren "temp.jpg" "Wallpaper.jpg"

echo Arquivos renomeados com sucesso!
exit
