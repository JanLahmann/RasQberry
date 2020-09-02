#!/bin/bash
#
# install Qiskit tutorials
echo; echo; echo "install Qiskit tutorials"
cd ~/
git clone https://github.com/Qiskit/qiskit-tutorials
pip install --prefer-binary cvxpy
#jupyter notebook qiskit-tutorials --no-browser
