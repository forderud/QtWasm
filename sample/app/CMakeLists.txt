# run moc automatically when needed
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED Qml Quick)

qt_add_resources(qml_QRC qml.qrc)

# source files
set(SOURCES
    main.cpp
)

# create helloworld executable
qt_add_executable(helloworld ${SOURCES} ${qml_QRC})

# link to dependent library
target_link_libraries(helloworld PRIVATE lib)

# link to Qt modules
target_link_libraries(helloworld PRIVATE Qt::Qml Qt::Quick)
qt_import_qml_plugins(helloworld)

# Find Eigen lib (for compatibility testing)
find_package(Eigen3 REQUIRED NO_MODULE)
target_link_libraries(helloworld PRIVATE Eigen3::Eigen)

# Find Boost (for compatibility testing)'
find_package(Boost REQUIRED)
target_link_libraries(helloworld PRIVATE Boost::boost)

# Find HDF5 (for compatibility testing)
find_package(HDF5 REQUIRED)
target_link_libraries(helloworld PRIVATE hdf5::hdf5)

# preload-embed a file into the library
configure_file(preload_example.txt preload_example.txt COPYONLY)
target_link_libraries(helloworld PRIVATE "--preload-file ${CMAKE_CURRENT_BINARY_DIR}/preload_example.txt")
