setlocal enableextensions
@echo off
cd build

echo Open http://localhost:80 in a web browser and navigate to the html page to test the web app.

python.exe -m http.server 80
