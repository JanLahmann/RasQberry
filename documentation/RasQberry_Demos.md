# RasQberry Demos
In this repository you can find diferent demos which also work with diferent hardware components.<br/>

## Demos using a (touch) display
* **Bloch Sphere** <br/>
In quantum mechanics and computing, the Bloch sphere is a geometrical representation of the pure state space of a two-level quantum mechanical system (qubit), named after the physicist Felix Bloch.<br/>
In this demo you can investigate how the Bloch Sphere behaves under curtain changes.<br/>

<p align="center"> 
    <img src="../Artwork/Bloch_Sphere_Demo.png" alt="drawing" width="400"/> 
</p>

The Bloch Sphere demo is based on https://github.com/JavaFXpert/grok-bloch by James Weaver.<br/>
You can install, start and stop this demo by opening the Rasqberry Configuration Tool, selecting `D - Quantum Demos` and then `D1 - Bloch-Sphere`. <br/>
You can use this demo offline.

* **Quantum Composer**<br/>
The IBM Quantum Composer allows public and premium access to cloud-based quantum computing services provided by IBM Quantum. This includes access to a set of IBM's prototype quantum processors, a set of tutorials on quantum computation, and access to an interactive textbook.<br/>
You can use the quantum composer only while connected to a network.

<p align="center"> 
    <img src="../Artwork/Quantum_Composer.png" alt="drawing" width="400"/> 
</p>

* **Lights**<br/>
You can connect LED Lightts to your Raspberry Pi. This demo starts a programm which lets the LED Lights shine in different colors and pattern.

<p align="center"> 
    <img src="../Artwork/LED_purple.png" alt="drawing" width="300"/> <img src="../Artwork/LED_rainbow.png" alt="drawing" width="300"/> <br/>
    <img src="../Artwork/LED_green.png" alt="drawing" width="300"/> <img src="../Artwork/LED_4red.png" alt="drawing" width="300"/> <br/>
     <img src="../Artwork/LED_4blue.png" alt="drawing" width="300"/> <br/>
</p>

* **RasQ-LED**<br/>
When you have an LED Ring Light connected to your Raspberry Pi you can use RasQ-LED.<br/>
This demo will randomly calculate which one of the single LEDs will be 0 and which will be 1. Zeros will be red and ones will be blue.

<p align="center">  
    <img src="../Artwork/RasQ_LED-1.png" alt="drawing" width="300"/> <img src="../Artwork/RasQ_LED-2.png" alt="drawing" width="300"/> <br/>
    <img src="../Artwork/RasQ_LED-3.png" alt="drawing" width="300"/> <img src="../Artwork/RasQ_LED-4.png" alt="drawing" width="300"/> <br/>
</p>

## Demos using a SenseHAT

* **Raspberry-Tie**<br/>
This demos comes in two alternatives. *Rasqberry-Tie 5* simulates 5 Qbits and *Rasqberry-Tie 16* simulates 16 Qbits.<br/>
The Raspberry-Tie demos are based on https://github.com/KPRoche/quantum-raspberry-tie by Kevin Roche. <br/>
You can install both demo versions by opening the Rasqberr Configuration Tool, selecting `D - Quantum Demos` and then `D2 - Rasqberry-Tie 5`. You can also start and stop the 5 Qbit version by using `D2`. <br/>
To start and top the 16 Qbit version you need to execute `D3 - Rasqberry-Tie 16`.<br>

<p align="center"> 
<img src="../Artwork/Tie5-1.png" alt="drawing" width="250"/><img src="../Artwork/Tie5-3.png" alt="drawing" width="250"/><br/>
<img src="../Artwork/Tie5-2.png" alt="drawing" width="250"/><img src="../Artwork/Tie16.png" alt="drawing" width="250"/><br/>
</p>

* **Qrasp**<br/>
You can install, start and stop this demo by opening the Rasqberry Configuration Tool, selecting `D - Quantum Demos` and then `D4 - Qrasp`.
The Qrasp demo is based on https://github.com/ordmoj/qrasp by Hassi Norlen.<br/>

<p align="center"> 
<img src="../Artwork/Qrasp-1.png" alt="drawing" width="250"/><img src="../Artwork/Qrasp-3.png" alt="drawing" width="250"/><br/>
<img src="../Artwork/Qrasp-2.png" alt="drawing" width="250"/><img src="../Artwork/Qrasp-4.png" alt="drawing" width="250"/>
</p>

## Continuative demos<br/>
* **Qiskit-Demos**<br/>
By cloning the git-repository with the qiskit-demos you have access to new jupyter notebooks that you can run and investigate.

* **Jupyter Notebooks**<br/>
By executing `S6 - Config & Demos` in the Rasqberry Configuration Tool you have acces to more demos that you can run in jupyter notebooks on your Raspberry Pi.