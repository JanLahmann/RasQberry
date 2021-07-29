#!/bin/bash
#
# installation of Qiskit 0.28
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.28"; echo;


LLVM_CONFIG=llvm-config-9 pip3 install llvmlite
pip3 install --prefer-binary -U Pillow
pip3 install --prefer-binary numpy==1.20.1 scipy==1.6.0 decorator==4.4.* sympy==1.7.1 retworkx==0.8.0 jupyter_core==4.6.1 matplotlib==3.3 traitlets==5.0
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.28.*'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`