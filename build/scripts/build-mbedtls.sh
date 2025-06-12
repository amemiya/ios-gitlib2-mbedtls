#!/usr/bin/env bash
set -euo pipefail

SRC_DIR=$(pwd)/mbedtls
BUILD_DIR=$(pwd)/build/mbedtls-ios

git clone --recursive https://github.com/Mbed-TLS/mbedtls.git "$SRC_DIR" || true
source ./venv/bin/activate

mkdir -p $BUILD_DIR && cd $BUILD_DIR

cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_SYSROOT=iphoneos \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DCMAKE_INSTALL_PREFIX=$(pwd)/../../install/mbedtls-ios \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON

cmake --build "$BUILD_DIR" --config Release
