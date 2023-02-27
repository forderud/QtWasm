# Configure WebAssembly build settings
# For some reason, the build settings need to be provided through the linker.
# Most flags are configured to match Qt qmake
# See EMCC_COMMON_LFLAGS in https://github.com/qt/qtbase/blob/dev/mkspecs/wasm-emscripten/qmake.conf

# Also search for packages beneath filesystem root (in addition to /emsdk_portable/sdk/system)
list(APPEND CMAKE_FIND_ROOT_PATH "/")

# Increase stack size (was reduced to 64k in Emscripten 3.1.27)
add_link_options("SHELL:-sSTACK_SIZE=1MB")
