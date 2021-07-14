# RasQberry Installation and Setup

If you already have a raspberry pi with the latest version of Raspbian you can start at step 2.

## Step 1: Get your Raspberry Pi ready
With the Raspberry Pi Imager (https://www.raspberrypi.org/software/ ) write the Raspberry Pi OS Raspian on an (empty) SD-Card. You can either choose the Image right from the Raspberry Pi Imager or you can first download Raspian at https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit.

<p align="center"> 
<img src="../Artwork/RPi.png" alt="drawing" width="350"/> <img src="../Artwork/RPi_OS.png" alt="drawing" width="350"/> <br/>
</p>

**(Optional)** Do the default Setup of your Raspberry Pi by using 
```python 
sudo raspi-config
```
 For this you will need an Display or for an headless set up you’ll need to enable SSH.

<br/>

## Step 2: Enable SSH (optional)
You can enable SSH in different ways:  
+ 	**Headless (add file):**  
After you wrote the Raspian Image on your SD-Card you need to add a file named “*ssh*” in your boot partition (boot register) of your SD-Card, which you can access on your personal computer.
When you added the file, you can now boot your Raspberry Pi.

* **Headless (with Imager):** <br/>
When you write the Raspberry Pi OS on your SD-Card you can enable SSH with the writing process. You can access the extend menu when entering **shift + command + X** (windows: **shift + control + X**)<br/>
<br/>
<p align="center">  
<img src="../Artwork/RPi_SSH.png" alt="drawing" width="350"/> <br/>
</p>
<br/>
The you can enable SSH and enter your password or pblic-key to make the authenticating process while connecting easier.

* 	**With Display:**  
Open the terminal on your Raspberry Pi.	You can find the terminal in the applicatin menu, under *Accessories*.
```python
sudo raspi-config
```
&emsp;&emsp;&emsp;Select `3 – Interface options`  
&emsp;&emsp;&emsp;Select `P2 – SSH`

Next, you’ll need to get the IP address from the Raspberry Pi. You can find the address in your Router’s DHCP lease allocation table or if you use a display, you can get your IP address by typing ifconfig in your terminal.

Open a terminal on your remote device and enter 
```python
ssh pi@/{your IP address}
```
You need to agree that you want to connect your devices and enter your Raspberry Pi password (default: raspberry).
Now you should be able to use SSH.

<br/>

## Step 3: Installing RasQberry
Open the terminal/ssh window on your Raspberry Pi.
```python
pip3 install getgist
.local/bin/getgist -y JanLahmann RasQ-init.sh
. ./RasQ-init.sh
```
<p align="center"> 
    <img src="../Artwork/rasqberry_config-1.png" alt="drawing" height="250"/> <img src="../Artwork/rasqberry_config-2.png" alt="drawing" height="250"/> 
</p>

This will download and start the RasQberry Configuration Tool (rasqberry-config) in your terminal. It is similar to the well-known raspi-config and can also be used for some basic configurations. 
To start the tool again you can use 
```pyhton 
. ./RasQ-init.sh 
````
in your terminal/ssh window.

<br/>

## Step 4: RasQberry Setup
You can assemble your Hardware either with an (touch) display or with an senseHAT. It is not possible to use the senseHAT and the touch display on the same Raspberry P, because the senseHAT isn't working with the installation process from the touch display.
### With touch display
In the RasQberry Configuration Tool select `S – RasQberry Setup`. <br/> Follow these steps one by one.
1.	Select `I0 – Initial Config`   
Your Raspberry will process the basic configurations on your device
1.	Select `S1 – Enable VNC` (required if you want to remotely access the screen)  
With this step you will be able to use VNC
After this step is executed, you will have to reboot your device.
(See also: Install VNC Viewer)
1.	Select `S2 – Enable 4’’ Display` (required if using a touchscreen)  
With this step you will be able to use a touchscreen with your Raspberry.
After this step is executed, you will have to reboot your device
1.	Select `S3 – Software Update`   
With this step your device is searching for software updates and will execute them.
After this step is executed, you will have to reboot your device.
1.	Select `Q1 – Install Qiskit`  
With this step you will install Qiskit. You can choose between a few versions of Qiskit to install. The latest version is recommended.
1.	Select `S0 – Bloch Autostart`   
With this step your Raspberry will start the Bloch Sphere Demo automatically whenever you start your device. 
After your first time executing `S0` your Raspberry will reboot automatically. After the reboot you should execute `S0` again. This time there is no automatic reboot, but one is recommended.
1.	Select `S7 – Enable LED Lights` (optional)   
With this step you can enable LED Lights that you connected to your Raspberry Pi.

### With Sense HAT
In the RasQberry Configuration Tool select `S – RasQberry Setup`. <br/> Follow these steps one by one.
1.	Select `I0 – Initial Config`   
Your Raspberry will process the basic configurations on your device
1.	Select `S3 – Software Update`   
With this step your device is searching for software updates and will execute them.
After this step is executed, you will have to reboot your device.
1.	Select `Q1 – Install Qiskit`  
With this step you will install Qiskit. You can choose between a few versions of Qiskit to install. The latest version is recommended.
1.	Select `S6 – Config & Demos` (optional if using touchscreen; required if using Sense HAT)  
With this step you will configurate Qiskit automatically and install the Quantum Demos. Also, this step will configurate jupyter notebook.  
This step will also configurate jupyter notebook and install the any required packages for the jupyter notebook, the Sense HAT and the Sense HAT Emulator.

<br/>

The above installation procedure used pre-compiled wheel files for most of the python packages. These are downloaded automatically from https://www.piwheels.org. For the packages retworkx and qiskit-aer, currently there are no whl files available. Total install with local compile takes 10 minutes on RPi 4.

<br/>

## Update your IBM Quantum Experience API Token
If you want to access IBM Quantum Experience (to use e.g. the senseHAT demos) you need an API Token. 
If you want to update or store your API Token, you need to select `D – Quantum Demos` first and after that `D7 – Update Q Token`.  
In the terminal you can now enter your new API Token.

<br/>

## Cloning the Git-Repository with the Qiskit-tutorials 
By executing the following instructions you clone a repository (https://github.com/Qiskit/qiskit-tutorials) with a collection of jupyter notebooks aimed at teaching people who want to use Qiskit for writing quantum computing programs, and executing them on one of several backends (online quantum processors, online simulators, and local simulators).

If you want to clone the Git Repository to access the with the Qiskit-Tutorials, you need to open the RasQberry Configuration Tool. First select `H - HD Demos` and second `Q1 - Qiskit Tutorials` (Jupyter Notebokk starts automatically) or `Q2 - Qiskit Tutorials - no browser`.<br/>
This will take a moment to clone and as the case may be to open the jupyter notebook.
 
 <br/>


## Disable the Bloch Autostart
You can disable the autostart of the BlochSphere Demo in the RasQberry Configuration Tool. First you need to select `D – Quantum Demos` and then `D8 – Disable Bloch Autostart`.   
The autostart is no disabled.

<br/>

## Changing WIFI Settings
If you got handed an SD-Card where the above described installation already is made and you want to connect the Raspberry with your network you can do this in different ways.<br/>
* **Raspberry Pi Imager**<br/>
When you write the Raspberry Pi OS on your SD-Card you can set your WIFI Settings with the writing process. You can access the extend menu when entering **shift + command + X** (windows: **shift + control + X**)<br/>
<br/>
<p align="center"> 
<img src="../Artwork/RPi_WIFI.png" alt="drawing" width="350"/> <br/>
</p>

<br/>

In this panel you can enter your SSID and your wifi-password and select your Wifi country.<br/>
When your boot your Raspberry Pi it should automatically connect to your wifi of choice. <br/>

<br/>

* **With the Raspberry Configuration Tool**
Open your terminal/ssh window.
```python
Sudo raspi-config
```
&emsp;&emsp;&emsp;Select `1 System Options`.<br/>
&emsp;&emsp;&emsp;When you select `S1 – Wireless LAN` you can enter your SSID and password.<br/>
<br/>

* **With the `wpa_supplicant.conf`-File before first boot** <br/>
Before you first boot your Raspberry Pi you can change the wpa_supplicant.conf-File on your SD-Card. In this File you can set your SSID ans the password.<br/>
Save the changes and exit the file.<br/>
<br/>

* **With the `wpa_supplicant.conf`-File after first boot** <br/>
Open your termins/ssh window.
```python
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```
&emsp;&emsp;&emsp;The file opens in your terminal/ssh window, and you can change the SSID and the password.<br/>
&emsp;&emsp;&emsp;Save the changes and exit the file.<br/>
<br> 

* **With the display and a (virtual) keyboard**<br/>
First click on the WIFI-Icon in the top right corner of the screen and activate the WIFI and select your WIFI of choice.<br/> 
If you don't have keyboard with you, you can use a virtual keyboard that comes with the Raspberry Pi OS. You can find it in the menu under `Accessories`.<br/>
With the virtual keyboard you can enter the wpa-key.

<br/>

## Install VNC Viewer
To remotely access the screen of your Raspberry Pi you need to have a VNC Viewer installed on a different computer. VNC has been tested using the realVNC Viewer (https://www.realvnc.com/de/connect/download/viewer/) 
To connect to your Raspberry Pi you need to open your VNC Viewer.  
In the VNC Viewer you enter the VNC server-address from your Raspberry. After that you will need to enter a username (default: pi) and a password (default: raspberry).  
Your VNC Viewer will now connect to your Raspberry Pi.

<br/>

## Enable/Disable second VNC Display
You can enable a second vnc display with an higher resolution that functions as a side-to-side display to your RasQberry or your first vnc display.<br/>
To enable the second display you need to open the Rasqberry Configuration Tool and select `S - RasQberry Setup` and then `S1a - Enable second VNC`.<br/>
You can now connect to the vnc server with the address: *{ip address}:5902*<br/>

To disable the second display you need to open the Rasqberry Configuration Tool and select `S - RasQberry Setup`and then `S1b - Disable second VNC`.<br>

<br/>

## Connect a LED Ring-Light to your Raspberry Pi
To connect your LED light, you need three cables (GND, VCC & IN).
Put your cables on the Raspberry Pins as follows:
* GND-cable to Pin 6 [GND]
* VCC-cable to Pin 4 [5V]
* IN-cable to Pin 40 [GPIO21]

You can check which Pin on your Raspberry is the right one, when you type 
```python
pinout 
```
in your terminal/ssh window.

<p align="center"> 
<img src="../Artwork/pinout-1.png" alt="drawing" height="350"/> <img src="../Artwork/pinout-2.png" alt="drawing" height="350"/> <br/>
</p>

Open your terminal/ssh window and type 
```python 
sudo python3 .local/bin/rq_LED-test.py -c
```
Your LED Light should now be turned on. To turn it of press ctl + c.

If this method doesn’t work, you can also open the RasQberry Configuration Tool. Select `S – RasQberry Setup`, then `S7 – Enable LED Light` and finally `S8 – Toggle LED Light`.  
Your LED Light should now be turned on. To turn it off again select `S8 – Toggle LED Light` again.
