#!/bin/bash
#
# install Qiskit tutorials
echo; echo; echo "install Qiskit tutorials"
#source ~/rasqberry/bin/activate
cd ~ 

if [ ! -d qiskit-tutorials ]; then
   git clone https://github.com/Qiskit/qiskit-tutorials;
   echo "Cloned Qiskit-tutorials Repository"
   pip3 install --prefer-binary cvxpy
fi

jupyter notebook qiskit-tutorials $1 $2 $3
