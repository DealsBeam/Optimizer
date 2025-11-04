using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;

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
            try { await ViewModel.SystemInformation(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void AdvancedPrivacy_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.AdvancedPrivacy(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void CreateRestorePoint_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.CreateRestorePoint(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void RestoreCenter_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.RestoreCenter(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }
    }
}
