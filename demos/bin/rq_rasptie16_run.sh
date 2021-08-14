#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 16 Qubit Demo"
cd ~/quantum-raspberry-tie

#nohup sh -c 'sleep 5 && python3 QuantumRaspberryTie.qiskit.py $1 -local expt16.qasm' &
sleep 5
python3 QuantumRaspberryTie.qiskit.py $1 -local expt16.qasm &
