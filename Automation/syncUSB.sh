#!/bin/sh

###################################################################
#Script Name    :syncUSB.sh
#Description    :Rsync between two folders when USB mounted
#Created        :22 November 2018
#Args           :
#Author         :Michal Czarnecki
#Email          :mczarnecki@gmail.com
#GitHub         :http://www.github.com/michalcza
###################################################################
#To Do          :Execute on mount
###################################################################
#
# Set exit code to assume bad exit
exitcode=1
# Declare variables
USB="/Volumes/ESD-USB"
devices="diskutil list | grep -i external"
local="~/Desktop/USBSync"
sync="rsync -avun --inplace --progress --exclude='.Trashes' --exclude='.Spotlight-V100' --exclude'.fseventsd'"
# Test if local and remote folders/devices exist.
if test -e $mount && test -e $local_folder ;
    then
    exitcode=0
    # Rsync USB>LOCAL and if success, Rsync LOCAL>USB
    $sync $local $USB && $sync $USB $local
    echo "Rsync between $mount and $local_folder has completed. Some hidden Mac OS index,trash, and notification files were excluded."
    echo "Exiting with exit code: $exitcode"
fi
# Exit if things didn't work out.
exit $exitcode
echo "$USB not found."
echo "Looking for: $USB"
echo "Found $devices"
echo "Exiting with exit code: $exitcode"
