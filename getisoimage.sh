#!/bin/bash

set -e

genisoimage -quiet -input-charset utf-8 -volid cidata -joliet -rock user-data meta-data > /tmp/cloudinit
