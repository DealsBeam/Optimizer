using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class ScheduledCleaningViewModel
    {
        public async Task CreateWeeklyCleaningTasks()
        {
            await RunProcess("schtasks", "/create /tn \"Optimizer Temp Clean\" /tr \"cmd.exe /c del /q /f /s %TEMP%\\*\" /sc weekly /d SUN /st 12:00 /ru \"System\"");
            await RunProcess("schtasks", "/create /tn \"Optimizer Update Cache Clean\" /tr \"cmd.exe /c del /q /f /s %SystemRoot%\\SoftwareDistribution\\Download\\*\" /sc weekly /d SUN /st 12:05 /ru \"System\"");
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
