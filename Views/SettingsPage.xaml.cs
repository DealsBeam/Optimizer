using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.Helpers;

namespace OptimizerGUI.Views
{
    public sealed partial class SettingsPage : Page
    {
        public SettingsPage()
        {
            this.InitializeComponent();
            LoadSettings();
        }

        private void LoadSettings()
        {
            var settings = SettingsManager.LoadSettings();
            PrimaryDnsBox.Text = settings.PreferredDnsServer;
            SecondaryDnsBox.Text = settings.AlternateDnsServer;
            AutoRestoreToggle.IsOn = settings.AutoCreateRestorePoint;
            ConfirmationsToggle.IsOn = settings.ShowConfirmationDialogs;
        }

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
