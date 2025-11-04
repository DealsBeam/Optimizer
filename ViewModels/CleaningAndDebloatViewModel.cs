using System.Diagnostics;
using System.Threading.Tasks;
using System.IO;

namespace OptimizerGUI.ViewModels
{
    public class CleaningAndDebloatViewModel
    {
        public async Task SystemCleaner()
        {
            await RunProcess("cmd.exe", $"/c del /q /f /s %TEMP%\\*");
            await RunProcess("cmd.exe", $"/c del /q /f /s \"{Path.GetTempPath()}\\*\"");
            await RunProcess("cleanmgr", "/sagerun:1");
        }

        public async Task ExtendedCleaner()
        {
            string localAppData = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
            await RunProcess("cmd.exe", $"/c del /q /f /s \"{localAppData}\\Google\\Chrome\\User Data\\Default\\Cache\\*\"");
            await RunProcess("cmd.exe", $"/c del /q /f /s \"{localAppData}\\Microsoft\\Edge\\User Data\\Default\\Cache\\*\"");
        }

        public async Task JunkFinder()
        {
            await RunProcess("cmd.exe", $"/c del /q /f /s %SystemDrive%\\*.log");
            await RunProcess("cmd.exe", $"/c del /q /f /s %SystemDrive%\\*.dmp");
        }

        public async Task RemoveBloatware()
        {
            await RunProcess("powershell.exe", "-ExecutionPolicy Bypass -Command \"Get-AppxPackage *3DBuilder* | Remove-AppxPackage; Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage;\"");
        }

        public async Task UninstallEdgeAndOneDrive()
        {
            await RunProcess("powershell.exe", "-ExecutionPolicy Bypass -Command \"& { $path = (Get-AppxPackage -Name Microsoft.MicrosoftEdge).InstallLocation; if ($path) { $setup = Get-ChildItem -Path $path -Filter setup.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1; if ($setup) { Start-Process -FilePath $setup.FullName -ArgumentList '--uninstall --system-level --verbose-logging --force-uninstall' -Wait } } }\"");
            await RunProcess("cmd.exe", "/c %SystemRoot%\\SysWOW64\\OneDriveSetup.exe /uninstall");
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
