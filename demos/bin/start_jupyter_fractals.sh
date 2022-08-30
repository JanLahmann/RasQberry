#!/bin/bash

if [ ! -d Visualizing-Quantum-Computing-using-fractals ]; then
   git clone -b raspberry https://github.com/Petzys/Visualizing-Quantum-Computing-using-fractals.git;
   echo "Cloned Fractal Repository"
fi

############### DIDNT WORK ###############
#pip install pipenv
#pipenv install --skip-lock appmode
#pipenv install jupyter

# install jupyter appmode
#pipenv run jupyter nbextension enable --py --sys-prefix appmode
#pipenv run jupyter serverextension enable --py --sys-prefix appmode
############### DIDNT WORK ###############

# start jupyter notebook
sudo -u pi -i jupyter notebook Visualizing-Quantum-Computing-using-fractals --port 8890 --ip=127.0.0.1
jupyter notebook stop 8890