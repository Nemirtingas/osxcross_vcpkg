# osxcross_vcpkg

## How to use
### Building the vcpkg triplet

Build your own vcpkg triplet (if you want to use vcpkg) and put it in the vcpkg (community) triplet folder: /vcpkg/triplets/community

Triplet example for MacOSX 64bits (x64-osx-mytriplet.cmake)
```
set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)
# You can override linkage type by package if needed
if(PORT STREQUAL "portaudio")
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

set(VCPKG_BUILD_TYPE release)

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)

set(ENV{OSXCROSS_HOST} "x86_64-apple-$ENV{OSXCROSS_TARGET}")

set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE /osxcross/target/toolchain.cmake)

set(ENV{VCPKG_TOOLCHAIN} "/vcpkg/scripts/toolchains/osx.cmake")

set(VCPKG_C_FLAGS "-stdlib=libc++")
set(VCPKG_CXX_FLAGS "-stdlib=libc++")
```

Triplet example for MacOSX 32bits (x86-osx-mytriplet.cmake)
```
set(VCPKG_TARGET_ARCHITECTURE x86)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_BUILD_TYPE release)

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)

set(ENV{OSXCROSS_HOST} "i386-apple-$ENV{OSXCROSS_TARGET}")

set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE /osxcross/target/toolchain.cmake)

set(ENV{VCPKG_TOOLCHAIN} "/vcpkg/scripts/toolchains/osx.cmake")

set(VCPKG_C_FLAGS "-stdlib=libc++")
set(VCPKG_CXX_FLAGS "-stdlib=libc++")
```

### Cross-compiling vcpkg libraries
vcpkg is in the PATH of this docker image, so you don't need to call it explicitly.

Cross-compiling libraries:
Define one triplet for multiple libraries:
```
vcpkg install --triplet=x86-osx-mytriplet zlib fmt
```
or define triplet for each library
```
vcpkg install zlib:x86-osx-mytriplet fmt:x64-osx-mytriplet
```

### Using cross-compiled vcpkg libraries with CMake
Build you own CMakeLists.txt and call it with the CMAKE_TOOLCHAIN_FILE and vcpkg variables:
```
export OSXCROSS_HOST=x86
cmake -G Ninja -Wno-dev -DCMAKE_BUILD_TYPE=Release "-DVCPKG_TARGET_TRIPLET=x86-osx-mytriplet" "-DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake" "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/osxcross/target/toolchain.cmake" -S . -B out
cmake --build out
cmake --install out
```
