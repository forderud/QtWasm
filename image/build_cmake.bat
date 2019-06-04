:: Build container
docker build --file Dockerfile.cmake --tag=forderud/wasmbuilder:cmake .

:: Push to dockerhub
docker tag forderud/wasmbuilder:cmake forderud/wasmbuilder:cmake
docker push forderud/wasmbuilder:cmake

pause
