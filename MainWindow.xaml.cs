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
                    string selectedItemTag = ((string)selectedItem.Tag);

                    Type pageType = Type.GetType($"OptimizerGUI.Views.{selectedItemTag}Page");
                    if (pageType != null)
                    {
                        ContentFrame.Navigate(pageType);
                    }
                }
            }
        }
    }
}
