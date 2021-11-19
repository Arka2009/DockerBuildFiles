#!/bin/bash

srcsHost="/home/amaity/Desktop/CHIPYARD"
srcsCont="/root"
dockerImage="arka2009/amaity-chipyard:v0"

# docker container run --rm -it --cap-add=SYS_PTRACE  ${dockerImage} 
# -v ${srcsHost}:${srcsCont}
docker container run -p 5901:5901 -d -it --cap-add=SYS_PTRACE ${dockerImage} bash