:: Uncomment to ease debugging of failed builds
::set DOCKER_BUILDKIT=false

:: Change current dir
cd /d "%~dp0"

echo Determining tag for current commit...
git describe --abbrev=0 --tags --exact-match > VERSION.txt

IF %ERRORLEVEL% EQU 0 (
  set /p VERSION=< VERSION.txt 
) ELSE (
  set VERSION=latest
)

:: Build container
docker build --file Dockerfile --build-arg EXTRA_BUILD_PARAMS="--parallel 4" --tag=forderud/qtwasm:latest .

IF %ERRORLEVEL% EQU 0 (
  :: Push to dockerhub
  docker push forderud/qtwasm:latest
  
  docker tag forderud/qtwasm:latest forderud/qtwasm:%VERSION%
  docker push forderud/qtwasm:%VERSION%
)
