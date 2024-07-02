@echo off
set "riotClientPath=C:\Riot Games\Riot Client\RiotClientServices.exe"

set "originalHomescreen=C:\Riot Games\Valorant_Homescreen.mp4"

set "menuPath=C:\Riot Games\VALORANT\live\ShooterGame\Content\Movies\Menu"

start "" "%riotClientPath%" --launch-product=valorant --launch-patchline=live

timeout /t 10 /nobreak

:checkValorant
tasklist | find /I "valorant" >NUL
if "%ERRORLEVEL%"=="0" (
    echo Valorant is running.
    goto deleteAndCopy
) else (
    echo Waiting for Valorant to start...
    timeout /t 5 /nobreak
    goto checkValorant
)

:deleteAndCopy
for %%f in ("%menuPath%\*Homescreen*") do (
    del "%%f"
    echo Deleted %%f
    copy "%originalHomescreen%" "%menuPath%\%%~nxf"
    echo Copied %originalHomescreen% to %menuPath%\%%~nxf
)

echo Done.
exit
