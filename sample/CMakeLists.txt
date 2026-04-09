cmake_minimum_required(VERSION 3.13)
set(CMAKE_CXX_STANDARD 17)

project(sample)

function(add_custom_shell target)
    # copy custom HTML launch file
    set(APPNAME ${target})
    set(APPEXPORTNAME ${target}_entry)
    # TODO: A "2" suffix is currently added to the HTML filename to avoid it being overwritten by the wasm_shell.html file. Need to figure out how to get rid of the "2" suffix.
    configure_file("wasm_shell.html" "${CMAKE_CURRENT_BINARY_DIR}/${target}2.html" @ONLY) # modified version of https://github.com/qt/qtbase/blob/dev/src/plugins/platforms/wasm/wasm_shell.html
    configure_file("cartman.svg"     "${CMAKE_CURRENT_BINARY_DIR}/cartman.svg" COPYONLY)
endfunction()

add_subdirectory(lib)
add_subdirectory(app)
