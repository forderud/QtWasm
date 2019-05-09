# QtWasm
Qt WebAssembly experimentation

### Outstanding problems
```
qt.qpa.plugin: Could not find the Qt platform plugin "wasm" in "" helloworld.html:1:508
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem. 
```

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
* https://github.com/emscripten-core/emscripten/blob/incoming/cmake/Modules/Platform/Emscripten.cmake
