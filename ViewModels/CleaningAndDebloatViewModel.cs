using OptimizerGUI.Helpers;
using Serilog;
using System;
using System.IO;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class CleaningAndDebloatViewModel
    {
        public async Task SystemCleaner()
        {
            Log.Information("Starting system cleaner");
            try
            {
                await ProcessHelper.RunProcessAsync("cmd.exe", $"/c del /q /f /s %TEMP%\\*", timeout: TimeSpan.FromSeconds(30));
                await ProcessHelper.RunProcessAsync("cmd.exe", $"/c del /q /f /s \"{Path.GetTempPath()}\\*\"", timeout: TimeSpan.FromSeconds(30));
                await ProcessHelper.RunProcessAsync("cleanmgr", "/sagerun:1", timeout: TimeSpan.FromSeconds(30));
                Log.Information("System cleaner completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "System cleaner failed");
                throw;
            }
        }

        public async Task ExtendedCleaner()
        {
            Log.Information("Starting extended cleaner");
            try
            {
                string localAppData = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
                await ProcessHelper.RunProcessAsync("cmd.exe", $"/c del /q /f /s \"{localAppData}\\Google\\Chrome\\User Data\\Default\\Cache\\*\"", timeout: TimeSpan.FromSeconds(30));
                await ProcessHelper.RunProcessAsync("cmd.exe", $"/c del /q /f /s \"{localAppData}\\Microsoft\\Edge\\User Data\\Default\\Cache\\*\"", timeout: TimeSpan.FromSeconds(30));
                Log.Information("Extended cleaner completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Extended cleaner failed");
                throw;
            }
        }

        public async Task JunkFinder()
        {
            Log.Information("Starting junk finder");
            try
            {
                await ProcessHelper.RunProcessAsync("cmd.exe", $"/c del /q /f /s %SystemDrive%\\*.log", timeout: TimeSpan.FromSeconds(30));
                await ProcessHelper.RunProcessAsync("cmd.exe", $"/c del /q /f /s %SystemDrive%\\*.dmp", timeout: TimeSpan.FromSeconds(30));
                Log.Information("Junk finder completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Junk finder failed");
                throw;
            }
        }

        public async Task RemoveBloatware()
        {
            Log.Information("Starting bloatware removal");
            try
            {
                await ProcessHelper.RunProcessAsync("powershell.exe", "-ExecutionPolicy Bypass -Command \"Get-AppxPackage *3DBuilder* | Remove-AppxPackage; Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage;\"", timeout: TimeSpan.FromSeconds(30));
                Log.Information("Bloatware removal completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Bloatware removal failed");
                throw;
            }
        }

        public async Task UninstallEdgeAndOneDrive()
        {
            Log.Information("Starting Edge and OneDrive uninstallation");
            try
            {
                await ProcessHelper.RunProcessAsync("powershell.exe", "-ExecutionPolicy Bypass -Command \"& { $path = (Get-AppxPackage -Name Microsoft.MicrosoftEdge).InstallLocation; if ($path) { $setup = Get-ChildItem -Path $path -Filter setup.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1; if ($setup) { Start-Process -FilePath $setup.FullName -ArgumentList '--uninstall --system-level --verbose-logging --force-uninstall' -Wait } } }\"", timeout: TimeSpan.FromSeconds(30));
                await ProcessHelper.RunProcessAsync("cmd.exe", "/c %SystemRoot%\\SysWOW64\\OneDriveSetup.exe /uninstall", timeout: TimeSpan.FromSeconds(30));
                Log.Information("Edge and OneDrive uninstallation completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Edge and OneDrive uninstallation failed");
                throw;
            }
        }
    }
}
