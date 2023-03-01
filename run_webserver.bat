setlocal enableextensions
@echo off
cd build

echo Opening web browser and starting web server...

start http://localhost:8080/helloworld.html

..\WebServer.py 8080
