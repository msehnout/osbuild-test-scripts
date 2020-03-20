#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/msehnout/osbuild-composer.git
pushd osbuild-composer
git checkout open-vm-tools-new-3
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep golang-github-osbuild-composer.spec -y
make rpm
dnf install rpmbuild/RPMS/x86_64/* -y
popd
popd
