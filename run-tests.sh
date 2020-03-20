#!/bin/bash

set -e

systemctl daemon-reload
systemctl restart osbuild-composer.socket osbuild-rcm.socket

cd /usr/libexec/osbuild-composer
for test in /usr/libexec/tests/osbuild-composer/*
do
	echo "Running ${test}"
       	if $test
	then
		echo "${test} passed"
	else
		echo "${test} failed"
	fi
done
