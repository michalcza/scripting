#!/bin/zsh
# File: auto-blast-db-delete.sh
# This script syncs updated files in the DB directory
# from the source Linux node to all nodes listed in LINUX_HOSTS.
# Files to exclude from syncing are listed in auto_blast_DB_exclude_file.txt.

# Obtain hostname of the current machine
HOST=$(hostname)

# Read Linux hosts from LINUX_HOSTS file
read -r Linux_hosts < "$HOME/scripts/LINUX_HOSTS"

# Source directory to sync from
SOURCE="$HOME/DB/"

# Exclude file list
EXCLUDE_FILE="$HOME/scripts/auto_blast_DB_exclude_file.txt"
EXCLUDE="--exclude-from=$EXCLUDE_FILE"

# Iterate over each node and sync files
for node in $Linux_hosts; do
    if [ "$node" != "$HOST" ]; then
        echo "Updating $node..."
        TARGET="$node:$HOME/DB/"
        # Perform rsync with backup, excluding specified files, and delete extraneous files
        /usr/bin/rsync -av --backup --backup-dir=~/acs_backup $EXCLUDE --delete --timeout=2 "$SOURCE" "$TARGET" > "$HOME/tmp/auto_blast_DB_delete_$node.log"
    fi
done

# Log operation using logger
logger -t BLASTDB "$USER has run auto_blast_DB on $HOST"

# Generate list of files to potentially remove
cd "$HOME/DB/"
echo "You may want to remove the following files in $HOME/DB/:" > "$HOME/tmp/files_to_cleanup"
find . -name '*.B[1-9]*' \
    -o -name '*.gz' \
    -o -name '*.old' \
    -o -name '*.orig' \
    -o -name '*.original' \
    -o -name '*.rpmsave' \
    -o -name '*.save' \
    -o -name '*.sav' \
    -o -name '*.tar' \
    -o -name '*.tgz' \
    -o -name '*.zip' >> "$HOME/tmp/files_to_cleanup"

# Display cleanup suggestions in a graphical interface
sleep 1
$HOME/bin/quickgui --title "Suggested Files to Remove" view-text "$HOME/tmp/files_to_cleanup" &
