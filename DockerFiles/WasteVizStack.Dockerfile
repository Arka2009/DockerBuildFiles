FROM ubuntu:20.04

ARG WDIR=/root
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR ${WDIR}
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV TZ=Asia/Singapore
ENV PATH /opt/conda/bin:$PATH
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Intall Anaconda
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        mercurial \
        openssh-client \
        openjdk-8-jdk \
        procps \
        subversion \
        wget \
        vim \
        less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh"; \
        SHA256SUM="2751ab3d678ff0277ae80f9e8a74f218cfc70fe9a9cdc7bb1c137d7e47e33d53"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-s390x.sh"; \
        SHA256SUM="a7d1a83279f439e7d8a6c53aa725552e195c0b96ae7e7fa63baefdf0118f7942"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-aarch64.sh"; \
        SHA256SUM="3a3d5a61df5422f7c8c7816217b926ec7e200cc6d62967541adead8ec46d935d"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-ppc64le.sh"; \
        SHA256SUM="097064807a9adae3f91fc4c5852cd90df2b77fc96505929bb25bf558f1eef76f"; \
    fi && \
    wget "${ANACONDA_URL}" -O anaconda.sh -q && \
    echo "${SHA256SUM} anaconda.sh" > shasum && \
    sha256sum --check --status shasum && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

# Install Tensorflow
RUN apt-get update --fix-missing && \
    apt-get install -y python3-pip \
    virtualenv \
    swig \
    libprotobuf-dev \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

# Some of these would have already installed
RUN python3 -m pip --no-cache-dir install --upgrade \
    pip \
    setuptools \
    Pillow \
    h5py \
    keras_preprocessing \
    mock \
    future \
    portpicker \
    enum34

RUN ln -s $(which python3) /usr/local/bin/python
ARG TF_PACKAGE=tensorflow
ARG TF_PACKAGE_VERSION=2.7.0
RUN python3 -m pip install --no-cache-dir ${TF_PACKAGE}${TF_PACKAGE_VERSION:+==${TF_PACKAGE_VERSION}}
COPY Configs/TensorflowBashrc.sh /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

# Required For GitHub Authentication
ARG SSH_PRIVKEY_FILE
RUN mkdir -p ${WDIR}/.ssh && \
    chmod 700 ${WDIR}/.ssh && \
    ssh-keyscan github.com > ${WDIR}/.ssh/known_hosts
COPY ${SSH_PRIVKEY_FILE} ${WDIR}/.ssh/id_rsa

RUN touch ${WDIR}/.bashrc
RUN echo "alias ll='ls -lFh'" >> ${WDIR}/.bashrc

# Startup
CMD ["/bin/bash"]
# CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/root/workspace --ip 0.0.0.0 --no-browser --allow-root"]
