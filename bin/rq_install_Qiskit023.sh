#!/bin/bash
#
# installation of Qiskit 0.23
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.23"; echo;

<<<<<<< HEAD
pip3 install --upgrade pip
python3 -m pip install virtualenv
python3 -m virtualenv rasqberry
source ~/rasqberry/bin/activate

# 2. Install qiskit

echo; echo; echo "Install Qiskit"; echo;
pip install --prefer-binary 'qiskit[visualization]==0.23.*'
pip list | grep qiskit
=======
pip3 install -U numpy Pillow
pip3 install --prefer-binary 'qiskit[visualization]==0.23.*'
pip3 list | grep qiskit
>>>>>>> JRL-dev3

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`