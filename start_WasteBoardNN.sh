#!/bin/bash

# Annotations, Images and Trained Models
dockerWorkspace="/root/workspace"
hostDir1="/home/amaity/Desktop/WasteBoard_Training/JayashreeDetectionCodes2"
contDir1="${dockerWorkspace}"
containerName="wasteboard-training-container"
dockerImage="wasteboard/training-host:v0"

docker container run --rm \
    -v ${hostDir1}:${contDir1} \
    -p 8888:8888 \
    --name=${containerName} \
    -d -it ${dockerImage}