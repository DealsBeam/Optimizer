using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    public sealed partial class AdvancedDebloaterPage : Page
    {
        private AdvancedDebloaterViewModel ViewModel { get; }

        public AdvancedDebloaterPage()
        {
            this.InitializeComponent();
            ViewModel = new AdvancedDebloaterViewModel();
            Loaded += OnPageLoaded;
        }

        private async void OnPageLoaded(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Loading removable apps...";
            try
            {
                var apps = await ViewModel.GetRemovableApps();
                AppsListView.ItemsSource = apps;
            }
            catch (Exception ex)
            {
                await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
            }
            finally
            {
                ProgressRing.IsActive = false;
                StatusText.Text = "";
            }
        }

        private async void UninstallButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedApps = AppsListView.SelectedItems.Cast<string>().ToList();
            if (selectedApps.Count > 0)
            {
                var confirmed = await DialogHelper.ShowWarningDialog(
                    $"Uninstall {selectedApps.Count} apps",
                    "• This action cannot be easily reversed\n" +
                    "• Removing certain apps may cause system instability",
                    XamlRoot
                );

                if (!confirmed) return;

                ProgressRing.IsActive = true;
                StatusText.Text = $"Uninstalling {selectedApps.Count} apps...";

                await SystemAndSafetyViewModel.CreateRestorePointAsync($"Before Uninstalling {selectedApps.Count} apps");

                try
                {
                    await ViewModel.UninstallApps(selectedApps);
                    StatusText.Text = $"✓ {selectedApps.Count} apps uninstalled successfully";
                    await Task.Delay(2000);
                }
                catch (Exception ex)
                {
                    StatusText.Text = "";
                    await DialogHelper.ShowErrorDialog(
                        $"Failed to uninstall apps.\n\n" +
                        $"Error: {ex.Message}\n\n" +
                        $"You can restore your system using System Restore.",
                        XamlRoot
                    );
                }
                finally
                {
                    ProgressRing.IsActive = false;
                    StatusText.Text = "";
                }
            }
        }
    }
}
