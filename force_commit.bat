@echo off
:: Script para añadir cambios, modificar el último commit y forzar el push al repositorio remoto.

:: Agrega todos los cambios al área de preparación
git add .

:: Modifica el último commit sin cambiar su mensaje
git commit --amend --no-edit

:: Fuerza el envío al repositorio remoto
git push --force

:: Mensaje de finalización
echo Operación completada: los cambios se han añadido, el commit ha sido modificado y los cambios se han empujado.
pause
