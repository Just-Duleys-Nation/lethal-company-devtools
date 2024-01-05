@echo off

chcp 65001 > nul
set "LETHAL_COMPANY_PATH=C:\Lethal Company"
set "REPOSITORY_URL=https://github.com/Just-Duleys-Devs/lethal-company-mods.git"

:CHECK_PATH
if not exist "%LETHAL_COMPANY_PATH%" (
    echo Error: The specified path does not contain Lethal Company.
    set /p LETHAL_COMPANY_PATH=Enter the valid path to the folder with Lethal Company: 
    goto CHECK_PATH
)

if not exist "%LETHAL_COMPANY_PATH%\BepInEx" (
    echo Error: The script requires BepInEx to be installed.
    exit /b 1
)

cd /d %LETHAL_COMPANY_PATH%\BepInEx

git --git-dir="%LETHAL_COMPANY_PATH%/BepInEx/plugins/.git"^
    --work-tree "%LETHAL_COMPANY_PATH%/BepInEx/plugins"^
    remote -v | find "%REPOSITORY_URL%" > nul
if errorLevel 1 (
    rmdir /s /q "plugins"
    git clone %REPOSITORY_URL% "plugins"
    echo [32m√ Mods installed successfully[0m
) else (
    cd "plugins"
    git pull origin main
    echo [32m√ Mods updated successfully[0m
)

chcp 850 > nul
cd /d %~dp0
pause
