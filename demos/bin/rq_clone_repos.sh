#!/bin/bash
#
# If not already cloned clone:
# - Fun-with-Quantum
# - Qiskit-tutorials
#

cd ~

if [ ! -d Fun-with-Quantum ]; then
   git clone https://github.com/JanLahmann/Fun-with-Quantum.git;
   echo "Cloned Fun-with-Quantum Repository"
fi

if [ ! -d qiskit-tutorials ]; then
   git clone https://github.com/Qiskit/qiskit-tutorials;
   echo "Cloned Qiskit-tutorials Repository"
fi