#!/usr/bin/env python
# coding: utf-8
# Credits: https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals

#############################################################
# Importing standard python libraries
from typing import Tuple, List
from math import pi

# Importing standard Qiskit libraries
from qiskit import QuantumCircuit, Aer, execute
import numpy as np


class FractalQuantumCircuit:
    def __init__(self, number_of_qubits:int = 1) -> None:
        # Create the circuit for which the gates will be applied
        self.quantum_circuit = QuantumCircuit(number_of_qubits)
        self.quantum_circuit.h(0)

        # Define the backend to run the Quantum Circuit
        self.backend = Aer.get_backend('statevector_simulator')

    # noinspection PyUnresolvedReferences
    def get_quantum_circuit(self, frame_iteration:int = 0, total_number_of_frames:int = 60) -> Tuple[np.complex128, QuantumCircuit, List[np.complex128]]:
        # In case quantum_circuit is already defined, delete the variable before assigning
        # it again to prevent multiple copies of the class variable being saved in memory
        if "quantum_circuit" in globals():
            del quantum_circuit

        # Create a fresh copy of the Quantum Circuit
        quantum_circuit = self.quantum_circuit.copy()

        # Calculate the rotation Phi and apply it to the local Quantum Circuit
        phi_rotation = frame_iteration * 2 * pi / total_number_of_frames
        quantum_circuit.rz(phi_rotation, 0)

        # Simulate the Quantum Circuit and extract the statevector
        statevector_array = execute(quantum_circuit, self.backend).result().get_statevector()
        statevector_idx_n = statevector_array.data
        statevector_idx_0 = statevector_array.data[0]
        statevector_idx_1 = statevector_array.data[1]

        # Check statevector values and calculate a new statevector
        if statevector_idx_1.real != 0 or statevector_idx_1.imag != 0:
            statevector_new = statevector_idx_0 / statevector_idx_1
            statevector_new = round(statevector_new.real, 2) + round(statevector_new.imag, 2) * 1j
        else:
            statevector_new = 0

        return statevector_new, quantum_circuit, statevector_idx_n
