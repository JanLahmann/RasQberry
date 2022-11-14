#!/usr/bin/env python
# coding: utf-8
# Credits: https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals

# Importing standard python libraries
from typing import Optional

# Externally installed libraries
import numpy as np
from numpy import ndarray, complex64, complex_, int_, bool_, ushort


class JuliaSet:
    def __init__(self, sv_custom: complex64, sv_list: ndarray[complex64], z:ndarray, con:ndarray, div:ndarray, escape_value:int = 2, max_iterations:int = 100) -> None:
        # Maximal number of iterations and escape value boundary for the magnitude of z
        self.max_iterations:int = max_iterations
        self.escape_value:int = escape_value

        # Arrays for when the points converge, diverge and z-values based on the frame resolution
        self.converge: ndarray[bool_, bool_] = con
        self.diverge: ndarray[ushort, ushort] = div
        self.z: ndarray[complex64, complex64] = z

        # StateVectors for the Quantum Circuit
        self.sv_custom: complex64 = sv_custom
        self.sv_list: ndarray[complex64] = sv_list

        # Class values to save the resulting Julia set arrays for when they diverge
        # -------------------------------------------------------------------------
        self.res_1cn: Optional[ndarray[ushort, ushort]] = None
        self.res_2cn1: Optional[ndarray[ushort, ushort]] = None
        self.res_2cn2: Optional[ndarray[ushort, ushort]] = None

    def set_1cn(self):
        # Run the iterative transformation for 1cn
        con = self.converge.copy()
        div = self.diverge.copy()
        z = self.z.copy()
        c = self.sv_custom
        for i in range(self.max_iterations):
            z[con] = z[con] ** 2 + c
            con[np.abs(z) > self.escape_value] = False
            div[con] = i
        self.res_1cn = div

    def set_2cn1(self) -> None:
        con = self.converge.copy()
        div = self.diverge.copy()
        z = self.z.copy()
        c = self.sv_list
        for i in range(self.max_iterations):
            z[con] = (z[con] ** 2 + c[0]) / (z[con] ** 2 + c[1])
            con[np.abs(z) > self.escape_value] = False
            div[con] = i
        self.res_2cn1 = div

    def set_2cn2(self) -> None:
        con = self.converge.copy()
        div = self.diverge.copy()
        z = self.z.copy()
        c = self.sv_list
        for i in range(self.max_iterations):
            z[con] = (c[0] * z[con] ** 2 + 1 - c[0]) / (c[1] * z[con] ** 2 + 1 - c[1])
            con[np.abs(z) > self.escape_value] = False
            div[con] = i
        self.res_2cn2 = div
