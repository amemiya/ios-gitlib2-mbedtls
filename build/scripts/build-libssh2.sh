#!/usr/bin/env bash
set -euo pipefail

SRC_DIR=$(pwd)/libssh2
BUILD_DIR=$(pwd)/build/libssh2-ios
MB_INC=$(pwd)/build/mbedtls-ios/include
MB_LIB=$(pwd)/build/mbedtls-ios/library

git clone https://github.com/libssh2/libssh2.git "$SRC_DIR" || true
cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$(xcrun --find cmake)/../../share/ios-cmake/ios.toolchain.cmake" \
  -DPLATFORM=OS64 \
  -DENABLE_ZLIB_COMPRESSION=ON \
  -DCRYPTO_BACKEND=mbedtls \
  -DMBEDTLS_INCLUDE_DIRS="$MB_INC" \
  -DMBEDTLS_LIBRARY="$MB_LIB/libmbedtls.a" \
  -DMBEDX509_LIBRARY="$MB_LIB/libmbedx509.a" \
  -DMBEDCRYPTO_LIBRARY="$MB_LIB/libmbedcrypto.a" \
  -DCMAKE_BUILD_TYPE=Release

cmake --build "$BUILD_DIR" --config Release
