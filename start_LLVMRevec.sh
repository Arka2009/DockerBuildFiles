#!/bin/bash
hostDir="/home/amaity/GenData/DockerVolumes"
contDir="/root/llvm-workspace"
dockerImage="arka2009/llvm-revec:v0"
containerName="llvm-revec-container"
if [ ! -d ${hostDir} ]
then
	mkdir -p ${hostDir}
else
	echo "${hostDir} already exist"
fi

docker container run --rm \
        -v ${hostDir}:${contDir} \
		-p 5900:5900 \
		--name=${containerName} \
		-d -it ${dockerImage}
