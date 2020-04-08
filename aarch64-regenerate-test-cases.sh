#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/msehnout/osbuild-composer.git
pushd osbuild-composer
git checkout aarch64-boot-test
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep osbuild-composer.spec -y
dnf install osbuild -y
popd
popd

cp ext4-format-request-map.json /tmp/osbuild-composer/tools/test-case-generators/format-request-map.json

pushd /tmp/osbuild-composer
mkdir -p /osbuild/store || touch /
mkdir -p /osbuild/output || touch /

echo "fedora-30
fedora-31" |
while read distro
do
  tools/test-case-generators/generate-test-cases --distro $distro --arch aarch64 --store /osbuild/store/ --output /osbuild/output/
done

popd
