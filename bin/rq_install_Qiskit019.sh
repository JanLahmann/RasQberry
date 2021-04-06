#!/bin/bash
#
# please see RasQ-01.sh for an introduction (http://ibm.biz/RasQ-gist-01)
#
# usage (in RPi terminal):
# getgist JanLahmann RasQ-02.sh
# time . ./RasQ-02.sh

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
echo; echo; echo "Install prereqs (retworkx pyscf cython)"; echo;

# if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card (esp. for retworkx and qiskit-aer) to save time
echo; echo; echo "if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card"; echo;
[ -d /boot/custom-wheels/ ] && pip install --prefer-binary /boot/custom-wheels/*`uname -m`.whl

echo; echo; echo "install retworkx pyscf cython"; echo;
pip install --prefer-binary retworkx pyscf cython


# 3.  Install qiskit

echo; echo; echo "Install Qiskit"; echo;
# workaround to install Qiskit-Aer on armv6l architecture:
# on armv6l, start a subshell to unpack libmuparserx.a from muparserx.armv7l.7z once the wrong library has been extracted
[ `uname -m` = "armv6l" ] && [ "$(pip list | grep qiskit-aer | wc -l)" -eq 0 ] &&   
( 
until [ -f /tmp/pip-install-*/qiskit-aer/src/third-party/linux/lib/libmuparserx.a ]; do sleep 30; done
cd /tmp/pip-install-*/qiskit-aer/src/third-party/linux/lib
echo "replacing libmuparserx.a"
ls -la 
7z x -y muparserx.armv7l.7z
ls -la
) &

pip install --prefer-binary 'qiskit[visualization]==0.19.*'
pip list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`
