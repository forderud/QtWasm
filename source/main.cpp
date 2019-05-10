#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtPlugin>

#if QT_FEATURE_static > 0
// import Qt plugins (needed for CMake builds)
Q_IMPORT_PLUGIN(QWasmIntegrationPlugin)
Q_IMPORT_PLUGIN(QtQuick2Plugin)       // QtQuick
Q_IMPORT_PLUGIN(QtQuick2WindowPlugin) // QtQuick.Window
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::addLibraryPath("./");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
	    
    return app.exec();
}

