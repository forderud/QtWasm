#!/bin/bash

cd build

echo Opening web browser and starting web server...

(sleep 1 && xdg-open "http://localhost:8080/helloworld.html") &
python3 ../WebServer.py 8080
