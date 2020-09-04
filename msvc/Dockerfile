# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download VS2019 bootstrapper.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Configure GE proxy (needed since vs_buildtools doesn't seem to pick up proxy settings from Docker)
# VisualStudio Bootstrapper:9/4/2020 9:13:17 AM: Attempting download 'https://aka.ms/vs/16/release/installer' using engine 'WinInet'
# VisualStudio Bootstrapper:9/4/2020 9:13:17 AM: Error in 'InternetOpenUrl' with '12007' - 'Unknown error 12007'.
# VisualStudio Bootstrapper:9/4/2020 9:13:17 AM: WinInet error 'UnknownError' Function: InternetOpenUrl, HR: -2147012889, Message: Unknown error 12007 - proxy setting 'DefaultCredentialsOrNoAutoProxy' - 'https://aka.ms/vs/16/release/installer'.
# WARNING: Doesn't seem to work
# RUN "set proxy proxy-server=pitc-zscaler-emea-amsterdam3pr.proxy.corporate.ge.com:80"

# Install C++ workload with CMake
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended;includeOptional `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
