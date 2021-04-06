#!/bin/bash
#
# installation of Qiskit 0.25
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.25"; echo;

LLVM_CONFIG=llvm-config-9 pip3 install llvmlite
pip3 install --prefer-binary -U Pillow
pip3 install --prefer-binary numpy==1.20.1 scipy==1.6.1 decorator==4.4.*
pip3 install git+https://github.com/Qiskit/qiskit-terra.git@0.17.0
pip3 install cmake
#pip3 install git+https://github.com/Qiskit/qiskit-aer.git@0.8.0
pip3 install --prefer-binary 'qiskit[visualization,all]==0.25.*'

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`
