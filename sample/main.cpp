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


static void PrintFileContent (const char * filename) {
    std::ifstream myfile (filename);
    if (!myfile.is_open()) {
        std::cerr << "ERROR: Unable to open file." << std::endl;
        return;
    }
    
    std::string line;
    while (getline(myfile,line))
        std::cout << line << '\n';
}

void ThreadFunction () {
    std::cout << "Hello thread\n";
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
    std::cout << "Release build." << std::endl;
#else
    std::cout << "Debug build." << std::endl;
#endif
    
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
