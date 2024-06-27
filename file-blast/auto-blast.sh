#!/bin/zsh
# File: auto-blast.sh
# This script will send all updated files in the home directory
# from the source Linux node to all of the Linux nodes listed
# in LINUX_HOSTS. Any files that you do NOT want to be sent to the
# other nodes need to be listed in the auto_blast_exclude_file.txt
# file located in the $HOME/scripts directory.
#set -x  # Uncomment this line for debugging to enable verbose output.

# Get the hostname of the current machine.
HOST=`hostname`

# Read the list of Linux hosts from the file $HOME/scripts/LINUX_HOSTS.
read Linux_hosts < $HOME/scripts/LINUX_HOSTS

# Define the source directory to sync from (home directory of the current user).
SOURCE="$HOME/"

# Define the path to the file that contains the list of patterns to exclude from syncing.
EXCLUDE_FILE="$HOME/scripts/auto_blast_exclude_file.txt"

# Define the rsync exclude option.
EXCLUDE="--exclude-from=$EXCLUDE_FILE"

# Loop through each host in the list of Linux hosts.
for node in $Linux_hosts
do
    # Check if the current host is not the same as the remote host.
    if [ "$node" != "$HOST" ]
    then
        echo "Updating $node..."
        
        # Define the target directory for rsync (home directory on the remote host).
        TARGET="$node:$HOME/"
        
        # Run rsync in dry-run mode to synchronize files, log the output.
        /usr/bin/rsync -av $EXCLUDE --timeout=2 --dry-run $SOURCE $TARGET > $HOME/tmp/auto_blast_$node.log
    fi
done

# Change directory to the home directory.
cd $HOME/

# Create a file listing suggestions for files to remove, initialize the file with a header.
echo "You may want to remove the following files in $HOME/:" > $HOME/tmp/files_to_cleanup

# Append lists of specific file types to the cleanup suggestion file.
find . -name '*.B[1-9]*' >> $HOME/tmp/files_to_cleanup
find . -name '*.gz' >> $HOME/tmp/files_to_cleanup
find . -name '*.old' >> $HOME/tmp/files_to_cleanup
find . -name '*.orig' >> $HOME/tmp/files_to_cleanup
find . -name '*.original' >> $HOME/tmp/files_to_cleanup
find . -name '*.rpmsave' >> $HOME/tmp/files_to_cleanup
find . -name '*.save' >> $HOME/tmp/files_to_cleanup
find . -name '*.sav' >> $HOME/tmp/files_to_cleanup
find . -name '*.tar' >> $HOME/tmp/files_to_cleanup
find . -name '*.tgz' >> $HOME/tmp/files_to_cleanup
find . -name '*.zip' >> $HOME/tmp/files_to_cleanup

# Wait for a second to ensure file operations complete.
sleep 1

# Open the cleanup suggestion file using a GUI tool.
$HOME/bin/quickgui --title "Suggested Files to Remove" view-text $HOME/tmp/files_to_cleanup &
