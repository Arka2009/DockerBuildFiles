#!/bin/bash

llvmver="llvm-13.0.1"
BUILDROOT=${PWD}
dockerImage="arka2009/${llvmver}:v0"
dockerFile="${BUILDROOT}/DockerFiles/LLVMLatest.Dockerfile"
dockerBuildContext="${BUILDROOT}/DockerBuildContexts"
sshPrivKeyFile="SSHKeys/id_rsa_docker" # This path is relative to ${dockerBuildContext}
vimrcFile="Configs/vimrc"
gitConfigFile="Configs/gitconfig"

docker build -t ${dockerImage} \
        --build-arg SSH_PRIVKEY_FILE=${sshPrivKeyFile} \
        --build-arg VIMRCFILE=${vimrcFile} \
        -f ${dockerFile} \
        ${dockerBuildContext}
