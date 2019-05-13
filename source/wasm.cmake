# Add WebAssembly compile & linker flags:
# USE_WEBGL2:          https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#webgl-friendly-subset-of-opengl-es-2-0-3-0
# FULL_ES2/3:          Emulate missing WebGL features (https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#opengl-es-2-0-3-0-emulation)
# EXIT_RUNTIME:        Run static dtors (https://emscripten.org/docs/getting_started/FAQ.html#what-does-exiting-the-runtime-mean-why-don-t-atexit-s-run)
# ALLOW_MEMORY_GROWTH: https://emscripten.org/docs/optimizing/Optimizing-Code.html#memory-growth
# BINARYEN_TRAP_MODE:  Prevent overflow from trapping (https://emscripten.org/docs/compiling/WebAssembly.html#trap-mode)

add_definitions("-s USE_WEBGL2=1")
add_definitions("-s FULL_ES2=1")
add_definitions("-s FULL_ES3=1")
add_definitions("-s EXIT_RUNTIME=1")
add_definitions("-s ALLOW_MEMORY_GROWTH=1")
add_definitions("-s \"BINARYEN_TRAP_MODE='clamp'\"")

add_link_options(--bind)
add_link_options("SHELL:-s USE_WEBGL2=1")
add_link_options("SHELL:-s FULL_ES2=1")
add_link_options("SHELL:-s FULL_ES3=1")
add_link_options("SHELL:-s EXIT_RUNTIME=1")
add_link_options("SHELL:-s ALLOW_MEMORY_GROWTH=1")
add_link_options("SHELL:-s \"BINARYEN_TRAP_MODE='clamp'\"")
