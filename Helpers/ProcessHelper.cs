using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace OptimizerGUI.Helpers
{
    /// <summary>
    /// Represents the result of an external process execution.
    /// </summary>
    public class ProcessResult
    {
        /// <summary>
        /// Gets or sets a value indicating whether the process executed successfully.
        /// </summary>
        public bool Success { get; set; }

        /// <summary>
        /// Gets or sets the exit code of the process.
        /// </summary>
        public int ExitCode { get; set; }

        /// <summary>
        /// Gets or sets the standard output of the process.
        /// </summary>
        public string Output { get; set; }

        /// <summary>
        /// Gets or sets the standard error of the process.
        /// </summary>
        public string Error { get; set; }
    }

    /// <summary>
    /// Provides helper methods for running external processes.
    /// </summary>
    public static class ProcessHelper
    {
        /// <summary>
        /// Runs an external process asynchronously.
        /// </summary>
        /// <param name="fileName">The name of the file to execute.</param>
        /// <param name="arguments">The command-line arguments to pass to the process.</param>
        /// <param name="captureOutput">A value indicating whether to capture the standard output and error streams.</param>
        /// <param name="throwOnError">A value indicating whether to throw an exception if the process returns a non-zero exit code.</param>
        /// <returns>A <see cref="ProcessResult"/> object containing the results of the process execution.</returns>
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