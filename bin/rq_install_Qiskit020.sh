#!/bin/bash
#
# installation of Qiskit 0.20
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit"; echo;

pip3 install --prefer-binary 'qiskit[visualization]==0.20.*'
pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`