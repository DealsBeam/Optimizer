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
echo            │    WINDOWS 11 PC OPTIMIZER v6.0            │
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
echo    [11] App Manager
echo    [12] Startup Manager
echo    [13] Advanced Privacy        - Telemetry, hosts file
echo    [14] Remove Bloatware
echo    [15] Uninstall Edge & OneDrive
echo    [16] Create Restore Point
echo    [17] Restore Center
echo    [18] Desktop Context Menu Editor
echo    [19] Ultimate Performance Power Plan
echo    [20] Scheduled Cleaning
echo    [21] Taskbar Customization
echo    [22] UI & Personalization
echo    [23] DWM Tweaks
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
if /i "%choice%"=="11" goto APP_MANAGER
if /i "%choice%"=="12" goto STARTUP_MANAGER
if /i "%choice%"=="13" goto PRIVACY
if /i "%choice%"=="14" goto DEBLOAT
if /i "%choice%"=="15" goto UNINSTALL_EDGE_ONEDRIVE
if /i "%choice%"=="16" goto CREATE_RESTORE_POINT
if /i "%choice%"=="17" goto RESTORE_CENTER
if /i "%choice%"=="18" goto CONTEXT_MENU_EDITOR
if /i "%choice%"=="19" goto ULTIMATE_PERFORMANCE
if /i "%choice%"=="20" goto SCHEDULED_CLEANING
if /i "%choice%"=="21" goto TASKBAR_CUSTOMIZATION
if /i "%choice%"=="22" goto UI_PERSONALIZATION
if /i "%choice%"=="23" goto DWM_TWEAKS
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
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    SERVICE TUNING                          │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Disable unnecessary services (SysMain, Telemetry, Xbox)
echo    [2] Restore original services
echo    [0] Back to Main Menu
echo.
set /p svch="          Choose an option: "
if "%svch%"=="1" (
    set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "backup_group=%timestamp%_Service_Tweaks"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" "Services_SysMain" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" "Services_DiagTrack" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" "Services_dmwappushservice" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" "Services_XblAuthManager" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" "Services_XblGameSave" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" "Services_XboxNetApiSvc" "%backup_group%"
    call :BACKUP "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "Services_DataCollection" "%backup_group%"
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
    sc config "dmwappushservice" start=auto & sc start "dmwappushservice"
    sc config "XblAuthManager" start=auto & sc start "XblAuthManager"
    sc config "XblGameSave" start=auto & sc start "XblGameSave"
    sc config "XboxNetApiSvc" start=auto & sc start "XboxNetApiSvc"
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /f >nul
    echo.
    echo [STATUS] Services restored. Restart recommended!
    pause
    goto MENU
)
if "%svch%"=="0" goto MENU
goto ANIM_SERV

:GAMEMODE
cls
call :progress "Gaming Optimization"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_Gaming_Tweaks"
call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Settings" "Gaming_PowerSettings" "%backup_group%"
call :BACKUP "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Gaming_MultimediaProfile" "%backup_group%"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "Gaming_BackgroundApps" "%backup_group%"
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
call :progress "Advanced Windows Tweaks"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_Advanced_Tweaks"
call :BACKUP "HKLM\SOFTWARE\Microsoft\DirectX" "Advanced_DirectX" "%backup_group%"
call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "Advanced_MemoryManagement" "%backup_group%"
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
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    INPUT LATENCY                           │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Apply lowest latency
echo    [2] Restore default latency
echo    [0] Back to Main Menu
echo.
set /p inlat="          Choose an option: "
if "%inlat%"=="1" (
    set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "backup_group=%timestamp%_Input_Latency"
    call :BACKUP "HKCU\Control Panel\Mouse" "Input_Mouse" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" "Input_MouseParameters" "%backup_group%"
    call :BACKUP "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" "Input_KeyboardParameters" "%backup_group%"
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
    reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 100 /f
    echo.
    echo [STATUS] Input latency restored to default. Restart!
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

:DEBLOAT
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    REMOVE BLOATWARE APPS                   │
echo            ╰────────────────────────────────────────────╯
echo.
echo [INFO] This will remove pre-installed Microsoft Store apps.
echo [INFO] This action is irreversible without reinstalling Windows.
echo.
set /p "confirm=Are you sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Removing Bloatware Apps"
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
echo [STATUS] Bloatware apps removed successfully.
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
echo    [1] Apply privacy settings (telemetry, hosts file)
echo    [2] Restore original privacy settings
echo    [0] Back to Main Menu
echo.
set /p "privacy_choice=Choose an option: "
if /i "%privacy_choice%"=="1" (
    call :progress "Applying privacy settings"
copy %windir%\System32\drivers\etc\hosts %windir%\System32\drivers\etc\hosts.bak >nul
(
    echo.
    echo # Block Microsoft Telemetry
    echo 0.0.0.0 vortex.data.microsoft.com
    echo 0.0.0.0 settings-win.data.microsoft.com
    echo 0.0.0.0 telecommand.telemetry.microsoft.com
) >> %windir%\System32\drivers\etc\hosts
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul
echo.
echo [STATUS] Privacy settings applied.
pause
goto MENU
)
if /i "%privacy_choice%"=="2" (
    call :RESTORE_HOSTS
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable >nul
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable >nul
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable >nul
    echo.
    echo [STATUS] Privacy settings restored.
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
echo [1] Uninstall Microsoft Edge
echo [2] Uninstall OneDrive
echo [0] Back to Main Menu
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
echo [WARNING] Removing Edge may cause unforeseen issues with Windows.
echo.
set /p "confirm=Are you absolutely sure you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU
call :progress "Uninstalling Microsoft Edge"
cd "C:\Program Files (x86)\Microsoft\Edge\Application"
for /d %%I in (*) do (
    if exist "%%I\Installer\setup.exe" (
        "%%I\Installer\setup.exe" --uninstall --system-level --verbose-logging --force-uninstall
    )
)
echo.
echo [STATUS] Microsoft Edge has been uninstalled.
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
echo [INFO] Querying startup registry keys...
echo.
echo --- HKEY_CURRENT_USER ---
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
echo.
echo --- HKEY_LOCAL_MACHINE ---
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
echo.
echo [STATUS] Startup programs listed.
pause
goto STARTUP_MANAGER

:REMOVE_STARTUP
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    REMOVE A STARTUP PROGRAM                │
echo            ╰────────────────────────────────────────────╯
echo.
set /p "startup_name=Enter the name of the startup program to remove: "
if "%startup_name%"=="" goto STARTUP_MANAGER
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_Startup_Manager"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" "Startup_Run_User" "%backup_group%"
call :BACKUP "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" "Startup_Run_Machine" "%backup_group%"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%startup_name%" /f >nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "%startup_name%" /f >nul
echo.
echo [STATUS] Attempted to remove "%startup_name%".
pause
goto STARTUP_MANAGER

:CONTEXT_MENU_EDITOR
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    DESKTOP CONTEXT MENU EDITOR             │
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
echo    [1] Enable Dark Mode
echo    [2] Disable Dark Mode
echo    [3] Disable Visual Effects
echo    [4] Restore Visual Effects
echo    [5] Restore Classic Context Menu
echo    [6] Restore Default Context Menu
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
echo [STATUS] Dark Mode has been enabled.
pause
goto UI_PERSONALIZATION

:DISABLE_DARK_MODE
cls
call :progress "Disabling Dark Mode"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul
echo.
echo [STATUS] Dark Mode has been disabled.
pause
goto UI_PERSONALIZATION

:DISABLE_VISUAL_EFFECTS
cls
call :progress "Disabling Visual Effects"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_VisualEffects"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualEffects" "%backup_group%"
call :BACKUP "HKCU\Control Panel\Desktop" "VisualEffects_Desktop" "%backup_group%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
echo.
echo [STATUS] Visual effects have been disabled.
pause
goto UI_PERSONALIZATION

:RESTORE_VISUAL_EFFECTS
cls
call :progress "Restoring Visual Effects"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9E2E078012000000 /f >nul
echo.
echo [STATUS] Visual effects have been restored.
pause
goto UI_PERSONALIZATION

:RESTORE_CLASSIC_CONTEXT_MENU
cls
call :progress "Restoring Classic Context Menu"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_ClassicContextMenu"
call :BACKUP "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" "ClassicContextMenu" "%backup_group%"
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f >nul
echo.
echo [STATUS] Classic context menu has been restored. Please restart Explorer.
pause
goto UI_PERSONALIZATION

:RESTORE_DEFAULT_CONTEXT_MENU
cls
call :progress "Restoring Default Context Menu"
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul
echo.
echo [STATUS] Default context menu has been restored. Please restart Explorer.
pause
goto UI_PERSONALIZATION

:TASKBAR_CUSTOMIZATION
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    TASKBAR CUSTOMIZATION                   │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Align Taskbar to Left
echo    [2] Restore Taskbar Center Alignment
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
echo [STATUS] Taskbar aligned to the left.
pause
goto TASKBAR_CUSTOMIZATION

:RESTORE_TASKBAR_CENTER
cls
call :progress "Restoring Taskbar Center Alignment"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f >nul
echo.
echo [STATUS] Taskbar alignment restored to center.
pause
goto TASKBAR_CUSTOMIZATION

:ADD_END_TASK
cls
call :progress "Adding 'End Task' to Taskbar"
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "backup_group=%timestamp%_EndTask"
call :BACKUP "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "EndTask" "%backup_group%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul
echo.
echo [STATUS] 'End Task' has been added to the taskbar context menu.
pause
goto TASKBAR_CUSTOMIZATION

:REMOVE_END_TASK
cls
call :progress "Removing 'End Task' from Taskbar"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarEndTask /t REG_DWORD /d 0 /f >nul
echo.
echo [STATUS] 'End Task' has been removed from the taskbar context menu.
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
schtasks /create /tn "Optimizer Update Cache Clean" /tr "cmd.exe /c del /q /f /s %SystemRoot%\SoftwareDistribution\Download\*" /sc weekly /d SUN /st 12:05 /ru "System" >nul
echo.
echo [STATUS] Weekly cleaning tasks for TEMP and Update Cache have been created.
pause
goto SCHEDULED_CLEANING

:REMOVE_CLEANING_TASKS
cls
call :progress "Removing Weekly Cleaning Tasks"
schtasks /delete /tn "Optimizer Temp Clean" /f >nul
schtasks /delete /tn "Optimizer Update Cache Clean" /f >nul
echo.
echo [STATUS] Weekly cleaning tasks have been removed.
pause
goto SCHEDULED_CLEANING

:ULTIMATE_PERFORMANCE
cls
echo.
echo            ╭────────────────────────────────────────────╮
echo            │    ULTIMATE PERFORMANCE POWER PLAN         │
echo            ╰────────────────────────────────────────────╯
echo.
echo    [1] Activate Ultimate Performance
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
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo [STATUS] Ultimate Performance power plan has been activated.
pause
goto ULTIMATE_PERFORMANCE

:RESTORE_BALANCED_POWER_PLAN
cls
call :progress "Restoring Balanced Power Plan"
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
echo [STATUS] Balanced power plan has been restored.
pause
goto ULTIMATE_PERFORMANCE

:EXIT
cls
echo.
echo                        [ Thank you for using! ]
echo      If you tweaked settings, please restart your computer.
echo.
pause
exit
