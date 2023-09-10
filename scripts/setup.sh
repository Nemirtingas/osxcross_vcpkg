#! /bin/bash

CLANG_VER=$1

apt-get update && apt-get -y install wget curl python3 git patch lsb-release software-properties-common gnupg pkg-config ninja-build zip unzip cmake lzma-dev libxml2-dev libssl-dev uuid-dev
wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh "${CLANG_VER}"
ln -s "/usr/bin/clang-${CLANG_VER}" /usr/bin/clang
ln -s "/usr/bin/clang++-${CLANG_VER}" /usr/bin/clang++

