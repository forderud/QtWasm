@echo off

:: clean up any previous builds
rmdir build /s /q

mkdir build

:: Input sources must be found in "sample" subfolder
:: Output binaries will be written to "build" subfolder

:: Valid choices are "Debug", "RelWithDebInfo", "Release" (also default)
set BUILD_TYPE=%1
set DOCKER_IMAGE=forderud/qtwasm:latest
set MOUNT_SOURCE=-v %cd%\sample:/project/source
set MOUNT_BUILD=-v %cd%\build:/project/build

if "%BUILD_TYPE%"=="" (
  :: Default build settings
  docker run --rm %MOUNT_SOURCE% %MOUNT_BUILD% %DOCKER_IMAGE% || exit /b 1
) else (
  :: Custom build settings
  copy image\wasm.cmake sample
  docker run --rm %MOUNT_SOURCE% %MOUNT_BUILD% %DOCKER_IMAGE% /bin/bash -c "/opt/Qt/bin/qt-cmake -DQT_CHAINLOAD_TOOLCHAIN_FILE=/project/source/wasm.cmake -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -G Ninja /project/source && ninja" || exit /b 1
)

:: Serve the webpage from current folder (%cd% ==> within docker that is /project)
:: To reflect what was built, we need /project/source and /project/build available
:: Correct file-mapping will make it possible to attach a debugger later 
set LOCAL_DEPLOY_FOLDER=%cd%
set DOCKER_DEPLOY_FOLDER=/project

start http://localhost:8080/build/app/helloworld.html

docker run --rm -p 8080:8080 ^
    -v %LOCAL_DEPLOY_FOLDER%:%DOCKER_DEPLOY_FOLDER% ^
    %MOUNT_SOURCE% ^
    -w %DOCKER_DEPLOY_FOLDER% %DOCKER_IMAGE% ^
    python3 WebServer.py 8080
