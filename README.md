# QtWasm
Dockerfile for building Qt projects for WebAssembly in a Docker container.

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
