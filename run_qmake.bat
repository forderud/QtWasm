mkdir C:\Dev\QtWasm\build

:: Input sources must be found in C:\Dev\QtWasm\source
:: Output binaries will be written to C:\Dev\QtWasm\build
docker run --rm -v C:\Dev\QtWasm\source:/project/source -v C:\Dev\QtWasm\build:/project/build forderud/qtwasm:latest /bin/bash -c "export PATH=$PATH:/project/Qt/bin;qmake /project/source && make"

pause
