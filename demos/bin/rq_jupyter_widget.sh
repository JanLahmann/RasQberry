#!/bin/bash
#
# configurations for the ibm_quantum_widgets

echo "Jupyter Notebook Widgets";

pip3 install ipwidgets
jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py --user ibm_quantum_widgets