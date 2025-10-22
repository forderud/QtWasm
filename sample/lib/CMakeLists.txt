# Enable SIMD support (required when not using Qt)
add_compile_options(-msimd128)

# source files
set(SOURCES
    main.cpp
)

# create library
add_library(lib ${SOURCES})

# embed a file into the library
configure_file(embed_example.txt embed_example.txt COPYONLY)
target_link_libraries(lib PRIVATE "--embed-file ${CMAKE_CURRENT_BINARY_DIR}/embed_example.txt")
