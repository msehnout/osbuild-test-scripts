#!/bin/bash

set -e

yum module install virt -y
yum install virt-install virt-viewer -y
systemctl start libvirtd
virt-host-validate

# This requires osbuild-composer checkout
genisoimage -input-charset utf-8 -volid cidata -joliet -rock /tmp/osbuild-composer/test/cloud-init/user-data /tmp/osbuild-composer/test/cloud-init/meta-data > /tmp/cloud-init.iso

# This requires /osbuild/output/disk.qcow2 created manually with `jq .manifest <test-case-for-the-arch> | osbuild --output-directory=/osbuild/output -`
virt-install --name demo789 --memory 2048 --vcpus 2 --os-variant rhel8-unknown --import --noautoconsole --network network=default --disk path=/osbuild/output/disk.qcow2 --disk path=/tmp/cloud-init.iso,device=cdrom

# Display IP addresses of running VMs
virsh net-dhcp-leases default

# Fix permissions
chmod go-rwx /tmp/osbuild-composer/test/keyring/id_rsa

# SSH into the machine like this: ssh -i /tmp/osbuild-composer/test/keyring/id_rsa redhat@192.168.122.6


