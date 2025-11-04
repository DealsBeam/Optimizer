using Serilog;
using System;
using System.IO;

namespace OptimizerGUI.Helpers
{
    /// <summary>
    /// Provides a centralized logging mechanism for the application.
    /// </summary>
    public static class Logger
    {
        /// <summary>
        /// Initializes the logger.
        /// </summary>
        public static void Initialize()
        {
            var logPath = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
                "OptimizerGUI",
                "Logs",
                "optimizer-.log"
            );

            Log.Logger = new LoggerConfiguration()
                .MinimumLevel.Information()
                .WriteTo.File(
                    logPath,
                    rollingInterval: RollingInterval.Day,
                    retainedFileCountLimit: 7,
                    outputTemplate: "{Timestamp:yyyy-MM-dd HH:mm:ss} [{Level:u3}] {Message:lj}{NewLine}{Exception}"
                )
                .CreateLogger();

            Log.Information("OptimizerGUI started");
        }

        /// <summary>
        /// Shuts down the logger.
        /// </summary>
        public static void Shutdown()
        {
            Log.Information("OptimizerGUI shutting down");
            Log.CloseAndFlush();
        }
    }
}
