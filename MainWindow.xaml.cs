using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;
using OptimizerGUI.Views;

namespace OptimizerGUI
{
    public sealed partial class MainWindow : Window
    {
        public MainWindow()
        {
            this.InitializeComponent();
            Title = "OptimizerGUI";
            this.Loaded += (s, e) => NavigationView.SelectedItem = NavigationView.MenuItems[0];
        }

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
