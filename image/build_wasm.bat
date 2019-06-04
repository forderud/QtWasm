:: Build container
docker build --file build_wasm\Dockerfile --tag=forderud/wasmbuilder:build_wasm .

:: Push to dockerhub
docker tag forderud/wasmbuilder:build_wasm forderud/wasmbuilder:build_wasm
docker push forderud/wasmbuilder:build_wasm

pause
