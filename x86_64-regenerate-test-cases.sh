#!/bin/bash

set -e

pushd /tmp/osbuild-composer
mkdir /tmp/store || touch /
mkdir /tmp/output || touch /

echo "fedora-30
fedora-31
fedora-32" |
while read distro
do
  echo "tools/test-case-generators/generate-test-cases --distro $distro --arch x86_64 --store /tmp/store/ --output /tmp/output/"
done

popd
