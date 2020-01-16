#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtPlugin>
#include <string>
#include <fstream>
#include <iostream>

#if QT_FEATURE_static > 0
// import Qt plugins (needed for CMake builds)
Q_IMPORT_PLUGIN(QtQuick2Plugin)       // QtQuick
Q_IMPORT_PLUGIN(QtQuick2WindowPlugin) // QtQuick.Window
#endif


static void PrintFileContent (const char * filename) {
    std::ifstream myfile (filename);
    if (!myfile.is_open())
        return;
    
    std::string line;
    while (getline(myfile,line))
        std::cout << line << '\n';
}

int main(int argc, char *argv[])
{
    PrintFileContent("example.txt");

    QGuiApplication app(argc, argv);

    QCoreApplication::addLibraryPath("./");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
