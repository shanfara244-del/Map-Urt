@echo off
SET Q3MAP2=C:\Users\Shanfara\Desktop\NetRadiant\q3map2.exe
SET MAPFILE=%~dp0maps\ut4_neonduct.map
SET BASEPATH=C:\Users\Shanfara\Desktop\UrbanTerror43
SET LOG=%~dp0compile_log.txt

echo === Compilation ut4_neonduct === > "%LOG%"
echo. >> "%LOG%"

echo [1/3] BSP...
echo [1/3] BSP... >> "%LOG%"
"%Q3MAP2%" -fs_basepath "%BASEPATH%" -fs_basegame q3ut4 -game quake3 -meta "%MAPFILE%" >> "%LOG%" 2>&1

echo [2/3] VIS...
echo [2/3] VIS... >> "%LOG%"
"%Q3MAP2%" -fs_basepath "%BASEPATH%" -fs_basegame q3ut4 -game quake3 -vis -fast "%~dp0maps\ut4_neonduct.bsp" >> "%LOG%" 2>&1

echo [3/3] LIGHT...
echo [3/3] LIGHT... >> "%LOG%"
"%Q3MAP2%" -fs_basepath "%BASEPATH%" -fs_basegame q3ut4 -game quake3 -light -fast -filter -super 2 -bounce 4 "%~dp0maps\ut4_neonduct.bsp" >> "%LOG%" 2>&1

echo. >> "%LOG%"
echo === Termine === >> "%LOG%"
echo === Termine ===
echo. >> "%LOG%"
echo === Termine === >> "%LOG%"
echo.
echo Log sauvegarde : %LOG%
start notepad.exe "%LOG%"
