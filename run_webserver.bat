setlocal enableextensions
@echo off
cd build

echo Opening web browser and starting web server...

start http://localhost:80/

python.exe -m http.server 80
