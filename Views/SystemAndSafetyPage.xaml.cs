using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    /// <summary>
    /// Represents the page for the System and Safety feature.
    /// </summary>
    public sealed partial class SystemAndSafetyPage : Page
    {
        private SystemAndSafetyViewModel ViewModel { get; }

        /// <summary>
        /// Initializes a new instance of the <see cref="SystemAndSafetyPage"/> class.
        /// </summary>
        public SystemAndSafetyPage()
        {
            this.InitializeComponent();
            ViewModel = new SystemAndSafetyViewModel();
        }

        /// <summary>
        /// Handles the click event for the system information button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the advanced privacy button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the restore center button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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
