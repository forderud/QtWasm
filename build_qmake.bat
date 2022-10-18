mkdir build

:: Input sources must be found in "sample" subfolder
:: Output binaries will be written to "build" subfolder
docker run --rm -v C:\Dev\QtWasm\sample:/project/source -v C:\Dev\QtWasm\build:/project/build forderud/qtwasm:latest /bin/bash -c "export PATH=$PATH:/project/Qt/bin;qmake /project/source && make"
