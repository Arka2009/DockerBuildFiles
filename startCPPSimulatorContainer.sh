#!/bin/bash

srcsHost="/home/amaity/Desktop/DevsCpp"
srcsCont="/home/amaity/DevsCpp"
dockerImage="arka2009/cppsimulators:v0"
docker container run --rm -it --cap-add=SYS_PTRACE -v ${srcsHost}:${srcsCont} ${dockerImage}