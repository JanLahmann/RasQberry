#!/bin/bash
#
# installation of Qiskit 0.37
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.37"; echo;

# install current version of rust; needed for retworkx
curl -o get_rustup.sh -s https://sh.rustup.rs
sh ./get_rustup.sh -y
source $HOME/.cargo/env

pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`