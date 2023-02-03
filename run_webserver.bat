setlocal enableextensions
@echo off
cd build

echo Opening web browser and starting web server...

start http://localhost:80/helloworld.html

..\WebServer.py 80
