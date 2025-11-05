namespace OptimizerGUI.Models
{
    /// <summary>
    /// Represents the application settings.
    /// </summary>
    public class AppSettings
    {
        /// <summary>
        /// Gets or sets the preferred DNS server.
        /// </summary>
        public string PreferredDnsServer { get; set; } = "1.1.1.1";

        /// <summary>
        /// Gets or sets the alternate DNS server.
        /// </summary>
        public string AlternateDnsServer { get; set; } = "1.0.0.1";

        /// <summary>
        /// Gets or sets a value indicating whether to automatically create a restore point.
        /// </summary>
        public bool AutoCreateRestorePoint { get; set; } = true;

        /// <summary>
        /// Gets or sets a value indicating whether to show confirmation dialogs.
        /// </summary>
        public bool ShowConfirmationDialogs { get; set; } = true;

        /// <summary>
        /// Gets or sets the hour for scheduled cleaning.
        /// </summary>
        public int ScheduledCleaningHour { get; set; } = 12;

        /// <summary>
        /// Gets or sets the day for scheduled cleaning.
        /// </summary>
        public string ScheduledCleaningDay { get; set; } = "SUN";
    }
}
