# RasQberry Test Report

The tests documented below were conducted under the following conditions:

Hardware used
- Raspberry Pi 4
- SanDisk Extreme Pro 64GB microSDXC UHS-I V30 card

Software used
- Raspberry Pi OS (Legacy 32 bit) with desktop
- Raspberry Pi Imager 1.8.5

```
pi@raspberrypi:~ $ lsb_release -a
No LSB modules are available.
Distributor ID:	Raspbian
Description:	Raspbian GNU/Linux 11 (bullseye)
Release:	11
Codename:	bullseye
pi@raspberrypi:~ $ uname -a
Linux raspberrypi 6.1.21-v8+ #1642 SMP PREEMPT Mon Apr  3 17:24:16 BST 2023 aarch64 GNU/Linux
```

Settings
- Default Username `pi` is used
- RasQberry is installed in the home directory of the default user `pi`

## Step 1: Preparing the Raspberry Pi 

1. Download and install Raspberry Pi Imager from the (official website)[https://www.raspberrypi.com/software/] and use that to write the Raspberry Pi OS (Legacy 32 bit) on an (empty) SD-Card. As seen in the images below, you can select the OS straight from the imager itself. 

<p align="center"> 
<img src="../Artwork/imager-02.png" alt="drawing" width="350"/> <img src="../Artwork/imager-03.png" alt="drawing" width="350"/> <img src="../Artwork/imager-04.png" alt="drawing" width="350"/> <img src="../Artwork/imager-05.png" alt="drawing" width="350"/> <img src="../Artwork/imager-06.png" alt="drawing" width="350"/> <img src="../Artwork/imager-07.png" alt="drawing" width="350"/> <img src="../Artwork/imager-08.png" alt="drawing" width="350"/> <img src="../Artwork/imager-09.png" alt="drawing" width="350"/> <img src="../Artwork/imager-10.png" alt="drawing" width="350"/> <br/>
</p>

**(Option A: Settings Using Imager)** Using the Raspberry Pi Imager, we can choose to customize the wifi settings, username and password and enable ssh as shown below. 

__<a style="color: red"> NOTE__: You must use the standard username `pi`. Otherwise, many functionalities will not work. </a>

<br/>

<p align="center"> 
<img src="../Artwork/imager-11.png" alt="drawing" width="350"/> <img src="../Artwork/imager-12.png" alt="drawing" width="350"/> <img src="../Artwork/imager-13.png" alt="drawing" width="350"/> <br/>
</p>

Once the OS and settings have been saved to the SD card, you can now boot your Raspberry Pi and connect it. 

There are several ways to find out which IP your Raspberry Pi received. For this particular test, a display was used to connect to the Raspberry Pi to enable the wireless interface and identify the IP address issued. 

**(Option B: Settings using Display)**  Ideally, with the aforementioned settings, your Pi should connect to WiFi once booted but if that is not the case, the following command can be used to perform initial setup of the Pi. To access terminal when using a display, navigate to the application menu, under *Accessories > Terminal.

```
sudo raspi-config
```

This command brings up menu options to choose from. 

1. Select `1 – System Options` 
2. Select `S1 – Wireless LAN` 
3. Fill in your WLAN network name under `Please enter SSID` 
4. Fill in your WLAN Password under `Please enter passphrase` 

<p align="center"> 
<img src="../Artwork/raspi-config_02.png" alt="drawing" width="350"/> <img src="../Artwork/raspi-config_03.png" alt="drawing" width="350"/> <img src="../Artwork/raspi-config_04.png" alt="drawing" width="350"/> <img src="../Artwork/raspi-config_05.png" alt="drawing" width="350"/> <br/>
</p>

Apply the settings and select `Finish`. To view the IP address of your device, go back to the terminal and type `ifconfig` can be used. 

```
ifconfig 
```

## Step 2: Enable SSH (optional) 

There are a couple of ways you can use to enable SSH for remote administration. 

**Option A: Headless (with Imager)** 

As we saw in `option A of step 1` above, when you write the Raspberry Pi OS on your SD-Card you can enable SSH during the writing process. You can access the extended menu by entering **shift + command + X** (windows: **shift + control + X**)<br/>

<br/>
<p align="center"> 
<img src="../Artwork/imager-13.png" alt="drawing" width="350"/> <br/>
</p>
<br/>

From this interface, you can enable SSH and enter your password or public-key to make the authenticating process while connecting easier.

**Option B: With Display** 

When using a display, to access the terminal on your Raspberry Pi,  navigate to the application menu, under *Accessories > Terminal*.

```
sudo raspi-config
```
1. Select `3 – Interface options`  
2. Select `I2 – SSH`
3. Click `Yes`

<br/>
<p align="center"> 
<img src="../Artwork/ssh_01.png" alt="drawing" width="350"/> <img src="../Artwork/ssh_04.png" alt="drawing" width="350"/> <img src="../Artwork/ssh_03.png" alt="drawing" width="350"/> <img src="../Artwork/ssh_02.png" alt="drawing" width="350"/><br/>
</p>
<br/>

**Option C: Headless (add file)** 

After writing the Raspberry Pi Image on your SD-Card you'll need to add a file named “*ssh*” in your boot partition (boot register) of your SD-Card, which you can access on your personal computer.
When you added the file, you can now boot your Raspberry Pi.

__<a style="color: red"> NOTE__: Added this option simply for completeness. This particular option was not tested for this report </a>

<br/>

Let's now get the IP address from the Raspberry Pi so that we can connect. You can find the address in your Router’s DHCP lease allocation table or if you use a display, you can get your IP address by typing ifconfig in your terminal.

```
ifconfig
```

With the IP address, we are now ready to connect remotely to the Raspberry Pi. Open a terminal on your remote device and `ssh` to the IP address using the username `pi` 

```
ssh pi@/{your IP address}
```

Example:

```
ssh pi@192.168.1.1
```

You are presented with a dialogue. You need to agree that you want to connect your devices and enter your Raspberry Pi password. By default, the password is `raspberry`. Now you should be able to use SSH moving forward.

<br/>

## Step 3: Installing RasQberry

**Prerequisites**

Before starting this section, the following needs to be true 

- [X] Installed Raspberry Pi OS Bullseye (Legacy 32 bit) with desktop
- [X] Made sure that you are using the default username `pi` 

Let's now navigate to the home directory of the user `pi`. __<a style="color: red"> NOTE__: Not doing this will result in an error while installing and using the RasQberry. </a>

<br/>

You can do that simply by typring `cd` then the user's path. 

```
cd /home/pi/
```

You can check which location you are currently in by running the `pwd` command. Output should be as shown below.

```
$ pwd 
/home/pi
```
 
Now we are finally ready to install RasQberry!

**Downloading the RasQberry OS**

To download the file from GitHub, we'll use the `getgist` (python command)[https://pypi.org/project/getgist/]

```
pip3 install getgist
```

That command installed the following version of getgist as of date of testing. 

```
$ pip3 list | grep -i getgist
getgist           0.2.2
```

You can download the installation script `RasQ-init.sh` from the source `JanLahmann` using the `getgist <username> <filename>` command 

```
.local/bin/getgist -y JanLahmann RasQ-init.sh
```

The command above downloads the script into the user's `pi` home directory as seen below. 

```
pi@raspberrypi:~ $ pwd
/home/pi
pi@raspberrypi:~ $ ls -l | grep RasQ-init.sh 
-rw-r--r-- 1 pi pi 3483 Aug 18 14:42 RasQ-init.sh
```

To start the installation, we need to run the script. The script can be run with specific parameters `. ./RasQ-init.sh <devoption> <branch> <gituser>` where:

1. The `devoption` parameter specifies which development version of the RasQberry repository to install. Specify `devoption=1` for development branch or `devoption=0` to download from production. 
2. The `branch` parameter is used to specify the branch you want to use. Example `branch=master` will download from the master branch. 
3. The `gituser` parameter is used to specify the GitHub user to clone the RasQberry repository from. Example `gituser=JanLahmann` will download from `JanLahmann`'s repository. 
 
If you choose to run the script without parameters, then the following default parameters will be used `devoption=0`, `branch=master` and  `gituser=JanLahmann`. 

For the test, we'll be downloading from the master branch, we want the production version in `JanLahmann`'s repository. We can run it with options like this `. ./RasQ-init.sh 0 master JanLahmann` but since that matches the default parameters, let's simply run the script. 

```
. ./RasQ-init.sh
```

This command downloads and starts the RasQberry Configuration Tool (rasqberry-config) in your terminal. It is similar to the well-known raspi-config and can also be used for some basic configurations. 

Once the script finishes, the SSH connection is closed for the following reason. 

```
**********************************************************************
/boot/config.txt will be modified to ensure 32 bit kernel being used
rebooting after modification of /boot/config.txt
After reboot, please login and restart the script RasQ-init.sh
**********************************************************************
```

We can now SSH back into the host and restart the script to start setting up. 

## Step 4: RasQberry Setup with touch display

Let's SSH back into the Raspberry Pi restart the `RasQ-init.sh` script again. 

```
. ./RasQ-init.sh 
```

This starts the RasQberry Configuration Tool (rasqberry-config) in the terminal. The tool is similar to the well-known `raspi-config` and can also be used for some basic configurations. We are presented with the below menu. 

<br/>
<p align="center"> 
<img src="../Artwork/rasqberry_config-0.png" alt="drawing" width="350"/> <br/>
</p>
<br/>

## Step 4a: One-Click Install with touch display

From the RasQberry Configuration Tool (rasqberry-config):

1. Select `OI – One-Click Install`. This will run options SU, IC, IR, DV, CD, D and BL in one go. 
