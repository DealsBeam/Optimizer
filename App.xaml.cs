using Microsoft.UI.Xaml;
using OptimizerGUI.Helpers;
using Serilog;
using System;

namespace OptimizerGUI
{
    public partial class App : Application
    {
        private Window m_window;

        public App()
        {
            this.InitializeComponent();
            Logger.Initialize(); // Add this
        }

        protected override void OnLaunched(LaunchActivatedEventArgs args)
        {
            try
            {
                m_window = new MainWindow();
                m_window.Activate();
            }
            catch (Exception ex)
            {
                Log.Fatal(ex, "Application startup failed");
                throw;
            }
        }
    }
}
