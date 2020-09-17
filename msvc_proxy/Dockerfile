# Windows-based Dockerfile to reproduce GE proxy problems
# Steps to reproduce:
# - Install Docker for Windows.
# - Start Docker and switch to Windows containers
# - Download GE_External_Root_CA_2_1.cer to this folder
# - Run "docker build -t ge_proxy:latest ." from this folder
# - Run "docker run --rm -it ge_proxy" from this folder
# - Run running a file download command from within the containter

# Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell
SHELL ["cmd", "/S", "/C"]

# Add GE root certificate
# REF: https://static.gecirtnotification.com/browser_remediation/sop_server_v1.html
COPY GE_External_Root_CA_2_1.cer  C:\\GE_External_Root_CA_2_1.cer
RUN certutil –addstore –f "root" C:\\GE_External_Root_CA_2_1.cer

# Configure GE proxy (doesn't work)
RUN netsh winhttp set proxy proxy-server=PITC-Zscaler-EMEA-Amsterdam3PR.proxy.corporate.ge.com:80 bypass-list="no_proxy=localhost;*.ge.com"
ENV https_proxy=http://pitc-zscaler-emea-amsterdam3pr.proxy.corporate.ge.com:80
ENV http_proxy=http://pitc-zscaler-emea-amsterdam3pr.proxy.corporate.ge.com:80
ENV no_proxy=localhost,.ge.com

# Test network connection
#RUN powershell ((New-Object System.Net.WebClient).DownloadString('https://github.build.ge.com')) # does work
#RUN powershell ((New-Object System.Net.WebClient).DownloadString('https://tools.ietf.org/html/rfc2616')) # remote name could not be resolved: 'www.news.com'
