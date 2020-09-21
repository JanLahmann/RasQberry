#!/bin/sh
if ! grep -q 'Raspberry Pi' /proc/device-tree/model || (grep -q okay /proc/device-tree/soc/v3d@7ec00000/status 2> /dev/null || grep -q okay /proc/device-tree/soc/firmwarekms@7e600000/status 2> /dev/null || grep -q okay /proc/device-tree/v3dbus/v3d@7ec04000/status 2> /dev/null) ; then
#  if xrandr --output HDMI-1 --primary --mode FIXED_MODE --rate 59.78 --pos 0x0 --rotate right --dryrun ; then 
#    xrandr --output HDMI-1 --primary --mode FIXED_MODE --rate 59.78 --pos 0x0 --rotate right
  if xrandr --output HDMI-1 --primary --rate 59.78 --pos 0x0 --rotate right --dryrun ; then 
    xrandr --output HDMI-1 --primary --rate 59.78 --pos 0x0 --rotate right
  fi
fi
if [ -e /usr/share/tssetup.sh ] ; then
  . /usr/share/tssetup.sh
fi
