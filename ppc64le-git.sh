#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/msehnout/osbuild-composer.git
pushd osbuild-composer
git checkout rhel8-ppc64le-support
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep osbuild-composer.spec -y
make rpm
dnf install rpmbuild/RPMS/ppc64le/* -y
rm -rf /osbuild
mkdir -p /osbuild/store
mkdir -p /osbuild/output
tools/test-case-generators/generate-test-cases --distro rhel-8 --arch ppc64le --store /osbuild/store/ --output /osbuild/output/
popd
popd
