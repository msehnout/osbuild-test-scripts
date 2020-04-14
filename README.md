# I'm going to eat your computer if you run the scripts

Run tests on ARM:
```
dnf install git vim -y && git clone https://github.com/msehnout/osbuild-test-scripts.git && cd osbuild-test-scripts && bash aarch64-git.sh && bash run-tests.sh
```
Image tests:
```
dnf install git vim -y && git clone https://github.com/msehnout/osbuild-test-scripts.git && cd osbuild-test-scripts && bash aarch64-git.sh && bash run-image-tests.sh
```
Generate test cases on ARM:
```
dnf install git vim -y && git clone https://github.com/msehnout/osbuild-test-scripts.git && cd osbuild-test-scripts && bash aarch64-regenerate-test-cases.sh
```

x86\_64:

```
dnf install git vim -y && git clone https://github.com/msehnout/osbuild-test-scripts.git && cd osbuild-test-scripts && bash x86_64-git.sh && bash run-tests.sh
```
```
dnf install git vim -y && git clone https://github.com/msehnout/osbuild-test-scripts.git && cd osbuild-test-scripts && bash x86_64-regenerate-test-cases.sh
```
