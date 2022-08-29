#!/bin/bash

git clone -b raspberry https://github.com/Petzys/Visualizing-Quantum-Computing-using-fractals.git

pip install pipenv
pipenv install appmode

# install jupyter appmode
pipenv run jupyter nbextension enable --py --sys-prefix appmode
pipenv run jupyter serverextension enable --py --sys-prefix appmode

# start jupyter notebook with appmode
jupyter notebook Visualizing-Quantum-Computing-using-fractals/quantum-fractals-multiple-complex-numbers/QuantumFractals1qubit_sphere_fractals_animation_images.ipynb --port 8889 --ip=127.0.0.1