#!/bin/bash
#
# start jupyter notebooks
# on port 8888 and port 8889
#

sudo -u pi -i nohup jupyter notebook --no-browser --port=8888 &
sudo -u pi -i nohup jupyter notebook --no-browser --port=8889 &