Dockerfile for building a containerized Qt SW development environment for WebAssembly. The Docker images are published at [forderud/qtwasm](https://hub.docker.com/repository/docker/forderud/qtwasm) on Docker Hub.

## Prerequisites
Instructions:
* Download and install Docker desktop from https://www.docker.com/products/docker-desktop/
* Start Docker desktop in "Linux container" mode

## How to build the image
Look at the scripts in the `image` subfolder.

Docker cleanup:
* Clean local images: `docker image prune`
* Clean build cache: `docker builder prune`

## How to use the image
From a Windows host:
* Run `build_cmake.bat` to build the sample project using CMake. A web browser will automatically open and load the app after the build process have completed.

## References
* [Qt for WebAssembly](https://doc.qt.io/qt-6/wasm.html)
* Qt [Building projects on the command line](https://doc.qt.io/qt-6/cmake-build-on-cmdline.html) - documents `qt-cmake`
* [Emscripten.cmake](https://github.com/emscripten-core/emscripten/blob/main/cmake/Modules/Platform/Emscripten.cmake) toolchain for CMake (automatically applied by `qt-cmake`)
