FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    bc \
    bison \
    build-essential \
    ccache \
    curl \
    flex \
    g++-multilib \
    gcc-multilib \
    git \
    lib32ncurses5-dev \
    lib32readline-dev \
    lib32z1-dev \
    libncurses5-dev \
    libssl-dev \
    libxml2-utils \
    lzop \
    pngcrush \
    python3 \
    repo \
    rsync \
    sudo \
    unzip \
    wget \
    zip \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Create user to match host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g ${GROUP_ID} worker && useradd -m -u ${USER_ID} -g worker worker
RUN echo "worker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER worker
WORKDIR /home/worker

