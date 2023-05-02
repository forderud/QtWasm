cmake_minimum_required(VERSION 3.13)

project(myproject)

if(EMSCRIPTEN)
  include(wasm.cmake)
endif()

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the Qt libraries for Qt Quick/QML
find_package(Qt6 REQUIRED Qml Quick Gui)

# add the qml.qrc file
qt_add_resources(qml_QRC qml.qrc)

# add source files
set(SOURCE
    ${SOURCE}
    main.cpp
)

# Tell CMake to create the helloworld executable
qt_add_executable(helloworld ${SOURCE} ${qml_QRC})

# Use the Qml/Quick modules from Qt 5.
target_link_libraries(helloworld PRIVATE Qt::Qml Qt::Quick)
qt_import_qml_plugins(helloworld)

# Find Eigen lib (for compatibility testing)
find_package(Eigen3 REQUIRED NO_MODULE)
target_link_libraries(helloworld PRIVATE Eigen3::Eigen)

configure_file(example.txt example.txt COPYONLY)
target_link_libraries(helloworld PRIVATE "--preload-file example.txt")
