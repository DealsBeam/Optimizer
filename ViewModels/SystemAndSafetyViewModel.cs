using OptimizerGUI.Helpers;
using Serilog;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class SystemAndSafetyViewModel
    {
        public async Task<string> SystemInformation()
        {
            Log.Information("Getting system information");
            try
            {
                var result = await ProcessHelper.RunProcessAsync("powershell.exe", "-Command \"Get-ComputerInfo | Format-List -Property OsName, OsVersion, CsManufacturer, CsModel, CsProcessors, 'PhysicalMemorySize', OsLastBootUpTime\"");
                Log.Information("Successfully retrieved system information");
                return result.Output;
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to get system information");
                throw;
            }
        }

        public async Task AdvancedPrivacy()
        {
            Log.Information("Applying advanced privacy settings");
            try
            {
                await ProcessHelper.RunProcessAsync("cmd.exe", "/c \"echo. >> %SystemRoot%\\System32\\drivers\\etc\\hosts & echo # Block Microsoft Telemetry >> %SystemRoot%\\System32\\drivers\\etc\\hosts & echo 0.0.0.0 vortex.data.microsoft.com >> %SystemRoot%\\System32\\drivers\\etc\\hosts\"");
                Log.Information("Advanced privacy settings applied successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to apply advanced privacy settings");
                throw;
            }
        }

        public static async Task<bool> CreateRestorePointAsync(string description = "OptimizerGUI Operation")
        {
            try
            {
                Log.Information($"Creating restore point: {description}");
                var result = await ProcessHelper.RunProcessAsync(
                    "powershell.exe",
                    $"-ExecutionPolicy Bypass -Command \"Checkpoint-Computer -Description '{description}' -RestorePointType 'MODIFY_SETTINGS'\"",
                    throwOnError: false
                );

                if (result.Success)
                {
                    Log.Information("Restore point created successfully");
                    return true;
                }
                else
                {
                    Log.Warning($"Restore point creation failed: {result.Error}");
                    return false;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to create restore point");
                return false;
            }
        }

        public async Task RestoreCenter()
        {
            Log.Information("Opening Restore Center");
            try
            {
                await ProcessHelper.RunProcessAsync("cmd.exe", "/c start rstrui.exe");
                Log.Information("Restore Center opened successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to open Restore Center");
                throw;
            }
        }
    }
}
