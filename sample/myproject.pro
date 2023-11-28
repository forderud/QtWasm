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

# Increase stack size (was reduced to 64k in Emscripten 3.1.27)
QMAKE_LFLAGS += -sSTACK_SIZE=1MB

# embed example.txt into binary
QMAKE_PRE_LINK += $$QMAKE_COPY ../source/example.txt .
QMAKE_LFLAGS += --embed-file example.txt
