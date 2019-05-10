#
# For basic cmake file structure see: http://doc.qt.io/qt-5/cmake-manual.html
#
cmake_minimum_required(VERSION 3.12)


project(myproject)

# build as HTML instead of JS
SET(CMAKE_EXECUTABLE_SUFFIX ".html")

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

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

# Add "--bind" linker flag
#add_link_options(--bind)               # require CMake 3.13
#target_link_options(helloworld --bind) # require CMake 3.13

set_target_properties(helloworld PROPERTIES COMPILE_FLAGS "-s ALLOW_MEMORY_GROWTH=1")

set_target_properties(helloworld PROPERTIES LINK_FLAGS "-s WASM=1 -s FULL_ES2=1 -s USE_WEBGL2=1 -s NO_EXIT_RUNTIME=0 -s ERROR_ON_UNDEFINED_SYMBOLS=1 --bind -s \"BINARYEN_TRAP_MODE='clamp'\" -O3 -s ALLOW_MEMORY_GROWTH=1")

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
