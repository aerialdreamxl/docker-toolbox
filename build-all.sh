cd supervisor
docker build -t aerialdreamxl/supervisord-toolbox:ubuntu -f Dockerfile.ubuntu .
docker build -t aerialdreamxl/supervisord-toolbox:debian -f Dockerfile.debian .
cd ..
cd supervisor-cn
docker build -t aerialdreamxl/supervisord-toolbox:ubuntu-cn -f Dockerfile.ubuntu .
docker build -t aerialdreamxl/supervisord-toolbox:debian-cn -f Dockerfile.debian .
cd ..
cd hermes
docker build -t aerialdreamxl/hermes-toolbox .
cd ..
cd devcontainer
docker build -t aerialdreamxl/dev-toolbox .
cd ..