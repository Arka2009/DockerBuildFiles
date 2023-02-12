# Dockerfile for C/C++ container 
# for experimenting with
# ARM(Neon) --> RISCV V
FROM debian:unstable

# Set the user
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install all needed packages
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install --no-install-recommends --yes \
    debian-ports-archive-keyring tini man ccache vim byobu sudo python2 build-essential \
    g++-10 g++-10-multilib g++-11-multilib cmake curl doxygen libc-devtools \
    gdb less psmisc gawk git git-lfs gperf jq libc-dev \
    libexpat1-dev libglib2.0-dev libinput-dev liblzma-dev libmount-dev \
    libncurses5-dev libreadline-dev libboost-all-dev \
    libtool m4 meson ninja-build pkg-config rsync sed ssh \
    graphviz graphviz-dev python3-pip python3-tqdm \
    python3-pyelftools crossbuild-essential-amd64 \
    crossbuild-essential-arm64 crossbuild-essential-armel \
    crossbuild-essential-armhf crossbuild-essential-i386 \
    crossbuild-essential-ppc64el crossbuild-essential-s390x \
    crossbuild-essential-mipsel gdb-multiarch \
    libstdc++-9-dev-riscv64-cross g++-riscv64-linux-gnu zlib1g-dev libxml2-dev \
    qemu-user \
    ca-certificates \
    libfdt-dev \
    screen \
    tmux \
    libgtk2.0-dev \
    autoconf \
    automake \
    autotools-dev \
    wget \
    libboost-dev \
    libsqlite3-dev \
    libbz2-dev \
    bison \
    device-tree-compiler \
    flex \
    git-core \
    vim \
    libprotobuf-dev \
    protobuf-compiler \
    libprotoc-dev \
    libgoogle-perftools-dev \
    swig \
    python3-dev \
    python3 \
    libpng-dev \
    unzip \
    xdot \
    valgrind \
    texinfo \
    libpixman-1-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# install QEMU development branch
RUN \
    cd /tmp && \
    wget https://download.qemu.org/qemu-7.0.0.tar.xz && \
    tar xvJf qemu-7.0.0.tar.xz && \
    cd qemu* && \
    ARCH_LIST="arm aarch64 i386 mips mipsel riscv64 s390x x86_64" && \
    TARGET_LIST=$(for a in $ARCH_LIST; do echo -n "${a}-linux-user "; done) && \
    ./configure "--target-list=$TARGET_LIST" && \
    make -j install plugins test-plugins && \
    mkdir -p /usr/local/share/qemu/plugins && \
    cp */tests/plugin/lib*.so */contrib/plugins/*.so /usr/local/share/qemu/plugins && \
    cd .. && \
    rm -r qemu*

# install binutils nightly
RUN \
    cd /tmp && \
    wget https://sourceware.org/pub/binutils/snapshots/binutils-2.38.90.tar.xz && \
    tar xvJf binutils-2.38.90.tar.xz && \
    cd binutils* && \
    ./configure  --target=riscv64-linux-gnu --program-prefix=riscv64-linux-gnu- && \
    make -j && \
    make install && \
    cd .. && \
    rm -r binutils*

# Copy VIMRC configs
ARG VIMRCFILE
COPY ${VIMRCFILE} /root/.vimrc

# Startup Script
COPY StartupScripts/build_LLVM.sh /root/
RUN chmod +x /root/build_LLVM.sh
RUN echo "Please execute build_LLVM.sh"
CMD ["/bin/bash"]
