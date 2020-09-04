:: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019

:: Incraase container disk space:
:: https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-storage#storage-limits
:: RUN "fsutil volume diskfree c:"


docker build -t buildtools2019:latest -m 4GB .

pause
