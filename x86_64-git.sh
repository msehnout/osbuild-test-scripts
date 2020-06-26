#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/osbuild/osbuild-composer.git
pushd osbuild-composer
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep osbuild-composer.spec -y
make rpm
dnf install rpmbuild/RPMS/x86_64/* -y
popd
popd
