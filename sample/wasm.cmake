# Configure WebAssembly build settings

# Use Emscripten build settings as starting point
include($ENV{EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)

# For some reason, the build settings need to be provided through the linker.
# Most flags are configured to match Qt qmake
# See EMCC_COMMON_LFLAGS in https://github.com/qt/qtbase/blob/dev/mkspecs/common/wasm/wasm.conf

# Also search for packages beneath /opt/wasm-deps in addition to /emsdk_portable/sdk/system
list(APPEND CMAKE_FIND_ROOT_PATH "/opt/wasm-deps") # required for Boost & Eigen

# Enable C++ exception catching also in non-Qt projects
# https://emscripten.org/docs/porting/exceptions.html
add_compile_options(-fwasm-exceptions) # enable WebAssembly exceptions

# Enable threading also in non-Qt projects
# https://emscripten.org/docs/porting/pthreads.html
add_compile_options(-pthread)

# Enable SSE2 support
# https://emscripten.org/docs/porting/simd.html
add_compile_options(-msse2 -mrelaxed-simd)
