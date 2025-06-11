#!/usr/bin/env bash
set -euo pipefail

SRC_DIR=$(pwd)/libssh2
BUILD_DIR=$(pwd)/build/libssh2-ios
MB_INC=$(pwd)/build/mbedtls-ios/include
MB_LIB=$(pwd)/build/mbedtls-ios/library

export OPENSSL_ROOT_DIR=""
export OPENSSL_LIBRARIES=""
export OPENSSL_INCLUDE_DIR=""

git clone https://github.com/libssh2/libssh2.git "$SRC_DIR" || true
cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$(pwd)/ios-cmake/ios.toolchain.cmake" \
  -DPLATFORM=OS64 \
  -DENABLE_ZLIB_COMPRESSION=ON \
  -DMBEDTLS=ON \
  -DCRYPTO_BACKEND=mbedtls \
  -DMBEDTLS_INCLUDE_DIRS="$MB_INC" \
  -DMBEDTLS_LIBRARY="$MB_LIB/libmbedtls.a" \
  -DMBEDX509_LIBRARY="$MB_LIB/libmbedx509.a" \
  -DMBEDCRYPTO_LIBRARY="$MB_LIB/libmbedcrypto.a" \
  -DUSE_SHARED_LIBS=OFF \
  -DUSE_OPENSSL=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_TESTS=OFF \
  -DBUILD_EXAMPLES=OFF \
  -DUSE_MBEDTLS=ON

cmake --build "$BUILD_DIR" --target install >/dev/null 2>/dev/null
