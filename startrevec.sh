#!/bin/bash
imageNameMain="revec"
srcsHost="/data/amaity/DockerVolumes"
srcsCont="/root/llvm-workspace"
dockerImage="arka2009/amaity-${imageNameMain}:v0"
containerName="${imageNameMain}-container"

docker container run --rm -v ${srcsHost}:${srcsCont} -p 5902:5902 --name=${containerName} -d -it ${dockerImage}