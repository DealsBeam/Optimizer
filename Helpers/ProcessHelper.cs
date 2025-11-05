using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace OptimizerGUI.Helpers
{
    public class ProcessResult
    {
        public bool Success { get; set; }
        public int ExitCode { get; set; }
        public string Output { get; set; }
        public string Error { get; set; }
    }

    public static class ProcessHelper
    {
        public static async Task<ProcessResult> RunProcessAsync(
            string fileName,
            string arguments,
            bool captureOutput = true,
            bool throwOnError = true)
        {
            var process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = fileName,
                    Arguments = arguments,
                    RedirectStandardOutput = captureOutput,
                    RedirectStandardError = captureOutput,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };

            try
            {
                process.Start();

                string output = captureOutput ? await process.StandardOutput.ReadToEndAsync() : string.Empty;
                string error = captureOutput ? await process.StandardError.ReadToEndAsync() : string.Empty;

                await process.WaitForExitAsync();

                var result = new ProcessResult
                {
                    Success = process.ExitCode == 0,
                    ExitCode = process.ExitCode,
                    Output = output,
                    Error = error
                };

                if (!result.Success && throwOnError)
                {
                    throw new Exception($"Command failed (Exit Code {result.ExitCode}): {fileName} {arguments}\n\nError: {error}");
                }

                return result;
            }
            finally
            {
                process?.Dispose();
            }
        }
    }
}