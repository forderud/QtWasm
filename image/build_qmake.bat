:: Build container
docker build --file qmake\Dockerfile --tag=forderud/wasmbuilder:qmake .

:: Push to dockerhub
docker tag forderud/wasmbuilder:qmake forderud/wasmbuilder:qmake
docker push forderud/wasmbuilder:qmake

pause
