using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Views
{
    public sealed partial class ManagementAndCustomizationPage : Page
    {
        private ManagementAndCustomizationViewModel ViewModel { get; }

        public ManagementAndCustomizationPage()
        {
            this.InitializeComponent();
            ViewModel = new ManagementAndCustomizationViewModel();
        }

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
