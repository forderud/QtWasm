# escape=`

# Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Add GE root certificate
COPY GE_External_Root_CA_2_1.cer  C:\TEMP\
RUN certutil –addstore –f "root" C:\TEMP\GE_External_Root_CA_2_1.cer

# Install Visual C++ workload with CMake
# REF: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019
# REF: https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2019
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended;includeOptional `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Install Qt
ADD http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe C:\TEMP\qt-unified-windows-x86-online.exe
ADD qt-installer-noninteractive.qs C:\TEMP\qt-installer-noninteractive.qs
# Copy Qt license from host
COPY *.ini  C:\TEMP\
RUN mkdir %APPDATA%\Qt && copy C:\TEMP\*.ini %APPDATA%\Qt\
# Run Qt installer noninteractively in scripted mode
RUN C:\TEMP\qt-unified-windows-x86-online.exe --script C:\TEMP\qt-installer-noninteractive.qs --platform=minimal --logging-rules "ifw.*=true" --verbose
ENV QT_ROOT_64=C:\Qt\5.15.1\msvc2019_64

# Install Chocolatey (based on https://chocolatey.org/install#individual)
RUN powershell -ExecutionPolicy Bypass -Command [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Python, Git & SVN
RUN choco install -y python && `
    choco install -y git && `
    choco install -y svn

# Install Python modules
RUN pip install comtypes numpy

# start developer command prompt
ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat && CMD ["cmd.exe"]
