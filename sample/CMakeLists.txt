cmake_minimum_required(VERSION 3.13)
set(CMAKE_CXX_STANDARD 17)

project(sample)

if(EMSCRIPTEN)
  include(wasm.cmake)
endif()

add_subdirectory(lib)
add_subdirectory(app)
