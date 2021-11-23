#!/bin/bash

# Make this as the startup script for WasteBoardNN.Dockerfile
currentDir=${PWD}
cd Tensorflow/models/research && protoc object_detection/protos/*.proto --python_out=. && cp object_detection/packages/tf2/setup.py . && python3 -m pip install .
cd ${currentDir}
