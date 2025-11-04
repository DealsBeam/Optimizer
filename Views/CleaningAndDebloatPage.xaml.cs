using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    public sealed partial class CleaningAndDebloatPage : Page
    {
        private CleaningAndDebloatViewModel ViewModel { get; }

        public CleaningAndDebloatPage()
        {
            this.InitializeComponent();
            ViewModel = new CleaningAndDebloatViewModel();
        }

        private async void SystemCleaner_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Cleaning system...";
            try
            {
                await ViewModel.SystemCleaner();
                StatusText.Text = "✓ System cleaned successfully";
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

        private async void ExtendedCleaner_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Performing extended cleaning...";
            try
            {
                await ViewModel.ExtendedCleaner();
                StatusText.Text = "✓ Extended cleaning completed successfully";
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

        private async void JunkFinder_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Finding junk files...";
            try
            {
                await ViewModel.JunkFinder();
                StatusText.Text = "✓ Junk files removed successfully";
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

        private async void RemoveBloatware_Click(object sender, RoutedEventArgs e)
        {
            var confirmed = await DialogHelper.ShowWarningDialog(
                "Remove Bloatware",
                "• Removes pre-installed Windows apps\n" +
                "• Cannot be easily reversed\n" +
                "• Some apps may be needed by system features",
                XamlRoot
            );

            if (!confirmed) return;

            ProgressRing.IsActive = true;
            StatusText.Text = "Removing bloatware...";

            await SystemAndSafetyViewModel.CreateRestorePointAsync("Before Bloatware Removal");

            try
            {
                await ViewModel.RemoveBloatware();
                StatusText.Text = "✓ Bloatware removed successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(
                    $"Failed to remove bloatware.\n\n" +
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

        private void AdvancedDebloater_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(AdvancedDebloaterPage));
        }

        private async void UninstallEdgeAndOneDrive_Click(object sender, RoutedEventArgs e)
        {
            var confirmed = await DialogHelper.ShowWarningDialog(
                "Uninstall Edge and OneDrive",
                "• Attempts to remove deeply integrated Microsoft applications\n" +
                "• This is a high-risk operation\n" +
                "• May cause issues with Windows Update and other system features",
                XamlRoot
            );

            if (!confirmed) return;

            ProgressRing.IsActive = true;
            StatusText.Text = "Uninstalling Edge and OneDrive...";

            await SystemAndSafetyViewModel.CreateRestorePointAsync("Before Uninstalling Edge and OneDrive");

            try
            {
                await ViewModel.UninstallEdgeAndOneDrive();
                StatusText.Text = "✓ Edge and OneDrive uninstalled successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(
                    $"Failed to uninstall Edge and OneDrive.\n\n" +
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

        private async void ScheduledCleaning_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Creating scheduled cleaning tasks...";
            try
            {
                var vm = new ScheduledCleaningViewModel();
                await vm.CreateWeeklyCleaningTasks();
                StatusText.Text = "✓ Weekly cleaning tasks have been created";
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
