#!/bin/bash

HOME="/root"
ROOT="${HOME}/llvm-workspace"
CDIR="${PWD}"

SRCDIR="${ROOT}/llvm-main-src"
BUILDDIR="${ROOT}/llvm-main-install/build"
INSTALLDIR="${ROOT}/llvm-main-install/install"

#########################################################################################
##### Compile and Install latest LLVM/CLANG
#########################################################################################

if [ ! -d ${SRCDIR} ]
then
    echo "Cloning"
    git clone git@github.com:Arka2009/llvm-project.git ${SRCDIR}
else
    echo "${SRCDIR} already exists"
fi

echo "Building Clang/LLVM"
mkdir -p $BUILDDIR
LLVM_ENABLE_ASSERTIONS=ON cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR} \
          -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;lld" \
          -DLLVM_USE_LINKER=gold \
          -DLLVM_TARGETS_TO_BUILD="X86;RISCV;ARM;AArch64" \
          -DLLVM_INCLUDE_TESTS=OFF \
          -S ${SRCDIR}/llvm \
          -B ${BUILDDIR}
cd ${BUILDDIR} && make install -j $(nproc) && cd ${CDIR}

touch ${HOME}/.bashrc
echo "alias ll='ls --color=auto -alhrt'" >> ${HOME}/.bashrc
echo "export PATH=\"${INSTALLDIR}/bin:${BUILDDIR}/bin:\$PATH\"" >> ${HOME}/.bashrc
echo "export LLVMSRC=\"${SRCDIR}\"" >> ${HOME}/.bashrc
