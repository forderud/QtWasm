:: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019

:: Incraase container disk space:
:: https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-storage#storage-limits
:: RUN "fsutil volume diskfree c:"

:: Copy Qt license files
copy %APPDATA%\Qt\*.ini .
:: Export proxy settings from host
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" GE_proxy.reg /y


docker build -t buildtools2019:latest -m 4GB .

pause
