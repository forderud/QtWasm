TEMPLATE = app
TARGET   = helloworld

QT += quick qml

SOURCES   += main.cpp
RESOURCES += qml.qrc

# embed example.txt into binary
QMAKE_PRE_LINK += $$QMAKE_COPY ../source/example.txt .
QMAKE_LFLAGS += --preload-file example.txt
