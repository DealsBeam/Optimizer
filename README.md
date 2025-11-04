# OptimizerGUI for Windows 11

OptimizerGUI is a modern, portable, and powerful optimization tool designed exclusively for Windows 11. Built with C# and WinUI 3, it provides a user-friendly graphical interface for a wide range of system tweaks, cleaning utilities, and management features.

This application is the successor to the original `Optimizer.bat` script, offering the same powerful features in a safer, more robust, and easier-to-use package.

## Features

OptimizerGUI is organized into four main categories:

### System & Network
- **Network Optimization:** Improve network stability and reduce ping by applying common TCP tweaks.
- **DNS Optimization:** Switch to Cloudflare's public DNS (1.1.1.1) and flush the DNS cache.
- **Network Reset:** Perform a complete reset of the network stack to resolve connectivity issues.
- **Service Management:** Disable unnecessary services like SysMain and DiagTrack to free up resources.
- **Gaming Optimization:** Boost GPU and CPU priority for games and disable background apps.
- **Power Plan Management:** Activate the hidden "Ultimate Performance" power plan for maximum performance.

### Cleaning & Debloat
- **System Cleaner:** Clean temporary files, system caches, and Windows Update leftovers.
- **Extended Cleaner:** Clear the caches for major web browsers and Windows Explorer.
- **Junk Finder:** Perform a deep scan for and remove junk files like `.log` and `.dmp` files.
- **Simple Debloater:** Remove a predefined list of common bloatware apps.
- **Advanced Debloater:** Get a list of all removable Microsoft Store apps and choose which ones to uninstall.
- **Uninstall Edge & OneDrive:** Remove these deeply integrated Microsoft applications.
- **Scheduled Cleaning:** Create a weekly scheduled task to automatically clean your system.

### Management & Customization
- **App Manager:** View a list of all installed applications (powered by `winget`).
- **Startup Manager:** View a list of all programs that run at startup.
- **Windows Features:** Enable or disable optional Windows features like WSL, Hyper-V, and more.
- **Context Menu Editor:** Add useful items like "Take Ownership" and "Copy To/Move To" to the right-click menu.
- **UI & Personalization:** Enable a system-wide dark mode, disable visual effects, and restore the classic context menu.
- **Taskbar Customization:** Align the taskbar to the left and add an "End Task" option to the taskbar's right-click menu.

### System & Safety
- **System Information:** View a detailed summary of your hardware and operating system.
- **Advanced Privacy:** Disable telemetry and block common Microsoft data collection domains via the `hosts` file.
- **Create Restore Point:** Create a system restore point before making major changes.
- **Restore Center:** Access the Windows System Restore utility.

## How to Use

This application is designed to be fully portable and does not require any installation. As this repository does not contain pre-compiled releases, you will need to compile the application from source.

### Build Instructions

1.  Install Visual Studio 2022 with the ".NET Multi-platform App UI development" workload.
2.  Open a terminal and run the following command to compile the application:
    ```
    dotnet publish -r win-x64 -c Release --self-contained true -p:PublishSingleFile=true -o releases
    ```
3.  Navigate to the `releases` directory.
4.  Run the `OptimizerGUI.exe` file as an administrator.

## For Developers

This project is built with C# and WinUI 3. To build it from source, you will need Visual Studio 2022 with the ".NET Multi-platform App UI development" workload installed.

### Build Instructions

You can compile the application into a single, self-contained executable using the following `dotnet` command:

```
dotnet publish -r win-x64 -c Release --self-contained true -p:PublishSingleFile=true
```
