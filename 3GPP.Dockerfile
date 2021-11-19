# Dockerfile for 3GPP RAN Network Research
# 1. srsRAN    : Industrial Strenght RAN research

FROM ubuntu:20.04

# Set the user
ENV DEBIAN_FRONTEND=noninteractive
ENV MY_DIR=/home/amaity
WORKDIR ${MY_DIR}

RUN apt-get update && apt-get install -y \
    libzmq3-dev \
    build-essential \
    cmake \
    libfftw3-dev \
    libmbedtls-dev \
    libboost-program-options-dev \
    libconfig++-dev \
    libsctp-dev \
    libpcsclite-dev \
    libdw-dev \
    git \
    vim \
    iproute2 \
    net-tools \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get clean