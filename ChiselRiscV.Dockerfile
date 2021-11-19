# Chisel/RISCV related docker files
FROM ubuntu:20.04 as base
ARG CHIPYARD_HASH=tags/1.5.0

# Install dependencies for ubuntu-req.sh
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
               curl \
               git \
               sudo \
               vim \
               ca-certificates \
               keyboard-configuration \
               console-setup

WORKDIR /root
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Chipyard and run ubuntu-req.sh to install necessary dependencies
RUN git clone https://github.com/ucb-bar/chipyard.git && \
        cd chipyard && \
        git checkout $CHIPYARD_HASH -b dev_amaity && \
        ./scripts/ubuntu-req.sh && \
        sudo rm -rf /var/lib/apt/lists/*

# Update PATH for RISCV toolchain (note: hardcoded for CircleCI)
ENV RISCV="/root/riscv-tools-install"
ENV LD_LIBRARY_PATH="$RISCV/lib"
ENV PATH="$RISCV/bin:$PATH"

# BUILD IMAGE WITH TOOLCHAINS

# Use above build as base
FROM base as base-with-tools

# Init submodules
RUN cd chipyard && \
        export MAKEFLAGS=-"j $(nproc)" && \
        ./scripts/init-submodules-no-riscv-tools.sh

# Install riscv-tools
RUN cd chipyard && \
        export MAKEFLAGS=-"j $(nproc)" && \
        ./scripts/build-toolchains.sh riscv-tools

# Install esp-tools
RUN cd chipyard && \
        export MAKEFLAGS=-"j $(nproc)" && \
        ./scripts/build-toolchains.sh esp-tools

# Run script to set environment variables on entry
ENTRYPOINT ["chipyard/scripts/entrypoint.sh"]

# END IMAGE CUSTOMIZATIONS
CMD ["/bin/sh"]