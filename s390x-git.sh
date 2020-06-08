#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/msehnout/osbuild-composer.git
pushd osbuild-composer
git checkout rhel8-s390x-support
dnf install go-rpm-macros make '@RPM Development Tools' -y
dnf builddep osbuild-composer.spec -y
make rpm
dnf install rpmbuild/RPMS/s390x/* -y
rm -rf /osbuild
mkdir -p /osbuild/store
mkdir -p /osbuild/output
popd
popd
cp qcow2-format-request-map.json /tmp/osbuild-composer/tools/test-case-generators/format-request-map.json
pushd /tmp/osbuild-composer
tools/test-case-generators/generate-test-cases --distro rhel-8 --arch s390x --store /osbuild/store/ --output /osbuild/output/
popd
