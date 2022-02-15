# Dockerfile for C/C++ container 
# for experimenting with
# ARM(Neon) --> RISCV V
FROM ubuntu:20.04

# Set the user
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install --no-install-recommends --yes \
    python \
    screen \
    tmux \
    binutils \
    binutils-gold \
    pkg-config \
    autoconf \
    automake \
    autotools-dev \
    build-essential \
    wget \
    libboost-dev \
    libsqlite3-dev \
    libbz2-dev \
    bc \
    bison \
    curl \
    device-tree-compiler \
    flex \
    gawk \
    gperf \
    libexpat-dev \
    libgmp-dev \
    libmpc-dev \
    libmpfr-dev \
    libtool \
    libusb-1.0-0-dev \
    patchutils \
    texinfo \
    gdb \
    gfortran \
    git \
    g++-9 \
    vim \
    git-core \
    m4 \
    scons \
    zlib1g \
    zlib1g-dev \
    libprotobuf-dev \
    protobuf-compiler  \
    libprotoc-dev \
    libgoogle-perftools-dev \
    swig \
    python3-dev \
    python3 \
    libpng-dev \
    cmake \
    unzip \
    ninja-build \
    gcc-multilib \
    xdot \
	graphviz \
    valgrind \
    ca-certificates \
    libglib2.0-dev \
    libgtk2.0-dev \
    libfdt-dev \
    libpixman-1-dev \
 && rm -rf /var/lib/apt/lists/*


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install --no-install-recommends --yes \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu \
        binutils-aarch64-linux-gnu


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install --no-install-recommends --yes \
        gcc-riscv64-linux-gnu \
        g++-riscv64-linux-gnu \
        binutils-riscv64-linux-gnu

# Required For GitHub Authentication
# ARG SSH_PRIVKEY_FILE
# RUN mkdir -p /root/.ssh && \
#    chmod 700 /root/.ssh && \
#    ssh-keyscan github.com > /root/.ssh/known_hosts
# COPY ${SSH_PRIVKEY_FILE} /root/.ssh/id_rsa

# Copy VIMRC configs
ARG VIMRCFILE
COPY ${VIMRCFILE} /root/.vimrc

# Startup Script
COPY StartupScripts/build_LLVMQEMU.sh /root/
RUN chmod +x /root/build_LLVMQEMU.sh
RUN echo "Please execute build_LLVMQEMU.sh"
CMD ["/bin/bash"]