ARG CLANG_VER
ARG UBUNTU_VER
FROM nemirtingas/nemirtingas_compilation_base:ubuntu${UBUNTU_VER}_clang${CLANG_VER}
ARG OSX_VER
ARG OSXCROSS_TARGET
ARG CLANG_VER
ENV PATH=$PATH:/osxcross/target/bin
ENV LD_LIBRARY_PATH=/osxcross/target/lib
ENV OSX_VER=${OSX_VER}
ENV OSXCROSS_SDK=/osxcross/target/SDK/MacOSX${OSX_VER}.sdk
ENV OSXCROSS_TARGET=${OSXCROSS_TARGET}
ENV OSXCROSS_TARGET_DIR=/osxcross/target
ENV CLANG_VER=${CLANG_VER}
RUN cd /&&\
    git clone --depth=1 https://github.com/Nemirtingas/osxcross_vcpkg --branch=SDK${OSX_VER}_clang${CLANG_VER}_target /osxcross_tmp &&\
    tar xzf /osxcross_tmp/osxcross_${OSX_VER}_clang${CLANG_VER}.tgz &&\
    rm -rf /osxcross_tmp &&\
    git clone --depth=1 --branch=feature/my-main https://github.com/Nemirtingas/osxcross.git /osxcross_b &&\
    /osxcross_b/build_compiler_rt.sh &&\
    rm -rf /osxcross_b /osxcross/build
