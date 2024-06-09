#!/bin/bash
#
# usage (in RPi terminal):
# pip3 install getgist
# .local/bin/getgist -y JanLahmann RasQ-init.sh
# . ./RasQ-init.sh
# also use the previous command to start the rasqberry-config tool again,
# or   sudo rasqberry-config
#
echo; echo;
echo "This script (RasQ-init.sh) downloads the rasqberry-config tool"
echo "rasqberry-config can be used to install and configure Qiskit and"
echo "several Quantum Computing Demos on the Raspberry Pi"
echo "This script is available at http://ibm.biz/RasQ-init"
echo;
echo "Before running this script, pls setup the SD card using the" 
echo "Raspberry Pi Imager (with 'Raspberry Pi OS 32-bit with Desktop')," 
echo "then login to the RPi via ssh and run the following commands:"
echo;
echo "pip3 install getgist"
echo ".local/bin/getgist JanLahmann RasQ-init.sh"
echo ". ./RasQ-init.sh"
echo "Also use the previous command to start the rasqberry-config tool again and pull github changes,"
echo "or   sudo rasqberry-config"
echo;
echo "The script be run with parameters . ./RasQ-init.sh branch gituser devoption"
echo "The -branch parameter is used to specify the branch you want to use"
echo "The -gituser parameter is used to specify the github user to use for the rasqberry repository"
echo "The -devoption parameter is used to install the development version of the rasqberry repository (production=0, dev=1)"
echo "default values are: branch=master gituser=JanLahmann devoption=0"
echo "example: . ./RasQ-init.sh master JanLahmann 1"
echo;
echo "See http://ibm.biz/Qiskit-Raspberry-Medium for an in-depth description" 
echo "of RasQberry, which combines Raspberry Pi and Qiskit,"
echo "IBM's open source Quantum Computing software framework."
echo;

# to use a differnt branch run e.g.   . ./RasQ-init.sh JRL-dev5
BRANCH=${1:-master}
GITUSER=${2:-JanLahmann}
DEVOPTION=${3:-0}
echo "using Branch " $BRANCH "and from github-user " $GITUSER "with DevOption " $DEVOPTION

# to reset local changes run.  cd ~/RasQberry; git reset --hard HEAD

cd ~/

if [ $DEVOPTION -eq 1 ]; then
    echo "using development mode"
    [ -d RasQberry ] && (cd RasQberry; git config pull.rebase false; git fetch --unshallow; git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"; git fetch origin; git pull origin $BRANCH)|| git clone --branch $BRANCH https://github.com/$GITUSER/RasQberry
else
    echo "using production mode"
    [ -d RasQberry ] && (cd RasQberry; git config pull.rebase false; git pull origin $BRANCH) || git clone --depth 1 --branch $BRANCH https://github.com/$GITUSER/RasQberry
fi

[ -f RasQberry/rasqberry-config ] && sudo cp -f RasQberry/rasqberry-config /usr/local/bin/

[ ! -d ~/.local/bin ] && mkdir ~/.local/bin
[ -d RasQberry/bin ] && cp -r RasQberry/bin/* ~/.local/bin

#[ ! -d ~/Desktop ] && mkdir ~/Desktop
#[ -d RasQberry/desktop-icons ] && cp RasQberry/desktop-icons/*.desktop ~/Desktop

# force 32 bit kernel  being used on Bullseye OS. Stay with 64-bit on Bookworm and later OS.

if grep -q -E "bullseye" /etc/os-release ; then  
  if ! grep -q -E "^arm_64bit=0" /boot/config.txt; then
    echo; echo;
    echo "**********************************************************************"
    echo "bookworm OS detected. Forcing 32-bit mode."
    echo "/boot/config.txt will be modified to ensure 32 bit kernel being used"
    sudo -H -- sh -c 'echo "\n# ensure 32 bit kernel being used\narm_64bit=0\n" >> /boot/config.txt'
    echo "rebooting after modification of /boot/config.txt"
    echo "After reboot, please login and restart the script RasQ-init.sh"
    echo "**********************************************************************"
    echo;
    sudo reboot
  fi
fi
sudo rasqberry-config