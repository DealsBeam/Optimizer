using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class SystemAndSafetyViewModel
    {
        public async Task SystemInformation()
        {
            await RunProcess("powershell.exe", "-Command \"Get-ComputerInfo | Format-List -Property OsName, OsVersion, CsManufacturer, CsModel, CsProcessors, 'PhysiscalMemorySize', OsLastBootUpTime\"");
        }

        public async Task AdvancedPrivacy()
        {
            await RunProcess("cmd.exe", "/c \"echo. >> %SystemRoot%\\System32\\drivers\\etc\\hosts & echo # Block Microsoft Telemetry >> %SystemRoot%\\System32\\drivers\\etc\\hosts & echo 0.0.0.0 vortex.data.microsoft.com >> %SystemRoot%\\System32\\drivers\\etc\\hosts\"");
        }

        public async Task CreateRestorePoint()
        {
            await RunProcess("powershell.exe", "-ExecutionPolicy Bypass -Command \"Checkpoint-Computer -Description 'OptimizerGUI Restore Point' -RestorePointType 'MODIFY_SETTINGS'\"");
        }

        public async Task RestoreCenter()
        {
            await RunProcess("cmd.exe", "/c start rstrui.exe");
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
    }
}
