#!/bin/bash

llvmver="llvm-main"


dockerImage="star5/${llvmver}:v0"
containerName="llvm14_SIMDTranslation_${USER}"
LLVM_HOSTDIR="${HOME}/GenData/DockerVolumes"
LLVM_DESTDIR="/root/llvm-workspace"
TEST_HOSTDIR="${HOME}/Desktop/SIMDTranslationTest"
TEST_CONTDIR="/root/SIMDTranslationTest"

docker container run --rm \
                -v ${LLVM_HOSTDIR}:${LLVM_DESTDIR} \
                -v ${TEST_HOSTDIR}:${TEST_CONTDIR} \
                --name=${containerName} \
                -d -it ${dockerImage}
docker exec -it ${containerName} /bin/bash
