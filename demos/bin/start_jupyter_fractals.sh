#!/bin/bash

git clone -b raspberry https://github.com/Petzys/Visualizing-Quantum-Computing-using-fractals.git

#pip install pipenv
#pipenv install --skip-lock appmode
#pipenv install jupyter

# install jupyter appmode
#pipenv run jupyter nbextension enable --py --sys-prefix appmode
#pipenv run jupyter serverextension enable --py --sys-prefix appmode

# start jupyter notebook
nohup jupyter notebook --port 8889 --ip=127.0.0.1 --no-browser &
nohup xdg-open http://127.0.0.1:8889/notebooks/Visualizing-Quantum-Computing-using-fractals/quantum-fractals-multiple-complex-numbers/QuantumFractals1qubit_sphere_fractals_animation_images.ipynb
