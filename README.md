# RasQberry
The RasQberry project (under construction): exploring quantum computing and Qiskit with a Raspberry Pi

Quantum Computing - which is based on Quantum Mechanics - is a complex technology that is hard to understand for most people. Completely new algorithms - and even new thinking - is needed to exploit the potential power of upcoming quantum computers. This requires new approaches to teach Quantum Computing in engaging and understandable ways for IT experts, developers and young academics.

In this project, we use Qiskit, a Raspberry Pi (the full range from Pi 4 down to a Pi Zero) and a spectrum of Quantum Computing demos and serious games (that illustrate superposition, interference and entanglement) for an engaging introduction to Quantum Computing.

### Qiskit on Raspberry Pi
A first discription how to install Qiskit on a Raspberry Pi is available at http://ibm.biz/Qiskit-Raspberry-Medium. It also includes a description how to setup some quantum demos (Qrasp, Raspberry-Tie) based on a Sense Hat 8x8 LED display.

A summary of that article has been published at hackster.io: https://www.hackster.io/news/jan-and-robert-lahmann-get-a-quantum-computer-running-on-your-raspberry-pi-in-under-30-minutes-4b972010009d

The medium article includes a "fastpass" at the end, and mentions a procedure that only requires very few commands for the full setup, based on the gists at https://gist.github.com/JanLahmann, starting with RasQ-init.sh. These commands need to be executed in a terminal/ssh window on the Raspberry Pi with Raspberry OS "Buster". It willl download and start a configuration tool "rasqberry-config" that can be used to install Qiskit and several quantum demos. 
```python
pip3 install getgist
.local/bin/getgist -y JanLahmann RasQ-init.sh
. ./RasQ-init.sh
```

Also use the ". ./RasQ-init.sh" command to start the rasqberry-config tool again or "sudo rasqberry-config".

The above installation procedure used pre-compiled wheel files for most of the python packages. These are downloaded automatically from pywheels.org.
For retworkx and qiskit-aer, currently there are no whl files available. Total install with local compile takes 25 minutes on RPi 4, on a Pi Zero about 4.5 hours.
