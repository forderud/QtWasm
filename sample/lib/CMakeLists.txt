find_package(Qt6 REQUIRED COMPONENTS Core)

# add source files
set(SOURCES
    main.cpp
)

# Tell CMake to create the library
qt_add_library(lib ${SOURCES})

target_link_libraries(lib PRIVATE Qt::Core)

# embed a file into the library
configure_file(embed_example.txt embed_example.txt COPYONLY)
target_link_libraries(lib PRIVATE "--embed-file ${CMAKE_CURRENT_BINARY_DIR}/embed_example.txt")
