#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtPlugin>
#include <string>
#include <fstream>
#include <iostream>


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
	
	try {
		throw std::runtime_error("Hello runtime_error");
	} catch (std::exception & e) {
		std::cout << "Exception catching works as expected: " << e.what() << std::endl;
	}

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
