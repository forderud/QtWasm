cmake_minimum_required(VERSION 3.13)

project(myproject)

if(EMSCRIPTEN)
  include(wasm.cmake)
endif()

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the Qt libraries for Qt Quick/QML
find_package(Qt5 REQUIRED Qml Quick Gui)

# add the qml.qrc file
qt5_add_resources(qml_QRC qml.qrc)

# add source files
set(SOURCE 
    ${SOURCE}
    main.cpp
)

# Tell CMake to create the helloworld executable
add_executable(helloworld ${SOURCE} ${qml_QRC})

# Use the Qml/Quick modules from Qt 5.
target_link_libraries(helloworld PRIVATE Qt5::Qml Qt5::Quick)

configure_file(example.txt example.txt COPYONLY)
target_link_libraries(helloworld PRIVATE "--preload-file example.txt")

if(EMSCRIPTEN)
  link_qt_static(helloworld)
  
  # Link to missing Qt libraries (the order does matter)
  target_link_libraries(helloworld PRIVATE
    "${_qt5Core_install_prefix}/qml/QtQuick.2/libqtquick2plugin.a"      # QtQuick2Plugin
    "${_qt5Core_install_prefix}/qml/QtQuick/Window.2/libwindowplugin.a" # QtQuick2WindowPlugin
    "${_qt5Core_install_prefix}/lib/libQt5Quick.a"
  )
endif()
