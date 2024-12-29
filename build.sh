#! /bin/bash

cd "$(dirname "$0")"

container_name=

function cleanup()
{
  [ ! -z "${container_name}" ] && docker rm "${container_name}"
  exit -1
}

function build_image()
{
    NAME="$1"
    UBUNTU_VER="$2"
    VERSION="$3"
    TARGET="$4"
    CLANG_VER="$5"
    dockerhub_user=nemirtingas
    image_tag="${NAME}:SDK${VERSION}_clang${CLANG_VER}"

    docker image rm "${dockerhub_user}/${image_tag}" --force
    docker image rm "${image_tag}" --force
    container_name="$(mktemp -u XXXXXXXXXXXX)"
    echo "Container: ${container_name}"
    docker build --build-arg "UBUNTU_VER=${UBUNTU_VER}" --build-arg OSX_VER=${VERSION} --build-arg OSXCROSS_TARGET=${TARGET} --build-arg CLANG_VER=${CLANG_VER} --no-cache --rm -t "${image_tag}" . &&
    docker run "--name=${container_name}" "${image_tag}" /bin/bash -c exit &&
    docker commit -m "${NAME} image built on ubuntu${UBUNTU_VER} with ${VERSION}" -a "Nemirtingas" "${container_name}" "${dockerhub_user}/${image_tag}" &&
    docker push "${dockerhub_user}/${image_tag}" &&
    docker rm "${container_name}"
}

trap cleanup INT

#build_image "osxcross_vcpkg" "22.04" "10.12" darwin16 17
#build_image "osxcross_vcpkg" "22.04" "10.13" darwin17 18
#build_image "osxcross_vcpkg" "22.04" "10.14" darwin18 17
#build_image "osxcross_vcpkg" "22.04" "10.15" darwin19 17
#build_image "osxcross_vcpkg" "22.04" "11.3" darwin20.4 18
build_image "osxcross_vcpkg" "22.04" "11.3" darwin20.4 20
#build_image "osxcross_vcpkg" "22.04" "12.1" darwin21.2 17
