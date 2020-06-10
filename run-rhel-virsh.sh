#!/bin/bash

set -e

yum module install virt -y
yum install virt-install virt-viewer -y
systemctl start libvirtd
virt-host-validate
