using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;

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
            await ViewModel.OptimizeNetwork();
        }

        private async void OptimizeDNS_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.OptimizeDNS();
        }

        private async void ResetNetworkAdapter_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.ResetNetworkAdapter();
        }

        private async void ManageServices_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.ManageServices();
        }

        private async void InputLatencyTweaks_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.InputLatencyTweaks();
        }

        private async void GameMode_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.GameMode();
        }

        private async void AdvancedWindowsTweaks_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.AdvancedWindowsTweaks();
        }

        private async void UltimatePerformance_Click(object sender, RoutedEventArgs e)
        {
            await ViewModel.UltimatePerformance();
        }
    }
}
