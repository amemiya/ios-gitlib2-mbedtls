#!/usr/bin/env bash
set -euo pipefail

SRC_DIR=$(pwd)/libgit2
BUILD_DIR=$(pwd)/build/libgit2-ios
SSH_INC=$(pwd)/build/libssh2-ios/include
SSH_LIB=$(pwd)/build/libssh2-ios/lib/libssh2.a
MB_INC=$(pwd)/build/mbedtls-ios/include
MB_LIBS="$(pwd)/build/mbedtls-ios/library/libmbedtls.a;$(pwd)/build/mbedtls-ios/library/libmbedx509.a;$(pwd)/build/mbedtls-ios/library/libmbedcrypto.a"

git clone https://github.com/libgit2/libgit2.git "$SRC_DIR" || true
cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$(pwd)/ios-cmake/ios.toolchain.cmake" \
  -DPLATFORM=OS64 \
  -DUSE_SSH=ON \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_CLAR=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DLIBSSH2_INCLUDE_DIR="$SSH_INC" \
  -DLIBSSH2_LIBRARY="$SSH_LIB" \
  -DMBEDTLS_INCLUDE_DIR="$MB_INC" \
  -DMBEDTLS_LIBRARIES="$MB_LIBS" \
  -DZLIB_LIBRARY="/usr/lib/libz.tbd" \
  -DZLIB_INCLUDE_DIR="$(xcrun --show-sdk-path)/usr/include"

cmake --build "$BUILD_DIR" --config Release
