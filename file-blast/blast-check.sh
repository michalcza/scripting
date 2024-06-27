#!/bin/zsh
# Filename: blast-check.sh
# This script checks the checksum of a file or files from all nodes
# listed in the LINUX_HOSTS file.
# Usage for a single file: ./blast-check.sh <file_name>
# Usage for all files in a directory: ./blast-check.sh

# Function to check checksum of files
check() {
    for name in $file_list
    do
        for rnode in $(cat /home/acs/scripts/LINUX_HOSTS)
        do
            if [ "$rnode" != "$host" ]
            then
                local_sum=$(sum "$name" 2>/dev/null)
                remote_sum=$($rsh_cmd "$rnode" sum "$file_path/$name" 2>/dev/null)

                if [ "$local_sum" = "$remote_sum" ]
                then
                    echo "File $name on $rnode is OK"
                else
                    echo "File $name on $rnode ($remote_sum) is different than on $host ($local_sum) * * * *"
                fi
            fi
        done
        echo "--------------------"
    done
}

host=$(hostname)
file_path=$(pwd)
rsh_cmd="ssh"

# Check if help option is provided
if [ $# -eq 1 ]; then
    if [ "$1" = "-h" ] || [ "$1" = "-help" ] || [ "$1" = "--help" ]; then
        echo " "
        echo "      This script checks the checksum of a given file, if a file name"
        echo "      is provided, or all the files in the directory designated by PWD."
        echo "      To check a single file, use the command: blast-check.sh {file_name}"
        echo "      To check all files in a directory, cd to the directory, then"
        echo "      simply enter the command: blast-check.sh"
        echo " "
        exit 0
    fi
    file_list=$1
    if [ -f "$file_list" ]; then
        check
    else
        echo "$file_list does not exist!"
        exit 1
    fi
else
    file_list=$(ls -d *)
    check
fi
