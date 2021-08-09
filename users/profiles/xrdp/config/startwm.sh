#!/bin/sh

. /etc/profile

eval $(dbus-launch --sh-syntax)
xhost +local:
startplasma-x11
