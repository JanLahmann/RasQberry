#!/bin/bash
#
cd ~/
[ -d Tools ] || mkdir Tools
cd Tools
[ -d LCD-show ] && ( cd LCD-show/ && sudo ./rotate.sh 180 ) || ( git clone https://github.com/goodtft/LCD-show && cd LCD-show/ && sudo ./MPI4008-show )
