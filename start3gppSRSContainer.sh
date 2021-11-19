#!/bin/bash

srcsHost="/home/amaity/Desktop/3gpp_srs"
srcsCont="/home/amaity/3gpp_srs"
dockerImage="arka2009/srs_3gpp:v0"
docker run --rm -it --cap-add=SYS_PTRACE -v ${srcsHost}:${srcsCont} ${dockerImage}