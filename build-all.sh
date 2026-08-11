set -e

cd supervisor
docker build -t aerialdreamxl/supervisord-toolbox:ubuntu -f Dockerfile.resolute .
docker build -t aerialdreamxl/supervisord-toolbox:debian -f Dockerfile.trixie .
cd ..
cd supervisor-cn
docker build -t aerialdreamxl/supervisord-toolbox:ubuntu-cn -f Dockerfile.resolute .
docker build -t aerialdreamxl/supervisord-toolbox:debian-cn -f Dockerfile.trixie .
cd ..
cd hermes
docker build -t aerialdreamxl/hermes-toolbox:ubuntu-cn .
cd ..
cd devcontainer
docker build -t aerialdreamxl/dev-toolbox:ubuntu-cn .
cd ..