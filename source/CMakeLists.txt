cmake_minimum_required(VERSION 3.13)
include(wasm.cmake)

project(myproject)

# build as HTML instead of JS
SET(CMAKE_EXECUTABLE_SUFFIX ".html")

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

set_target_properties(helloworld PROPERTIES LINK_FLAGS "--bind ${WASM_FLAGS}")

# Link to missing Qt libraries (the order does matter)
target_link_libraries(helloworld PRIVATE
    "${_qt5Core_install_prefix}/plugins/platforms/libqwasm.a"
    "${_qt5Core_install_prefix}/lib/libQt5EventDispatcherSupport.a"
    "${_qt5Core_install_prefix}/lib/libQt5FontDatabaseSupport.a"
    "${_qt5Core_install_prefix}/lib/libqtfreetype.a"
    
    #"${_qt5Core_install_prefix}/lib/libQt5EglSupport.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqgif.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqicns.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqico.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqjpeg.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqtga.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqtiff.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqwbmp.a"
    #"${_qt5Core_install_prefix}/plugins/imageformats/libqwebp.a"

    "${_qt5Core_install_prefix}/qml/QtQuick.2/libqtquick2plugin.a"
    "${_qt5Core_install_prefix}/qml/QtQuick/Window.2/libwindowplugin.a"
    "${_qt5Core_install_prefix}/lib/libQt5Quick.a"
)
