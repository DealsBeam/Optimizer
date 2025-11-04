namespace OptimizerGUI.Models
{
    public class AppSettings
    {
        public string PreferredDnsServer { get; set; } = "1.1.1.1";
        public string AlternateDnsServer { get; set; } = "1.0.0.1";
        public bool AutoCreateRestorePoint { get; set; } = true;
        public bool ShowConfirmationDialogs { get; set; } = true;
        public int ScheduledCleaningHour { get; set; } = 12;
        public string ScheduledCleaningDay { get; set; } = "SUN";
    }
}
