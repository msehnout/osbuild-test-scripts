#!/bin/bash

set -e

systemctl daemon-reload
systemctl restart osbuild-composer.socket 

cd /usr/libexec/osbuild-composer
for test in /usr/libexec/tests/osbuild-composer/osbuild-image-tests
do
	echo "Running ${test}"
       	if $test
	then
		echo "${test} passed"
	else
		echo "${test} failed"
	fi
done
