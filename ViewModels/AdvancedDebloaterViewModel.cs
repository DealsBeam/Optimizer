using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class AdvancedDebloaterViewModel
    {
        public async Task<List<string>> GetRemovableApps()
        {
            var process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = "powershell",
                    Arguments = "-Command \"Get-AppxPackage | Where-Object {$_.IsFramework -eq $false -and $_.NonRemovable -eq $false} | ForEach-Object { $_.Name }\"",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };
            process.Start();
            string output = await process.StandardOutput.ReadToEndAsync();
            await process.WaitForExitAsync();
            return output.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries).ToList();
        }

        public async Task UninstallApps(List<string> appNames)
        {
            foreach (var appName in appNames)
            {
                await RunProcess("powershell", $"-ExecutionPolicy Bypass -Command \"Get-AppxPackage '{appName}' | Remove-AppxPackage\"");
            }
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
