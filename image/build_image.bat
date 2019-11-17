:: Build container
docker build --file Dockerfile --tag=forderud/qtwasm:latest .

:: Push to dockerhub
docker push forderud/qtwasm:latest

pause
