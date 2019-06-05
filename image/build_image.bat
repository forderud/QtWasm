:: Build container
docker build --file Dockerfile --tag=forderud/wasmbuilder .

:: Push to dockerhub (to "latest" tag)
docker push forderud/wasmbuilder

pause
