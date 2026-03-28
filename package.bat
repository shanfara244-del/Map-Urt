@echo off
SET MAPNAME=ut4_neonduct
SET URTDIR=C:\Users\Shanfara\Desktop\UrbanTerror43\q3ut4
SET PROJDIR=%~dp0
SET PK3=%URTDIR%\%MAPNAME%.pk3

echo === Packaging %MAPNAME%.pk3 ===

:: Create temp staging folder
IF EXIST "%TEMP%\%MAPNAME%_pkg" RMDIR /S /Q "%TEMP%\%MAPNAME%_pkg"
MKDIR "%TEMP%\%MAPNAME%_pkg\maps"
MKDIR "%TEMP%\%MAPNAME%_pkg\scripts"

:: Copy compiled BSP
COPY "%PROJDIR%maps\%MAPNAME%.bsp" "%TEMP%\%MAPNAME%_pkg\maps\" >nul

:: Copy arena file
COPY "%PROJDIR%scripts\%MAPNAME%.arena" "%TEMP%\%MAPNAME%_pkg\scripts\" >nul

:: Delete old pk3 if exists
IF EXIST "%PK3%" DEL "%PK3%"

:: Pack with PowerShell (built-in zip)
powershell -Command "Compress-Archive -Path '%TEMP%\%MAPNAME%_pkg\*' -DestinationPath '%PK3:.pk3=.zip%' -Force; Rename-Item -Path '%PK3:.pk3=.zip%' -NewName '%MAPNAME%.pk3'"

:: Cleanup
RMDIR /S /Q "%TEMP%\%MAPNAME%_pkg"

IF EXIST "%PK3%" (
    echo SUCCESS: %PK3%
    echo Launch Urban Terror and type in console:
    echo   \map ut4_neonduct
) ELSE (
    echo FAILED: pk3 not created
)
