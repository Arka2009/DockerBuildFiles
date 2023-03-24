#!/bin/bash

llvmver="llvm-main"
BUILDROOT=${PWD}
dockerImage="tutorial/${llvmver}:v0"
dockerFile="${BUILDROOT}/LLVMQEMU.Dockerfile"
dockerBuildContext="${BUILDROOT}/DockerBuildContexts"
vimrcFile="Configs/vimrc"
gitConfigFile="Configs/gitconfig"

docker build -t ${dockerImage} \
        --build-arg VIMRCFILE=${vimrcFile} \
        -f ${dockerFile} \
        ${dockerBuildContext}
