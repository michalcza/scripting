#!/bin/zsh
# blast.sh
# usage: ./blast.sh file1.txt file2.txt
# This script will send specified files to all nodes listed in the LINUX_HOSTS file.

# Ensure the user's profile is sourced to load environment variables.
. ~/.profile > /dev/null 2>&1

# Function to send a file to all Linux nodes
blastit() {
    # Iterate over each node listed in the Linux_hosts array
    for node in $Linux_hosts; do
        # Skip the current host
        if [ "$node" != "$HOST" ]; then
            echo " Sending file $NAME to Linux node $node . . ."
            # Use scp to copy the file while preserving modification times and permissions
            scp -p "$FULLNAME" "$node:$FULLNAME"
            # Log the action
            logger -t BLAST "$USER has blasted the file $FULLNAME"
        fi
    done
}

# ========================== Main Routine ==========================

Linux_file="$HOME/scripts/LINUX_HOSTS"

# Check if the Linux hosts file exists
if [ ! -f "$Linux_file" ]; then
    echo " "
    echo " File $Linux_file containing Linux hostnames does not exist"
    echo " "
    exit 1
fi

# Read the list of Linux hosts into the Linux_hosts variable
read Linux_hosts < "$Linux_file"

# Get the hostname of the current machine
HOST=$(hostname)

# Iterate over all the files provided as arguments
for file in "$@"; do
    NAME="$file"
    FULLNAME="$PWD/$file"
    # Call the blastit function to send the file to all nodes
    blastit
done
