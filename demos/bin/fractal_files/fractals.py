#!/usr/bin/env python
# coding: utf-8
# Credits: https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals

# |
# | Library imports
# └───────────────────────────────────────────────────────────────────────────────────────────────────────
# Importing standard python libraries
from threading import Thread
from pathlib import Path
from typing import Optional
from copy import deepcopy
from io import BytesIO
import traceback
import timeit
import sys

# Externally installed libraries
import matplotlib.pyplot as plt
import numpy as np

from selenium.common.exceptions import WebDriverException, NoSuchWindowException
from selenium.webdriver.common.by import By
from celluloid import Camera
from numpy import complex_, complex64, ndarray, ushort, bool_
from PIL import Image

# Importing standard Qiskit libraries
from qiskit import QuantumCircuit
from qiskit.visualization import plot_bloch_multivector

# self-coded libraries
from fractal_webclient import WebClient
from fractal_julia_calculations import JuliaSet
from fractal_quantum_circuit import QuantumFractalCircuit

# |
# | Global settings for the script
# └───────────────────────────────────────────────────────────────────────────────────────────────────────
# Julia set calculation values
julia_iterations: int = 100
julia_escape_val: int = 2

# Image generation and animation values
GIF_ms_intervals: int = 200  # 200ms = 5 fps
number_of_frames: int = 60  # Total number of frames to generate

# Coordinate values in the Julia Set fractal image/frame
frame_resolution: int = 200  # Height and width
height: int = frame_resolution
width: int = frame_resolution
zoom: float = 1.0

x_start: float = 0
x_width: float = 1.5
x_min: float = x_start - x_width / zoom
x_max: float = x_start + x_width / zoom

y_start: float = 0
y_width: float = 1.5
y_min: float = y_start - y_width / zoom
y_max: float = y_start + y_width / zoom

# Create the basis 2D array for the fractal
x_arr = np.linspace(start=x_min, stop=x_max, num=width).reshape((1, width))
y_arr = np.linspace(start=y_min, stop=y_max, num=height).reshape((height, 1))
z_arr = np.array(x_arr + 1j * y_arr, dtype=complex64)

# Create array to keep track in which iteration the points have diverged
div_arr = np.zeros(z_arr.shape, dtype=np.uint8)

# Create Array to keep track on which points have not converged
con_arr = np.full(z_arr.shape, True, dtype=bool_)

# Dictionary to keep track of time pr. loop
timer = {"QuantumCircuit": 0.0, "Julia_calculations": 0.0, "Animation": 0.0, "Image": 0.0, "Bloch_data": 0.0}
acc_timer = timer
# |
# | Pathing, default folder and generated files, webclient
# └───────────────────────────────────────────────────────────────────────────────────────────────────────
# Set default path values
temp_image_folder = Path(Path.cwd(), "img")
browser_file_path = f"file://{temp_image_folder}"
default_image_url = f"{browser_file_path}/2cn2.png"

# Start the Chromedriver and redirect to default image before removal
driver = WebClient(default_image_url=default_image_url).get_driver()  # ChromeDriver

# Remove previously generated files
if temp_image_folder.exists():
    try:
        for image in temp_image_folder.glob("*.*"):
            Path(image).unlink()
    except FileNotFoundError:
        pass
else:
    temp_image_folder.mkdir(parents=True, exist_ok=True)


# |
# | Defining the animation class to generate the images for the Quantum Fractal
# └───────────────────────────────────────────────────────────────────────────────────────────────────────
class QuantumFractalImages:
    """Calculate and generate Quantum Fractal Images using Julia Set formulas"""
    def __init__(self):
        # Define the result variables for the three Julia Set calculations
        self.res_1cn: Optional[np.ndarray[np.int_, np.int_]] = None
        self.res_2cn1: Optional[np.ndarray[np.int_, np.int_]] = None
        self.res_2cn2: Optional[np.ndarray[np.int_, np.int_]] = None

        # Save the QuantumCircuit as class variable
        self.circuit: Optional[BytesIO] = None

        # Save the GIF variables in class variables to keep the state for the lifetime of this class
        # in contrary to qf_images which requires the variables to be defined for each iteration
        self.gif_fig, self.gif_ax = plt.subplots(1, 4, figsize=(20, 5))
        self.gif_cam = Camera(self.gif_fig)

    def qfi_julia_calculation(self, sv_custom: complex_, sv_list: ndarray[complex_]) -> None:
        """Calculate the results for all three of the Julia-set formulas"""
        timer['Julia_calculations'] = timeit.default_timer()
        julia = JuliaSet(sv_custom=sv_custom, sv_list=sv_list, z=z_arr, con=con_arr, div=div_arr)

        # Define the three julia-set formulas for each of their own threads
        threads = [Thread(target=julia.set_1cn), Thread(target=julia.set_2cn1), Thread(target=julia.set_2cn2)]

        # Start the threads and wait for threads to complete
        [thread.start() for thread in threads]
        [thread.join() for thread in threads]

        # Define the results from the three calculations
        self.res_1cn = julia.res_1cn
        self.res_2cn1 = julia.res_2cn1
        self.res_2cn2 = julia.res_2cn2
        timer['Julia_calculations'] = timeit.default_timer() - timer['Julia_calculations']

    def qfi_quantum_circuit(self, quantum_circuit: Optional[QuantumCircuit] = None) -> None:
        """Generate the Bloch Sphere image from the Quantum Circuit and convert to Bytes"""
        timer['Bloch_data'] = timeit.default_timer()
        bloch_data = BytesIO()
        plot_bloch_multivector(quantum_circuit).savefig(bloch_data, format='png')
        bloch_data.seek(0)
        self.circuit = bloch_data
        del bloch_data
        timer['Bloch_data'] = timeit.default_timer() - timer['Bloch_data']

    def qfi_animations(self) -> None:
        """Generate Animation of the Quantum Fractal Images"""
        timer['Animation'] = timeit.default_timer()

        # Plot Bloch sphere
        self.gif_ax[0].imshow(Image.open(deepcopy(self.circuit)))
        self.gif_ax[0].set_title('Bloch sphere', fontsize=20, pad=15.0)

        # Plot 1st Julia Fractal
        self.gif_ax[1].imshow(self.res_1cn, cmap='magma')

        # Plot 2nd Julia Fractal
        self.gif_ax[2].imshow(self.res_2cn1, cmap='magma')
        self.gif_ax[2].set_title('3 types of Julia set fractals based on the superposition H-gate', fontsize=20, pad=15.0)

        # Plot 3rd Julia Fractal
        self.gif_ax[3].figure.set_size_inches(16, 5)
        self.gif_ax[3].imshow(self.res_2cn2, cmap='magma')
        self.gif_ax[3].figure.supxlabel('ibm.biz/quantum-fractals-blog            ibm.biz/quantum-fractals', fontsize=20)

        # Turn off axis values for all columns of images
        for col in range(0, self.gif_ax[0].get_gridspec().ncols):
            self.gif_ax[col].axis('off')

        # Snap a picture of the image outcome and close the plt object
        self.gif_cam.snap()
        plt.close()
        timer['Animation'] = timeit.default_timer() - timer['Animation']

    def qfi_images(self) -> None:
        """Generate an image for each iteration of the Quantum Fractals"""
        img_fig, img_ax = plt.subplots(1, 4, figsize=(20, 5))
        # Secondly (b), generate the images based on the Julia set results
        timer['Image'] = timeit.default_timer()

        # Plot Bloch sphere
        img_ax[0].imshow(Image.open(deepcopy(self.circuit)))
        img_ax[0].set_title('Bloch sphere', fontsize=20, pad=15.0)

        # Plot 1st Julia Fractal
        img_ax[1].imshow(self.res_1cn, cmap='magma')

        # Plot 2nd Julia Fractal
        img_ax[2].imshow(self.res_2cn1, cmap='magma')
        img_ax[2].set_title('3 types of Julia set fractals based on the superposition H-gate', fontsize=20, pad=15.0)

        # Plot 3rd Julia Fractal
        img_ax[3].figure.set_size_inches(16, 5)
        img_ax[3].imshow(self.res_2cn2, cmap='magma')
        img_ax[3].figure.supxlabel('ibm.biz/quantum-fractals-blog            ibm.biz/quantum-fractals', fontsize=20)

        # Turn off axis values for all columns of images
        for col in range(0, img_ax[0].get_gridspec().ncols):
            img_ax[col].axis('off')

        # Save image locally and open image in browser and close the plt object
        img_ax[3].figure.savefig(Path(temp_image_folder, "2cn2.png"))
        driver.get(default_image_url)
        plt.close('all')
        del img_fig, img_ax
        timer['Image'] = timeit.default_timer() - timer['Image']


# |
# | Running the script
# └───────────────────────────────────────────────────────────────────────────────────────────────────────
QFC = QuantumFractalCircuit(number_of_qubits=1, number_of_frames=number_of_frames)
QFI = QuantumFractalImages()

for i in range(number_of_frames):
    try:
        # Firstly, get the complex numbers from the complex circuit
        timer['QuantumCircuit'] = timeit.default_timer()
        ccc = QFC.get_quantum_circuit(frame_iteration=i)
        timer['QuantumCircuit'] = timeit.default_timer() - timer['QuantumCircuit']

        # Secondly, run the animation and image creation
        QFI.qfi_julia_calculation(sv_custom=ccc[0], sv_list=ccc[2])
        QFI.qfi_quantum_circuit(quantum_circuit=ccc[1])
        QFI.qfi_animations()
        QFI.qfi_images()

        # Console logging output:
        complex_numb = round(ccc[0].real, 2) + round(ccc[0].imag, 2) * 1j
        complex_amp1 = round(ccc[2][0].real, 2) + round(ccc[2][0].imag, 2) * 1j
        complex_amp2 = round(ccc[2][1].real, 2) + round(ccc[2][1].imag, 2) * 1j
        print(f"Loop i = {i:>2} | One complex no: ({complex_numb:>11.2f}) | "
              f"Complex amplitude one: ({complex_amp1:>11.2f}) and two: ({complex_amp2:>11.2f}) | "
              f"QuantumCircuit: {round(timer['QuantumCircuit'], 4):>6.4f} | "
              f"Julia_calc: {round(timer['Julia_calculations'], 4):>6.4f} | "
              f"Anim: {round(timer['Animation'], 4):>6.4f} | Img: {round(timer['Image'], 4):>6.4f} | "
              f"Bloch: {round(timer['Bloch_data'], 4):>6.4f} |")
        acc_timer = {key: acc_timer[key] + val for key, val in timer.items()}
    except (NoSuchWindowException, WebDriverException):
        print("Error, Browser window closed during generation of images")
        raise traceback.format_exc()

# Print the accumulated time
print("Accumulated time:", ", ".join([f"{key}: {value:.3f} seconds" for key, value in acc_timer.items()]))

# Quit the currently running driver and prepare for the animation
driver.quit()

print("\nStarting - Saving the current animation state in GIF")
anim = QFI.gif_cam.animate(blit=True, interval=GIF_ms_intervals)
anim.save(f'{temp_image_folder}/1qubit_simulator_4animations_H_{number_of_frames}.gif', writer='pillow')
gif_url = f"{browser_file_path}/1qubit_simulator_4animations_H_{number_of_frames}.gif"
print("Finished - Saving the current animation state in GIF")

# Define a fresh instance of the ChromeDriver to retrieve the image
driver = WebClient(default_image_url).get_driver()  # ChromeDriver
driver.get(gif_url)

# check if the browser window is closed
while True:
    try:
        driver.find_element(By.TAG_NAME, 'body')
    except (NoSuchWindowException, WebDriverException):
        print("Error, Browser window closed, quitting the program")
        driver.quit()
        sys.exit()
