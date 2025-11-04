using System;
using System.IO;
using System.Text.Json;
using OptimizerGUI.Models;

namespace OptimizerGUI.Helpers
{
    /// <summary>
    /// Manages the loading and saving of application settings.
    /// </summary>
    public static class SettingsManager
    {
        private static readonly string SettingsPath = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            "OptimizerGUI",
            "settings.json"
        );

        /// <summary>
        /// Loads the application settings from the settings file.
        /// </summary>
        /// <returns>An <see cref="AppSettings"/> object containing the application settings.</returns>
        public static AppSettings LoadSettings()
        {
            try
            {
                if (File.Exists(SettingsPath))
                {
                    var json = File.ReadAllText(SettingsPath);
                    return JsonSerializer.Deserialize<AppSettings>(json) ?? new AppSettings();
                }
            }
            catch (Exception ex)
            {
                Serilog.Log.Error(ex, "Failed to load settings");
            }

            return new AppSettings();
        }

        /// <summary>
        /// Saves the application settings to the settings file.
        /// </summary>
        /// <param name="settings">The <see cref="AppSettings"/> object to save.</param>
        public static void SaveSettings(AppSettings settings)
        {
            try
            {
                var directory = Path.GetDirectoryName(SettingsPath);
                Directory.CreateDirectory(directory);

                var json = JsonSerializer.Serialize(settings, new JsonSerializerOptions { WriteIndented = true });
                File.WriteAllText(SettingsPath, json);
            }
            catch (Exception ex)
            {
                Serilog.Log.Error(ex, "Failed to save settings");
            }
        }
    }
}
