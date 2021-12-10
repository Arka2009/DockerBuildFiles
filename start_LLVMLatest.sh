#!/bin/bash
hostDir="/home/amaity/GenData/DockerVolumes"
dropboxHostDir="/home/amaity/Dropbox/WL2_LLVMIRTestFiles"
contDir="/root/llvm-workspace"
dropboxContDir="/root/Dropbox"
dockerImage="arka2009/llvm-13.0.0:v0"
containerName="llvm-13.0.0-container"

if [ ! -d ${hostDir} ]
then
	mkdir -p ${hostDir}
else
	echo "${hostDir} already exist"
fi

if [ ! -d ${dropboxHostDir} ]
then
    mkdir -p ${dropboxHostDir}
else
    echo "${dropboxHostDir} already exist"
fi

docker container run --rm \
        -v ${hostDir}:${contDir} \
		-v ${dropboxHostDir}:${dropboxContDir} \
		-p 5902:5902 \
		--name=${containerName} \
		-d -it ${dockerImage}
