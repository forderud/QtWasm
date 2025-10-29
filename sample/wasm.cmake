# Configure WebAssembly build settings
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

# Enable debugging in the browser (works with edge)
if(CMAKE_BUILD_TYPE STREQUAL "Debug" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    #Increase stack size (this is here for historical reasons)
    add_link_options("SHELL:-s STACK_SIZE=32mb")
    add_link_options("SHELL:-s INITIAL_MEMORY=40mb")

    #Output more debug options (equivalent to pdb files in c++)
    #This allows debugging in the web-browser
    add_link_options("SHELL:-gsource-map")
    add_link_options("SHELL:-gseparate-dwarf")
endif()

