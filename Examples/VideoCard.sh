#----------------- SCRIPT -----------------#  
#!/bin/bash

#----------------- IDENTIFY VIDEO HARDWARE -----------------#  
lspci | grep VGA

#----------------- CHECK LOADED KERNEL -----------------#  
find /dev -group video

#----------------- CHECK X DRIVER -----------------#  
glxinfo | grep -i vendor

lspci | grep VGA; lsmod | grep "kms\|drm" ; find /dev -group video ; \ cat /proc/cmdline ; find /etc/modprobe.d ; cat /etc/modprobe.d/*kms* ; \ ls /etc/X11/xorg.conf ; glxinfo | grep -i "vendor\|rendering" ; \ grep LoadModule /var/log/Xorg.0.log 