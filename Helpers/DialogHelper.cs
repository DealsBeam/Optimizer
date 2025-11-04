using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using System;
using System.Threading.Tasks;

namespace OptimizerGUI.Helpers
{
    public static class DialogHelper
    {
        public static async Task ShowErrorDialog(string message, XamlRoot xamlRoot)
        {
            ContentDialog dialog = new ContentDialog
            {
                Title = "Error",
                Content = message,
                CloseButtonText = "OK",
                XamlRoot = xamlRoot
            };
            await dialog.ShowAsync();
        }

        public static async Task ShowMessageDialog(string title, string message, XamlRoot xamlRoot)
        {
            ContentDialog dialog = new ContentDialog
            {
                Title = title,
                Content = message,
                CloseButtonText = "OK",
                XamlRoot = xamlRoot
            };
            await dialog.ShowAsync();
        }

        public static async Task ShowSuccessDialog(string message, XamlRoot xamlRoot)
        {
            ContentDialog dialog = new ContentDialog
            {
                Title = "Success",
                Content = message,
                CloseButtonText = "OK",
                XamlRoot = xamlRoot
            };
            await dialog.ShowAsync();
        }
    }
}
