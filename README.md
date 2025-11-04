# OptimizerGUI for Windows 11

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

> ⚠️ **WARNING:** This tool makes significant system changes to Windows 11. Always create a restore point before use. Some features may affect system stability, break Windows updates, or disable features you rely on. Use at your own risk.

OptimizerGUI is a modern, portable, and powerful optimization tool designed exclusively for Windows 11. Built with C# and WinUI 3, it provides a user-friendly graphical interface for a wide range of system tweaks, cleaning utilities, and management features.

This application is the successor to the original `Optimizer.bat` script, offering the same powerful features in a safer, more robust, and easier-to-use package.

## System Requirements
- **OS:** Windows 11 (Version 21H2 or newer)
- **Architecture:** x64

## Installation
This application is designed to be fully portable and does not require any installation.

1.  Go to the [Releases](/releases) page.
2.  Download the latest `OptimizerGUI.exe` file from the "Assets" section.
3.  Place the executable in a convenient location.
4.  Right-click `OptimizerGUI.exe` and select "Run as administrator".

## Features

OptimizerGUI is organized into four main categories:

### System & Network
- **Network Optimization:** Applies several TCP (Transmission Control Protocol) tweaks to improve network stability and reduce latency, which can be beneficial for gaming and streaming.
- **DNS Optimization:** Changes your system's DNS (Domain Name System) resolver to Cloudflare's public DNS (1.1.1.1 and 1.0.0.1) and flushes the local DNS cache. This can sometimes improve browsing speed and privacy.
- **Network Reset:** Performs a comprehensive reset of the Windows network stack, which can resolve common connectivity issues. **Warning:** This will temporarily disconnect you from the internet.
- **Service Management:** Disables services that are often considered unnecessary for many users, such as `SysMain` (formerly Superfetch) and `DiagTrack` (Connected User Experiences and Telemetry). Disabling these can free up system resources but may impact certain system features.
- **Gaming Optimization:** Prioritizes gaming performance by setting the "GPU Priority" and "Priority" for games to high and disabling the ability for UWP apps to run in the background.
- **Power Plan Management:** Imports and activates the "Ultimate Performance" power plan, which is designed for high-performance systems and can provide a small boost in performance at the cost of higher power consumption.

### Cleaning & Debloat
- **System Cleaner:** Deletes files from the system's temporary folders and the Windows Update download cache.
- **Extended Cleaner:** Clears the cache for common web browsers (Chrome, Edge) and the Windows Explorer thumbnail cache.
- **Junk Finder:** Performs a deep scan of your system for common junk files, such as log files (`.log`) and memory dumps (`.dmp`), and removes them.
- **Simple Debloater:** Removes a predefined list of common bloatware and pre-installed applications (e.g., 3D Builder, Skype, Mixed Reality Portal). **Warning:** This action is not easily reversible.
- **Advanced Debloater:** Provides an interactive list of all removable Microsoft Store apps and allows you to select which ones to uninstall. **Warning:** Removing certain apps, especially those that are part of the core OS, may cause system instability.
- **Uninstall Edge & OneDrive:** Attempts to remove these deeply integrated Microsoft applications. **Warning:** This is a high-risk operation that can cause issues with Windows Update and other system features.
- **Scheduled Cleaning:** Creates a weekly scheduled task that will automatically run the "System Cleaner" functions every Sunday at noon.

### Management & Customization
- **App Manager:** Opens a new window with a list of all installed applications on your system, as reported by the `winget` package manager.
- **Startup Manager:** Displays a list of all programs that are configured to run when you log in to Windows.
- **Windows Features:** Opens the built-in Windows Features dialog, allowing you to enable or disable optional features like the Windows Subsystem for Linux (WSL), Hyper-V, and the Telnet Client.
- **Context Menu Editor:** Adds useful shortcuts to the right-click context menu, such as "Take Ownership" (for taking full control of files and folders) and "Copy To/Move To".
- **UI & Personalization:** Provides several tweaks to customize the look and feel of Windows 11, including a system-wide dark mode, the ability to disable performance-intensive visual effects, and an option to restore the classic (Windows 10-style) right-click menu.
- **Taskbar Customization:** Allows you to align the taskbar icons to the left (similar to Windows 10) and add a convenient "End Task" option to the taskbar's right-click menu.

### System & Safety
- **System Information:** Displays a detailed summary of your computer's hardware and operating system, including the OS version, CPU, and installed RAM.
- **Advanced Privacy:** Disables the main telemetry service (`DiagTrack`) and blocks a list of known Microsoft data collection domains by adding them to your `hosts` file. **Warning:** Blocking these domains may interfere with some Microsoft services, including Windows Update.
- **Create Restore Point:** Creates a new system restore point, which you can use to revert your system to a previous state if you encounter any issues.
- **Restore Center:** Opens the built-in Windows System Restore utility, allowing you to select and restore a previously created restore point.

## For Developers

This project is built with C# and WinUI 3. To build it from source, you will need Visual Studio 2022 with the ".NET Multi-platform App UI development" workload installed.

### Build Instructions

You can compile the application into a single, self-contained executable using the following `dotnet` command:

```
dotnet publish -r win-x64 -c Release --self-contained true -p:PublishSingleFile=true
```

## Screenshots
*(Screenshots will be added here soon)*

## Disclaimer
OptimizerGUI is a powerful tool that can significantly improve the performance and usability of your Windows 11 system. However, many of the tweaks modify the system registry and disable core services. While these changes are generally considered safe, they are made at your own risk. Performance improvements are not guaranteed and will vary depending on your hardware and system configuration.
