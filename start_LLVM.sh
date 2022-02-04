#!/bin/bash

llvmver="llvm-13.0.1"
portM=5902

hostDir="/home/amaity/GenData/DockerVolumes"
dropboxHostDir="/home/amaity/Dropbox/WL2_LLVMIRTestFiles/BackendTutorial"
contDir="/root/llvm-workspace"
dropboxContDir="/root/Dropbox"
dockerImage="arka2009/${llvmver}:v0"
containerName="${llvmver}-container"
simdBenchDirHost="/home/amaity/Desktop/SIMDBenchmarks"
simdBenchDirCont="/root/SIMDBenchmarks"
llvmTblGenTutDirHost="/home/amaity/Desktop/HsuLLVMTutorial"
llvmTblGenTutDirCont="/root/HsuLLVMTutorial"

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

if [ ! -d ${simdBenchDirHost} ]
then
	mkdir -p ${simdBenchDirHost}
else
	echo "${simdBenchDirHost} already exist"
fi

if [ ! -d ${llvmTblGenTutDirHost} ]
then
	git clone --depth=1 https://github.com/PacktPublishing/LLVM-Techniques-Tips-and-Best-Practices-Clang-and-Middle-End-Libraries.git ${llvmTblGenTutDirHost}
else
	echo "${llvmTblGenTutDirHost} already exist"
fi

docker container run --rm \
        -v ${hostDir}:${contDir} \
		-v ${dropboxHostDir}:${dropboxContDir} \
		-v ${simdBenchDirHost}:${simdBenchDirCont} \
		-v ${llvmTblGenTutDirHost}:${llvmTblGenTutDirCont} \
		-p ${portM}:${portM} \
		--name=${containerName} \
		-d -it ${dockerImage}
