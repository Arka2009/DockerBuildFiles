#!/bin/bash

# Obtain the sources
# dockerImage="arka2009/srs_3gpp:v0"
#dockerImage="arka2009/amaity-chipyard:v0"
# dockerImage="arka2009/amaity-llvm-13.0.0:v0"
# dockerFile="amaity-llvm-13.0.0.Dockerfile"
dockerImage="arka2009/llvm-revec:v0"
dockerFile="llvm-revec.Dockerfile"

# SSH_PRIVATE_KEY="$(cat $HOME/.ssh/id_rsa)"
# echo $SSH_PRIVATE_KEY
# Building an image
docker build -f ${dockerFile} -t ${dockerImage} .