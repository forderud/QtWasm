:: Build container
docker build --file Dockerfile --tag=forderud/qtwasm .

:: Push to dockerhub (to "latest" tag)
docker push forderud/qtwasm

pause
