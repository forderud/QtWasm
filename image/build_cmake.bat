:: Build container
docker build --file cmake\Dockerfile --tag=forderud/wasmbuilder:cmake .

:: Push to dockerhub
docker tag forderud/wasmbuilder:cmake forderud/wasmbuilder:cmake
docker push forderud/wasmbuilder:cmake

pause
