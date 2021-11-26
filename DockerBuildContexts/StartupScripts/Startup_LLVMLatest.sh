#!/bin/bash

LLVM_VERSION="13.0.0" # Do not touch
HOME="/root"
ROOT="${HOME}/llvm-workspace"
CDIR="${PWD}"

SRCDIR="${ROOT}/llvm-$LLVM_VERSION-src"
BUILDDIR="${ROOT}/llvm-${LLVM_VERSION}-install/build"
INSTALL_DIR="${ROOT}/llvm-$LLVM_VERSION-install/install"

# Clone LLVM
if [ ! -d ${SRCDIR} ]
then
    echo "Cloning"
    git clone -b llvmorg-$LLVM_VERSION --depth 1 https://github.com/llvm/llvm-project.git ${SRCDIR}
else 
    echo "${SRCDIR} already exists"
fi

# Configure
if [ ! -d ${BUILDDIR} ]
then
    mkdir -p $BUILDDIR
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_PROJECTS="clang;lld" \
              -DLLVM_USE_LINKER=gold \
              -DLLVM_TARGETS_TO_BUILD="X86;RISCV;ARM" \
              -DLLVM_INCLUDE_TESTS=OFF \
              -S ${SRCDIR}/llvm \
              -B ${BUILDDIR}
else
    echo "${BUILDDIR} alreay exists"
fi

# Build (Comment this for now)
# cd ${BUILDDIR} && make -j 4 && make install && cd ${CDIR}
# touch ${HOME}/.bashrc
# echo "export PATH=\"/root/llvm-workspace/llvm-13.0.0-install/build/bin:\$PATH\"" >> ${HOME}/.bashrc

# Install ARM NEON

# Install RISCV Tools

#echo "Install Spike..."
#ROOTSPIKESRC="${HOME}/riscv-spike"
#if [ ! -d ${ROOTSPIKESRC} ]
#then
#    echo "Cloning to ${ROOTSPIKESRC}"
#    git clone --depth=1 https://github.com/riscv-software-src/riscv-isa-sim.git ${ROOTSPIKESRC}
#else
#    echo "${ROOTSPIKESRC} already exist"
#fi
#
#ROOTSPIKEBLD="${ROOTSPIKESRC}/build"
#if [ ! -d ${ROOTSPIKEBLD} ]
#then
#    echo "Building ${ROOTSPIKEBLD}"
#    mkdir -p ${ROOTSPIKEBLD}
#    #apt-get install gmake
#    # source ${ROOTSPIKEBLD}/../configure --prefix=
#
#else
#     echo "${ROOTSPIKESRC} already exist"
#fi

# Install ARM Simulator
# echo "Install ARM Simulator..."

# Comment this for now
# /bin/bash
