@echo off
:: Suppress command echoing to keep the output clean.

:: Set the code page to UTF-8 to support a wide range of characters.
chcp 65001 >nul

:: Set a consistent window size for better presentation.
mode con: cols=80 lines=40

:: Elevate to Administrator privileges if not already running with them.
:: This is a more robust way to check and request elevation.
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    powershell.exe -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:: =============================================================================
:: PRE-LOADER ANIMATION & INITIALIZATION
:: =============================================================================
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

:: =============================================================================
:: MAIN MENU
:: =============================================================================
:MENU
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    WINDOWS 11 PC OPTIMIZER v8.0 (Revised)  │
echo            ╰────────────────────────────────────────────╯
echo.
echo    SYSTEM & NETWORK
echo    [1] Network Optimization    - Lower ping, better stability
echo    [2] DNS Optimization        - Set to Cloudflare DNS, flush cache
echo    [3] Network Reset           - Reset network adapter & stack
echo    [4] Service Management      - Disable unnecessary services
echo    [5] Input Latency Tweaks    - Optimize mouse and keyboard response
echo    [6] Gaming Optimization     - Boost GPU priority, disable background apps
echo    [7] Advanced System Tweaks  - Prefetch, RAM, DirectX tweaks
echo    [8] Power Plan Management   - Activate Ultimate Performance
echo.
echo    CLEANING & DEBLOAT
echo    [9] System Cleaner          - Clean TEMP, cache, and update files
echo    [10] Extended Cleaner        - Clean browser and Explorer caches
echo    [11] Junk Finder             - Deep scan for logs and dumps
echo    [12] Simple Debloater        - Remove common pre-installed apps
echo    [13] Advanced Debloater      - Choose which apps to uninstall
echo    [14] Uninstall Edge & OneDrive
echo    [15] Scheduled Cleaning      - Automate weekly system cleaning
echo.
echo    MANAGEMENT & CUSTOMIZATION
echo    [16] App Manager             - List and uninstall installed apps
echo    [17] Startup Manager         - Manage programs that run at startup
echo    [18] Windows Features        - Enable or disable optional features
echo    [19] Context Menu Editor     - Add/remove useful context menu items
echo    [20] UI & Personalization    - Tweak dark mode, visual effects, etc.
echo    [21] Taskbar Customization   - Adjust taskbar alignment and behavior
echo    [22] DWM Tweaks              - Reduce Desktop Window Manager usage
echo.
echo    SYSTEM & SAFETY
echo    [23] System Information      - View hardware and OS details
echo    [24] Advanced Privacy        - Disable telemetry and block hosts
echo    [25] Create Restore Point    - Create a system restore point
echo    [26] Restore Center          - Restore backups of registry/hosts
echo    [0] Exit
echo.
set /p choice="          Select an option: "
if /i "%choice%"=="1" goto ANIM_NET
if /i "%choice%"=="2" goto ANIM_DNS
if /i "%choice%"=="3" goto ANIM_RSTNET
if /i "%choice%"=="4" goto ANIM_SERV
if /i "%choice%"=="5" goto ANIM_INPUT
if /i "%choice%"=="6" goto GAMEMODE
if /i "%choice%"=="7" goto ADVANCED_TWEAKS
if /i "%choice%"=="8" goto ULTIMATE_PERFORMANCE
if /i "%choice%"=="9" goto ANIM_CLEAN
if /i "%choice%"=="10" goto ANIM_CLEANX
if /i "%choice%"=="11" goto ANIM_JUNK
if /i "%choice%"=="12" goto DEBLOAT_SIMPLE
if /i "%choice%"=="13" goto ADVANCED_DEBLOATER
if /i "%choice%"=="14" goto UNINSTALL_EDGE_ONEDRIVE
if /i "%choice%"=="15" goto SCHEDULED_CLEANING
if /i "%choice%"=="16" goto APP_MANAGER
if /i "%choice%"=="17" goto STARTUP_MANAGER
if /i "%choice%"=="18" goto WINDOWS_FEATURES_MANAGER
if /i "%choice%"=="19" goto CONTEXT_MENU_EDITOR
if /i "%choice%"=="20" goto UI_PERSONALIZATION
if /i "%choice%"=="21" goto TASKBAR_CUSTOMIZATION
if /i "%choice%"=="22" goto DWM_TWEAKS
if /i "%choice%"=="23" goto SYSTEM_INFORMATION
if /i "%choice%"=="24" goto PRIVACY
if /i "%choice%"=="25" goto CREATE_RESTORE_POINT
if /i "%choice%"=="26" goto RESTORE_CENTER
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
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    SYSTEM CLEANER                          │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will clean temporary files, caches, and update leftovers.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Running System Cleaner"

:: Safely clean user and system temporary folders
if exist "%TEMP%" ( del /q /f /s "%TEMP%\*" 2>nul )
if exist "%SystemRoot%\Temp" ( del /q /f /s "%SystemRoot%\Temp\*" 2>nul )

:: Clean Prefetch files (can help with some performance issues)
if exist "%SystemRoot%\Prefetch" ( del /q /f /s "%SystemRoot%\Prefetch\*" 2>nul )

:: Run Windows Disk Cleanup in a non-interactive mode
cleanmgr /sagerun:1

:: Stop the Windows Update service to safely clear its download cache
net stop wuauserv >nul 2>&1
if exist "%SystemRoot%\SoftwareDistribution\Download" ( del /q /f /s "%SystemRoot%\SoftwareDistribution\Download\*" 2>nul )
net start wuauserv >nul 2>&1

echo.
echo [SUCCESS] System cleaning tasks completed.
pause
goto MENU

:ANIM_CLEANX
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    EXTENDED CLEANER                        │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will clean caches for major browsers and Windows Explorer.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Running Extended Cleaner"

:: Clean browser caches
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" ( del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*" 2>nul )
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" ( del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*" 2>nul )
if exist "%APPDATA%\Opera Software\Opera Stable\Cache" ( del /q /f /s "%APPDATA%\Opera Software\Opera Stable\Cache\*" 2>nul )

:: Clean Windows Explorer thumbnail cache
if exist "%LOCALAPPDATA%\Microsoft\Windows\Explorer" ( del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul )

echo.
echo [SUCCESS] Browser and Explorer caches have been cleared.
pause
goto MENU

:ANIM_JUNK
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    JUNK FINDER                             │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will perform a deep scan for junk files like logs and memory dumps.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Scanning for Junk Files"

:: Use where command to safely find and delete junk files
where /r "%SystemDrive%\" *.log *.dmp *.bak *.old *.tmp > junk_files.txt
for /f "delims=" %%i in (junk_files.txt) do (
    echo Deleting %%i
    del "%%i"
)
del junk_files.txt

echo.
echo [SUCCESS] Deep junk file scan and removal completed.
pause
goto MENU

:ANIM_DNS
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    DNS OPTIMIZATION                        │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will set your DNS to Cloudflare's public DNS (1.1.1.1).
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Optimizing DNS Settings"

:: Set DNS for all active network adapters
for /f "tokens=*" %%a in ('powershell -Command "Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'} | ForEach-Object { $_.Name }"') do (
    echo Applying DNS settings to "%%a"...
    netsh interface ip set dns "%%a" static 1.1.1.1 primary >nul
    netsh interface ip add dns "%%a" 1.0.0.1 index=2 >nul
)

:: Flush the DNS cache to apply changes immediately
ipconfig /flushdns

echo.
echo [SUCCESS] DNS settings have been optimized.
pause
goto MENU

:ANIM_SERV
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    SERVICE MANAGEMENT                      │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Disable Unnecessary Services (SysMain, Telemetry, Xbox)
echo    [2] Restore Default Services
echo    [0] Back to Main Menu
echo.
set /p "svch=Select an option: "
if "%svch%"=="1" (
    call :progress "Disabling Services"
    set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "backup_group=%timestamp%_Service_Tweaks"

    :: Backup and disable services, checking for errors at each step.
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" "Services_SysMain" "%backup_group%"
    sc config "SysMain" start=disabled >nul & sc stop "SysMain" >nul
    if errorlevel 1 (echo [WARNING] Could not modify SysMain service.)

    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" "Services_DiagTrack" "%backup_group%"
    sc config "DiagTrack" start=disabled >nul & sc stop "DiagTrack" >nul
    if errorlevel 1 (echo [WARNING] Could not modify DiagTrack service.)

    call :BACKUP "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "Services_DataCollection" "%backup_group%"
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
    if errorlevel 1 (echo [WARNING] Could not set Telemetry policy.)

    echo.
    echo [SUCCESS] Services have been disabled. A system restart is recommended to apply all changes.
    pause
    goto MENU
)
if "%svch%"=="2" (
    call :progress "Restoring Services"
    sc config "SysMain" start=auto >nul & sc start "SysMain" >nul
    sc config "DiagTrack" start=auto >nul & sc start "DiagTrack" >nul
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul
    echo.
    echo [SUCCESS] Default service configurations have been restored. A system restart is recommended.
    pause
    goto MENU
)
if "%svch%"=="0" goto MENU
goto ANIM_SERV

:GAMEMODE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    GAMING OPTIMIZATION                     │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will apply various tweaks to improve gaming performance.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Applying Gaming Optimizations"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_Gaming_Tweaks"

:: Backup registry keys before modification
call :BACKUP "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Gaming_MultimediaProfile" "%backup_group%"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "Gaming_BackgroundApps" "%backup_group%"

:: Boost GPU and CPU priority for games
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul

:: Disable background apps to free up resources
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul

echo.
echo [SUCCESS] Gaming optimizations have been applied.
pause
goto MENU

:ADVANCED_TWEAKS
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    ADVANCED SYSTEM TWEAKS                  │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will apply advanced tweaks for memory management and performance.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Applying Advanced Tweaks"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_Advanced_Tweaks"

:: Backup registry keys before modification
call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "Advanced_MemoryManagement" "%backup_group%"

:: Enable Large System Cache for better performance on systems with more RAM
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul

:: Disable Prefetch and Superfetch, which can improve performance on SSDs
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul

:: Automatically clear crash dumps
if exist "%SystemRoot%\Minidump" ( del /q /f /s "%SystemRoot%\Minidump\*" 2>nul )

echo.
echo [SUCCESS] Advanced system tweaks have been applied. A restart is recommended.
pause
goto MENU

:ANIM_RSTNET
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    NETWORK RESET                           │
echo            ╰────────────────────────────────────────────╯
echo.
echo [WARNING] This will reset your network configuration and may require a restart.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Resetting Network Stack"

ipconfig /release >nul
ipconfig /renew >nul
ipconfig /flushdns
netsh winsock reset
netsh int ip reset

echo.
echo [SUCCESS] Network stack has been reset. Please restart your computer.
pause
goto MENU

:ANIM_INPUT
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    INPUT LATENCY TWEAKS                    │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Apply Low Latency Tweaks
echo    [2] Restore Default Latency
echo    [0] Back to Main Menu
echo.
set /p "inlat=Select an option: "
if "%inlat%"=="1" (
    call :progress "Applying Low Latency Tweaks"
    set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "backup_group=%timestamp%_Input_Latency"
    call :BACKUP "HKCU\Control Panel\Mouse" "Input_Mouse" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" "Input_MouseParameters" "%backup_group%"

    :: Disable mouse acceleration
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul

    echo.
    echo [SUCCESS] Input latency tweaks have been applied. A restart is recommended.
    pause
    goto MENU
)
if "%inlat%"=="2" (
    call :progress "Restoring Default Latency"
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f >nul
    echo.
    echo [SUCCESS] Default input latency settings have been restored. A restart is recommended.
    pause
    goto MENU
)
if "%inlat%"=="0" goto MENU
goto ANIM_INPUT

:: BACKUP a registry key. Creates a backup set in a timestamped folder.
:BACKUP
set "key_path=%~1"
set "backup_name=%~2"
set "group_folder=%~3"
set "backup_dir=backups\%group_folder%"
if not exist "%backup_dir%" md "%backup_dir%"
reg export "%key_path%" "%backup_dir%\%backup_name%.reg" >nul
exit /b

:RESTORE_CENTER
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    RESTORE CENTER                          │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Restore Registry from Backup Set
echo    [2] Restore Hosts File
echo    [0] Back to Main Menu
echo.
set /p "restore_choice=Select a restore option: "
if /i "%restore_choice%"=="1" goto RESTORE_REGISTRY
if /i "%restore_choice%"=="2" goto RESTORE_HOSTS
if /i "%restore_choice%"=="0" goto MENU
goto RESTORE_CENTER

:RESTORE_REGISTRY
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    RESTORE REGISTRY FROM BACKUP SET        │
echo            ╰────────────────────────────────────────────╯
echo.
if not exist backups\ (
    echo [ERROR] No backup folder found.
    pause
    goto RESTORE_CENTER
)
setlocal enabledelayedexpansion
set /a i=0
echo --- Available Backup Sets ---
for /d %%d in (backups\*) do (
    set /a i+=1
    echo [!i!] %%~nd
    set "backupfolder[!i!]=%%d"
)
if %i% equ 0 (
    echo [ERROR] No backup sets found.
    pause
    goto RESTORE_CENTER
)
echo.
set /p "choice=Select a backup set to restore (1-%i%): "
if %choice% gtr 0 if %choice% leq %i% (
    set "folder_to_restore=!backupfolder[%choice%]!"
    echo [INFO] Restoring from !folder_to_restore!...
    for %%f in ("!folder_to_restore!\*.reg") do (
        echo      - Importing %%~nxf
        reg import "%%f"
    )
    echo.
    echo [STATUS] Restore complete! Restart recommended.
) else (
    echo [ERROR] Invalid selection.
)
endlocal
pause
goto RESTORE_CENTER

:RESTORE_HOSTS
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    RESTORE HOSTS FILE                      │
echo            ╰────────────────────────────────────────────╯
echo.
if not exist %windir%\System32\drivers\etc\hosts.bak (
    echo [ERROR] No hosts file backup found.
    pause
    goto RESTORE_CENTER
)
copy %windir%\System32\drivers\etc\hosts.bak %windir%\System32\drivers\etc\hosts /Y >nul
echo [STATUS] Hosts file has been restored from backup.
pause
goto RESTORE_CENTER

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

:DEBLOAT_SIMPLE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    SIMPLE DEBLOATER                        │
echo            ╰────────────────────────────────────────────╯
echo.
echo [WARNING] This will remove a predefined list of common bloatware.
echo [INFO] This action is irreversible without reinstalling the apps from the Microsoft Store.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Removing Bloatware Apps"
powershell.exe -ExecutionPolicy Bypass -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage; Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage; Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage; Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage; Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage; Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage; Get-AppxPackage *Microsoft.People* | Remove-AppxPackage; Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage; Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage; Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage; Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage; Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage; Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage;"
if errorlevel 1 (
    echo [ERROR] Failed to remove one or more bloatware apps.
) else (
    echo [SUCCESS] Common bloatware apps have been removed.
)
pause
goto MENU

:DWM_TWEAKS
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    DWM TWEAKS                              │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will apply tweaks to reduce DWM resource usage.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Applying DWM Tweaks"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_DWM_Tweaks"
call :BACKUP "HKCU\Software\Microsoft\Windows\Dwm" "DWM_Tweaks_User" "%backup_group%"
call :BACKUP "HKLM\SOFTWARE\Microsoft\Windows\Dwm" "DWM_Tweaks_Machine" "%backup_group%"
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
echo            │    APP MANAGER                             │
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

:PRIVACY
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    ADVANCED PRIVACY                        │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Apply Privacy Settings (Telemetry, Hosts File)
echo    [2] Restore Default Privacy Settings
echo    [0] Back to Main Menu
echo.
set /p "privacy_choice=Select an option: "
if /i "%privacy_choice%"=="1" (
    call :progress "Applying Privacy Settings"

    :: Backup the hosts file if a backup doesn't already exist
    if not exist "%SystemRoot%\System32\drivers\etc\hosts.bak" (
        copy "%SystemRoot%\System32\drivers\etc\hosts" "%SystemRoot%\System32\drivers\etc\hosts.bak" >nul
    )

    :: Add telemetry domains to hosts file to block them, only if they aren't already present
    findstr /c:"vortex.data.microsoft.com" "%SystemRoot%\System32\drivers\etc\hosts" >nul || (
        echo.>>"%SystemRoot%\System32\drivers\etc\hosts"
        echo # Block Microsoft Telemetry>>"%SystemRoot%\System32\drivers\etc\hosts"
        echo 0.0.0.0 vortex.data.microsoft.com>>"%SystemRoot%\System32\drivers\etc\hosts"
    )

    :: Disable telemetry-related scheduled tasks
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul

    echo.
    echo [SUCCESS] Privacy settings have been applied.
    pause
    goto MENU
)
if /i "%privacy_choice%"=="2" (
    call :RESTORE_HOSTS
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable >nul
    echo.
    echo [SUCCESS] Default privacy settings have been restored.
    pause
    goto MENU
)
if /i "%privacy_choice%"=="0" goto MENU
goto PRIVACY

:UNINSTALL_EDGE_ONEDRIVE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    UNINSTALL EDGE & ONEDRIVE               │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Uninstall Microsoft Edge
echo    [2] Uninstall OneDrive
echo    [0] Back to Main Menu
echo.
set /p "uninstall_choice=Select an option: "
if /i "%uninstall_choice%"=="1" goto UNINSTALL_EDGE
if /i "%uninstall_choice%"=="2" goto UNINSTALL_ONEDRIVE
if /i "%uninstall_choice%"=="0" goto MENU
goto UNINSTALL_EDGE_ONEDRIVE

:UNINSTALL_EDGE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    UNINSTALL MICROSOFT EDGE                │
echo            ╰────────────────────────────────────────────╯
echo.
echo [WARNING] This is an advanced and potentially unstable operation.
echo [WARNING] Removing Edge may cause unforeseen issues with some Windows features.
echo.
set /p "confirm=Are you absolutely sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Attempting to Uninstall Microsoft Edge"
powershell.exe -ExecutionPolicy Bypass -Command "& {
    $path = (Get-AppxPackage -Name Microsoft.MicrosoftEdge).InstallLocation
    if ($path) {
        $setup = Get-ChildItem -Path $path -Filter setup.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($setup) {
            Start-Process -FilePath $setup.FullName -ArgumentList '--uninstall --system-level --verbose-logging --force-uninstall' -Wait
            Write-Host '[SUCCESS] Microsoft Edge has been uninstalled.'
        } else {
            Write-Host '[ERROR] Could not find the Edge installer.'
        }
    } else {
        Write-Host '[ERROR] Could not find Microsoft Edge installation path.'
    }
}"
pause
goto MENU

:UNINSTALL_ONEDRIVE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    UNINSTALL ONEDRIVE                      │
echo            ╰────────────────────────────────────────────╯
echo.
echo [WARNING] This will completely remove OneDrive from your system.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Uninstalling OneDrive"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_OneDrive_Uninstall"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace" "OneDrive_Desktop_Namespace" "%backup_group%"
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul
echo.
echo [STATUS] OneDrive has been uninstalled.
pause
goto MENU

:STARTUP_MANAGER
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    STARTUP MANAGER                         │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] List Startup Programs
echo    [2] Remove a Startup Program
echo    [0] Back to Main Menu
echo.
set /p "startup_choice=Select an option: "
if /i "%startup_choice%"=="1" goto LIST_STARTUP
if /i "%startup_choice%"=="2" goto REMOVE_STARTUP
if /i "%startup_choice%"=="0" goto MENU
goto STARTUP_MANAGER

:LIST_STARTUP
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    LIST STARTUP PROGRAMS                   │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] The following programs are configured to run at startup.
echo.
echo --- For Current User ---
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
echo.
echo --- For All Users ---
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
echo.
pause
goto STARTUP_MANAGER

:REMOVE_STARTUP
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    REMOVE A STARTUP PROGRAM                │
echo            ╰────────────────────────────────────────────╯
echo.
set /p "startup_name=Enter the exact name of the startup value to remove: "
if "%startup_name%"=="" goto STARTUP_MANAGER

set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_Startup_Manager"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "Startup_Run_User" "%backup_group%"
call :BACKUP "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "Startup_Run_Machine" "%backup_group%"

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%startup_name%" /f >nul 2>nul
if not errorlevel 1 (
    echo [SUCCESS] Removed "%startup_name%" from current user startup.
) else (
    reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "%startup_name%" /f >nul 2>nul
    if not errorlevel 1 (
        echo [SUCCESS] Removed "%startup_name%" from all users startup.
    ) else (
        echo [ERROR] Could not find or remove a startup entry named "%startup_name%".
    )
)
pause
goto STARTUP_MANAGER

:CONTEXT_MENU_EDITOR
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    CONTEXT MENU EDITOR                     │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Add 'Copy To'/'Move To'
echo    [2] Remove 'Copy To'/'Move To'
echo    [3] Add 'Take Ownership'
echo    [4] Remove 'Take Ownership'
echo    [0] Back to Main Menu
echo.
set /p "context_choice=Select an option: "
if /i "%context_choice%"=="1" goto ADD_COPY_MOVE
if /i "%context_choice%"=="2" goto REMOVE_COPY_MOVE
if /i "%context_choice%"=="3" goto ADD_TAKE_OWNERSHIP
if /i "%context_choice%"=="4" goto REMOVE_TAKE_OWNERSHIP
if /i "%context_choice%"=="0" goto MENU
goto CONTEXT_MENU_EDITOR

:ADD_COPY_MOVE
cls
call :progress "Adding 'Copy To'/'Move To'"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_ContextMenu_CopyMove"
call :BACKUP "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\CopyTo" "ContextMenu_CopyTo" "%backup_group%"
call :BACKUP "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\MoveTo" "ContextMenu_MoveTo" "%backup_group%"
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\CopyTo" /ve /d "{C2FBB630-2971-11D1-A18C-00C04FD75D13}" /f >nul
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\MoveTo" /ve /d "{C2FBB631-2971-11D1-A18C-00C04FD75D13}" /f >nul
echo.
echo [STATUS] 'Copy To'/'Move To' added to the context menu.
pause
goto CONTEXT_MENU_EDITOR

:REMOVE_COPY_MOVE
cls
call :progress "Removing 'Copy To'/'Move To'"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_ContextMenu_CopyMove_Removal"
call :BACKUP "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\CopyTo" "ContextMenu_CopyTo_Removal" "%backup_group%"
call :BACKUP "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\MoveTo" "ContextMenu_MoveTo_Removal" "%backup_group%"
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\CopyTo" /f >nul
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\MoveTo" /f >nul
echo.
echo [STATUS] 'Copy To'/'Move To' removed from the context menu.
pause
goto CONTEXT_MENU_EDITOR

:ADD_TAKE_OWNERSHIP
cls
call :progress "Adding 'Take Ownership'"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_ContextMenu_TakeOwnership"
call :BACKUP "HKCR\*\shell\runas" "ContextMenu_TakeOwnershipFile" "%backup_group%"
call :BACKUP "HKCR\Directory\shell\runas" "ContextMenu_TakeOwnershipDir" "%backup_group%"
reg add "HKCR\*\shell\runas" /ve /d "Take Ownership" /f >nul
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >nul
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F" /f >nul
reg add "HKCR\Directory\shell\runas" /ve /d "Take Ownership" /f >nul
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >nul
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t" /f >nul
echo.
echo [STATUS] 'Take Ownership' added to the context menu.
pause
goto CONTEXT_MENU_EDITOR

:REMOVE_TAKE_OWNERSHIP
cls
call :progress "Removing 'Take Ownership'"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_ContextMenu_TakeOwnership_Removal"
call :BACKUP "HKCR\*\shell\runas" "ContextMenu_TakeOwnershipFile_Removal" "%backup_group%"
call :BACKUP "HKCR\Directory\shell\runas" "ContextMenu_TakeOwnershipDir_Removal" "%backup_group%"
reg delete "HKCR\*\shell\runas" /f >nul
reg delete "HKCR\Directory\shell\runas" /f >nul
echo.
echo [STATUS] 'Take Ownership' removed from the context menu.
pause
goto CONTEXT_MENU_EDITOR

:UI_PERSONALIZATION
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    UI & PERSONALIZATION                    │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Enable System-Wide Dark Mode
echo    [2] Restore Default Light Mode
echo    [3] Disable Visual Effects for Performance
echo    [4] Restore Default Visual Effects
echo    [5] Enable Classic (Windows 10) Context Menu
echo    [6] Restore Default (Windows 11) Context Menu
echo    [0] Back to Main Menu
echo.
set /p "ui_choice=Select an option: "
if /i "%ui_choice%"=="1" goto ENABLE_DARK_MODE
if /i "%ui_choice%"=="2" goto DISABLE_DARK_MODE
if /i "%ui_choice%"=="3" goto DISABLE_VISUAL_EFFECTS
if /i "%ui_choice%"=="4" goto RESTORE_VISUAL_EFFECTS
if /i "%ui_choice%"=="5" goto RESTORE_CLASSIC_CONTEXT_MENU
if /i "%ui_choice%"=="6" goto RESTORE_DEFAULT_CONTEXT_MENU
if /i "%ui_choice%"=="0" goto MENU
goto UI_PERSONALIZATION

:ENABLE_DARK_MODE
cls
call :progress "Enabling Dark Mode"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_DarkMode"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "DarkMode" "%backup_group%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
echo.
echo [SUCCESS] System-wide dark mode has been enabled.
pause
goto UI_PERSONALIZATION

:DISABLE_DARK_MODE
cls
call :progress "Restoring Light Mode"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul
echo.
echo [SUCCESS] System-wide light mode has been restored.
pause
goto UI_PERSONALIZATION

:DISABLE_VISUAL_EFFECTS
cls
call :progress "Disabling Visual Effects"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_VisualEffects"
call :BACKUP "HKCU\Control Panel\Desktop" "VisualEffects_Desktop" "%backup_group%"
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
echo.
echo [SUCCESS] Visual effects have been disabled for performance. A restart is recommended.
pause
goto UI_PERSONALIZATION

:RESTORE_VISUAL_EFFECTS
cls
call :progress "Restoring Visual Effects"
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9E2E078012000000 /f >nul
echo.
echo [SUCCESS] Default visual effects have been restored. A restart is recommended.
pause
goto UI_PERSONALIZATION

:RESTORE_CLASSIC_CONTEXT_MENU
cls
call :progress "Enabling Classic Context Menu"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_ClassicContextMenu"
call :BACKUP "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" "ClassicContextMenu" "%backup_group%"
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f >nul
echo.
echo [SUCCESS] Classic context menu has been enabled. Please restart Explorer.
pause
goto UI_PERSONALIZATION

:RESTORE_DEFAULT_CONTEXT_MENU
cls
call :progress "Restoring Default Context Menu"
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul
echo.
echo [SUCCESS] Default context menu has been restored. Please restart Explorer.
pause
goto UI_PERSONALIZATION

:TASKBAR_CUSTOMIZATION
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    TASKBAR CUSTOMIZATION                   │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Align Taskbar to Left (Windows 10 Style)
echo    [2] Restore Taskbar Center Alignment (Windows 11 Style)
echo    [3] Add 'End Task' to Taskbar Context Menu
echo    [4] Remove 'End Task' from Taskbar Context Menu
echo    [0] Back to Main Menu
echo.
set /p "taskbar_choice=Select an option: "
if /i "%taskbar_choice%"=="1" goto ALIGN_TASKBAR_LEFT
if /i "%taskbar_choice%"=="2" goto RESTORE_TASKBAR_CENTER
if /i "%taskbar_choice%"=="3" goto ADD_END_TASK
if /i "%taskbar_choice%"=="4" goto REMOVE_END_TASK
if /i "%taskbar_choice%"=="0" goto MENU
goto TASKBAR_CUSTOMIZATION

:ALIGN_TASKBAR_LEFT
cls
call :progress "Aligning Taskbar to Left"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_TaskbarAlign"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAlign" "%backup_group%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul
echo.
echo [SUCCESS] Taskbar aligned to the left. A restart of Explorer may be needed.
pause
goto TASKBAR_CUSTOMIZATION

:RESTORE_TASKBAR_CENTER
cls
call :progress "Restoring Taskbar Center Alignment"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f >nul
echo.
echo [SUCCESS] Taskbar alignment restored to center. A restart of Explorer may be needed.
pause
goto TASKBAR_CUSTOMIZATION

:ADD_END_TASK
cls
call :progress "Adding 'End Task' to Taskbar"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_EndTask"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "EndTask" "%backup_group%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul
echo.
echo [SUCCESS] 'End Task' has been added to the taskbar context menu. A restart is recommended.
pause
goto TASKBAR_CUSTOMIZATION

:REMOVE_END_TASK
cls
call :progress "Removing 'End Task' from Taskbar"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarEndTask /t REG_DWORD /d 0 /f >nul
echo.
echo [SUCCESS] 'End Task' has been removed from the taskbar context menu. A restart is recommended.
pause
goto TASKBAR_CUSTOMIZATION

:SCHEDULED_CLEANING
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    SCHEDULED CLEANING MANAGER              │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Create Weekly Cleaning Tasks
echo    [2] Remove Weekly Cleaning Tasks
echo    [0] Back to Main Menu
echo.
set /p "cleaning_choice=Select an option: "
if /i "%cleaning_choice%"=="1" goto CREATE_CLEANING_TASKS
if /i "%cleaning_choice%"=="2" goto REMOVE_CLEANING_TASKS
if /i "%cleaning_choice%"=="0" goto MENU
goto SCHEDULED_CLEANING

:CREATE_CLEANING_TASKS
cls
call :progress "Creating Weekly Cleaning Tasks"
schtasks /create /tn "Optimizer Temp Clean" /tr "cmd.exe /c del /q /f /s %TEMP%\*" /sc weekly /d SUN /st 12:00 /ru "System" >nul
if errorlevel 1 (echo [ERROR] Failed to create TEMP cleaning task.)
schtasks /create /tn "Optimizer Update Cache Clean" /tr "cmd.exe /c del /q /f /s %SystemRoot%\SoftwareDistribution\Download\*" /sc weekly /d SUN /st 12:05 /ru "System" >nul
if errorlevel 1 (echo [ERROR] Failed to create Update Cache cleaning task.)
echo.
echo [SUCCESS] Weekly cleaning tasks have been created.
pause
goto SCHEDULED_CLEANING

:REMOVE_CLEANING_TASKS
cls
call :progress "Removing Weekly Cleaning Tasks"
schtasks /delete /tn "Optimizer Temp Clean" /f >nul
schtasks /delete /tn "Optimizer Update Cache Clean" /f >nul
echo.
echo [SUCCESS] Weekly cleaning tasks have been removed.
pause
goto SCHEDULED_CLEANING

:ULTIMATE_PERFORMANCE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    POWER PLAN MANAGEMENT                   │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Activate Ultimate Performance Power Plan
echo    [2] Restore Balanced Power Plan
echo    [0] Back to Main Menu
echo.
set /p "power_choice=Select an option: "
if /i "%power_choice%"=="1" goto ACTIVATE_ULTIMATE_PERFORMANCE
if /i "%power_choice%"=="2" goto RESTORE_BALANCED_POWER_PLAN
if /i "%power_choice%"=="0" goto MENU
goto ULTIMATE_PERFORMANCE

:ACTIVATE_ULTIMATE_PERFORMANCE
cls
call :progress "Activating Ultimate Performance"
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
if errorlevel 1 (
    echo [ERROR] Failed to activate the Ultimate Performance power plan.
) else (
    echo [SUCCESS] Ultimate Performance power plan has been activated.
)
pause
goto ULTIMATE_PERFORMANCE

:RESTORE_BALANCED_POWER_PLAN
cls
call :progress "Restoring Balanced Power Plan"
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
if errorlevel 1 (
    echo [ERROR] Failed to restore the Balanced power plan.
) else (
    echo [SUCCESS] Balanced power plan has been restored.
)
pause
goto ULTIMATE_PERFORMANCE

:SYSTEM_INFORMATION
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    SYSTEM INFORMATION                      │
echo            ╰────────────────────────────────────────────╯
echo.
call :progress "Gathering System Information"
powershell.exe -ExecutionPolicy Bypass -Command "Get-ComputerInfo | Format-List -Property OsName, OsVersion, CsManufacturer, CsModel, CsProcessors, 'PhysiscalMemorySize', OsLastBootUpTime"
echo.
echo [SUCCESS] System information gathered.
pause
goto MENU

:ADVANCED_DEBLOATER
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    ADVANCED DEBLOATER                      │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will list all removable Microsoft Store apps.
echo [INFO] You can select which apps to uninstall.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Gathering list of removable apps"
powershell.exe -ExecutionPolicy Bypass -Command "& {
    $apps = Get-AppxPackage | Where-Object {$_.IsFramework -eq $false -and $_.NonRemovable -eq $false}
    $i = 1
    $apps | ForEach-Object {
        Write-Host "[$i] $($_.Name)"
        $i++
    }
}"
echo.
set /p "app_numbers=Enter the numbers of the apps to uninstall (e.g., 1,5,10): "
powershell.exe -ExecutionPolicy Bypass -Command "& {
    $apps = Get-AppxPackage | Where-Object {$_.IsFramework -eq $false -and $_.NonRemovable -eq $false}
    $selection = '%app_numbers%'.Split(',') | ForEach-Object { $apps[$_.Trim() - 1] }
    $selection | ForEach-Object {
        Write-Host "Uninstalling $($_.Name)..."
        Remove-AppxPackage -Package $_.PackageFullName
    }
}"
echo.
echo [STATUS] Selected apps have been uninstalled.
pause
goto MENU

:WINDOWS_FEATURES_MANAGER
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    WINDOWS FEATURES MANAGER                │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Enable Windows Subsystem for Linux (WSL)
echo    [2] Disable Windows Subsystem for Linux (WSL)
echo    [3] Enable Hyper-V
echo    [4] Disable Hyper-V
echo    [5] Enable Telnet Client
echo    [6] Disable Telnet Client
echo    [0] Back to Main Menu
echo.
set /p "feature_choice=Select an option: "
if /i "%feature_choice%"=="1" goto ENABLE_WSL
if /i "%feature_choice%"=="2" goto DISABLE_WSL
if /i "%feature_choice%"=="3" goto ENABLE_HYPERV
if /i "%feature_choice%"=="4" goto DISABLE_HYPERV
if /i "%feature_choice%"=="5" goto ENABLE_TELNET
if /i "%feature_choice%"=="6" goto DISABLE_TELNET
if /i "%feature_choice%"=="0" goto MENU
goto WINDOWS_FEATURES_MANAGER

:ENABLE_WSL
cls
call :progress "Enabling WSL"
dism /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart >nul
if errorlevel 1 (echo [ERROR] Failed to enable WSL.) else (echo [SUCCESS] WSL has been enabled. A restart is required.)
pause
goto WINDOWS_FEATURES_MANAGER

:DISABLE_WSL
cls
call :progress "Disabling WSL"
dism /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart >nul
if errorlevel 1 (echo [ERROR] Failed to disable WSL.) else (echo [SUCCESS] WSL has been disabled. A restart is required.)
pause
goto WINDOWS_FEATURES_MANAGER

:ENABLE_HYPERV
cls
call :progress "Enabling Hyper-V"
dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart >nul
if errorlevel 1 (echo [ERROR] Failed to enable Hyper-V.) else (echo [SUCCESS] Hyper-V has been enabled. A restart is required.)
pause
goto WINDOWS_FEATURES_MANAGER

:DISABLE_HYPERV
cls
call :progress "Disabling Hyper-V"
dism /online /disable-feature /featurename:Microsoft-Hyper-V-All /norestart >nul
if errorlevel 1 (echo [ERROR] Failed to disable Hyper-V.) else (echo [SUCCESS] Hyper-V has been disabled. A restart is required.)
pause
goto WINDOWS_FEATURES_MANAGER

:ENABLE_TELNET
cls
call :progress "Enabling Telnet Client"
dism /online /enable-feature /featurename:TelnetClient /all /norestart >nul
if errorlevel 1 (echo [ERROR] Failed to enable Telnet Client.) else (echo [SUCCESS] Telnet Client has been enabled.)
pause
goto WINDOWS_FEATURES_MANAGER

:DISABLE_TELNET
cls
call :progress "Disabling Telnet Client"
dism /online /disable-feature /featurename:TelnetClient /norestart >nul
if errorlevel 1 (echo [ERROR] Failed to disable Telnet Client.) else (echo [SUCCESS] Telnet Client has been disabled.)
pause
goto WINDOWS_FEATURES_MANAGER

:EXIT
cls
echo.
echo                        [ Thank you for using! ]
echo      If you tweaked settings, please restart your computer.
echo.
pause
exit
