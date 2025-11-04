using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;

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
            try { await ViewModel.AppManager(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void StartupManager_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var output = await ViewModel.StartupManager();
                await DialogHelper.ShowMessageDialog("Startup Programs", output, XamlRoot);
            }
            catch (Exception ex)
            {
                await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
            }
        }

        private async void WindowsFeaturesManager_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.WindowsFeaturesManager(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void DesktopContextMenuEditor_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.DesktopContextMenuEditor(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void UIAndPersonalization_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.UIAndPersonalization(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void TaskbarCustomization_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.TaskbarCustomization(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void DWMTweaks_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.DWMTweaks(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }
    }
}
