#!/bin/bash
#
echo; echo; echo "Raspberry-Tie"
cd ~

if [ ! -d quantum-raspberry-tie ]; then
   git clone https://github.com/KPRoche/quantum-raspberry-tie;
fi

cd quantum-raspberry-tie

python QuantumRaspberryTie.qiskit.py # standard 5 Qubit example
#python QuantumRaspberryTie.qiskit.py expt16.qasm # 16 Qubit example
#/usr/bin/sense_emu_gui &
#python QuantumRaspberryTie.qiskit.py -e  # "-e" forces to use the emulator
