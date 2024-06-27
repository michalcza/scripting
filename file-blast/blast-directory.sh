#!/bin/bash
# File: blast-directory.sh
# Usage: ./blast-directory.sh <directory-to-copy>
# Usage example: ./blast-directory.sh example_dir
# This script copies a specified directory to all nodes listed in the LINUX_HOSTS file.
# Note: Ensure that the directory does not already exist on the other nodes before running the script.

# Get the hostname of the current machine.
HOST=$(hostname)

# Check if a directory argument was provided.
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# The directory to copy, provided as the first argument to the script.
DIRECTORY=$1

echo "Copying $DIRECTORY to all nodes"

# Loop through each remote node listed in the LINUX_HOSTS file.
for RNODE in $(cat $HOME/scripts/LINUX_HOSTS)
do
    # Skip copying to the current host.
    if [ "$RNODE" == "$HOST" ]; then
        echo "Skipping local host $HOST"
    else
        echo "Copying $DIRECTORY to remote host $RNODE"
        # Use scp to securely copy the directory to the remote node, preserving permissions and recursively copying.
        scp -rp $DIRECTORY $RNODE:$PWD/
    fi
done
