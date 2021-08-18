#!/bin/sh

. /etc/profile

eval $(dbus-launch --sh-syntax)
startplasma-x11
