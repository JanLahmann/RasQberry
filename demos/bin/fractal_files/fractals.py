#!/usr/bin/env python
# coding: utf-8

# Credits: https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals

# Importing standard python libraries
from math import pi
from threading import *
import os
from pathlib import Path

# Import additional python libraries
from IPython.display import clear_output
from celluloid import Camera

import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np

from selenium import webdriver
import selenium
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By

# Importing standard Qiskit libraries
from qiskit import QuantumCircuit, Aer, execute
from qiskit.visualization import *  # plot_bloch_multivector
from ibm_quantum_widgets import *  # CircuitComposer

cwd = Path.cwd()
browser_file_path = f"file://{cwd}"
pic_url = f"{browser_file_path}/2cn2.png"

# Try to remove previously generated files
try:
    os.remove(f"{cwd}/2cn2.png")
except:
    print("Error while deleting 2cn2.png file. This is probably normal.")

try:
    # open selenium browser driver
    options = webdriver.ChromeOptions()
    # Disable "Chrome is being controlled by automated test software" message
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_argument(f"--app={pic_url}")
    options.add_argument('--start-maximized')
    service = Service('/usr/lib/chromium-browser/chromedriver')
    driver = webdriver.Chrome(service=service, options=options)
except selenium.common.exceptions.WebDriverException:
    print("Error while starting chrome. Are you using a desktop? SSH is not supported!")
    exit()

# Start with a one qubit quantum circuit yielding a nice fractal. Change the circuit as you like.
circuit = QuantumCircuit(1, 1)
circuit.h(0)
editor = CircuitComposer(circuit=circuit)

# Generate a Bloch sphere based on the quantum circuit.
qc1 = editor.circuit
plot_bloch_multivector(qc1)

# Run the circuit with the state vector simulator to obtain a noise-free fractal.
backend = Aer.get_backend('statevector_simulator')
out = execute(qc1, backend).result().get_statevector()
# print(out)

# Extract the first element of the state vector as z0 and the second element as z1.
z0 = out.data[0]
z1 = out.data[1]

# Goal: One complex number for the Julia set fractal.
if z1.real != 0 or z1.imag != 0:
    z = z0 / z1
    z = round(z.real, 2) + round(z.imag, 2) * 1j
else:
    z = 0

# Define the JuliaSet class

class JuliaSet:
    def __init__(self, esc_val: int = 2, height: int = 200, width: int = 200, zoom: int = 1, x: int = 0, y: int = 0):
        # Escape value boundary for the magnitude of z
        self.escape_value = esc_val

        # To make navigation easier we calculate the ...
        x_width = 1.5
        x_from = x - x_width / zoom
        x_to = x + x_width / zoom

        y_height = 1.5 * height / width
        y_from = y - y_height / zoom
        y_to = y + y_height / zoom

        # Image coordinates used for the initial z value in each Julia set class function
        self.x = np.linspace(x_from, x_to, width).reshape((1, width))
        self.y = np.linspace(y_from, y_to, height).reshape((height, 1))
        self.z = self.x + self.y * 1j

        # Values kept as class variables to reduce compute power
        # -------------------------------------------------------------
        # div_time: To keep track in which iteration the point diverged
        self.div_time = np.zeros(self.z.shape, dtype=int)

        # m: To keep track on which points did not converge so far
        self.m = np.full(self.z.shape, True, dtype=bool)

        # Class values to get the resulting Julia sets
        # -------------------------------------------------------------
        self.res_1cn = None
        self.res_2cn1 = None
        self.res_2cn2 = None

    def set_1cn(self, c: np.complex128, max_iterations: int = 100) -> np.ndarray:
        # Initialize z as x + yi and initialize c to all zero
        z = self.z.copy()
        c = np.full(z.shape, c)

        # Create a copy of the default arrays
        div_time = self.div_time.copy()
        m = self.m.copy()

        # Run the iterative transformation for 1cn
        for i in range(max_iterations):
            z[m] = z[m] ** 2 + c[m]
            m[np.abs(z) > self.escape_value] = False
            div_time[m] = i
        self.res_1cn = div_time

    def set_2cn1(self, c0: np.complex128, c1: np.complex128, max_iterations: int = 100) -> np.ndarray:
        # Initialize z as x + yi and initialize c0 and c1 to all zero
        z = self.z.copy()
        c0 = np.full(z.shape, c0)
        c1 = np.full(z.shape, c1)

        # Create a copy of the default arrays
        div_time = self.div_time.copy()
        m = self.m.copy()

        for i in range(max_iterations):
            z[m] = (z[m] ** 2 + c0[m]) / (z[m] ** 2 + c1[m])  # Julia set mating 1
            m[np.abs(z) > self.escape_value] = False  # 2
            div_time[m] = i
        self.res_2cn1 = div_time

    def set_2cn2(self, c0: np.complex128, c1: np.complex128, max_iterations: int = 100) -> np.ndarray:
        # Initialize z as x + yi and initialize c0 and c1 to all zero
        z = self.z.copy()
        c0 = np.full(z.shape, c0)
        c1 = np.full(z.shape, c1)

        # Create a copy of the default arrays
        div_time = self.div_time.copy()
        m = self.m.copy()

        for i in range(max_iterations):
            z[m] = (c0[m] * z[m] ** 2 + 1 - c0[m]) / (c1[m] * z[m] ** 2 + 1 - c1[m])  # julia set mating 2
            m[np.abs(z) > self.escape_value] = False  # 2
            div_time[m] = i
        self.res_2cn2 = div_time


def complexcircuit(tt):
    lqc1 = qc1.copy()
    phl = tt * 2 * pi / frameno
    lqc1.rz(phl, 0)

    lout = execute(lqc1, backend).result().get_statevector()
    lz0 = lout.data[0]
    lz1 = lout.data[1]

    if lz1.real != 0 or lz1.imag != 0:
        lz = lz0 / lz1
        lz = round(lz.real, 2) + round(lz.imag, 2) * 1j
    else:
        lz = 0

    return lz, lqc1, lz0, lz1


# Define the animations class
class QuantumFractalImages:
    def __init__(self, i: int, cno: np.complex128, cc1: np.complex128, cc2: np.complex128, ccircuit: QuantumCircuit):
        # Firstly, calculate the three types of Julia Sets
        # Create the threads based on each function the Julia Set Class
        self.Julia = JuliaSet()
        threads = [
            Thread(target=self.Julia.set_1cn, kwargs={"c": cno}),
            Thread(target=self.Julia.set_2cn1, kwargs={"c0": cc1, "c1": cc2}),
            Thread(target=self.Julia.set_2cn2, kwargs={"c0": cc1, "c1": cc2})
        ]

        # Start the threads
        for thread in threads:
            thread.start()

        # Wait for all threads to complete:
        for thread in threads:
            thread.join()

        # Define the results from the three calculations
        self.i = i
        self.res_1cn = self.Julia.res_1cn
        self.res_2cn1 = self.Julia.res_2cn1
        self.res_2cn2 = self.Julia.res_2cn2

    def qfanimations(self):
        # Secondly (a), generate the images based on the Julia set results
        plot_bloch_multivector(ccircuit, filename=f'{cwd}/H.png')
        ax[0].imshow(mpimg.imread('H.png'))
        ax[0].axis('off')
        ax[0].set_title('Bloch sphere', fontsize=20, pad=15.0)
        ax[1].imshow(self.res_1cn, cmap='magma')
        ax[1].axis('off')
        ax[2].imshow(self.res_2cn1, cmap='magma')
        ax[2].set_title('3 types of Julia set fractals based on the superposition H-gate', fontsize=20, pad=15.0)
        ax[2].axis('off')
        ax[3].figure.set_size_inches(16, 5)
        ax[3].imshow(self.res_2cn2, cmap='magma')
        ax[3].axis('off')
        ax[3].figure.supxlabel('ibm.biz/quantum-fractals-blog            ibm.biz/quantum-fractals', fontsize=20)
        camera.snap()
        plt.close()

    def qfimages(self):
        # Secondly (b), generate the images based on the Julia set results
        clear_output(wait=True)  # remove if you want to see all images in a loop
        fig, ax = plt.subplots(1, 4, figsize=(20, 20))

        print("Loop i =", i, " One complex no =", round(cno.real, 2) + round(cno.imag, 2) * 1j,
              "    Complex amplitude one:", round(cc1.real, 2) + round(cc1.imag, 2) * 1j, "and two:",
              round(cc2.real, 2) + round(cc2.imag, 2) * 1j)  # round(num.real, 2) + round(num.imag, 2) * 1j
        plot_bloch_multivector(ccircuit, filename=f'{cwd}/H.png')
        ax[0].imshow(mpimg.imread('H.png'))
        ax[0].axis('off')
        ax[0].set_title('Bloch sphere', fontsize=20, pad=15.0)
        ax[1].imshow(self.res_1cn, cmap='magma')
        ax[1].axis('off')
        ax[2].imshow(self.res_2cn1, cmap='magma')
        ax[2].set_title('3 types of Julia set fractals based on the superposition H-gate', fontsize=20, pad=15.0)
        ax[2].axis('off')
        ax[3].figure.set_size_inches(16, 5)
        ax[3].imshow(self.res_2cn2, cmap='magma')
        ax[3].axis('off')
        ax[3].figure.supxlabel('ibm.biz/quantum-fractals-blog            ibm.biz/quantum-fractals', fontsize=20)
        ax[3].figure.savefig('2cn2.png')
        # Open in browser
        driver.get(pic_url)
        # plt.show()
        clear_output()
        plt.close()


fig, ax = plt.subplots(1, 4, figsize=(20, 5))
camera = Camera(fig)

frameps = 5  # used below to calculate interval between images
frameno = 60

for i in range(frameno):
    try:
        # Firstly, get the complex numbers from the complex circuit
        ccc = complexcircuit(i)

        # Secondly, for the sake of transparency, the elements from the list are defined as separate variables
        cno = ccc[0]
        ccircuit = ccc[1]
        cc1 = ccc[2]
        cc2 = ccc[3]

        # Thirdly, run the animation and image creation
        QFI = QuantumFractalImages(i=i, cno=cno, cc1=cc1, cc2=cc2, ccircuit=ccircuit)
        QFI.qfanimations()
        QFI.qfimages()
    except (selenium.common.exceptions.NoSuchWindowException, selenium.common.exceptions.WebDriverException):
        print("Error, Browser window closed during generation of images")
        driver.quit()
        break
driver.quit()
print("Saving the current animation state in GIF")
interval = 1000 / frameps
anim = camera.animate(blit=True, interval=interval)
anim.save(f'1qubit_simulator_4animations_H_{frameno}_steps_{interval}ms_interval.gif', writer='pillow')
gif_url = f"{browser_file_path}/1qubit_simulator_4animations_H_{frameno}_steps_{interval}ms_interval.gif"
driver2 = webdriver.Chrome(service=service, options=options)
driver2.get(gif_url)

# check if the browser window is closed
while True:
    try:
        driver2.find_element(By.TAG_NAME, 'body')
    except (selenium.common.exceptions.NoSuchWindowException, selenium.common.exceptions.WebDriverException):
        print("Error, Browser window closed, quitting the program")
        sys.exit()
