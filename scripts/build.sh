#! /bin/bash

CLANG_VER=$1
SDK=$2

export UNATTENDED=1

rm /osxcross/tarballs/MacOSX*
cd osxcross
ln -s "/sdks/MacOSX${SDK}.sdk.tar.xz" tarballs/
./build.sh
#./build_llvm_dsymutil.sh
patch target/toolchain.cmake /scripts/toolchain.cmake.patch
mkdir /tmp/osxcross && mv target /tmp/osxcross && cd /tmp
tar czf "osxcross_${SDK}.tgz" osxcross
mv "osxcross_${SDK}.tgz" "/targets/osxcross_${SDK}_clang${CLANG_VER}.tgz"
rm -rf /tmp/osxcross
