cmake_minimum_required(VERSION 3.13)

project(myproject)

if(EMSCRIPTEN)
  include(wasm.cmake)
endif()

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the Qt libraries for Qt Quick/QML
find_package(Qt6 COMPONENTS Qml Quick Gui QUIET)
if(NOT Qt6_FOUND)
    find_package(Qt5 REQUIRED Qml Quick Gui QmlImportScanner)
endif()

# add the qml.qrc file
qt_add_resources(qml_QRC qml.qrc)

# add source files
set(SOURCE 
    ${SOURCE}
    main.cpp
)

# Tell CMake to create the helloworld executable
add_executable(helloworld ${SOURCE} ${qml_QRC})

# Use the Qml/Quick modules from Qt 5.
target_link_libraries(helloworld PRIVATE Qt::Qml Qt::Quick)
qt_import_qml_plugins(helloworld)

configure_file(example.txt example.txt COPYONLY)
target_link_libraries(helloworld PRIVATE "--preload-file example.txt")

if(EMSCRIPTEN)
  link_qt_static(helloworld)
endif()
