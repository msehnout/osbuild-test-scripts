#!/bin/bash

set -e

dnf install https://kojipkgs.fedoraproject.org//work/tasks/7585/42617585/golang-github-osbuild-composer-8-1.20200319git9ddc65b.fc31.aarch64.rpm https://kojipkgs.fedoraproject.org//work/tasks/7585/42617585/golang-github-osbuild-composer-rcm-8-1.20200319git9ddc65b.fc31.aarch64.rpm https://kojipkgs.fedoraproject.org//work/tasks/7585/42617585/golang-github-osbuild-composer-tests-8-1.20200319git9ddc65b.fc31.aarch64.rpm https://kojipkgs.fedoraproject.org//work/tasks/7585/42617585/golang-github-osbuild-composer-worker-8-1.20200319git9ddc65b.fc31.aarch64.rpm -y

cat > /etc/systemd/system/osbuild-composer.service << EOF
[Unit]
Description=OSBuild Composer
After=multi-user.target
Requires=osbuild-composer.socket
Wants=osbuild-worker@1.service

[Service]
Type=simple
ExecStart=/usr/libexec/osbuild-composer/osbuild-composer -v
CacheDirectory=osbuild-composer
StateDirectory=osbuild-composer
WorkingDirectory=/usr/libexec/osbuild-composer/
User=_osbuild-composer
Restart=on-failure

# systemd >= 240 sets this, but osbuild-composer runs on earlier versions
Environment="CACHE_DIRECTORY=/var/cache/osbuild-composer"
Environment="STATE_DIRECTORY=/var/lib/osbuild-composer"

[Install]
WantedBy=multi-user.target
EOF

