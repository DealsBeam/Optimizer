using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;

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
            try { await ViewModel.OptimizeNetwork(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void OptimizeDNS_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.OptimizeDNS(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void ResetNetworkAdapter_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.ResetNetworkAdapter(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void ManageServices_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.ManageServices(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void InputLatencyTweaks_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.InputLatencyTweaks(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void GameMode_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.GameMode(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void AdvancedWindowsTweaks_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.AdvancedWindowsTweaks(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }

        private async void UltimatePerformance_Click(object sender, RoutedEventArgs e)
        {
            try { await ViewModel.UltimatePerformance(); }
            catch (Exception ex) { await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot); }
        }
    }
}
