#!/bin/bash
#
# installation of Qiskit 0.28
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.28"; echo;


LLVM_CONFIG=llvm-config-9 pip3 install llvmlite
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.28.*'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`