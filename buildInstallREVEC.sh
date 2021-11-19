#!/bin/bash

LLVM_VERSION="revec"
ROOT="/root/llvm-workspace"
CDIR="${PWD}"

SRC_DIR="${ROOT}/llvm-$LLVM_VERSION-src"
BUILD_DIR="${ROOT}/llvm-${LLVM_VERSION}-install/build"
INSTALL_DIR="${ROOT}/llvm-$LLVM_VERSION-install/install"


# INstall them separately as a part of Dockerfile
# sudo apt-get update
# sudo apt-get install llvm-6.0 clang-6.0 cmake ninja-build

# Clone
if [ ! -d ${SRC_DIR} ]
then
    echo "Cloning"
    git clone --depth 1 git@github.com/revec/llvm-revec.git ${SRC_DIR}

    cd ${SRC_DIR}/llvm/tools
    git clone --depth 1 git@github.com:revec/clang-revec.git clang

    cd ${SRC_DIR}/llvm/tools/clang
    git clone --depth 1 git@github.com:llvm-mirror/clang-tools-extra.git extra

    cd ${SRC_DIR}/llvm/projects
    git clone --depth 1 git@github.com:llvm-mirror/libcxx.git
    git clone --depth 1 git@github.com:llvm-mirror/libcxxabi.git
    git clone --depth 1 git@github.com:llvm-mirror/compiler-rt.git
else
    echo "${SRC_DIR} already exists"
fi

# Configure
if [ ! -d ${BUILD_DIR} ]
then
    mkdir -p $BUILD_DIR
    cd ${BUILD_DIR}
    CXX=clang++-6.0 CC=clang-6.0 cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DLLVM_USE_LINKER=gold \
              -DLLVM_TARGETS_TO_BUILD="X86" \
              -DLLVM_INCLUDE_TESTS=OFF \
              -S ${SRC_DIR} \
              -B ${BUILD_DIR}
else
    echo "${BUILD_DIR} alreay exists"
fi

# Build
cd ${BUILD_DIR} && make -j 20 && make install && cd ${CDIR}