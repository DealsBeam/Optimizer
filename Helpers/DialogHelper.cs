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

        public static async Task<bool> ShowConfirmationDialog(string title, string message, string primaryButtonText = "Continue", string secondaryButtonText = "Cancel", XamlRoot xamlRoot)
        {
            ContentDialog dialog = new ContentDialog
            {
                Title = title,
                Content = message,
                PrimaryButtonText = primaryButtonText,
                SecondaryButtonText = secondaryButtonText,
                DefaultButton = ContentDialogButton.Secondary,
                XamlRoot = xamlRoot
            };

            var result = await dialog.ShowAsync();
            return result == ContentDialogResult.Primary;
        }

        public static async Task<bool> ShowWarningDialog(string operation, string consequences, XamlRoot xamlRoot)
        {
            var message = $"⚠️ Warning\n\n" +
                          $"Operation: {operation}\n\n" +
                          $"Consequences:\n{consequences}\n\n" +
                          $"A restore point will be created automatically.\n\n" +
                          $"Do you want to continue?";

            return await ShowConfirmationDialog("Confirm Operation", message, "Yes, Continue", "Cancel", xamlRoot);
        }
    }
}
