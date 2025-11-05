using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    /// <summary>
    /// Represents the page for the System and Network feature.
    /// </summary>
    public sealed partial class SystemAndNetworkPage : Page
    {
        private SystemAndNetworkViewModel ViewModel { get; }

        /// <summary>
        /// Initializes a new instance of the <see cref="SystemAndNetworkPage"/> class.
        /// </summary>
        public SystemAndNetworkPage()
        {
            this.InitializeComponent();
            ViewModel = new SystemAndNetworkViewModel();
        }

        /// <summary>
        /// Handles the click event for the optimize network button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the optimize DNS button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the reset network adapter button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the manage services button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the input latency tweaks button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the game mode button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the advanced Windows tweaks button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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

        /// <summary>
        /// Handles the click event for the ultimate performance button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
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
