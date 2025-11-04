using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace OptimizerGUI.Views
{
    public sealed partial class CleaningAndDebloatPage : Page
    {
        public CleaningAndDebloatPage()
        {
            this.InitializeComponent();
        }

        private void SystemCleaner_Click(object sender, RoutedEventArgs e) { }
        private void ExtendedCleaner_Click(object sender, RoutedEventArgs e) { }
        private void JunkFinder_Click(object sender, RoutedEventArgs e) { }
        private void RemoveBloatware_Click(object sender, RoutedEventArgs e) { }
        private void AdvancedDebloater_Click(object sender, RoutedEventArgs e) { }
        private void UninstallEdgeAndOneDrive_Click(object sender, RoutedEventArgs e) { }
        private void ScheduledCleaning_Click(object sender, RoutedEventArgs e) { }
    }
}
