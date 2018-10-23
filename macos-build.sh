#!/usr/bin/env bash

set -e

THIRD_PARTY_DIR="$(pwd)/third_party"

rm -rf build
mkdir build
cd build

PACK_ROOT="deb"
DEBIAN_FOLDER="$PACK_ROOT/DEBIAN"
LOCAL_INSTALL="$PACK_ROOT/usr/local"
mkdir -p "$LOCAL_INSTALL"
LOCAL_INSTALL_FULL="$(pwd)"/"$LOCAL_INSTALL"

cmake .. \
-DEIGEN_INCLUDE_DIR="$THIRD_PARTY_DIR/include/eigen3" \
-DFLANN_INCLUDE_DIR="$THIRD_PARTY_DIR/include/flann" -DFLANN_LIBRARY="$THIRD_PARTY_DIR/lib/libflann_s.a" \
-DQHULL_INCLUDE_DIR="$THIRD_PARTY_DIR/include" -DQHULL_LIBRARY="$THIRD_PARTY_DIR/lib/libqhullstatic.a" \
-DBUILD_tools=OFF \
-DWITH_CUDA=OFF -DWITH_DAVIDSDK=OFF -DWITH_DSSDK=OFF -DWITH_ENSENSO=OFF -DWITH_FZAPI=OFF -DWITH_LIBUSB=OFF \
-DWITH_OPENGL=OFF -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF -DWITH_PCAP=OFF -DWITH_PNG=OFF \
-DWITH_QHULL=ON -DWITH_QT=OFF -DWITH_RSSDK=OFF -DWITH_VTK=OFF \
-DPCL_SHARED_LIBS=OFF -DPCL_NO_PRECOMPILE=OFF -DPCL_ONLY_CORE_POINT_TYPES=OFF \
-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$LOCAL_INSTALL_FULL" \
-DCMAKE_MACOSX_RPATH=1

make -j8
make install

open "$LOCAL_INSTALL_FULL"

