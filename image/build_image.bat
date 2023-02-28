:: Uncomment to ease debugging of failed builds
::set DOCKER_BUILDKIT=false

:: Build container
docker build --file Dockerfile --build-arg EXTRA_BUILD_PARAMS="--parallel 4" --tag=forderud/qtwasm:latest .

IF %ERRORLEVEL% EQU 0 (
  :: Push to dockerhub
  docker push forderud/qtwasm:latest
)
