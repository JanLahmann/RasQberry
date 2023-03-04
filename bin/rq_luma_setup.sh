#!/bin/sh
# setup of luma (https://luma-led-matrix.readthedocs.io/en/latest/install.html)
# to control the 22x20 LED Matrix

# install luma led_matrix package
sudo python3 -m pip install --upgrade luma.led_matrix

# modify display.config file to change pin from GPIO 18 to GPIO 21
sed -i "s/pin = 18/pin = 21/" /usr/local/lib/python3.9/dist-packages/luma/led_matrix/device.py

# clone and install examples
sudo -u pi -H -- sh -c "git clone https://github.com/JanLahmann/luma.examples.git"

cd luma.examples/
pip install -e .

