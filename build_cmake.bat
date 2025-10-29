:: clean up any previous builds
rmdir build /s /q

mkdir build

:: Input sources must be found in "sample" subfolder
:: Output binaries will be written to "build" subfolder

:: Default build settings
docker run --rm -v %cd%\sample:/project/source -v %cd%\build:/project/build forderud/qtwasm:latest || exit /b 1

:: Custom build settings
::docker run --rm -v %cd%\sample:/project/source -v %cd%\build:/project/build forderud/qtwasm:latest /bin/bash -c "/opt/Qt/bin/qt-cmake -DQT_CHAINLOAD_TOOLCHAIN_FILE=/project/source/wasm.cmake -DCMAKE_BUILD_TYPE=Release -G Ninja /project/source && ninja" || exit /b 1

run_webserver.bat
