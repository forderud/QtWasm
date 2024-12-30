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

# embed example.txt into binary
QMAKE_PRE_LINK += $$QMAKE_COPY ../source/example.txt .
QMAKE_LFLAGS += --preload-file example.txt
