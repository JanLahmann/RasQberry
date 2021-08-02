#!/bin/bash
#
# installation of Qiskit 0.28
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.28"; echo;

pip3 install --prefer-binary "importlib-metadata<4" "pillow>=6.2.0" "decorator<5,>=4.3"
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.28.*'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`