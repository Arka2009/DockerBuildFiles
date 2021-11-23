#!/bin/bash
hostDir="/home/amaity/GenData/DockerVolumes"
contDir="/root/llvm-workspace"
dockerImage="arka2009/llvm-13.0.0:v0"
containerName="llvm-13.0.0-container"
if [ ! -d ${hostDir} ]
then
	mkdir -p ${hostDir}
else
	echo "${hostDir} already exist"
fi

docker container run --rm \
        -v ${hostDir}:${contDir} \
		-p 5902:5902 \
		--name=${containerName} \
		-d -it ${dockerImage}