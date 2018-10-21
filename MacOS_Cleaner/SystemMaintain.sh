#!/bin/bash
clear
set -ev
#set -e: Enables checking of all commands. If a command fails, the script will terminate.
#set -x: Prints the command that is surrently being executed
#set -v: Verbose
	#THINGS TO KNOW
#visudo to edit the sudo file. This is where you can make your username act as root with full admin privileges
#you can also white list individual files to have root privileges 
#ALL= NOPASSWD: ~/Documents/AppleScript/RemoveAllLogs.sh
#use vi commands and nomenclature within this file. DO NOT USE VI. USE ONLY VISUDO
#find [path] -type f -mtime +1 -exec srm -f {} \;
#will find any file in that path greater than +1 days and execute a secure rm
#find [path] -type d -mtime +1 -exec srm -f {} \;
#will find any folder in that path greater than +1 days and execute a secure rm
#if you want to test a find command to fell you what it will delete without deleting it, replace srm with find
	#LOG FILES
#find FILES inside of FOLDER that are +1 days old and DELETE
VarLog="/var/log/"
find  $VarLog -type f -mtime +1 && srm -frv $VarLog
wait
find  $VarLog -type d -mtime +1 && srm -frv $VarLog
wait
PrivateVarLog="/private/var/log/"
find  $PrivateVarLog -type f -mtime +1 && srm -frv $PrivateVarLog
wait
find  $PrivateVarLog -type d -mtime +1 && srm -frv $PrivateVarLog
wait
UserLibraryLog="~/Library/Logs/"
find  $UserLibraryLog -type f -mtime +1 && srm -frv $UserLibraryLog
wait
find  $UserLibraryLog -type d -mtime +1 && srm -frv $UserLibraryLog
wait

	#SEARCH and CLEAR download quarantine log
#SHOW all downloaded items in quarantine for user
#sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | sort
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
wait
	#history of servers that finder connected to and DVDs mounted
FinderConnected="~/Library/Preferences/com.apple.finder.plist"
find $FinderConnected -type f -mtime +1 && srm -fv $FinderConnected
wait
	#disk images .dmg that have been burned using DiskUtility
BurnedImages="~/Library/Preferences/com.apple.DiskUtility.plist"
find $BurnedImages -type f -mtime +1 && srm -fv $BurnedImages
wait
	#Safari items
SafariItems="~/Library/Preferences/com.apple.Safari.plist"
find  $SafariItems -type f -mtime +1 && srm -fv $SafariItems
wait
	#CACHES
SafariCache="~/Library/Caches/Safari"
#find $SafariCache -type f -mtime +1 && -exec srm -fv $SafariCache
#wait
#find ~/Library/Caches/ -type f -mtime +1 -exec srm -fv {} \;
#wait
#find ~/Library/Caches -type f -mtime +1 -exec srm -fv {} \;
#wait
	#Handbrake
Handbrake="~/Library/Caches/fr.handbrake.HandBrake"
find $Handbrake -type f -mtime +1 && srm -fv $Handbrake
wait
	#Azerus
Azerus="~/Library/Caches/com.azureus.vuze/fsCachedData"
find  $Azerus -type d -mtime +1 && srm -fv $Azerus
	#AIM
AIM="~/Library/Preferences/com.apple.iChat.AIM.plist"	
find  $AIM -type f -mtime +1 && srm -fv $AIM
wait	
	#recent Preview items
Preview="~/Library/Preferences/com.apple.Preview.bookmarks.plist"
find  $Preview -type f -mtime +1 && srm -fv $Preview
wait
	#recent desktop connections
Desktop="~/Library/Preferences/com.apple.RemoteDesktop.plist"
find  $Desktop -type f -mtime +1 && srm -fv $Desktop
wait
	#last ipod connnected
Ipod="~/Library/Preferences/com.apple.iPod.plist"
find  $Ipod -type f -mtime +1 && srm -fv $Ipod
wait
	#address book
AddressBook="~/Library/Caches/com.apple.AddressBook/MetaData"
find  $AddressBook -type d -mtime +1 && srm -fv $AddressBook
wait
	#recent items
RecentItems="~/Library/Preferences/com.apple.recentitems.plist"
find  $RecentItems -type f -mtime +1 && srm -fv $RecentItems
wait
	#recent Quicktime
QuickTime="~/Library/Preferences/com.apple.quicktimeplayer.plist"
find  $QuickTime -type f -mtime +1 && srm -fv $QuickTime
wait
	#VARIOUS
	#original registrant of computer
OrigReg="~/Library/Assistants/Sendregistration.setup"
find  $OrigReg -type f -mtime +1 && srm -fv $OrigReg
wait
AddressBook="~/Library/Preferences/AddressBookMe.plist"
find  $AddressBook -type f -mtime +1 && srm -fv $AddressBook
wait
	#DNS cache
sudo discoveryutil mdnsflushcache
wait
sudo discoveryutil udnsflushcaches
wait
	#remove sleep image
sudo srm -fv /private/var/vm/sleepimage
wait
	#SQL
SQL="~/.sqlite_history"
find  $SQL -type f -mtime +1 && srm -fv $SQL	
wait
	#Bash
BASH="~/.bash_history"
find  $BASH -type f -mtime +1 && srm -fv $BASH	
wait
	#Install History
Install="/Library/Receipts/InstallHistory.plist"
find  $Install -type f -mtime +1 && srm -fv $Install	
wait
	#Network Diagnostics
Net="/Library/Caches/com.apple.DiagnosticReporting.Networks.New.plist"
find  $Net -type f -mtime +1 && srm -fv $Net
wait			

#and replace them with a random file of the same name
#dd if=/dev/urandom of=~/.sqlite_history count=2
#dd if=/dev/urandom of=~/.bash_history count=2
#and make sure the file permissions are there
#chmod 600 ~/.bash_history
#chmod 600 ~/.sqlite_history

	#iMessages
iMessageAttachments="~/Library/Messages/Attachments/"
find iMessageAttachments -type d -mtime +1 && srm -frv $iMessageAttachments
wait
ChatDB="~/Library/Messages/chat.db"
find ChatDB -type f -mtime +1 && srm -fv $ChatDB
wait
ChatDBshm="~/Library/Messages/chat.db-shm"
find ChatDBshm -type f -mtime +1 && srm -fv $ChatDBshm
wait
ChatDBwal="~/Library/Messages/chat.db-wal"
find ChatDBwal -type f -mtime +1 && srm -fv $ChatDBwal
wait

##### CREAR AND REMOVE FIREWIRE KERNEL #####

folder_firewire="/System/Library/Extensions/IOFireWireFamily.kext/Contents/PlugIns/AppleFWOHCI.kext/"
#test to see if folder exists
if [ -d "$folder_firewire" ]
then

echo "$folder_firewire folder will be archived and removed"
	
	#make directory with today's date
	sudo mkdir -p ~/Documents/ScriptBackups/Firewire/$(date +%Y%m%d)/
	#copy the files
	sudo cp -R "$folder_firewire" ~/Documents/ScriptBackups/Firewire/$(date +%Y%m%d)/
	#remove the old files
	sudo rm -frv "$folder_firewire"

else
	echo "$folder_firewire not found. Will check again later"
fi

wait
#update to MacPorts
sudo port selfupdate
wait
sudo port upgrade outdated
wait

#add bit bucket to /dev/null

#sudo nano /etc/rc.boot
#add fsck;fsck;reboot to the file
#the only reason for single user boot would be to fsck anyways so if you boot SU you just run fsck

#set firmware password with
#reboot, command + r

#check sleep image status
#pmset -g | grep hibernatemode
#hibernatemode 0 - disabled
#hibernatemode 3 - enabled

#find file inside of folder older than +1 days
#find /var/log -type f -mtime +1



	#Mobile Backups
	#THESE ARE NOT LOG FILES. THESE FOLDERS ARE THE ACTUAL BACKUP FILES FROM MOBILE DEVICES
	#LOOKS LIKE THESE FILES ARE ENCRYPTED THROUGH ITUNES
#~/Library/Application Support/MobileSync/Backup

#syslog -F raw -k Facility com.apple.system.lastlog | grep insert_username_here
#last shows the last login events





