# osxcross_vcpkg

Building the osxcross env:
  - Clean old osxcross env: rm -rf osxcross
  - Build docker base container: ./create_docker.sh
  - Build osxcross env: ./build_target.sh
