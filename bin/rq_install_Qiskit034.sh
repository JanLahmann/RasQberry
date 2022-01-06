#!/bin/bash
#
# installation of Qiskit 0.34
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.34"; echo;

# install current version of rust; needed for retworkx
curl -o get_rustup.sh -s https://sh.rustup.rs
sh ./get_rustup.sh -y
source $HOME/.cargo/env

pip3 install --prefer-binary cmake "pillow>=6.2.0" "decorator<5,>=4.3" "numpy<1.23.0,>=1.17.3" 
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.34.*'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`