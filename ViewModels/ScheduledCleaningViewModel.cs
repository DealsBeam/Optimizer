using OptimizerGUI.Helpers;
using Serilog;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.ViewModels
{
    public class ScheduledCleaningViewModel
    {
        public async Task CreateWeeklyCleaningTasks()
        {
            Log.Information("Creating weekly cleaning tasks");
            try
            {
                await ProcessHelper.RunProcessAsync("schtasks", "/create /tn \"Optimizer Temp Clean\" /tr \"cmd.exe /c del /q /f /s %TEMP%\\*\" /sc weekly /d SUN /st 12:00 /ru \"System\"", timeout: TimeSpan.FromSeconds(30));
                await ProcessHelper.RunProcessAsync("schtasks", "/create /tn \"Optimizer Update Cache Clean\" /tr \"cmd.exe /c del /q /f /s %SystemRoot%\\SoftwareDistribution\\Download\\*\" /sc weekly /d SUN /st 12:05 /ru \"System\"", timeout: TimeSpan.FromSeconds(30));
                Log.Information("Weekly cleaning tasks created successfully");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to create weekly cleaning tasks");
                throw;
            }
        }
    }
}
