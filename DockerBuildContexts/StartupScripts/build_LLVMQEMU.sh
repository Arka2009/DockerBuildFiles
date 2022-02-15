#!/bin/bash

LLVMVERSION="main" 
HOME="/root"
ROOT="${HOME}/llvm-workspace"
CDIR="${PWD}"

SRCDIR="${ROOT}/llvm-$LLVMVERSION-src"
BUILDDIR="${ROOT}/llvm-$LLVMVERSION-install/build"
INSTALLDIR="${ROOT}/llvm-$LLVMVERSION-install/install"

#########################################################################################
##### Compile and Install QEMU
#########################################################################################
QEMUBRANCH="rvv-zve32f-zve64f-upstream-v2"
QEMUSRCDIR="${ROOT}/qemu-rvv-src"
if [ ! -d ${QEMUSRCDIR} ]
then
    GIT_SSL_NO_VERIFY=1 git clone --branch $QEMUBRANCH --depth 1  https://github.com/sifive/qemu.git ${QEMUSRCDIR}
    cd ${QEMUSRCDIR} && ./configure \
                --enable-capstone \
                --enable-plugins \
                --python=python3 \
                --target-list=aarch64-linux-user,riscv64-linux-user \
                --disable-werror \
else
    echo "${QEMUSRCDIR} exists"
fi


cd ${QEMUSRCDIR} && make -j4 && make install && cd ${CDIR}

#########################################################################################
##### Compile and Install latest LLVM/CLANG
#########################################################################################

if [ ! -d ${SRCDIR} ]
then
    echo "Cloning"
    git clone -b $LLVMVERSION --depth 1 git@github.imec.be:StarFiveShared/NeonToRVVllvm.git ${SRCDIR}
else 
    echo "${SRCDIR} already exists"
fi

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

cd ${BUILDDIR} && make -j 4 && make install && cd ${CDIR}

#########################################################################################
##### Compile and Install QEMU
#########################################################################################
touch ${HOME}/.bashrc
echo "export PATH=\"${INSTALLDIR}/bin:${BUILDDIR}/bin:\$PATH\"" >> ${HOME}/.bashrc
echo "export LLVMSRC=\"${SRCDIR}\"" >> ${HOME}/.bashrc