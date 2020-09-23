# RasQberry
The RasQberry project: exploring quantum computing with Qiskit and a Raspberry Pi

Quantum Computing - which is based on Quantum Mechanics - is a complex technology that is hard to understand for most people. Completely new algorithms - and even new thinking - is needed to exploit the potential power of upcoming quantum computers. This requires new approaches to teach Quantum Computing in engaging and understandable ways for IT experts, developers and young academics.

In this project, we use Qiskit, a Raspberry Pi (the full range from Pi 4 down to a Pi Zero) and a spectrum of Quantum Computing demos and serious games (that illustrate superposition, interference and entanglement) for an engaging introduction to Quantum Computing.

### Qiskit on Raspberry Pi
A first discription how to install Qiskit on a Raspberry Pi is available at http://ibm.biz/Qiskit-Raspberry-Medium. It also includes a description how to setup some quantum demos (Qrasp, Raspberry-Tie) based on a Sense Hat 8x8 LED display.

A summary of that article has been published at hackster.io: https://www.hackster.io/news/jan-and-robert-lahmann-get-a-quantum-computer-running-on-your-raspberry-pi-in-under-30-minutes-4b972010009d

### RasQberry installation
The medium article http://ibm.biz/Qiskit-Raspberry-Medium includes a "fastpass" at the end, and mentions a procedure that only requires very few commands for the full setup. The following commands need to be executed in a terminal/ssh window on the Raspberry Pi with Raspberry OS "Buster". It will download and start a configuration tool "rasqberry-config", similar to the well known "raspi-config", that can be used to to some basic configuration, install Qiskit and several quantum demos. 
```python
pip3 install getgist
.local/bin/getgist -y JanLahmann RasQ-init.sh
. ./RasQ-init.sh
```

Also use the ". ./RasQ-init.sh" command to start the rasqberry-config tool again or "sudo rasqberry-config".

"rasqberry-config" offers a simple menu structure. To setup RasQberry, go through the menu items in "S RasQberry Setup" one by one. Some of them require a reboot. Select either Qiskit version 0.19 or version 0.20 to be installed. "S6 Config & Demos" installs and configures some of the quantum demos.
"D Quantum Demos" offers several Quantum demos, e.g. a Bloch Sphere demo (based on https://github.com/JavaFXpert/grok-bloch by James Weaver) that runs on a TFT display attached to the Raspberry, and two demos that run on a SenseHAT display: Raspberry-Tie (https://github.com/KPRoche/quantum-raspberry-tie by Kevin Roche) and Qrasp (https://github.com/ordmoj/qrasp by Hassi Norlen).


The above installation procedure used pre-compiled wheel files for most of the python packages. These are downloaded automatically from https://www.piwheels.org.
For the packages retworkx and qiskit-aer, currently there are no whl files available. Total install with local compile takes 25 minutes on RPi 4, on a Pi Zero about 4.5 hours.

