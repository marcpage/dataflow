#!/usr/bin/env bash

set -euo pipefail

QT_MAJOR_MINOR="6.11"
QT_PATCH="1"
QT_VERSION="$QT_MAJOR_MINOR.$QT_PATCH"
SRC_FILENAME="qt-everywhere-src-$QT_VERSION.tar.xz"
PLAT="$(uname -ms | tr ' ' -)"
BIN_FILENAME="qt-bin-$QT_VERSION-$PLAT.tar.xz"
URL="https://qt.mirror.constant.com/archive/qt/$QT_MAJOR_MINOR/$QT_VERSION/single/$SRC_FILENAME"
CACHE_DIR="$(pwd)/dependencies/cache/qt/$QT_VERSION/src"
QT_DIR="$(pwd)/dependencies/qt/$QT_VERSION"
SRC_DIR="$CACHE_DIR/qt-everywhere-src-$QT_VERSION"
BUILD_DIR="$CACHE_DIR/build"

if [[ -x "$QT_DIR/bin/qt-cmake" ]]; then
    echo "Qt $QT_VERSION is already installed at $QT_DIR"
    exit 0
fi

mkdir -p "$CACHE_DIR"
mkdir -p "$BUILD_DIR"
mkdir -p "$QT_DIR"

if [[ -f "$CACHE_DIR/../$BIN_FILENAME" ]]; then
    tar -xJf "$CACHE_DIR/../$BIN_FILENAME" -C "$QT_DIR"
    exit 0
fi

if [[ ! -f "$CACHE_DIR/$SRC_FILENAME" ]]; then
    curl -fL "$URL" -o "$CACHE_DIR/$SRC_FILENAME"
fi

if [[ ! -d "$SRC_DIR" ]]; then
    tar -xJf "$CACHE_DIR/$SRC_FILENAME" -C "$CACHE_DIR"
fi

cd "$BUILD_DIR"

"$SRC_DIR/configure" \
    -prefix "$QT_DIR"

ninja -C "$BUILD_DIR" -j 8 install
tar -cJf "$CACHE_DIR/../$BIN_FILENAME" -C "$QT_DIR" .
