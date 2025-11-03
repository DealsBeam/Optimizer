@echo off
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
