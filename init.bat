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
    pause
    exit /b
)

cd /d %LETHAL_COMPANY_PATH%

git --git-dir="%LETHAL_COMPANY_PATH%\BepInEx\.git"^
    --work-tree "%LETHAL_COMPANY_PATH%/BepInEx"^
    remote -v | find "%REPOSITORY_URL%" > nul
if errorLevel 1 (
    rmdir /s /q "BepInEx"
    git clone %REPOSITORY_URL% "BepInEx"
    echo [32m√ BepInEx installed successfully[0m
) else (
    cd "BepInEx"
    git pull origin main
    echo [32m√ BepInEx updated successfully[0m
)

chcp 850 > nul
cd /d %~dp0
pause
