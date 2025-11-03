@echo off
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    DWM (DESKTOP WINDOW MANAGER) TWEAKS     │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will apply tweaks to reduce DWM resource usage.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Applying DWM Tweaks"
call :BACKUP "HKCU\Software\Microsoft\Windows\Dwm" "DWM_Tweaks_User"
call :BACKUP "HKLM\SOFTWARE\Microsoft\Windows\Dwm" "DWM_Tweaks_Machine"
reg add "HKCU\Software\Microsoft\Windows\Dwm" /v EnableAeroPeek /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\Dwm" /v AlwaysShowThumbnails /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\Dwm" /v ColorPrevalence /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\Dwm" /v EnableBlurBehind /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v ForceEffectMode /t REG_DWORD /d 1 /f
echo.
echo [STATUS] DWM tweaks applied successfully.
pause
goto MENU
