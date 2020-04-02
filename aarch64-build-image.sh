#!/bin/bash

set -e

# Make store directory
mkdir /tmp/store || touch /
# Get the manifest
cat /usr/share/tests/osbuild-composer/cases/fedora_31-aarch64-qcow2-boot.json | jq .manifest > /tmp/manifest.json
# Run OSBuild and build the image
cat /tmp/manifest.json | osbuild --store /tmp/store/ -
# Copy the image to known location
IMAGE=$(find /tmp/store -name disk.qcow2 | head -1)
rm -f /tmp/disk.qcow2
cp "${IMAGE}" /tmp/disk.qcow2
