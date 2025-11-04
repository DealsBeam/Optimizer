# Contributing to OptimizerGUI

First off, thank you for considering contributing to OptimizerGUI! Your help is appreciated.

## How Can I Contribute?

### Reporting Bugs
If you find a bug, please open an issue and provide the following:
- A clear and descriptive title.
- Steps to reproduce the bug.
- The expected behavior and what actually happened.
- Your Windows 11 version and build number.

### Suggesting Enhancements
If you have an idea for a new feature or an improvement to an existing one, please open an issue with a clear description of your suggestion and why it would be valuable.

### Pull Requests
We welcome pull requests! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature` or `bugfix/YourBug`).
3. Make your changes.
4. Ensure your code follows the project's coding style.
5. Commit your changes (`git commit -m 'Add some feature'`).
6. Push to the branch (`git push origin feature/YourFeature`).
7. Open a pull request.

## Development Setup
This project is built with C# and WinUI 3. To build it from source, you will need Visual Studio 2022 with the ".NET Multi-platform App UI development" workload installed.

You can compile the application into a single, self-contained executable using the following `dotnet` command:
```
dotnet publish -r win-x64 -c Release --self-contained true -p:PublishSingleFile=true -o releases
```
