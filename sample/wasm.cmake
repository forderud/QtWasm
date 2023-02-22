# Configure WebAssembly build settings
# For some reason, the build settings need to be provided through the linker.
# Most flags are configured to match Qt qmake
# See EMCC_COMMON_LFLAGS in https://github.com/qt/qtbase/blob/dev/mkspecs/wasm-emscripten/qmake.conf

# Also search for packages beneath filesystem root (in addition to /emsdk_portable/sdk/system)
list(APPEND CMAKE_FIND_ROOT_PATH "/")

# Enable C++ exception catching
# https://emscripten.org/docs/optimizing/Optimizing-Code.html#c-exceptions
add_compile_options(-fexceptions)

# Enable threading also in non-Qt projects
# https://emscripten.org/docs/porting/pthreads.html
add_compile_options(-pthread)
add_link_options("SHELL:-s USE_PTHREADS=1")


find_package(Qt6 REQUIRED Core QUIET)
include(${QT6_INSTALL_PREFIX}/lib/cmake/Qt6/QtPublicWasmToolchainHelpers.cmake)
