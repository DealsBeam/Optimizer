using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.Helpers;

namespace OptimizerGUI.Views
{
    /// <summary>
    /// Represents the page for the application settings.
    /// </summary>
    public sealed partial class SettingsPage : Page
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="SettingsPage"/> class.
        /// </summary>
        public SettingsPage()
        {
            this.InitializeComponent();
            LoadSettings();
        }

        /// <summary>
        /// Loads the settings from the settings manager and displays them on the page.
        /// </summary>
        private void LoadSettings()
        {
            var settings = SettingsManager.LoadSettings();
            PrimaryDnsBox.Text = settings.PreferredDnsServer;
            SecondaryDnsBox.Text = settings.AlternateDnsServer;
            AutoRestoreToggle.IsOn = settings.AutoCreateRestorePoint;
            ConfirmationsToggle.IsOn = settings.ShowConfirmationDialogs;
        }

        /// <summary>
        /// Handles the click event for the save settings button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void SaveSettings_Click(object sender, RoutedEventArgs e)
        {
            var settings = new Models.AppSettings
            {
                PreferredDnsServer = PrimaryDnsBox.Text,
                AlternateDnsServer = SecondaryDnsBox.Text,
                AutoCreateRestorePoint = AutoRestoreToggle.IsOn,
                ShowConfirmationDialogs = ConfirmationsToggle.IsOn
            };

            SettingsManager.SaveSettings(settings);
            await DialogHelper.ShowSuccessDialog("Settings saved successfully", XamlRoot);
        }
    }
}
