#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/osbuild/osbuild-composer.git
pushd osbuild-composer
dnf install make '@RPM Development Tools' -y
dnf builddep osbuild-composer.spec -y
make rpm
dnf install rpmbuild/RPMS/ppc64le/* -y
rm -rf /osbuild
mkdir -p /osbuild/store
mkdir -p /osbuild/output
popd
popd

/usr/libexec/tests/osbuild-composer/osbuild-image-tests
