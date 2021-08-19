#!/bin/bash
#
# start jupyter notebooks
# on port 8888 and port 8889
#

sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_clone_qiskit_tutorial.sh -port 8888 --no-browser &
sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_clone_FwQ.sh -port 8889 --no-browser &