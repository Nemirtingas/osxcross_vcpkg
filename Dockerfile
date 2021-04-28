FROM ubuntu:18.04
ENV PATH                $PATH:/osxcross/target/bin
ENV LD_LIBRARY_PATH     /osxcross/target/lib
ENV OSX_VER             10.13
ENV OSXCROSS_SDK        /osxcross/target/SDK/MacOSX${OSX_VER}.sdk
ENV OSXCROSS_TARGET     darwin17
ENV OSXCROSS_TARGET_DIR /osxcross/target
RUN dpkg --add-architecture i386 &&\
    apt update &&\
    apt -y install build-essential python git wget zip unzip pkg-config curl clang-9 ninja-build &&\
    apt clean &&\
    ln -s /usr/bin/clang-9 /usr/bin/clang &&\
    ln -s /usr/bin/clang++-9 /usr/bin/clang++
RUN cd / &&\
    git clone --branch=with-resume https://github.com/circulosmeos/gdown.pl gdown && mv gdown/gdown.pl /usr/bin/ && rm -rf gdown &&\
    gdown.pl 'https://drive.google.com/file/d/1o4Q2xqh3M8b0cfAdSri0kYbC4HB1prBP/view?usp=sharing' "${OSX_VER}.tgz"; tar xf "${OSX_VER}.tgz" && rm "${OSX_VER}.tgz" gdown*
RUN cd / &&\
    git clone --depth 1 -b my_crosscompile https://github.com/Nemirtingas/vcpkg.git vcpkg &&\
    cd /vcpkg &&\
    ./bootstrap-vcpkg.sh -disableMetrics &&\
    ln -s /vcpkg/vcpkg /usr/bin/ &&\
    ln -s /vcpkg/downloads/tools/cmake-*-linux/cmake-*-Linux-x86_64/bin/cmake /usr/bin/
