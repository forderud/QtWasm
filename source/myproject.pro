TEMPLATE = app
TARGET   = helloworld

QT += quick qml

SOURCES   += main.cpp
RESOURCES += qml.qrc

# enable C++ exception catching
QMAKE_CXXFLAGS += -fexceptions
QMAKE_LFLAGS += -s DISABLE_EXCEPTION_CATCHING=0

# embed example.txt into binary
QMAKE_PRE_LINK += $$QMAKE_COPY ../source/example.txt .
QMAKE_LFLAGS += --preload-file example.txt
