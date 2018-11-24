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
#Status         :Development
###################################################################
#
# Set exit code to assume bad exit
exitcode=1
# Declare variables
USB="/Volumes/ESD-USB"
devices="diskutil list | grep -i external"
local="/Desktop/USBSync"
sync="rsync -a --inplace"
location="$HOME${local}"
exclude1=".Spotlight-V100"
exclude2=".Trashes"
exclude3=".fseventsd"
# Test if local and remote folders/devices exist.
if  test -e $USB && test -e $location
then
    echo "Tested for $location, found it."
    echo "Tested for $USB, found it."
    echo "Continuing with code 0"
# Rsync USB>LOCAL and if success, Rsync LOCAL>USB
    $sync $location $USB && $sync $USB $location && echo "Rsync between $USB and $location has completed."
    exitcode=0

else
    echo "Tested for $location, didn't find it."
    echo "Tested for $USB, didn't find it"
    echo "Exiting with code 1"
    exitcode=1
fi
#
exitcode=0
