#!/bin/bash
#
# installation of Qiskit 0.23
#

export STARTDATE=`date`
# 1. Setup virtualenv "rasqberry"
echo; echo; echo "Setup virtualenv rasqberry"; echo;
( echo; echo '##### added for rasqberry #####';
echo 'export PATH=/home/pi/.local/bin:$PATH';
echo "alias rasqberry='source ~/rasqberry/bin/activate'" ) >> ~/.bashrc && . ~/.bashrc

pip3 install --upgrade pip
python3 -m pip install virtualenv
python3 -m virtualenv rasqberry
source ~/rasqberry/bin/activate

# 2. if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card (esp. for retworkx and qiskit-aer) to save time
echo; echo; echo "if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card"; echo;
[ -d /boot/custom-wheels/ ] && pip install --prefer-binary /boot/custom-wheels/*`uname -m`.whl

# 3. Install Rust Compiler
echo; echo; echo "Install Rust Compiler"; echo;

# if retworkx is not installed, install Rust compiler
echo; echo; echo "if retworkx is not installed, install Rust compiler"; echo;
[ "$(pip list | grep retworkx | wc -l)" -eq 0 ] && 
pip install --prefer-binary setuptools-rust &&
curl -o get_rustup.sh -s https://sh.rustup.rs &&
sh ./get_rustup.sh -y && 
source ~/.cargo/env

# 4.  Install qiskit

echo; echo; echo "Install Qiskit"; echo;
pip install --prefer-binary 'qiskit[visualization]==0.23.*'
pip list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`
