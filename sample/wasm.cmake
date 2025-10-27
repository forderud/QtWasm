# Configure WebAssembly build settings
# For some reason, the build settings need to be provided through the linker.
# Most flags are configured to match Qt qmake
# See EMCC_COMMON_LFLAGS in https://github.com/qt/qtbase/blob/dev/mkspecs/common/wasm/wasm.conf

# Also search for packages beneath filesystem root (in addition to /emsdk_portable/sdk/system)
list(APPEND CMAKE_FIND_ROOT_PATH "/opt/wasm-deps") # required for Boost & Eigen

# Enable C++ exception catching also in non-Qt projects
# https://emscripten.org/docs/porting/exceptions.html
add_compile_options(-fwasm-exceptions) # enable WebAssembly exceptions

# Enable threading also in non-Qt projects
# https://emscripten.org/docs/porting/pthreads.html
add_compile_options(-pthread)

# Enable only WebGL 2
# https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html
add_link_options("SHELL:-s MAX_WEBGL_VERSION=2")
add_link_options("SHELL:-s MIN_WEBGL_VERSION=2")

# Enable SSE2 support
# https://emscripten.org/docs/porting/simd.html#compiling-simd-code-targeting-x86-sse-instruction-sets
# Do not need to add "-msimd128" since it will be appended by qt-cmake
add_compile_options(-msse2)
