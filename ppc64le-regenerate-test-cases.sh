#!/bin/bash

set -e

pushd /tmp
rm -rf osbuild-composer
git clone https://github.com/osbuild/osbuild-composer.git
pushd osbuild-composer
dnf install make '@RPM Development Tools' -y
dnf builddep golang-github-osbuild-composer.spec -y
popd
popd

cp ppc64le-formats.json /tmp/osbuild-composer/tools/test-case-generators/format-request-map.json

pushd /tmp/osbuild-composer
mkdir -p /osbuild/store || touch /
mkdir -p /osbuild/output || touch /

tools/test-case-generators/generate-test-cases --distro rhel-8 --arch ppc64le --store /osbuild/store/ --output /osbuild/output/

popd
