cd supervisor
docker build -t aerialdreamxl/supervisord-toolbox:ubuntu -f Dockerfile.ubuntu .
docker build -t aerialdreamxl/supervisord-toolbox:debian -f Dockerfile.debian .
