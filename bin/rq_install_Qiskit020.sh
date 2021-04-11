#!/bin/bash
#
# installation of Qiskit 0.20
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.20"; echo;

<<<<<<< HEAD
pip3 install --upgrade pip
python3 -m pip install virtualenv
python3 -m virtualenv rasqberry
source ~/rasqberry/bin/activate

# 2. Install prereqs (retworkx pyscf cython)
echo; echo; echo "Install prereqs (retworkx pyscf cython six)"; echo;

# if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card (esp. for retworkx and qiskit-aer) to save time
echo; echo; echo "if /boot/custom-wheels/ exists, use pre-compiled wheels on SD card"; echo;
[ -d /boot/custom-wheels/ ] && pip install --prefer-binary /boot/custom-wheels/*`uname -m`.whl

echo; echo; echo "install retworkx pyscf cython six"; echo;
pip install --prefer-binary retworkx pyscf cython six==1.14.*


# 3.  Install qiskit

echo; echo; echo "Install Qiskit"; echo;
pip install --prefer-binary 'qiskit[visualization]==0.20.*'
pip list | grep qiskit
=======
pip3 install -U numpy Pillow
pip3 install --prefer-binary 'qiskit[visualization]==0.20.*'
pip3 list | grep qiskit
>>>>>>> JRL-dev3

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`