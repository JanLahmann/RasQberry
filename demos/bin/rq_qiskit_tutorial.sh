#!/bin/bash
#
# install Qiskit tutorials
echo; echo; echo "install Qiskit tutorials"
#source ~/rasqberry/bin/activate
cd ~/
git clone https://github.com/Qiskit/qiskit-tutorials
pip3 install --prefer-binary cvxpy
jupyter notebook qiskit-tutorials $1 $2 $3
