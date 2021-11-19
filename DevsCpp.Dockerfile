# Dockerfile for C/C++ Performance Modelling based on Discrete Event Simulation
# 1. Sniper    : x86 Multicore simulator based on Interval Simulation Model
# 2. gem5      : Multicore computer architecture simulator
# 3. SystemC   : High-level Modelling of Complex HW/SW systems
# 3. ns3       : A widely used network simulator
# 4. OMNeT++   : Another network simulator
# 5. Verilator : RTL simulator

FROM ubuntu:20.04

# Set the user
ENV DEBIAN_FRONTEND=noninteractive
ENV MY_DIR=/home/amaity
WORKDIR ${MY_DIR}

# Add i386 support for support for Pin
RUN dpkg --add-architecture i386

# Helper utilities
RUN apt-get update && apt-get install -y \
    python \
    screen \
    tmux \
    binutils \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    pkg-config \
    autoconf \
    automake \
    autotools-dev \
    build-essential \
    curl \
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
    verilator \
    build-essential \
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
 && rm -rf /var/lib/apt/lists/*
      
RUN apt-get clean