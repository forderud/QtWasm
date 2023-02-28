setlocal enableextensions
@echo off
cd build

echo Opening web browser and starting web server...

start http://localhost:80/helloworld.html

docker run -ti --rm -p 8000:8000 -v `pwd`/sample:/project/source -v `pwd`/build:/project/build -v `pwd`/WebServer.py:/project/WebServer.py qdel/qtwasm bash -c "python3 /project/WebServer.py 8000"
