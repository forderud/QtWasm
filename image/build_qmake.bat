cd qmake

:: Build container
docker build --tag=forderud/wasmbuilder:qmake .

:: Push to dockerhub
docker tag forderud/wasmbuilder:qmake forderud/wasmbuilder:qmake
docker push forderud/wasmbuilder:qmake

pause
