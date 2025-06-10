#!/usr/bin/env bash
set -euo pipefail

SRC_DIR=$(pwd)/mbedtls
BUILD_DIR=$(pwd)/build/mbedtls-ios

git clone https://github.com/ARMmbed/mbedtls.git "$SRC_DIR" || true
cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_TOOLCHAIN_FILE="$(xcrun --find cmake)/../../share/ios-cmake/ios.toolchain.cmake" \
  -DPLATFORM=OS64 \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_PROGRAMS=OFF \
  -DENABLE_TESTING=OFF

cmake --build "$BUILD_DIR" --config Release
