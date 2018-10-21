#!/bin/bash
clear
Trash="$HOME"/.Trash
find  $Trash -type f -mtime +7 && srm -frv $Trash
wait
mkdir $Trash
read -p "Press [Enter] key to finish file maintenance..."