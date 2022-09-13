# RasQberry Demos
In this repository you can find different demos which also work with different hardware components.<br/>

You can access the different demos with the main menu from the Raspberry under the categories `Demos` and `HD Demos`. When you use your RasQberry with a display you can access the demos with the Kivy Interface as well.<br> 
You can start the Kivy Interface by clicking the desktop-icon on your Desktop.

## Demos using a (touch) display
### Bloch Sphere <br/>
In quantum mechanics and computing, the Bloch sphere is a geometrical representation of the pure state space of a two-level quantum mechanical system (qubit), named after the physicist Felix Bloch.<br/>
In this demo you can investigate how the Bloch Sphere behaves under curtain changes.<br/>

* **Start**<br/>
After your RasQberry Configuration is done the Bloch Sphere Demo should be autostarted whenever you boot your RasQberry.<br/>
If it is not installed, install, start and stop this demo by opening the Rasqberry Configuration Tool, selecting `D - Quantum Demos` and then `D1 - Bloch-Sphere`. <br/>
You can also start it manually by clicking on the desktop icon *BlochSphereDemo*.<br/>
Enter fullscreen-mode by clicking on the icon on the right.<br/>

<p align="center"> 
    <img src="../Artwork/Bloch_Sphere_Demo.png" alt="drawing" width="400"/> 
</p>

* **Usage**<br/>
You can click on the Bloch Sphere and use the buttons on the left and right side to change equation on the top.<br/>
You can turn the bloch sphere itself and view it from different angle.

* **Stop**<br/>
You can exit fullscreen-mode by clicking the icon in the top right again.
Now you can exit the demo by closing the window.

The Bloch Sphere demo is based on https://github.com/JavaFXpert/grok-bloch by James Weaver.<br/>
You can use this demo offline.

### Quantum Composer<br/>
The IBM Quantum Composer allows public and premium access to cloud-based quantum computing services provided by IBM Quantum. This includes access to a set of IBM's prototype quantum processors, a set of tutorials on quantum computation, and access to an interactive textbook.<br/>
You can use the quantum composer only while connected to a network.

* **Start**<br/>
You can start the IBM Quantum Composer by clicking on the desktop icon *IBM Quantum Composer*.<br/>
The Quantum Composer will be started in fullscreen-mode.

<p align="center"> 
    <img src="../Artwork/Quantum_Composer.png" alt="drawing" width="400"/> 
</p>

* **Usage**<br/>
You can customize the view of the quantum composer to be clearly arranged by selecting the windows you want to use in the *View*-tab in the window.

* **Stop**<br/>
You can exit fullscreen-mode by tipping with your pen on or by moving your mouse to the very top of the screen and then clicking on the appearing *x*.<br/>
Now you can exit the quantum composer by closing the window.

### Lights<br/>
You can connect LED Lights to your Raspberry Pi. This demo starts a program which lets the LED Lights shine in different colors and pattern.

<p align="center"> 
    <img src="../Artwork/LED_purple.png" alt="drawing" width="300"/> <img src="../Artwork/LED_rainbow.png" alt="drawing" width="300"/> <br/>
    <img src="../Artwork/LED_green.png" alt="drawing" width="300"/> <img src="../Artwork/LED_4red.png" alt="drawing" width="300"/> <br/>
     <img src="../Artwork/LED_4blue.png" alt="drawing" width="300"/> <br/>
</p>

* **Start and Stop**<br/>
You can toggle your LEDs by clicking on the desktop icon *lights*.

### RasQ-LED<br/>
When you have an LED Ring Light connected to your Raspberry Pi you can use RasQ-LED.<br/>
This demo will randomly calculate which one of the single LEDs will be `0` and which will be `1`. Zeros will be red and ones will be blue.

* **Start**<br/>
To start the RasQ-LED Demo you need to click on the desktop icon *RasQ-LED*.

<p align="center">  
    <img src="../Artwork/RasQ_LED-1.png" alt="drawing" width="300"/> <img src="../Artwork/RasQ_LED-2.png" alt="drawing" width="300"/> <br/>
    <img src="../Artwork/RasQ_LED-3.png" alt="drawing" width="300"/> 
</p>

* **Stop**<br/>
You can stop the RasQ-LED demo by closing the window and then clicking on the *Turn LEDs off*-desktop icon. This will turn all LED lights, that are still turn on, off.s

## Demos using a SenseHAT

### Raspberry-Tie<br/>
This demos comes in two alternatives. *Rasqberry-Tie 5* simulates 5 Qbits and *Rasqberry-Tie 16* simulates 16 Qbits.<br/>
The Raspberry-Tie demos are based on https://github.com/KPRoche/quantum-raspberry-tie by Kevin Roche. <br/>
* **Start**<br/>
You can install both demo versions by opening the Rasqberr Configuration Tool, selecting `D - Quantum Demos` and then `D2 - Rasqberry-Tie 5`. <br/>
To start the 16 Qbit version you need to execute `D3 - Rasqberry-Tie 16`.<br>

<p align="center"> 
<img src="../Artwork/Tie5-1.png" alt="drawing" width="250"/><img src="../Artwork/Tie5-3.png" alt="drawing" width="250"/><br/>
<img src="../Artwork/Tie5-2.png" alt="drawing" width="250"/><img src="../Artwork/Tie16.png" alt="drawing" width="250"/><br/>
</p>

* **Stop**<br/>
To stop the demo you need to select the same menu option (`D2`or `D3`) as before by starting this demo.

### Qrasp<br/>
The Qrasp demo is based on https://github.com/ordmoj/qrasp by Hassi Norlen.<br/>
* **Start**<br/>
If not installed, you can install, start and stop this demo by opening the Rasqberry Configuration Tool, selecting `D - Quantum Demos` and then `D4 - Qrasp`.<br/>
<br/>
<p align="center"> 
<img src="../Artwork/Qrasp-1.png" alt="drawing" width="250"/><img src="../Artwork/Qrasp-3.png" alt="drawing" width="250"/><br/>
<img src="../Artwork/Qrasp-2.png" alt="drawing" width="250"/><img src="../Artwork/Qrasp-4.png" alt="drawing" width="250"/>
</p>
<br/>

* **Usage**<br/>
You can control the demo with the little joystick on th senseHAT.<br/>
By pushing the joystick to the top you select the `GHZ`-option.<br/>
By pushing the joystick to the bottom you select the `Bell`-option.<br/>
By pushing the joystick to the right you select the `2Q`-option.<br/>
By pushing the joystick to the left you select the `3Q`-option.<br/>

* **Stop**<br/>
To stop the Qrasp demo by selecting `D4` again.

## Visualizing Quantum Computing using fractals
By choosing `D - Quantum Demos` and `FR - Fractals` you can start a demo which visualizes quantum computing using fractals.
The demo opens a new browser window and generates a fractal in real time. After the fractal is generated the animation will be saved as a GIF which will be displayed afterwards.

The GIF can be found in the folder `/RasQberry/demos/bin/fractal_files/`.<br/>
By closing the browser window the generation will be interrupted and the current state of the animation will be saved as a GIF which also will be shown afterwards. 

The old fractal will be overwritten by the new one.

See more information [here](https://github.com/wmazin/Visualizing-Quantum-Computing-using-fractals).

## Continuative demos<br/>
### Qiskit-Demos<br/>
By cloning the git-repository with the qiskit-demos you have access to new jupyter notebooks that you can run and investigate.<br/>

### Jupyter Notebooks<br/>
In your Jupyter Notebook you can investigate demos (e.g. the qiskit tutorials and demos) or can run your own code.<br/>
By executing `D1 - Config & Demos` (under `S - RasQerry Setup`) in the Rasqberry Configuration Tool you have access to more demos that you can run in jupyter notebooks on your Raspberry Pi. You need to provide your API Token and the jupyter notebook will be configurated.
<br/>

* **Start**<br/>
To start the Jupyter Notebook you need to open the Rasqberry Configuration Tool. You can start it automatically with the Qiskit demos or with the Fun-with-Quantum Demos. <br/>
You need to select `H - HD Demos` and then the option you want.<br/>
The Jupyter Notebook boots in the background, and you can access it over your browser, or it will open on your RasQberry.<br/> 
<br/>
If you want to start the jupyter notebook with the cloned Fun-with-Quantum or Qiskit-Tutorials Repository you can open the Rasqberry-Configuration Tool and select `H - HD Demos` and then choose the demo you want to access.<br/>
<br/>
When you are on your Raspberry you can access the Jupyter Notebook by opening http://raspberrypi:8888/ in your browser. When you want to access the Jupyter Notebook on your Laptop you can open it by typing http://{ip address}:{port}. The Default port is *8888*. You can find the corresponding port number in the messagebox.
</br>
<h7 style="color:red"> Password: **RasQberry**. </h7> <br/>
You can now use the Jupyter notebook.

[Go back to: Content](./README.md) <br/>
[Go back to: Start Page](../README.md) 
