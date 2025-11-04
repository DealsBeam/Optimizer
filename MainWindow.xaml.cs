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
        }

        private void NavigationView_SelectionChanged(NavigationView sender, NavigationViewSelectionChangedEventArgs args)
        {
            if (args.IsSettingsSelected)
            {
                // Navigate to settings page if you have one
            }
            else
            {
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
}
