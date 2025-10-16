TEMPLATE = app
TARGET   = helloworld

QT += quick qml

SOURCES   += main.cpp
RESOURCES += qml.qrc

INCLUDEPATH  += /opt/wasm-deps/include
INCLUDEPATH  += /opt/wasm-deps/include/eigen3

# enable C++ exception catching
QMAKE_CXXFLAGS += -fwasm-exceptions
QMAKE_LFLAGS += -fwasm-exceptions

# embed preload_example.txt into binary
QMAKE_PRE_LINK += $$QMAKE_COPY ../source/preload_example.txt .
QMAKE_LFLAGS += --preload-file preload_example.txt
