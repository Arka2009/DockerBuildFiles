#!/bin/bash

BUILDROOT=${PWD}
dockerImage="wasteboard/training-host:v0"
dockerFile="${BUILDROOT}/DockerFiles/WasteBoardNN.Dockerfile"
dockerBuildContext="${BUILDROOT}/DockerBuildContexts"
sshPrivKeyFile="SSHKeys/id_rsa_docker" # This path is relative to ${dockerBuildContext}

docker build \
        -t ${dockerImage} \
        --build-arg SSH_PRIVKEY_FILE=${sshPrivKeyFile} \
        -f ${dockerFile} \
        ${dockerBuildContext}