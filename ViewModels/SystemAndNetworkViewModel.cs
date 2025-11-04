using OptimizerGUI.Helpers;
using Serilog;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class SystemAndNetworkViewModel
    {
        public async Task OptimizeNetwork()
        {
            Log.Information("Starting network optimization");
            try
            {
                await ProcessHelper.RunProcessAsync("netsh", "int tcp set global autotuninglevel=normal");
                await ProcessHelper.RunProcessAsync("netsh", "int tcp set global chimney=enabled");
                await ProcessHelper.RunProcessAsync("netsh", "int tcp set global congestionprovider=ctcp");
                await ProcessHelper.RunProcessAsync("netsh", "int tcp set heuristics disabled");
                await ProcessHelper.RunProcessAsync("netsh", "int tcp set global rss=enabled");
                await ProcessHelper.RunProcessAsync("netsh", "int tcp set global fastopen=enabled");
                await ProcessHelper.RunProcessAsync("netsh", "interface tcp set global timestamps=disabled");
                Log.Information("Network optimization completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Network optimization failed");
                throw;
            }
        }

        public async Task OptimizeDNS()
        {
            Log.Information("Starting DNS optimization");
            try
            {
                var settings = SettingsManager.LoadSettings();
                var adapters = await GetActiveAdapters();

                foreach (var adapter in adapters)
                {
                    await ProcessHelper.RunProcessAsync("netsh",
                        $"interface ip set dns \"{adapter}\" static {settings.PreferredDnsServer} primary");
                    await ProcessHelper.RunProcessAsync("netsh",
                        $"interface ip add dns \"{adapter}\" {settings.AlternateDnsServer} index=2");
                }

                await ProcessHelper.RunProcessAsync("ipconfig", "/flushdns");
                Log.Information("DNS optimization completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "DNS optimization failed");
                throw;
            }
        }

        private async Task<string[]> GetActiveAdapters()
        {
            Log.Information("Getting active network adapters");
            try
            {
                var result = await ProcessHelper.RunProcessAsync("powershell", "-Command \"Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'} | ForEach-Object { $_.Name }\"");
                return result.Output.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to get active adapters");
                throw;
            }
        }

        public async Task ResetNetworkAdapter()
        {
            Log.Information("Starting network adapter reset");
            try
            {
                await ProcessHelper.RunProcessAsync("ipconfig", "/release");
                await ProcessHelper.RunProcessAsync("ipconfig", "/renew");
                await ProcessHelper.RunProcessAsync("ipconfig", "/flushdns");
                await ProcessHelper.RunProcessAsync("netsh", "winsock reset");
                await ProcessHelper.RunProcessAsync("netsh", "int ip reset");
                Log.Information("Network adapter reset completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Network adapter reset failed");
                throw;
            }
        }

        public async Task ManageServices()
        {
            Log.Information("Starting service management");
            try
            {
                await ProcessHelper.RunProcessAsync("sc", "config \"SysMain\" start=disabled");
                await ProcessHelper.RunProcessAsync("sc", "stop \"SysMain\"");
                await ProcessHelper.RunProcessAsync("sc", "config \"DiagTrack\" start=disabled");
                await ProcessHelper.RunProcessAsync("sc", "stop \"DiagTrack\"");
                Log.Information("Service management completed successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Service management failed");
                throw;
            }
        }

        public async Task InputLatencyTweaks()
        {
            Log.Information("Applying input latency tweaks");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Control Panel\\Mouse\" /v MouseSpeed /t REG_SZ /d 0 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Control Panel\\Mouse\" /v MouseThreshold1 /t REG_SZ /d 0 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Control Panel\\Mouse\" /v MouseThreshold2 /t REG_SZ /d 0 /f");
                Log.Information("Input latency tweaks applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply input latency tweaks");
                throw;
            }
        }

        public async Task GameMode()
        {
            Log.Information("Applying game mode tweaks");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"GPU Priority\" /t REG_DWORD /d 8 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Priority\" /t REG_DWORD /d 6 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\BackgroundAccessApplications\" /v GlobalUserDisabled /t REG_DWORD /d 1 /f");
                Log.Information("Game mode tweaks applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply game mode tweaks");
                throw;
            }
        }

        public async Task AdvancedWindowsTweaks()
        {
            Log.Information("Applying advanced Windows tweaks");
            try
            {
                await ProcessHelper.RunProcessAsync("reg", "add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\" /v LargeSystemCache /t REG_DWORD /d 1 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\\PrefetchParameters\" /v EnablePrefetcher /t REG_DWORD /d 0 /f");
                await ProcessHelper.RunProcessAsync("reg", "add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\\PrefetchParameters\" /v EnableSuperfetch /t REG_DWORD /d 0 /f");
                Log.Information("Advanced Windows tweaks applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply advanced Windows tweaks");
                throw;
            }
        }

        public async Task UltimatePerformance()
        {
            Log.Information("Enabling Ultimate Performance power plan");
            try
            {
                await ProcessHelper.RunProcessAsync("powercfg", "-duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61");
                await ProcessHelper.RunProcessAsync("powercfg", "/setactive e9a42b02-d5df-448d-aa00-03f14749eb61");
                Log.Information("Ultimate Performance power plan enabled successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to enable Ultimate Performance power plan");
                throw;
            }
        }
    }
}