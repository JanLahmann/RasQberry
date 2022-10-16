#!/usr/bin/env python
# coding: utf-8
# Credits: https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals

#############################################################
from numba import jit, prange
import numpy as np
import numba as nb


@jit(nopython=True, cache=False, parallel=False, error_model='numpy')
def set_1cn(c:nb.complex128, z:np.ndarray[nb.complex128, nb.complex128], con:np.ndarray[nb.bool_, nb.bool_], div:np.ndarray[nb.int_, nb.int_], max_iterations: nb.int64 = 100, escape_number: nb.int64 = 2, frame_resolution: nb.int64 = 200):
    for j in range(max_iterations):
        for x in prange(frame_resolution):
            for y in prange(frame_resolution):
                if con[x, y]:
                    z[x, y] = z[x, y] ** 2 + c
                    if abs(z[x, y]) > escape_number:
                        con[x, y] = False
                        div[x, y] = j
    return div


@jit(nopython=True, cache=False, parallel=False)
def set_2cn1(c0:nb.complex128, c1:nb.complex128, z:np.ndarray[nb.complex128, nb.complex128], con:np.ndarray[nb.bool_, nb.bool_], div:np.ndarray[nb.int_, nb.int_], max_iterations: nb.int64 = 100, escape_number: nb.int64 = 2, frame_resolution: nb.int64 = 200):
    for j in range(max_iterations):
        for x in range(frame_resolution):
            for y in range(frame_resolution):
                if con[x, y]:
                    z[x, y] = (z[x, y] ** 2 + c0) / (z[x, y] ** 2 + c1)
                    if abs(z[x, y]) > escape_number:
                        con[x, y] = False
                        div[x, y] = j
    return div


@jit(nopython=True, cache=False, parallel=False, error_model='numpy')
def set_2cn2(c0:nb.complex128, c1:nb.complex128, z:np.ndarray[nb.complex128, nb.complex128], con:np.ndarray[nb.bool_, nb.bool_], div:np.ndarray[nb.int_, nb.int_], max_iterations: nb.int64 = 100, escape_number: nb.int64 = 2, frame_resolution: nb.int64 = 200):
    for j in range(max_iterations):
        for x in prange(frame_resolution):
            for y in prange(frame_resolution):
                if con[x, y]:
                    z[x, y] = (c0 * z[x, y] ** 2 + 1 - c0) / (c1 * z[x, y] ** 2 + 1 - c1)
                    if abs(z[x, y]) > escape_number:
                        con[x, y] = False
                        div[x, y] = j
    return div
