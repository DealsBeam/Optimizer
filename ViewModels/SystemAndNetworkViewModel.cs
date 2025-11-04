using System.Diagnostics;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class SystemAndNetworkViewModel
    {
        public async Task OptimizeNetwork()
        {
            await RunProcess("netsh", "int tcp set global autotuninglevel=normal");
            await RunProcess("netsh", "int tcp set global chimney=enabled");
            await RunProcess("netsh", "int tcp set global congestionprovider=ctcp");
            await RunProcess("netsh", "int tcp set heuristics disabled");
            await RunProcess("netsh", "int tcp set global rss=enabled");
            await RunProcess("netsh", "int tcp set global fastopen=enabled");
            await RunProcess("netsh", "interface tcp set global timestamps=disabled");
        }

        public async Task OptimizeDNS()
        {
            await RunProcess("netsh", "interface ip set dns \"Ethernet\" static 1.1.1.1 primary");
            await RunProcess("netsh", "interface ip add dns \"Ethernet\" 1.0.0.1 index=2");
            await RunProcess("netsh", "interface ip set dns \"Wi-Fi\" static 1.1.1.1 primary");
            await RunProcess("netsh", "interface ip add dns \"Wi-Fi\" 1.0.0.1 index=2");
            await RunProcess("ipconfig", "/flushdns");
        }

        public async Task ResetNetworkAdapter()
        {
            await RunProcess("ipconfig", "/release");
            await RunProcess("ipconfig", "/renew");
            await RunProcess("ipconfig", "/flushdns");
            await RunProcess("netsh", "winsock reset");
            await RunProcess("netsh", "int ip reset");
        }

        public async Task ManageServices()
        {
            await RunProcess("sc", "config \"SysMain\" start=disabled");
            await RunProcess("sc", "stop \"SysMain\"");
            await RunProcess("sc", "config \"DiagTrack\" start=disabled");
            await RunProcess("sc", "stop \"DiagTrack\"");
        }

        public async Task InputLatencyTweaks()
        {
            await RunProcess("reg", "add \"HKCU\\Control Panel\\Mouse\" /v MouseSpeed /t REG_SZ /d 0 /f");
            await RunProcess("reg", "add \"HKCU\\Control Panel\\Mouse\" /v MouseThreshold1 /t REG_SZ /d 0 /f");
            await RunProcess("reg", "add \"HKCU\\Control Panel\\Mouse\" /v MouseThreshold2 /t REG_SZ /d 0 /f");
        }

        public async Task GameMode()
        {
            await RunProcess("reg", "add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"GPU Priority\" /t REG_DWORD /d 8 /f");
            await RunProcess("reg", "add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Priority\" /t REG_DWORD /d 6 /f");
            await RunProcess("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\BackgroundAccessApplications\" /v GlobalUserDisabled /t REG_DWORD /d 1 /f");
        }

        public async Task AdvancedWindowsTweaks()
        {
            await RunProcess("reg", "add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\" /v LargeSystemCache /t REG_DWORD /d 1 /f");
            await RunProcess("reg", "add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\\PrefetchParameters\" /v EnablePrefetcher /t REG_DWORD /d 0 /f");
            await RunProcess("reg", "add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\\PrefetchParameters\" /v EnableSuperfetch /t REG_DWORD /d 0 /f");
        }

        public async Task UltimatePerformance()
        {
            await RunProcess("powercfg", "-duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61");
            await RunProcess("powercfg", "/setactive e9a42b02-d5df-448d-aa00-03f14749eb61");
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
        }
    }
}
