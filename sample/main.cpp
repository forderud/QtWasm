#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtPlugin>
#include <string>
#include <fstream>
#include <thread>
#include <iostream>


static void PrintFileContent (const char * filename) {
    std::ifstream myfile (filename);
    if (!myfile.is_open())
        return;
    
    std::string line;
    while (getline(myfile,line))
        std::cout << line << '\n';
}

void ThreadFunction () {
    std::cout << "Hello thread\n";
}

#ifdef Q_OS_WASM
QGuiApplication*    g_app = nullptr;
#endif

void startEngine(QObject* parent)
{
    QQmlApplicationEngine* engine = new QQmlApplicationEngine(parent);
    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
}

int main(int argc, char *argv[])
{
    std::cout << "Qt version " << QT_VERSION_STR << std::endl;
    
    PrintFileContent("example.txt");
    
    try {
        throw std::runtime_error("Hello runtime_error");
    } catch (std::exception & e) {
        std::cout << "Exception catching works as expected: " << e.what() << std::endl;
    }

    try {
        std::thread t(&ThreadFunction);
        t.join();
        std::cout << "Thread joined\n";
    } catch (std::exception & e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return -1;
    }

#ifdef Q_OS_WASM
    /*
     * According to https://doc-snapshots.qt.io/qt6-dev/wasm.html#wasm-exceptions
     * the call to QGuiApplication::exec is not compatible with emscripten
     * when exceptions are enabled.
     *
     * Note that the runtime will not exit when leaving the main function on
     * this platform.
     * https://doc-snapshots.qt.io/qt6-dev/wasm.html#application-startup-and-the-event-loop
     */
    g_app = new QGuiApplication(argc, argv);
    startEngine(g_app);
    return 0;
#else
    QGuiApplication app(argc, argv);
    startEngine(&app);
    return app.exec();
#endif
}
