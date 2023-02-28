#!/bin/bash

echo Opening web browser and starting web server...
(sleep 1 && xdg-open "http://localhost:8000/helloworld.html") &
docker run -ti --rm -p 8000:8000 -v `pwd`/sample:/project/source -v `pwd`/build:/project/build -v `pwd`/WebServer.py:/project/WebServer.py qdel/qtwasm bash -c "python3 /project/WebServer.py 8000" || exit 1
