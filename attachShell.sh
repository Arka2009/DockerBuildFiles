#!/bin/bash

targetContainer=$1 #"llvm-13.0.0-container"
docker exec -it ${targetContainer} /bin/bash 
