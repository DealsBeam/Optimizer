using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    public sealed partial class SystemAndNetworkPage : Page
    {
        private SystemAndNetworkViewModel ViewModel { get; }

        public SystemAndNetworkPage()
        {
            this.InitializeComponent();
            ViewModel = new SystemAndNetworkViewModel();
        }

        private async void OptimizeNetwork_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Optimizing network settings...";
            try
            {
                await ViewModel.OptimizeNetwork();
                StatusText.Text = "✓ Network optimized successfully";
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

        private async void OptimizeDNS_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Optimizing DNS...";
            try
            {
                await ViewModel.OptimizeDNS();
                StatusText.Text = "✓ DNS optimized successfully";
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

        private async void ResetNetworkAdapter_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Resetting network adapter...";
            try
            {
                await ViewModel.ResetNetworkAdapter();
                StatusText.Text = "✓ Network adapter reset successfully";
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

        private async void ManageServices_Click(object sender, RoutedEventArgs e)
        {
            var confirmed = await DialogHelper.ShowWarningDialog(
                "Manage Services",
                "• Disables SysMain and DiagTrack services\n" +
                "• May impact certain system features",
                XamlRoot
            );

            if (!confirmed) return;

            ProgressRing.IsActive = true;
            StatusText.Text = "Managing services...";

            await SystemAndSafetyViewModel.CreateRestorePointAsync("Before Managing Services");

            try
            {
                await ViewModel.ManageServices();
                StatusText.Text = "✓ Services managed successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(
                    $"Failed to manage services.\n\n" +
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

        private async void InputLatencyTweaks_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Applying input latency tweaks...";
            try
            {
                await ViewModel.InputLatencyTweaks();
                StatusText.Text = "✓ Input latency tweaks applied successfully";
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

        private async void GameMode_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Applying game mode tweaks...";
            try
            {
                await ViewModel.GameMode();
                StatusText.Text = "✓ Game mode tweaks applied successfully";
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

        private async void AdvancedWindowsTweaks_Click(object sender, RoutedEventArgs e)
        {
            var confirmed = await DialogHelper.ShowWarningDialog(
                "Advanced Windows Tweaks",
                "• Disables Prefetch and Superfetch\n" +
                "• May affect system performance",
                XamlRoot
            );

            if (!confirmed) return;

            ProgressRing.IsActive = true;
            StatusText.Text = "Applying advanced Windows tweaks...";

            await SystemAndSafetyViewModel.CreateRestorePointAsync("Before Advanced Windows Tweaks");

            try
            {
                await ViewModel.AdvancedWindowsTweaks();
                StatusText.Text = "✓ Advanced Windows tweaks applied successfully";
                await Task.Delay(2000);
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                await DialogHelper.ShowErrorDialog(
                    $"Failed to apply advanced Windows tweaks.\n\n" +
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

        private async void UltimatePerformance_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Enabling Ultimate Performance power plan...";
            try
            {
                await ViewModel.UltimatePerformance();
                StatusText.Text = "✓ Ultimate Performance power plan enabled successfully";
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
