#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/msehnout/osbuild-composer.git
pushd osbuild-composer
git checkout aarch64-image-tests
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep osbuild-composer.spec -y
make rpm
dnf install rpmbuild/RPMS/aarch64/* -y
popd
popd
