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
set_target_properties(helloworld PROPERTIES LINK_FLAGS --bind)
