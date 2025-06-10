#!/usr/bin/env bash
set -euo pipefail

LIB_PATH=$(pwd)/build/libgit2-ios
HEADERS=$(pwd)/libgit2/include

if [[ ! -f "$LIB_PATH/libgit2.a" ]]; then
  echo "Error: libgit2.a not found"
  exit 1
fi

xcodebuild -create-xcframework \
  -library "$LIB_PATH/libgit2.a" \
  -headers "$HEADERS" \
  -output build/output/libgit2.xcframework
