# Configure WebAssembly build settings
# For some reason, the build settings need to be provided through the linker.

# Activate Embind C/C++ bindings
# https://emscripten.org/docs/porting/connecting_cpp_and_javascript/embind.html
add_link_options(--bind) 

# Activate WebGL 2 (in addition to WebGL 1)
# https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#webgl-friendly-subset-of-opengl-es-2-0-3-0
add_link_options("SHELL:-s USE_WEBGL2=1")

# Emulate missing OpenGL ES2/ES3 features
# https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#opengl-es-2-0-3-0-emulation
add_link_options("SHELL:-s FULL_ES2=1")
add_link_options("SHELL:-s FULL_ES3=1")

# Run static dtors at teardown
# https://emscripten.org/docs/getting_started/FAQ.html#what-does-exiting-the-runtime-mean-why-don-t-atexit-s-run
add_link_options("SHELL:-s EXIT_RUNTIME=1")

# Allows amount of memory used to change 
# https://emscripten.org/docs/optimizing/Optimizing-Code.html#memory-growth
add_link_options("SHELL:-s ALLOW_MEMORY_GROWTH=1")

# Prevent overflow from trapping
# https://emscripten.org/docs/compiling/WebAssembly.html#trap-mode
add_link_options("SHELL:-s \"BINARYEN_TRAP_MODE='clamp'\"")

# Also search for packages beneath filesystem root (in addition to /emsdk_portable/sdk/system)
list(APPEND CMAKE_FIND_ROOT_PATH "/")
