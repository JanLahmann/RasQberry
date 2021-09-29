#!/bin/bash
#
# installation of Qiskit 0.29
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.29"; echo;

pip3 install --prefer-binary  "pillow>=6.2.0" "decorator<5,>=4.3" "numpy<1.23.0,>=1.17.3"
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.29.*'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`