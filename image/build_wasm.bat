cd build_wasm

:: Build container
docker build --tag=forderud/wasmbuilder:build_wasm .

:: Push to dockerhub
docker tag forderud/wasmbuilder:build_wasm forderud/wasmbuilder:build_wasm
docker push forderud/wasmbuilder:build_wasm

pause
