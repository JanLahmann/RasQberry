# RasQberry Test Report

The tests documented below were conducted under the following conditions:

Hardware used
- Raspberry Pi 4
- SanDisk Extreme Pro 64GB microSDXC UHS-I V30 card

Software used
- Raspberry Pi OS (Legacy 32 bit) with desktop
- Raspberry Pi Imager 1.8.5

Settings
- Username: pi 

## Step 1: Preparing the Raspberry Pi 

1. Download and Install Raspberry Pi Imager from the (official website)[https://www.raspberrypi.com/software/] and use that to write the Raspberry Pi OS (Legacy 32 bit) on an (empty) SD-Card. As seen in the images below, you can select the OS straight from the imager itself. 

<p align="center"> 
<img src="../Artwork/imager-02.png" alt="drawing" width="500"/> <img src="../Artwork/imager-03.png" alt="drawing" width="500"/> <img src="../Artwork/imager-04.png" alt="drawing" width="500"/> <img src="../Artwork/imager-05.png" alt="drawing" width="500"/> <img src="../Artwork/imager-06.png" alt="drawing" width="500"/> <img src="../Artwork/imager-07.png" alt="drawing" width="500"/> <img src="../Artwork/imager-08.png" alt="drawing" width="500"/> <img src="../Artwork/imager-09.png" alt="drawing" width="500"/> <img src="../Artwork/imager-10.png" alt="drawing" width="500"/> <br/>
</p>

**(Option A: Settings Using Imager)** Using the Raspberry Pi Imager, you can choose to customize the wifi settings, username and password and enable ssh as shown below. 

__<a style="color: red"> NOTE__: You have to use the standard username `pi`. Otherwise, many functionalities will not work. </a>

<br/>

<p align="center"> 
<img src="../Artwork/imager-11.png" alt="drawing" width="500"/> <img src="../Artwork/imager-12.png" alt="drawing" width="500"/> <img src="../Artwork/imager-13.png" alt="drawing" width="500"/> <br/>
</p>

Once the OS and settings have been saved to the SD card, you can now boot your Raspberry Pi and connect it. 

There are several ways to find out which IP your Raspberry Pi received. For this particular test, a display was used to connect to the Raspberry Pi to enable the wireless interface and identify the IP address issued. 

**(Option B: Settings using Display)**  Ideally, with the aforementioned settings, your Pi should connect to WiFi once booted but if that is not the case, the following command can be used to perform initial setup of the Pi. To access terminal when using a display, navigate to the application menu, under *Accessories > Terminal.

```python
sudo raspi-config
```

This command brings up menu options to choose from. 

1. Select `1 – System Options` 
2. Select `S1 – Wireless LAN` 
3. Fill in your WLAN network name under `Please enter SSID` 
4. Fill in your WLAN Password under `Please enter passphrase` 

<p align="center"> 
<img src="../Artwork/raspi-config_02.png" alt="drawing" width="500"/> <img src="../Artwork/raspi-config_03.png" alt="drawing" width="500"/> <img src="../Artwork/raspi-config_04.png" alt="drawing" width="500"/> <img src="../Artwork/raspi-config_05.png" alt="drawing" width="500"/> <br/>
</p>

Apply the settings and select `Finish`. To view the IP address of your device, go back to the terminal and type `ifconfig` can be used. 

```python
ifconfig 
```

## Step 2: Enable SSH (optional) 

There are a couple of ways you can use to enable SSH for remote administration. 

**Option A: Headless (with Imager)** 

As we saw in `option A of step 1` above, when you write the Raspberry Pi OS on your SD-Card you can enable SSH during the writing process. You can access the extended menu by entering **shift + command + X** (windows: **shift + control + X**)<br/>

<br/>
<p align="center"> 
<img src="../Artwork/imager-13.png" alt="drawing" width="500"/> <br/>
</p>
<br/>

From this interface, you can enable SSH and enter your password or public-key to make the authenticating process while connecting easier.

**Option B: With Display** 

When using a display, to access the terminal on your Raspberry Pi,  navigate to the application menu, under *Accessories > Terminal*.

```python
sudo raspi-config
```
1. Select `3 – Interface options`  
2. Select `I2 – SSH`
3. Click `Yes`

<br/>
<p align="center"> 
<img src="../Artwork/ssh_01.png" alt="drawing" width="500"/> <img src="../Artwork/ssh_04.png" alt="drawing" width="500"/> <img src="../Artwork/ssh_03.png" alt="drawing" width="500"/> <img src="../Artwork/ssh_02.png" alt="drawing" width="500"/><br/>
</p>
<br/>

**Option C: Headless (add file)** 

After you wrote the Raspbian Image on your SD-Card you need to add a file named “*ssh*” in your boot partition (boot register) of your SD-Card, which you can access on your personal computer.
When you added the file, you can now boot your Raspberry Pi.

__<a style="color: red"> NOTE__: Added this option simply for completeness. This particular option was not tested for this particular report </a>

<br/>