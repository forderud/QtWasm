cmake_minimum_required(VERSION 3.13)

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

# Add WebAssembly compile & linker flags:
#add_link_options(--bind)
#target_link_options(helloworld --bind)
# USE_WEBGL2:          https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#webgl-friendly-subset-of-opengl-es-2-0-3-0
# FULL_ES2/3:          Emulate missing WebGL features (https://emscripten.org/docs/porting/multimedia_and_graphics/OpenGL-support.html#opengl-es-2-0-3-0-emulation)
# ALLOW_MEMORY_GROWTH: https://emscripten.org/docs/optimizing/Optimizing-Code.html#memory-growth
# BINARYEN_TRAP_MODE:  Prevent overflow from trapping (https://emscripten.org/docs/compiling/WebAssembly.html#trap-mode)
# EXIT_RUNTIME:        Run static dtors (https://emscripten.org/docs/getting_started/FAQ.html#what-does-exiting-the-runtime-mean-why-don-t-atexit-s-run)
set(WASM_FLAGS "-s USE_WEBGL2=1 -s FULL_ES2=1 -s FULL_ES3=1 -s EXIT_RUNTIME=1 -s ALLOW_MEMORY_GROWTH=1 -s \"BINARYEN_TRAP_MODE='clamp'\"")

add_definitions(${WASM_FLAGS})
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
