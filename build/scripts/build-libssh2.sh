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
cmake --trace-expand -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$(pwd)/ios-cmake/ios.toolchain.cmake" \
  -DPLATFORM=OS64 \
  -DENABLE_ZLIB_COMPRESSION=ON \
  -DLIBSSH2_MBEDTLS=ON \
  -DLIBSSH2_CRYPTO_BACKEND=mbedtls \
  -DMBEDTLS_INCLUDE_DIRS="$MB_INC" \
  -DMBEDTLS_LIBRARY="$MB_LIB/libmbedtls.a" \
  -DMBEDX509_LIBRARY="$MB_LIB/libmbedx509.a" \
  -DMBEDCRYPTO_LIBRARY="$MB_LIB/libmbedcrypto.a" \
  -DLIBSSH2_USE_SHARED_LIBS=OFF \
  -DLIBSSH2_USE_OPENSSL=OFF \
  -DLIBSSH2_BUILD_EXAMPLES=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF

cmake --build "$BUILD_DIR" --config Release
