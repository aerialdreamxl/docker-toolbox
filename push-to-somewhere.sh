docker tag aerialdreamxl/supervisord-toolbox:ubuntu $1/aerialdreamxl/supervisord-toolbox:ubuntu
docker tag aerialdreamxl/supervisord-toolbox:debian $1/aerialdreamxl/supervisord-toolbox:debian
docker tag aerialdreamxl/supervisord-toolbox:ubuntu-cn $1/aerialdreamxl/supervisord-toolbox:ubuntu-cn
docker tag aerialdreamxl/supervisord-toolbox:debian-cn $1/aerialdreamxl/supervisord-toolbox:debian-cn
docker tag aerialdreamxl/hermes-toolbox:ubuntu-cn $1/aerialdreamxl/hermes-toolbox:ubuntu-cn
docker tag aerialdreamxl/dev-toolbox:ubuntu-cn $1/aerialdreamxl/dev-toolbox:ubuntu-cn
docker tag aerialdreamxl/dev-toolbox:ubuntu-cn-rocwsl $1/aerialdreamxl/dev-toolbox:ubuntu-cn-rocwsl

docker push $1/aerialdreamxl/supervisord-toolbox:ubuntu
docker push $1/aerialdreamxl/supervisord-toolbox:debian
docker push $1/aerialdreamxl/supervisord-toolbox:ubuntu-cn
docker push $1/aerialdreamxl/supervisord-toolbox:debian-cn
docker push $1/aerialdreamxl/hermes-toolbox:ubuntu-cn
docker push $1/aerialdreamxl/dev-toolbox:ubuntu-cn
docker push $1/aerialdreamxl/dev-toolbox:ubuntu-cn-rocwsl

docker rmi $1/aerialdreamxl/supervisord-toolbox:ubuntu
docker rmi $1/aerialdreamxl/supervisord-toolbox:debian
docker rmi $1/aerialdreamxl/supervisord-toolbox:ubuntu-cn
docker rmi $1/aerialdreamxl/supervisord-toolbox:debian-cn
docker rmi $1/aerialdreamxl/hermes-toolbox:ubuntu-cn
docker rmi $1/aerialdreamxl/dev-toolbox:ubuntu-cn
docker rmi $1/aerialdreamxl/dev-toolbox:ubuntu-cn-rocwsl