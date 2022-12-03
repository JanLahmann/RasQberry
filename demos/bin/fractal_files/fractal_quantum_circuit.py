#!/usr/bin/env python
# coding: utf-8
# Credits: https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals

#############################################################
# Importing standard python libraries
from typing import Tuple, List
from math import pi

# Importing standard Qiskit libraries
from qiskit import QuantumCircuit
from qiskit.quantum_info import Statevector
from numpy import complex64, ndarray
import numpy as np


class QuantumFractalCircuit:
    def __init__(self, number_of_qubits:int = 1, number_of_frames: int = 60) -> None:
        self.n_qubits = number_of_qubits
        self.n_frames = number_of_frames

        # Create the circuit for which the gates will be applied
        self.quantum_circuit = QuantumCircuit(number_of_qubits)
        self.quantum_circuit.h(0)

    # noinspection PyUnresolvedReferences
    def get_quantum_circuit(self, frame_iteration:int = 0) -> Tuple[complex64, QuantumCircuit, ndarray[complex64]]:
        # Create a fresh copy of the Quantum Circuit
        quantum_circuit = self.quantum_circuit.copy()

        # Calculate the rotation Phi and apply it to the local Quantum Circuit
        phi_rotation = frame_iteration * 2 * pi / self.n_frames
        quantum_circuit.rz(phi_rotation, 0)

        # Simulate the Quantum Circuit and extract the statevector
        statevector_array = Statevector(quantum_circuit)
        statevector_idx_n = statevector_array.data.astype(complex64)
        statevector_idx_0 = statevector_array.data[0].astype(complex64)
        statevector_idx_1 = statevector_array.data[1].astype(complex64)

        # Check statevector values and calculate a new statevector
        if statevector_idx_1.real != 0 or statevector_idx_1.imag != 0:
            statevector_new = statevector_idx_0 / statevector_idx_1
            statevector_new = round(statevector_new.real, 2) + round(statevector_new.imag, 2) * 1j
        else:
            statevector_new = 0

        return statevector_new.astype(complex64), quantum_circuit, statevector_idx_n
