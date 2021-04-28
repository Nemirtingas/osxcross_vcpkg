# osxcross_vcpkg

This project will build a Docker Image that can cross-compile for MacOSX in C/C++ and that supports CMake + vcpkg.

See the different branches and pick the version of OSX you need.


To build your own OSX SDK, you need to login with an Apple ID, download the XCode SDK you want and build the tools with this project: https://github.com/tpoechtrager/osxcross

Note: 32bits support has been dropped from MacOS since the SDK 10.14. If you need to build a 32bits app, you __MUST__ pull the 10.12 or 10.13 image.
