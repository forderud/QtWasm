Dockerfile for building a containerized Qt SW development environment for WebAssembly. The Docker images are published at [forderud/qtwasm](https://hub.docker.com/repository/docker/forderud/qtwasm) on Docker Hub.

## How to build the image
Look at the scripts in the `image` subfolder.

## How to use the image
From a Windows host:
* Run either `build_cmake.bat` or `build_qmake.bat` to build the sample project using either QMake or CMake.
* Run `run_webserver.bat` to start a webserver for serving the Qt app.
*  Open `http://localhost:80` in a web browser and navigate to the html page to test the web app.

## References
* https://blog.qt.io/blog/2019/03/05/using-docker-test-qt-webassembly/
* CMake toolkit: https://github.com/emscripten-core/emscripten/blob/main/cmake/Modules/Platform/Emscripten.cmake
