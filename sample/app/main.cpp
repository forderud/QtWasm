#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtPlugin>
#include <string>
#include <fstream>
#include <thread>
#include <iostream>

#include <emscripten/version.h>
#include <Eigen/Dense>
#include <boost/version.hpp>
#include <hdf5.h>

#include "../lib/lib.hpp"


static void PrintFileContent (const char * filename) {
    std::ifstream myfile (filename);
    if (!myfile.is_open()) {
        printf("ERROR: Unable to open file.\n");
        return;
    }
    
    printf("%s file content: ", filename);
    std::string line;
    while (getline(myfile,line))
        printf("%s\n", line.c_str());
}

void ThreadFunction () {
    printf("App thread running.\n");
}

void startEngine(QObject* parent)
{
    QQmlApplicationEngine* engine = new QQmlApplicationEngine(parent);
    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
}

int main(int argc, char *argv[])
{
    std::cout << "Emscripten version " << __EMSCRIPTEN_major__ << "." << __EMSCRIPTEN_minor__ << "." << __EMSCRIPTEN_tiny__ << std::endl;
    std::cout << "Qt version " << QT_VERSION_STR << std::endl;
    std::cout << "Eigen version " << EIGEN_WORLD_VERSION << "." << EIGEN_MAJOR_VERSION  << "." << EIGEN_MINOR_VERSION << " (SIMD: " << Eigen::SimdInstructionSetsInUse() << ")" << std::endl;
    std::cout << "Boost version " << BOOST_VERSION << std::endl;
    std::cout << "HDF5 version " << H5_VERSION << std::endl;

#ifdef NDEBUG
    printf("Release build.\n");
#else
    printf("Debug build.\n");
#endif

    CallLib();

    PrintFileContent("lib/embed_example.txt");
    PrintFileContent("app/preload_example.txt");
    
    try {
        throw std::runtime_error("Hello runtime_error");
    } catch (std::exception & e) {
        printf("Exception catching works as expected: %s\n", e.what());
    }

    try {
        std::thread t(&ThreadFunction);
        t.join();
        printf("[thread joined]\n");
    } catch (std::exception & e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return -1;
    }

#ifdef Q_OS_WASM
    /*
     * Asynchronous main() implementation that omits exec() call as proposed in https://doc.qt.io/qt-6/wasm.html
     * The QGuiApplication pointer leakage is therefore deliberate.
     */
    auto* g_app = new QGuiApplication(argc, argv);
    startEngine(g_app);
    return 0;
#else
    QGuiApplication app(argc, argv);
    startEngine(&app);
    return app.exec();
#endif
}
