# zjv2-env 

[![Build Docker Image](https://github.com/riscv-zju/zjv2-env/actions/workflows/build.yaml/badge.svg)](https://github.com/riscv-zju/zjv2-env/actions/workflows/build.yaml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/riscv-zju/zjv2-env/blob/main/LICENSE) [![Docker Pulls](https://img.shields.io/docker/pulls/alphavake/zjv2)](https://hub.docker.com/r/alphavake/zjv2) [![Docker Image Size](https://img.shields.io/docker/image-size/alphavake/zjv2/latest)](https://hub.docker.com/r/alphavake/zjv2)

**zjv2-env** is a toolchain image for developing Chisel based CPU core.

## Usage

```bash
$ docker pull alphavake/zjv2
```

## Toolchain List

- **qemu-system-riscv64**: v6.2.0
- **riscv-gnu-toolchain**: nightly 2021.12.22 (64-bit)
- **sbt**: 1.5.7
- **verilator**: 4.210

## LICENSE

riscv-zju @ [MIT](https://github.com/riscv-zju/zjv2-env/blob/main/LICENSE)
