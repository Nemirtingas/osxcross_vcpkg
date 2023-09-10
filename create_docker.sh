#! /bin/bash

CLANG_VER=17

docker run --name osxcross-build -it -v $(pwd)/scripts:/scripts -v $(pwd)/targets:/targets -v $(pwd)/sdks:/sdks -v $(pwd)/osxcross:/osxcross ubuntu:22.04 /scripts/setup.sh ${CLANG_VER}

git clone --depth=1 https://github.com/tpoechtrager/osxcross.git

docker start osxcross-build
