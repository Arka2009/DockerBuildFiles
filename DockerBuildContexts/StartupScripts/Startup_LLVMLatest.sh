#!/bin/bash

LLVMVERSION="13.0.0" 
HOME="/root"
ROOT="${HOME}/llvm-workspace"
CDIR="${PWD}"

SRCDIR="${ROOT}/llvm-$LLVMVERSION-src"
BUILDDIR="${ROOT}/llvm-$LLVMVERSION-install/build"
INSTALLDIR="${ROOT}/llvm-$LLVMVERSION-install/install"

# Clone LLVM
if [ ! -d ${SRCDIR} ]
then
    echo "Cloning"
    git clone -b llvmorg-$LLVMVERSION --depth 1 https://github.com/llvm/llvm-project.git ${SRCDIR}
else 
    echo "${SRCDIR} already exists"
fi

# Configure
if [ ! -d ${BUILDDIR} ]
then
    mkdir -p $BUILDDIR
    LLVM_ENABLE_ASSERTIONS=ON cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR} \
              -DCMAKE_BUILD_TYPE=Debug -DLLVM_ENABLE_PROJECTS="clang;lld" \
              -DLLVM_USE_LINKER=gold \
              -DLLVM_TARGETS_TO_BUILD="X86;RISCV;ARM" \
              -DLLVM_INCLUDE_TESTS=OFF \
              -S ${SRCDIR}/llvm \
              -B ${BUILDDIR}
else
    echo "${BUILDDIR} alreay exists"
fi

# Build (Comment this for now)
cd ${BUILDDIR} && make -j 4 && make install && cd ${CDIR}

# Set the bash
touch ${HOME}/.bashrc
echo "export PATH=\"/root/llvm-workspace/$LLVMVERSION/build/bin:\$PATH\"" >> ${HOME}/.bashrc
echo "export LLVMSRC=\"${SRCDIR}/llvm\"" >> ${HOME}/.bashrc
