Dockerfile for building a containerized Qt SW development environment for WebAssembly. The Docker images are published at [forderud/qtwasm](https://hub.docker.com/repository/docker/forderud/qtwasm) on Docker Hub.

Look at `run_cmake.bat` and `run_qmake.bat` for how to build QMake and CMake projects from a Windows host.

## Docker cheat sheet
List images:
```
docker image ls
```
Delete image:
```
docker image rm <name>:<tag>
```

## References
* https://blog.qt.io/blog/2019/03/05/using-docker-test-qt-webassembly/
* CMake toolkit: https://github.com/emscripten-core/emscripten/blob/incoming/cmake/Modules/Platform/Emscripten.cmake
