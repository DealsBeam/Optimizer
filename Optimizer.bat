@echo off
chcp 65001 >nul
mode con: cols=80 lines=33

:: PRE-LOADER ANIMATION
set "spinner=|/-\"
cls
echo.
echo                                ╭─────────────────────────────╮
echo                                │  Windows 11 PC Optimizer   │
echo                                ╰─────────────────────────────╯
echo.
set msg=Initializing...
call :spinner "%msg%"
echo                              [ OK ] Initialization Finished!
timeout /t 1 >nul

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo =========================================================
    echo                ADMINISTRATOR RIGHTS REQUIRED
    echo  Run as administrator! Right-click -> "Run as administrator"
    echo =========================================================
    pause
    exit
)

:: MAIN MENU LOOP
:MENU
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    WINDOWS 11 PC OPTIMIZER v3.2            │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Optimize Network        - Lower ping, stability
echo    [2] System Cleaner          - TEMP/cache/update
echo    [3] Extended Cleaner        - Browsers/Explorer cache
echo    [4] Junk Finder             - Deep log/dump removal
echo    [5] Optimize DNS            - Cloudflare + flush
echo    [6] Manage Services         - SysMain, Telemetry, Xbox
echo    [7] Game Mode + GPU Priority- Optimizes for gaming
echo    [8] Advanced Windows Tweaks - Prefetch, RAM, DirectX
echo    [9] Reset Network Adapter
echo    [10] Input Latency Tweaks
echo    [11] Restore From Backup
echo    [12] Create Restore Point
echo    [13] Remove Debloat Apps
echo    [14] DWM Tweaks
echo    [15] App Manager
echo    [0] Exit
echo.
set /p choice="          Select an option: "
if /i "%choice%"=="1" goto ANIM_NET
if /i "%choice%"=="2" goto ANIM_CLEAN
if /i "%choice%"=="3" goto ANIM_CLEANX
if /i "%choice%"=="4" goto ANIM_JUNK
if /i "%choice%"=="5" goto ANIM_DNS
if /i "%choice%"=="6" goto ANIM_SERV
if /i "%choice%"=="7" goto GAMEMODE
if /i "%choice%"=="8" goto ADVANCED_TWEAKS
if /i "%choice%"=="9" goto ANIM_RSTNET
if /i "%choice%"=="10" goto ANIM_INPUT
if /i "%choice%"=="11" goto RESTORE
if /i "%choice%"=="12" goto CREATE_RESTORE_POINT
if /i "%choice%"=="13" goto DEBLOAT
if /i "%choice%"=="14" goto DWM_TWEAKS
if /i "%choice%"=="15" goto APP_MANAGER
if /i "%choice%"=="0" goto EXIT
goto MENU

:: -------- Spinner Animation
:spinner
setlocal enabledelayedexpansion
set "msg=%~1"
for /L %%i in (1,1,30) do (
    set /a idx=%%i %% 4
    set "spinchar=!spinner:~%idx%,1!"
    <nul set /p="                           !msg! !spinchar!`r"
    ping -n 1 127.0.0.1 >nul
)
endlocal
echo.
exit /b

:: -------- Progress Animation
:progress
setlocal enabledelayedexpansion
set "msg=%~1"
echo.
for /L %%i in (1,1,36) do (
    set "bar=["
    for /L %%j in (1,1,%%i) do set "bar=!bar!█"
    for /L %%k in (%%i,1,36) do set "bar=!bar! "
    set "bar=!bar!]"
    <nul set /p="                 !msg! !bar!`r"
    ping -n 1 127.0.0.1 >nul
)
echo.
endlocal
exit /b

:ANIM_NET
cls
call :progress "Optimizing Network"
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set heuristics disabled
netsh int tcp set global rss=enabled
netsh int tcp set global fastopen=enabled
netsh interface tcp set global timestamps=disabled
echo.
echo [STATUS] Network optimization complete!
pause
goto MENU

:ANIM_CLEAN
cls
call :progress "System Clean"
del /q /f /s %TEMP%\* 2>nul
del /q /f /s C:\Windows\Temp\* 2>nul
del /q /f /s C:\Windows\Prefetch\* 2>nul
cleanmgr /sagerun:1
net stop wuauserv 2>nul
del /q /f /s C:\Windows\SoftwareDistribution\Download\* 2>nul
net start wuauserv 2>nul
echo.
echo [STATUS] Junk cleaned.
pause
goto MENU

:ANIM_CLEANX
cls
call :progress "Extended Cleaner"
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*" 2>nul
del /q /f /s "%APPDATA%\Opera Software\Opera Stable\Cache\*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
echo.
echo [STATUS] Browser/Explorer cache cleaned.
pause
goto MENU

:ANIM_JUNK
cls
call :progress "Junk Finder"
del /q /f /s "%SYSTEMDRIVE%\*.log" 2>nul
del /q /f /s "%SYSTEMDRIVE%\*.dmp" 2>nul
del /q /f /s "%SYSTEMDRIVE%\*.bak" 2>nul
del /q /f /s "%SYSTEMDRIVE%\*.old" 2>nul
del /q /f /s "%USERPROFILE%\Downloads\*.tmp" 2>nul
echo.
echo [STATUS] Deep junk removed.
pause
goto MENU

:ANIM_DNS
cls
call :progress "Optimizing DNS"
netsh interface ip set dns "Ethernet" static 1.1.1.1 primary
netsh interface ip add dns "Ethernet" 1.0.0.1 index=2
netsh interface ip set dns "Wi-Fi" static 1.1.1.1 primary
netsh interface ip add dns "Wi-Fi" 1.0.0.1 index=2
ipconfig /flushdns
echo.
echo [STATUS] DNS optimization done.
pause
goto MENU

:ANIM_SERV
cls
call :progress "Service Tuning"
echo [1] Disable unnecessary services (SysMain, Telemetry, Xbox)
echo [2] Restore default state
set /p svch="Choose 1/2 or [Enter] to back: "
if "%svch%"=="1" (
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" "Services_SysMain"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" "Services_DiagTrack"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" "Services_dmwappushservice"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" "Services_XblAuthManager"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" "Services_XblGameSave"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" "Services_XboxNetApiSvc"
    call :BACKUP "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "Services_DataCollection"
    sc config "SysMain" start=disabled & sc stop "SysMain"
    sc config "DiagTrack" start=disabled & sc stop "DiagTrack"
    sc config "dmwappushservice" start=disabled & sc stop "dmwappushservice"
    sc config "XblAuthManager" start=disabled & sc stop "XblAuthManager"
    sc config "XblGameSave" start=disabled & sc stop "XblGameSave"
    sc config "XboxNetApiSvc" start=disabled & sc stop "XboxNetApiSvc"
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    echo.
    echo [STATUS] Services disabled. Restart recommended!
    pause
    goto MENU
)
if "%svch%"=="2" (
    sc config "SysMain" start=auto & sc start "SysMain"
    sc config "DiagTrack" start=auto & sc start "DiagTrack"
    sc config "dmwappushservice" start=manual
    sc config "XblAuthManager" start=demand
    sc config "XblGameSave" start=demand
    sc config "XboxNetApiSvc" start=demand
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f 2>nul
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /f 2>nul
    echo.
    echo [STATUS] Services restored.
    pause
    goto MENU
)
goto MENU

:GAMEMODE
cls
call :progress "Gaming Optimization"
call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Settings" "Gaming_PowerSettings"
call :BACKUP "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Gaming_MultimediaProfile"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "Gaming_BackgroundApps"
:: Enable game mode (if applicable)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Settings" /v GameMode /t REG_DWORD /d 1 /f
:: Boost GPU/CPU/RAM priority for games
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f
:: Disable background apps for performance
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
:: Set power plan to "High performance"
powercfg /setactive SCHEME_MIN
echo.
echo [STATUS] Game Mode, GPU/CPU priority and background apps optimized.
pause
goto MENU

:ADVANCED_TWEAKS
cls
call :progress "Advanced Tweaks"
call :BACKUP "HKLM\SOFTWARE\Microsoft\DirectX" "Advanced_DirectX"
call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "Advanced_MemoryManagement"
:: DirectX/VRAM tweaks, prefetch, priority optimization
reg add "HKLM\SOFTWARE\Microsoft\DirectX" /v EnableAdaptiveSync /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f
:: Disable prefetch/superfetch for SSD performance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f
:: Automatically clear crash dumps
del /q /f /s "%SystemDrive%\Windows\Minidump\*" 2>nul
echo.
echo [STATUS] Advanced Windows tweaks applied.
pause
goto MENU

:ANIM_RSTNET
cls
call :progress "Network Reset"
ipconfig /release
ipconfig /renew
ipconfig /flushdns
netsh winsock reset
netsh int ip reset
netsh interface ipv4 reset
netsh interface ipv6 reset
echo.
echo [STATUS] Network reset done.
pause
goto MENU

:ANIM_INPUT
cls
call :progress "Input Latency"
echo [1] Apply lowest latency
echo [2] Restore defaults
set /p inlat="Choose 1/2 [Enter]-menu: "
if "%inlat%"=="1" (
    call :BACKUP "HKCU\Control Panel\Mouse" "Input_Mouse"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" "Input_MouseParameters"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" "Input_KeyboardParameters"
    reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 20 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 20 /f
    echo.
    echo [STATUS] Input latency tweaks applied. Restart!
    pause
    goto MENU
)
if "%inlat%"=="2" (
    reg delete "HKCU\Control Panel\Mouse" /v MouseSensitivity /f 2>nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseSpeed /f 2>nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold1 /f 2>nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold2 /f 2>nul
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /f 2>nul
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /f 2>nul
    echo.
    echo [STATUS] Input latency values restored.
    pause
    goto MENU
)
goto MENU

:: BACKUP a registry key
:BACKUP
set "key=%~1"
set "desc=%~2"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "filename=%desc%_%timestamp%.reg"
if not exist backups md backups
reg export "%key%" "backups\%filename%" >nul
exit /b

:: RESTORE from backup
:RESTORE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    RESTORE FROM BACKUP                     │
echo            ╰────────────────────────────────────────────╯
echo.
if not exist backups\ (
    echo [ERROR] No backup folder found.
    pause
    goto MENU
)
dir backups\*.reg /b /o:n
echo.
set /p "backupfile=Enter backup name to restore (e.g., Services_...reg): "
if not exist "backups\%backupfile%" (
    echo [ERROR] Backup file not found.
    pause
    goto MENU
)
reg import "backups\%backupfile%"
echo.
echo [STATUS] Restore complete! Restart recommended.
pause
goto MENU

:CREATE_RESTORE_POINT
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    CREATE WINDOWS RESTORE POINT            │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will create a system restore point.
echo [INFO] This may take a few minutes. Please be patient.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Optimizer.bat Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
echo.
echo [STATUS] Restore point created successfully.
pause
goto MENU

:DEBLOAT
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    REMOVE DEBLOAT APPS                     │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will remove pre-installed Microsoft Store apps.
echo [INFO] This action is irreversible without reinstalling Windows.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Removing Debloat Apps"
powershell.exe -ExecutionPolicy Bypass -Command ^
"Get-AppxPackage *3DBuilder* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.BingSports* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.People* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.StorePurchaseApp* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.WindowsCommunicationsApps* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage; ^
 Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage; ^
 Get-AppxPackage *king.com.CandyCrushSaga* | Remove-AppxPackage; ^
 Get-AppxPackage *king.com.CandyCrushSodaSaga* | Remove-AppxPackage"
echo.
echo [STATUS] Debloat apps removed successfully.
pause
goto MENU

:DWM_TWEAKS
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

:APP_MANAGER
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    APP MANAGER (WINGET)                    │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] List Installed Apps
echo    [2] Uninstall an App
echo    [0] Back to Main Menu
echo.
set /p app_choice="          Select an option: "
if /i "%app_choice%"=="1" goto LIST_APPS
if /i "%app_choice%"=="2" goto UNINSTALL_APP
if /i "%app_choice%"=="0" goto MENU
goto APP_MANAGER

:LIST_APPS
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    LIST INSTALLED APPS                     │
echo            ╰────────────────────────────────────────────╯
echo.
call :progress "Gathering list of installed apps"
winget list
echo.
echo [STATUS] App list generated.
pause
goto APP_MANAGER

:UNINSTALL_APP
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    UNINSTALL AN APP                        │
echo            ╰────────────────────────────────────────────╯
echo.
set /p "app_name=Enter the name of the app to uninstall: "
if "%app_name%"=="" goto APP_MANAGER
call :progress "Uninstalling %app_name%"
winget uninstall %app_name%
echo.
echo [STATUS] Uninstallation of %app_name% complete.
pause
goto APP_MANAGER

:EXIT
cls
echo.
echo                        [ Thank you for using! ]
echo      If you tweaked settings, please restart your computer.
echo.
pause
exit
