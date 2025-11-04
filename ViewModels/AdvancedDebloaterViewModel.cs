using OptimizerGUI.Helpers;
using Serilog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class AdvancedDebloaterViewModel
    {
        public async Task<List<string>> GetRemovableApps()
        {
            Log.Information("Getting list of removable apps");
            try
            {
                var result = await ProcessHelper.RunProcessAsync("powershell", "-Command \"Get-AppxPackage | Where-Object {$_.IsFramework -eq $false -and $_.NonRemovable -eq $false} | ForEach-Object { $_.Name }\"");
                Log.Information("Successfully retrieved list of removable apps");
                return result.Output.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries).ToList();
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to get list of removable apps");
                throw;
            }
        }

        public async Task UninstallApps(List<string> appNames)
        {
            Log.Information("Uninstalling {Count} apps", appNames.Count);
            try
            {
                foreach (var appName in appNames)
                {
                    Log.Information("Uninstalling app: {AppName}", appName);
                    await ProcessHelper.RunProcessAsync("powershell", $"-ExecutionPolicy Bypass -Command \"Get-AppxPackage '{appName}' | Remove-AppxPackage\"");
                }
                Log.Information("Successfully uninstalled selected apps");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to uninstall apps");
                throw;
            }
        }
    }
}
