#!/bin/bash

LLVM_VERSION="13.0.0"
ROOT="/root/llvm-workspace"
CDIR="${PWD}"

SRC_DIR="${ROOT}/llvm-$LLVM_VERSION-src"
BUILD_DIR="${ROOT}/llvm-${LLVM_VERSION}-install/build"
INSTALL_DIR="${ROOT}/llvm-$LLVM_VERSION-install/install"


# Clone
if [ ! -d ${SRC_DIR} ]
then
    echo "Cloning"
    git clone -b llvmorg-$LLVM_VERSION --depth 1 https://github.com/llvm/llvm-project.git ${SRC_DIR}
else 
    echo "${SRC_DIR} already exists"
fi

# Configure
if [ ! -d ${BUILD_DIR} ]
then
    mkdir -p $BUILD_DIR
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
              -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;lld" \
              -DLLVM_USE_LINKER=gold \
              -DLLVM_TARGETS_TO_BUILD="X86;RISCV;ARM" \
              -DLLVM_INCLUDE_TESTS=OFF \
              -S ${SRC_DIR}/llvm \
              -B ${BUILD_DIR}
else
    echo "${BUILD_DIR} alreay exists"
fi

# Build
cd ${BUILD_DIR}
make -j 20
make install
cd ${CDIR}

# 
/bin/bash