# escape=`

# Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Add GE root certificate
# REF: https://static.gecirtnotification.com/browser_remediation/sop_server_v1.html
COPY GE_External_Root_CA_2_1.cer  C:\TEMP\
RUN certutil –addstore –f "root" C:\TEMP\GE_External_Root_CA_2_1.cer

# Configure GE proxy (doesn't work)
RUN netsh winhttp set proxy proxy-server=PITC-Zscaler-EMEA-Amsterdam3PR.proxy.corporate.ge.com:80 bypass-list="no_proxy=localhost;*.ge.com"
COPY GE_proxy.reg C:\TEMP\
#RUN reg import C:\TEMP\GE_proxy.reg
ENV https_proxy=http://pitc-zscaler-emea-amsterdam3pr.proxy.corporate.ge.com:80
ENV http_proxy=http://pitc-zscaler-emea-amsterdam3pr.proxy.corporate.ge.com:80
ENV no_proxy=localhost,.ge.com

# Test network connection
RUN powershell ((New-Object System.Net.WebClient).DownloadString('https://github.build.ge.com')) # does work
RUN powershell ((New-Object System.Net.WebClient).DownloadString('https://www.news.com'))        # remote name could not be resolved: 'www.news.com'
