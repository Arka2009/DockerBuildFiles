#!/bin/bash

srcsHost="/home/amaity/GenData/DockerVolumes"
srcsCont="/root/llvm-workspace"
dockerImage="arka2009/llvm-revec:v0"
containerName="llvm-revec-container"

if [ ! -d ${srcsHost} ]
then
	mkdir -p ${srcsHost}
else
	echo "${srcsHost} already exist"
fi

docker container run --rm -v ${srcsHost}:${srcsCont} -p 5900:5900 --name=${containerName} -d -it ${dockerImage}
