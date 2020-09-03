:: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019
:: https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-storage#storage-limits

docker build -t buildtools2019:latest -m 4GB .

pause
