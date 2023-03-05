#!/bin/bash
#
# installation of Qiskit 0.38
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.38"; echo;

# install current version of rust; needed for retworkx
curl -o get_rustup.sh -s https://sh.rustup.rs
sh ./get_rustup.sh -y
source $HOME/.cargo/env

# workaround to force conan v1.x
git clone https://github.com/Qiskit/qiskit-aer/ --branch 0.11.0
cd qiskit-aer
sed -i "s/conan>=1.40.0/conan<2.0.0/" pyproject.toml
pip install .


pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.38'
pip3 install --prefer-binary ibm-quantum-widgets

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`