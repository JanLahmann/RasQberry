#!/bin/bash
#
echo; echo; echo "configure jupyter notebooks"
source ~/rasqberry/bin/activate
pip install --prefer-binary jupyter
jupyter notebook --generate-config
JUPYTER_PW=`(echo "from notebook.auth import passwd"; echo "print(passwd('RasQberry'))") | python`; echo $JUPYTER_PW
sed -i "s/#c.NotebookApp.password = ''/c.NotebookApp.password = '$JUPYTER_PW'/" ~/.jupyter/jupyter_notebook_config.py
sed -i "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '*'/" ~/.jupyter/jupyter_notebook_config.py
