#!/bin/bash

set -e

# to get dnf-json in place
dnf install osbuild-composer -y

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/msehnout/osbuild-composer.git
pushd osbuild-composer
git checkout fedora-selinux-build-pipeline
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep golang-github-osbuild-composer.spec -y
popd
popd

pushd /tmp/osbuild-composer
mkdir -p /osbuild/store || touch /
mkdir -p /osbuild/output || touch /

echo "fedora-32" | while read distro
do
  tools/test-case-generators/generate-test-cases --distro $distro --arch x86_64 --store /osbuild/store/ --output /osbuild/output/ --image-types qcow2 --with-customizations
done

popd
