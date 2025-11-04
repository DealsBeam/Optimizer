using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace OptimizerGUI.Views
{
    public sealed partial class ManagementAndCustomizationPage : Page
    {
        public ManagementAndCustomizationPage()
        {
            this.InitializeComponent();
        }

        private void AppManager_Click(object sender, RoutedEventArgs e) { }
        private void StartupManager_Click(object sender, RoutedEventArgs e) { }
        private void WindowsFeaturesManager_Click(object sender, RoutedEventArgs e) { }
        private void DesktopContextMenuEditor_Click(object sender, RoutedEventArgs e) { }
        private void UIAndPersonalization_Click(object sender, RoutedEventArgs e) { }
        private void TaskbarCustomization_Click(object sender, RoutedEventArgs e) { }
        private void DWMTweaks_Click(object sender, RoutedEventArgs e) { }
    }
}
