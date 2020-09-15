# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download VS2019 bootstrapper.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Install C++ workload with CMake
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended;includeOptional `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Install Chocolatey (based on https://chocolatey.org/install#individual)
RUN powershell -ExecutionPolicy Bypass -Command [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Python, Git & SVN
RUN choco install -y python && `
    choco install -y git && `
    choco install -y svn

# Install Qt
ADD http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe C:\TEMP\qt-unified-windows-x86-online.exe
ADD qt-installer-noninteractive.qs C:\TEMP\qt-installer-noninteractive.qs

RUN C:\TEMP\qt-unified-windows-x86-online.exe --script C:\TEMP\qt-installer-noninteractive.qs --platform=minimal --logging-rules "ifw.*=true" --verbose

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
