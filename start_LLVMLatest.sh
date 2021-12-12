#!/bin/bash

llvmver="llvm-13.0.0"
portM=5902

hostDir="/home/amaity/GenData/DockerVolumes"
dropboxHostDir="/home/amaity/Dropbox/WL2_LLVMIRTestFiles"
contDir="/root/llvm-workspace"
dropboxContDir="/root/Dropbox"
dockerImage="arka2009/${llvmver}:v0"
containerName="${llvmver}-container"

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
		-p ${portM}:${portM} \
		--name=${containerName} \
		-d -it ${dockerImage}
