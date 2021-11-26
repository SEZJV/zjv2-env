FROM ubuntu:20.04

# non-interactive build
ENV DEBIAN_FRONTEND=noninteractive

# riscv isa bit width
ARG BITS=64

# version
ARG RV64_VERSION=2021.09.21
ARG QEMU_VERSION=6.1.0
ARG VERILATOR_VERSION=4.210
ARG SBT_VERSION=1.5.5

# static link
ARG RV64_REPO_URL=https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download

# apt's mirror domain
ARG APT_MIRROR_DOMAIN=mirrors.tuna.tsinghua.edu.cn

ENV PATH="/sbt/bin:/riscv-glibc/bin:/riscv-elf/bin:${PATH}"

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    sed -i s@/archive.ubuntu.com/@/$APT_MIRROR_DOMAIN/@g /etc/apt/sources.list && \
    apt -y -qq update && \
    apt -y -qq upgrade && \
    apt install -y -qq sudo default-jdk g++ autoconf curl flex bison bc python3 wget make gcc vim git ninja-build libglib2.0-dev libpixman-1-dev pkg-config &&\
    wget -q https://github.com/verilator/verilator/archive/refs/tags/v$VERILATOR_VERSION.tar.gz && \
    tar -zxf v$VERILATOR_VERSION.tar.gz && \
    cd verilator-$VERILATOR_VERSION && \
    unset VERILATOR_ROOT && \
    autoconf && \
    ./configure && \
    make -j$(nproc) && \
    sudo make install && \
    cd .. && rm -rf v$VERILATOR_VERSION.tar.gz verilator-$VERILATOR_VERSION && \
    wget -q $RV64_REPO_URL/$RV64_VERSION/riscv$BITS-elf-ubuntu-20.04-nightly-$RV64_VERSION-nightly.tar.gz && \
    wget -q $RV64_REPO_URL/$RV64_VERSION/riscv$BITS-glibc-ubuntu-20.04-nightly-$RV64_VERSION-nightly.tar.gz && \
    tar -zxf riscv$BITS-elf-ubuntu-20.04-nightly-$RV64_VERSION-nightly.tar.gz && \
    mv riscv riscv-elf && \
    tar -zxf riscv$BITS-glibc-ubuntu-20.04-nightly-$RV64_VERSION-nightly.tar.gz && \
    mv riscv riscv-glibc && \
    rm -rf riscv$BITS-elf-ubuntu-20.04-nightly-$RV64_VERSION-nightly.tar.gz && \
    rm -rf riscv$BITS-glibc-ubuntu-20.04-nightly-$RV64_VERSION-nightly.tar.gz && \
    wget -q https://download.qemu.org/qemu-$QEMU_VERSION.tar.xz && \
    tar xJf qemu-$QEMU_VERSION.tar.xz && \
    cd qemu-$QEMU_VERSION && \
    ./configure --target-list=riscv$BITS-softmmu && \
    make -j$(nproc) && \
    make install && \
    cd .. && rm -rf qemu-$QEMU_VERSION qemu-$QEMU_VERSION.tar.xz && \
    wget -q https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
    tar -xzf sbt-$SBT_VERSION.tgz && \
    rm -rf sbt-$SBT_VERSION.tgz
