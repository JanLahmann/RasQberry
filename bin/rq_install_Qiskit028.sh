#!/bin/bash
#
# installation of Qiskit 0.28
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.28"; echo;

sudo apt update
sudo apt -y full-upgrade
pip3 install --upgrade pip
pip3 install --prefer-binary scikit-build
sudo apt install cmake
pip3 install --no-use-pep517 tweedledum
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.28.*'

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`