using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class ManagementAndCustomizationViewModel
    {
        public async Task AppManager()
        {
            await RunProcess("cmd.exe", "/c start winget list");
        }

        public async Task<string> StartupManager()
        {
            return await RunProcessWithOutput("powershell.exe", "-Command \"Get-CimInstance Win32_StartupCommand | Format-Table -Property Name, Command, Location, User\"");
        }

        public async Task WindowsFeaturesManager()
        {
            await RunProcess("cmd.exe", "/c start optionalfeatures.exe");
        }

        public async Task DesktopContextMenuEditor()
        {
            await RunProcess("reg", "add \"HKCR\\AllFilesystemObjects\\shellex\\ContextMenuHandlers\\CopyTo\" /ve /d \"{C2FBB630-2971-11D1-A18C-00C04FD75D13}\" /f");
            await RunProcess("reg", "add \"HKCR\\AllFilesystemObjects\\shellex\\ContextMenuHandlers\\MoveTo\" /ve /d \"{C2FBB631-2971-11D1-A18C-00C04FD75D13}\" /f");
        }

        public async Task UIAndPersonalization()
        {
            await RunProcess("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\" /v AppsUseLightTheme /t REG_DWORD /d 0 /f");
            await RunProcess("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f");
        }

        public async Task TaskbarCustomization()
        {
            await RunProcess("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v TaskbarAl /t REG_DWORD /d 0 /f");
        }

        public async Task DWMTweaks()
        {
            await RunProcess("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\Dwm\" /v EnableAeroPeek /t REG_DWORD /d 0 /f");
        }

        private async Task RunProcess(string fileName, string arguments)
        {
            var process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = fileName,
                    Arguments = arguments,
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };
            process.Start();
            await process.WaitForExitAsync();

            if (process.ExitCode != 0)
            {
                throw new Exception($"Command failed with exit code {process.ExitCode}: {fileName} {arguments}");
            }
        }

        private async Task<string> RunProcessWithOutput(string fileName, string arguments)
        {
            var process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = fileName,
                    Arguments = arguments,
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };
            process.Start();
            string output = await process.StandardOutput.ReadToEndAsync();
            await process.WaitForExitAsync();

            if (process.ExitCode != 0)
            {
                throw new Exception($"Command failed with exit code {process.ExitCode}: {fileName} {arguments}");
            }

            return output;
        }
    }
}
