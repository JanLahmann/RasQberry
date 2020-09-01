#!/bin/bash
#
cd ~/
[ -d RasQberry ] && (cd RasQberry; git pull origin master) || git clone https://github.com/JanLahmann/RasQberry 
pwd
cd
pwd
ls
sleep 10
