using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using OptimizerGUI.ViewModels;
using OptimizerGUI.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OptimizerGUI.Views
{
    public sealed partial class AdvancedDebloaterPage : Page
    {
        private AdvancedDebloaterViewModel ViewModel { get; }

        public AdvancedDebloaterPage()
        {
            this.InitializeComponent();
            ViewModel = new AdvancedDebloaterViewModel();
            Loaded += OnPageLoaded;
        }

        private async void OnPageLoaded(object sender, RoutedEventArgs e)
        {
            try
            {
                var apps = await ViewModel.GetRemovableApps();
                AppsListView.ItemsSource = apps;
            }
            catch (Exception ex)
            {
                await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
            }
        }

        private async void UninstallButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedApps = AppsListView.SelectedItems.Cast<string>().ToList();
            if (selectedApps.Count > 0)
            {
                try
                {
                    await ViewModel.UninstallApps(selectedApps);
                }
                catch (Exception ex)
                {
                    await DialogHelper.ShowErrorDialog(ex.Message, XamlRoot);
                }
            }
        }
    }
}
