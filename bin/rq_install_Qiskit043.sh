#!/bin/bash
#
# installation of Qiskit 0.43
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.43"; echo;

# install current version of rust; needed for retworkx
curl -o get_rustup.sh -s https://sh.rustup.rs
sh ./get_rustup.sh -y --default-host arm-unknown-linux-gnueabihf
source $HOME/.cargo/env


pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.43'
pip3 install ~/RasQberry/whl/ibm_quantum_widgets-1.0.3-py2.py3-none-any.whl

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`