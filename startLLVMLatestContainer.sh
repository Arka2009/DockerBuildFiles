#!/bin/bash
imageNameMain="llvm-13.0.0"
srcsHost="/data/amaity/DockerVolumes"
srcsCont="/root/llvm-workspace"
dockerImage="arka2009/amaity-${imageNameMain}:v0"
containerName="${imageNameMain}-container"

docker container run --rm -v ${srcsHost}:${srcsCont} -p 5900:5900 --name=${containerName} -d -it ${dockerImage}
# docker exec -it 