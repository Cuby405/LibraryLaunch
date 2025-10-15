@echo off
setlocal enabledelayedexpansion
title Library Launch
set "ARCHIVO=programs.txt"

>nul 2>&1 reg query HKCU\Console || exit /b
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul

:MENU
cls
echo [92m================================
echo          LIBRARY LAUNCH
echo ================================[0m

REM limpiar variables anteriores
for /L %%N in (1,1,100) do set "COMANDO[%%N]="

set /a i=0
for /f "tokens=1* delims=|" %%A in ('type "%ARCHIVO%"') do (
    set /a i+=1
    echo [!i!] - %%A
    set "COMANDO[!i!]=%%B"
)

if %i%==0 echo [90m(Empty)
echo.
echo [90m[C] - Change paths and labels.
echo [Q] - Quit
echo [92m================================
set /p opcion=[93mSelect an option: [0m

if /i "%opcion%"=="C" goto CAMBIAR
if /i "%opcion%"=="Q" goto SALIR

set "COMANDO_SEL=!COMANDO[%opcion%]!"
if defined COMANDO_SEL (
    start "" "!COMANDO_SEL!"
    goto MENU
)

echo [91mInvalid option, try again.
pause >nul
goto MENU


:CAMBIAR
cls
echo [92m================================
echo         PROGRAMS EDITOR
echo ================================
echo [91mThis process will delete all current paths.
echo [96mEnter paths one by one.
echo Leave the label EMPTY and press ENTER to finish.
echo [92m================================
echo.

REM vaciar el archivo correctamente
break > "%ARCHIVO%"

set /a j=1
:AGREGAR
set "nombre="
set "ruta="
set /p nombre=[93mLabel name #%j% (ENTER to finish): [0m
if "%nombre%"=="" goto FIN_AGREGAR
set /p ruta=[93mComplete path to "%nombre%": [0m

REM importante: escapamos la tubería (|) correctamente al guardar
>>"%ARCHIVO%" echo %nombre%^|%ruta%
set /a j+=1
goto AGREGAR

:FIN_AGREGAR
echo.
echo [95mMenu updated successfully!!
pause >nul
goto MENU


:SALIR
exit /b
