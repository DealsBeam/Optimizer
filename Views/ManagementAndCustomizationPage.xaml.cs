using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    /// <summary>
    /// Represents the page for the Management and Customization feature.
    /// </summary>
    public sealed partial class ManagementAndCustomizationPage : Page
    {
        private ManagementAndCustomizationViewModel ViewModel { get; }

        /// <summary>
        /// Initializes a new instance of the <see cref="ManagementAndCustomizationPage"/> class.
        /// </summary>
        public ManagementAndCustomizationPage()
        {
            this.InitializeComponent();
            ViewModel = new ManagementAndCustomizationViewModel();
        }

        /// <summary>
        /// Handles the click event for the app manager button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void AppManager_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Opening App Manager...";
            try
            {
                await ViewModel.AppManager();
                StatusText.Text = "✓ App Manager opened successfully";
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
        /// Handles the click event for the startup manager button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void StartupManager_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Getting startup programs...";
            try
            {
                var output = await ViewModel.StartupManager();
                await DialogHelper.ShowMessageDialog("Startup Programs", output, XamlRoot);
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
        /// Handles the click event for the Windows features manager button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void WindowsFeaturesManager_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Opening Windows Features Manager...";
            try
            {
                await ViewModel.WindowsFeaturesManager();
                StatusText.Text = "✓ Windows Features Manager opened successfully";
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
        /// Handles the click event for the desktop context menu editor button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void DesktopContextMenuEditor_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Editing desktop context menu...";
            try
            {
                await ViewModel.DesktopContextMenuEditor();
                StatusText.Text = "✓ Desktop context menu edited successfully";
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
        /// Handles the click event for the UI and personalization button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void UIAndPersonalization_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Applying UI and personalization tweaks...";
            try
            {
                await ViewModel.UIAndPersonalization();
                StatusText.Text = "✓ UI and personalization tweaks applied successfully";
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
        /// Handles the click event for the taskbar customization button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void TaskbarCustomization_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Applying taskbar customization...";
            try
            {
                await ViewModel.TaskbarCustomization();
                StatusText.Text = "✓ Taskbar customization applied successfully";
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
        /// Handles the click event for the DWM tweaks button.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">The event arguments.</param>
        private async void DWMTweaks_Click(object sender, RoutedEventArgs e)
        {
            ProgressRing.IsActive = true;
            StatusText.Text = "Applying DWM tweaks...";
            try
            {
                await ViewModel.DWMTweaks();
                StatusText.Text = "✓ DWM tweaks applied successfully";
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
