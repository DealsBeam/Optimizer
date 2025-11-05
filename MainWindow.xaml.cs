using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.Views;

namespace OptimizerGUI
{
    /// <summary>
    /// Represents the main window of the application.
    /// </summary>
    public sealed partial class MainWindow : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="MainWindow"/> class.
        /// </summary>
        public MainWindow()
        {
            this.InitializeComponent();
            Title = "OptimizerGUI";
            this.Loaded += (s, e) => NavigationView.SelectedItem = NavigationView.MenuItems[0];
        }

        /// <summary>
        /// Handles the selection changed event for the navigation view.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="args">The event arguments.</param>
        private void NavigationView_SelectionChanged(NavigationView sender, NavigationViewSelectionChangedEventArgs args)
        {
            if (args.IsSettingsSelected || args.SelectedItem is NavigationViewItem item && item.Tag?.ToString() == "Settings")
            {
                ContentFrame.Navigate(typeof(SettingsPage));
                return;
            }

            var selectedItem = (NavigationViewItem)args.SelectedItem;
            if (selectedItem != null)
            {
                string selectedItemTag = (string)selectedItem.Tag;
                switch (selectedItemTag)
                {
                    case "SystemAndNetwork":
                        ContentFrame.Navigate(typeof(SystemAndNetworkPage));
                        break;
                    case "CleaningAndDebloat":
                        ContentFrame.Navigate(typeof(CleaningAndDebloatPage));
                        break;
                    case "ManagementAndCustomization":
                        ContentFrame.Navigate(typeof(ManagementAndCustomizationPage));
                        break;
                    case "SystemAndSafety":
                        ContentFrame.Navigate(typeof(SystemAndSafetyPage));
                        break;
                }
            }
        }
    }
}
