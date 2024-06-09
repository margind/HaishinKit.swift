#!/bin/bash

srt_tvos() {
  OPENSSL=$(pwd)/OpenSSL/$1

  mkdir -p ./build/tvos/$2
  pushd ./build/tvos/$2
  ../../../srt/configure --cmake-prefix-path=$OPENSSL --visionos-platform=$2 --visionos-arch=arm64 --cmake-toolchain-file=scripts/tvOS.cmake --USE_OPENSSL_PC=off
  make
  popd
}

# visionOS
srt_tvos appletvsimulator SIMULATOR
srt_tvos appletvos OS
mkdir -p ./build/tvos/_SIMULATOR
libtool -static -o ./build/tvos/_SIMULATOR/libsrt.a ./build/tvos/SIMULATOR/libsrt.a ./OpenSSL/appletvsimulator/lib/libcrypto.a ./OpenSSL/appletvsimulator/lib/libssl.a
mkdir -p ./build/tvos/_OS
libtool -static -o ./build/tvos/_OS/libsrt.a ./build/tvos/OS/libsrt.a ./OpenSSL/appletvos/lib/libcrypto.a ./OpenSSL/appletvos/lib/libssl.a

