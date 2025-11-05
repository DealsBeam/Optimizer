using OptimizerGUI.Helpers;
using Serilog;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class ManagementAndCustomizationViewModel
    {
        public async Task AppManager()
        {
            Log.Information("Opening App Manager (winget)");
            try
            {
                await ProcessHelper.RunProcessAsync("cmd.exe", "/c start winget list");
                Log.Information("App Manager opened successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to open App Manager");
                throw;
            }
        }

        public async Task<string> StartupManager()
        {
            Log.Information("Getting startup applications");
            try
            {
                var result = await ProcessHelper.RunProcessAsync("powershell.exe", "-Command \"Get-CimInstance Win32_StartupCommand | Format-Table -Property Name, Command, Location, User\"");
                Log.Information("Successfully retrieved startup applications");
                return result.Output;
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to get startup applications");
                throw;
            }
        }

        public async Task WindowsFeaturesManager()
        {
            Log.Information("Opening Windows Features Manager");
            try
            {
                await ProcessHelper.RunProcessAsync("cmd.exe", "/c start optionalfeatures.exe");
                Log.Information("Windows Features Manager opened successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to open Windows Features Manager");
                throw;
            }
        }

        public async Task DesktopContextMenuEditor()
        {
            Log.Information("Editing desktop context menu");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCR\\AllFilesystemObjects\\shellex\\ContextMenuHandlers\\CopyTo\" /ve /d \"{C2FBB630-2971-11D1-A18C-00C04FD75D13}\" /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCR\\AllFilesystemObjects\\shellex\\ContextMenuHandlers\\MoveTo\" /ve /d \"{C2FBB631-2971-11D1-A18C-00C04FD75D13}\" /f");
                Log.Information("Desktop context menu edited successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to edit desktop context menu");
                throw;
            }
        }

        public async Task UIAndPersonalization()
        {
            Log.Information("Applying UI and personalization tweaks");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\" /v AppsUseLightTheme /t REG_DWORD /d 0 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f");
                Log.Information("UI and personalization tweaks applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply UI and personalization tweaks");
                throw;
            }
        }

        public async Task TaskbarCustomization()
        {
            Log.Information("Applying taskbar customization");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v TaskbarAl /t REG_DWORD /d 0 /f");
                Log.Information("Taskbar customization applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply taskbar customization");
                throw;
            }
        }

        public async Task DWMTweaks()
        {
            Log.Information("Applying DWM tweaks");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\Dwm\" /v EnableAeroPeek /t REG_DWORD /d 0 /f");
                Log.Information("DWM tweaks applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply DWM tweaks");
                throw;
            }
        }
    }
}
