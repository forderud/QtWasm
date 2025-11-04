@echo off

:: clean up any previous builds
rmdir build /s /q

mkdir build

:: Input sources must be found in "sample" subfolder
:: Output binaries will be written to "build" subfolder

:: Valid choices are "Debug", "RelWithDebInfo", "Release" (also default)
set BUILD_TYPE=%1
set DOCKER_IMAGE=forderud/qtwasm:latest

if "%BUILD_TYPE%"=="" (
  :: Default build settings
  docker run --rm -v %cd%\sample:/project/source -v %cd%\build:/project/build %DOCKER_IMAGE% || exit /b 1
) else (
  :: Custom build settings
  copy image\wasm.cmake sample
  docker run --rm -v %cd%\sample:/project/source -v %cd%\build:/project/build %DOCKER_IMAGE% /bin/bash -c "/opt/Qt/bin/qt-cmake -DQT_CHAINLOAD_TOOLCHAIN_FILE=/project/source/wasm.cmake -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -G Ninja /project/source && ninja" || exit /b 1
)

run_webserver.bat
