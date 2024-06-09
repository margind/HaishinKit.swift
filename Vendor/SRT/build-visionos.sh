#!/bin/bash

srt_visionos() {
  VISION_OPENSSL=$(pwd)/OpenSSL/$1

  mkdir -p ./build/visionos/$2
  pushd ./build/visionos/$2
  ../../../srt/configure --cmake-prefix-path=$VISION_OPENSSL --visionos-platform=$2 --visionos-arch=arm64 --cmake-toolchain-file=scripts/visionOS.cmake --USE_OPENSSL_PC=off
  make
  popd
}

# visionOS
srt_visionos visionsimulator SIMULATOR
srt_visionos visionos OS
mkdir -p ./build/visionos/_SIMULATOR
libtool -static -o ./build/visionos/_SIMULATOR/libsrt.a ./build/visionos/SIMULATOR/libsrt.a ./OpenSSL/visionsimulator/lib/libcrypto.a ./OpenSSL/visionsimulator/lib/libssl.a
mkdir -p ./build/visionos/_OS
libtool -static -o ./build/visionos/_OS/libsrt.a ./build/visionos/OS/libsrt.a ./OpenSSL/visionos/lib/libcrypto.a ./OpenSSL/visionos/lib/libssl.a

