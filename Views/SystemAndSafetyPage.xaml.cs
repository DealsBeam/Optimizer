using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    public sealed partial class SystemAndSafetyPage : Page
    {
        private SystemAndSafetyViewModel ViewModel { get; }

        public SystemAndSafetyPage()
        {
            this.InitializeComponent();
            ViewModel = new SystemAndSafetyViewModel();
        }

        private async void SystemInformation_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Getting system information...";
            try
            {
                var info = await ViewModel.SystemInformation();
                await DialogHelper.ShowMessageDialog("System Information", info, XamlRoot);
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

        private async void AdvancedPrivacy_Click(object sender, RoutedEventArgs e)
        {
            var confirmed = await DialogHelper.ShowWarningDialog(
                "Advanced Privacy",
                "• Blocks Microsoft telemetry domains\n" +
                "• May interfere with some Microsoft services",
                XamlRoot
            );

            if (!confirmed) return;

            ProgressRing.IsActive = true;
            StatusText.Text = "Applying advanced privacy settings...";

            await SystemAndSafetyViewModel.CreateRestorePointAsync("Before Advanced Privacy");

            try
            {
                await ViewModel.AdvancedPrivacy();
                StatusText.Text = "✓ Advanced privacy settings applied successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(
                    $"Failed to apply advanced privacy settings.\n\n" +
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

        private async void CreateRestorePoint_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Creating restore point...";
            try
            {
                await SystemAndSafetyViewModel.CreateRestorePointAsync("Manual Restore Point");
                StatusText.Text = "✓ Restore point created successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
            }
            finally
            {
                ProgressRing.IsActive = false;
                StatusText.Text = "";
            }
        }

        private async void RestoreCenter_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Opening Restore Center...";
            try
            {
                await ViewModel.RestoreCenter();
                StatusText.Text = "✓ Restore Center opened successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
            }
            finally
            {
                ProgressRing.IsActive = false;
                StatusText.Text = "";
            }
        }
    }
}
