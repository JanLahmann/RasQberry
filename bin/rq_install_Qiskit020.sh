#!/bin/bash
#
# please see RasQ-01.sh for an introduction (http://ibm.biz/RasQ-gist-01)
# installation of Qiskit 0.20
#
# usage (in RPi terminal):
# getgist JanLahmann RasQ-02_020.sh
# time . ./RasQ-02_020.sh

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

# 2. Install prereqs (retworkx pyscf cython)
echo; echo; echo "Install prereqs (retworkx pyscf cython six)"; echo;

# if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card (esp. for retworkx and qiskit-aer) to save time
echo; echo; echo "if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card"; echo;
[ -d /boot/custom-wheels/ ] && pip install --prefer-binary /boot/custom-wheels/*`uname -m`.whl

# if retworkx is not installed, install Rust compiler
echo; echo; echo "if retworkx is not installed, install Rust compiler"; echo;
[ "$(pip list | grep retworkx | wc -l)" -eq 0 ] && 
pip install --prefer-binary setuptools-rust &&
curl -o get_rustup.sh -s https://sh.rustup.rs &&
sh ./get_rustup.sh -y && 
source ~/.cargo/env

echo; echo; echo "install retworkx pyscf cython six"; echo;
pip install --prefer-binary retworkx pyscf cython six==1.14.*


# 4.  Install qiskit

echo; echo; echo "Install Qiskit"; echo;
pip install --prefer-binary 'qiskit[visualization]==0.20.*'
pip list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`
