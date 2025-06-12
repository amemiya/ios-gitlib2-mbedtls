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
  -DENABLE_DEBUG_LOGGING=ON \
  -DCRYPTO_BACKEND=mbedtls \
  -DMBEDTLS_INCLUDE_DIR="$MB_INC" \
  -DMBEDTLS_LIBRARY_DIR="$MB_LIB" \
  -DMBEDTLS_LIBRARY="$MB_LIB/libmbedtls.a" \
  -DMBEDX509_LIBRARY="$MB_LIB/libmbedx509.a" \
  -DMBEDCRYPTO_LIBRARY="$MB_LIB/libmbedcrypto.a" \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_EXAMPLES=OFF

cmake --build "$BUILD_DIR" --target install
