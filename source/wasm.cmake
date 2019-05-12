# Add WebAssembly compile & linker flags:
# USE_WEBGL2:          https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#webgl-friendly-subset-of-opengl-es-2-0-3-0
# FULL_ES2/3:          Emulate missing WebGL features (https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#opengl-es-2-0-3-0-emulation)
# ALLOW_MEMORY_GROWTH: https://emscripten.org/docs/optimizing/Optimizing-Code.html#memory-growth
# BINARYEN_TRAP_MODE:  Prevent overflow from trapping (https://emscripten.org/docs/compiling/WebAssembly.html#trap-mode)
# EXIT_RUNTIME:        Run static dtors (https://emscripten.org/docs/getting_started/FAQ.html#what-does-exiting-the-runtime-mean-why-don-t-atexit-s-run)
set(WASM_FLAGS "-s USE_WEBGL2=1 -s FULL_ES2=1 -s FULL_ES3=1 -s EXIT_RUNTIME=1 -s ALLOW_MEMORY_GROWTH=1 -s \"BINARYEN_TRAP_MODE='clamp'\"")

add_definitions(${WASM_FLAGS})

#add_link_options(--bind ${WASM_FLAGS})
#target_link_options(helloworld --bind ${WASM_FLAGS})
