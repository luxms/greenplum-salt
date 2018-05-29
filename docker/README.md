# Docker init-files

## Development branch, not yet ready for production use, but we're working on it !

Docker in Docker
https://github.com/jpetazzo/dind
https://hub.docker.com/_/docker/

docker run --privileged --name some-docker -d docker:18.03.0-ce

https://hub.docker.com/_/centos/
docker run --privileged --name c74 -h c74 -d centos:7.4.1708

docker run --privileged --name c74 -h c74 -d dind

docker run --privileged --name c74 -h c74 -d -v /var/run/docker.sock:/var/run/docker.sock dind

docker kill c74 && docker rm c74 && docker rmi dind

docker run --privileged --name c74 -h c74 -d \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v /home/nouser:/home/nouser \
           -e "container=docker" \
           -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
           --security-opt seccomp:unconfined --cap-add=SYS_ADMIN \
           -u $(id -u $USER):$(id -g $USER) dind /sbin/init
#/usr/sbin/init

docker run --privileged --name c74 -h c74 -d \
           --mount type=bind,source=/home/nouser,target=/home/nouser,user=user,group=user \
           -v /var/run/docker.sock:/var/run/docker.sock dind

docker exec -it c74 -u $(id -u $USER):$(id -g $USER) bash
docker exec --user root -it c74 bash

docker exec -it c74 bash

https://github.com/sbt/sbt/issues/714
компонент jline от eclipse "тупит"
если в выводе #> stty -a
                 columns is set to 0
#> stty columns 80
#> stty rows 44 columns 168

Build the image:
  docker build -t dind .

Run Docker-in-Docker and get a shell where you can play, and docker daemon logs to stdout:
  docker run --privileged -t -i dind

Run Docker-in-Docker and get a shell where you can play, but docker daemon logs into /var/log/docker.log:
  docker run --privileged -t -i -e LOG=file dind

Run Docker-in-Docker and expose the inside Docker to the outside world:
  docker run --privileged -d -p 4444 -e PORT=4444 dind

Remove image:
  docker rmi dind
