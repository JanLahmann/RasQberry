#!/bin/bash
#
# clone the Fun-with-Quantum Repository

cd ~

if [ ! -d Fun-with-Quantum ]; then
   git clone https://github.com/JanLahmann/Fun-with-Quantum.git;
   echo "Cloned Fun-with-Quantum Repository"
fi

jupyter notebook Fun-with-Quantum $1 $2 $3