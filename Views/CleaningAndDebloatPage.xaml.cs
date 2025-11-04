using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;

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
            try { await ViewModel.SystemCleaner(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void ExtendedCleaner_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.ExtendedCleaner(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void JunkFinder_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.JunkFinder(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void RemoveBloatware_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.RemoveBloatware(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private void AdvancedDebloater_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(AdvancedDebloaterPage));
        }

        private async void UninstallEdgeAndOneDrive_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.UninstallEdgeAndOneDrive(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void ScheduledCleaning_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var vm = new ScheduledCleaningViewModel();
                await vm.CreateWeeklyCleaningTasks();
                await DialogHelper.ShowSuccessDialog("Weekly cleaning tasks have been created.", XamlRoot);
            }
            catch (Exception ex)
            {
                await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
            }
        }
    }
}
