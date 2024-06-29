#!/usr/bin/env sh

set -eux

export VER="0.1.5"

mkdir /build
cd /build

wget https://github.com/hyprwm/hyprutils/archive/refs/tags/v$VER.tar.gz -O hyprutils-$VER.tar.gz
tar -xzmf hyprutils-$VER.tar.gz
cd hyprutils-$VER

cp -r /shared/debian /build/hyprutils-$VER/debian
sed -i "s/VERSION_TEMPLATE/$VER/g" /build/hyprutils-$VER/debian/changelog
sed -i "s/VERSION_TEMPLATE/$VER/g" /build/hyprutils-$VER/debian/control
dpkg-buildpackage -us -uc

cd /build
ls -l

cp hyprutils_$VER\_amd64.deb /shared

cd /shared
dpkg-deb -c hyprutils_$VER\_amd64.deb
dpkg -I hyprutils_$VER\_amd64.deb