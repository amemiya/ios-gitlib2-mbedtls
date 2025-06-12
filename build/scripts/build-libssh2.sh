#!/usr/bin/env bash
set -euo pipefail

SRC_DIR=$(pwd)/libssh2
BUILD_DIR=$(pwd)/build/libssh2-ios
MB_INC=$(pwd)/build/mbedtls-ios/include
MB_LIB=$(pwd)/build/mbedtls-ios/library

export OPENSSL_ROOT_DIR=""
export OPENSSL_LIBRARIES=""
export OPENSSL_INCLUDE_DIR=""

unset OPENSSL_ROOT_DIR
unset PKG_CONFIG_PATH

git clone https://github.com/libssh2/libssh2.git "$SRC_DIR" || true

mkdir -p $BUILD_DIR && cd $BUILD_DIR

cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_SYSROOT=iphoneos \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DCRYPTO_BACKEND=mbedtls \
  -DCMAKE_PREFIX_PATH=$(pwd)/../../install/mbedtls-ios \
  -DLIBSSH2_USE_OPENSSL=OFF \
  -DLIBSSH2_USE_MBEDTLS=ON \
  -DENABLE_ZLIB_COMPRESSION=ON \
  -DBUILD_SHARED_LIBS=OFF \
  -DENABLE_EXAMPLES=OFF

cmake --build "$BUILD_DIR" --target install
