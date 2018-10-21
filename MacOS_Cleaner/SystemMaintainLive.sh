#!/bin/bash
clear
read -p "Press [Enter] key to start file maintenance..."
set -e

	#find FILES inside of FOLDER that are +1 days old and DELETE
VarLog=/var/log/
find  $VarLog -type f -mtime +1 && srm -frv $VarLog
wait
find  $VarLog -type d -mtime +1 && srm -frv $VarLog
wait
PrivateVarLog=/private/var/log/
find  $PrivateVarLog -type f -mtime +1 && srm -frv $PrivateVarLog
wait
find  $PrivateVarLog -type d -mtime +1 && srm -frv $PrivateVarLog
wait
UserLibraryLog="$HOME"/Library/Logs/
find  $UserLibraryLog -type f -mtime +1 && srm -frv $UserLibraryLog
wait
find  $UserLibraryLog -type d -mtime +1 && srm -frv $UserLibraryLog
wait

	#SEARCH and CLEAR download quarantine log
sqlite3 "$HOME"/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
wait
	#history of servers that finder connected to and DVDs mounted
FinderConnected="$HOME"/Library/Preferences/com.apple.finder.plist
find $FinderConnected -type f -mtime +1 && srm -fv $FinderConnected
wait
	#DVD CSS files
DVDCSS="$HOME"/.dvdcss
find $DVDCSS -type f -mtime +1 && srm -frv $DVDCSS
wait
	#disk images .dmg that have been burned using DiskUtility
BurnedImages="$HOME"/Library/Preferences/com.apple.DiskUtility.plist
find $BurnedImages -type f -mtime +1 && srm -fv $BurnedImages
wait
	#Safari items
SafariItems="$HOME"/Library/Preferences/com.apple.Safari.plist
find  $SafariItems -type f -mtime +1 && srm -fv $SafariItems
wait
	#CACHES
SafariCache="$HOME"/Library/Caches/Safari
#find $SafariCache -type f -mtime +1 && -exec srm -fv $SafariCache
#wait
#find "$HOME"/Library/Caches/ -type f -mtime +1 -exec srm -fv {} \;
#wait
#find "$HOME"/Library/Caches -type f -mtime +1 -exec srm -fv {} \;
#wait
	#Handbrake
Handbrake="$HOME"/Library/Caches/fr.handbrake.HandBrake
find $Handbrake -type f -mtime +1 && srm -fv $Handbrake
wait
	#Azerus
Azerus="$HOME"/Library/Caches/com.azureus.vuze/fsCachedData
find  $Azerus -type d -mtime +1 && srm -fv $Azerus
	#AIM
AIM="$HOME"/Library/Preferences/com.apple.iChat.AIM.plist	
find  $AIM -type f -mtime +1 && srm -fv $AIM
wait	
	#recent Preview items
Preview="$HOME"/Library/Preferences/com.apple.Preview.bookmarks.plist
find  $Preview -type f -mtime +1 && srm -fv $Preview
wait
	#recent desktop connections
Desktop="$HOME"/Library/Preferences/com.apple.RemoteDesktop.plist
find  $Desktop -type f -mtime +1 && srm -fv $Desktop
wait
	#last ipod connnected
Ipod="$HOME"/Library/Preferences/com.apple.iPod.plist
find  $Ipod -type f -mtime +1 && srm -fv $Ipod
wait
	#address book
AddressBook="$HOME"/Library/Caches/com.apple.AddressBook/MetaData
find  $AddressBook -type d -mtime +1 && srm -fv $AddressBook
wait
	#recent items
RecentItems="$HOME"/Library/Preferences/com.apple.recentitems.plist
find  $RecentItems -type f -mtime +1 && srm -fv $RecentItems
wait
	#recent Quicktime
QuickTime="$HOME"/Library/Preferences/com.apple.quicktimeplayer.plist
find  $QuickTime -type f -mtime +1 && srm -fv $QuickTime
wait
	#original registrant of computer
OrigReg="$HOME"/Library/Assistants/Sendregistration.setup
find  $OrigReg -type f -mtime +1 && srm -fv $OrigReg
wait
AddressBook="$HOME"/Library/Preferences/AddressBookMe.plist
find  $AddressBook -type f -mtime +1 && srm -fv $AddressBook
wait
	#DNS cache
sudo killall -HUP mDNSResponder
wait
	#remove sleep image
sudo srm -fv /private/var/vm/sleepimage
wait
	#SQL
SQL="$HOME"/.sqlite_history
find  $SQL -type f -mtime +1 && srm -fv $SQL	
wait
	#Bash
BASH="$HOME"/.bash_history
find  $BASH -type f -mtime +1 && srm -fv $BASH	
wait
	#Install History
Install=/Library/Receipts/InstallHistory.plist
find  $Install -type f -mtime +1 && srm -fv $Install	
wait
	#Network Diagnostics
Net=/Library/Caches/com.apple.DiagnosticReporting.Networks.New.plist
find  $Net -type f -mtime +1 && srm -fv $Net
wait			

	#iMessages
iMessageAttachments="$HOME"/Library/Messages/Attachments/
find $iMessageAttachments -type d -mtime +1 && srm -frv $iMessageAttachments
wait
ChatDB="$HOME"/Library/Messages/chat.db
find $ChatDB -type f -mtime +1 && srm -fv $ChatDB
wait
ChatDBshm="$HOME"/Library/Messages/chat.db-shm
find $ChatDBshm -type f -mtime +1 && srm -fv $ChatDBshm
wait
ChatDBwal="$HOME"/Library/Messages/chat.db-wal
find $ChatDBwal -type f -mtime +1 && srm -fv $ChatDBwal
wait

	#Clear and remove FireWire Kernel
folder_firewire=/System/Library/Extensions/IOFireWireFamily.kext/Contents/PlugIns/AppleFWOHCI.kext/
if [ -d $folder_firewire ]
then
echo "$folder_firewire folder will be archived and removed"	
	sudo mkdir -p "$HOME"/Documents/ScriptBackups/Firewire/$(date +%Y%m%d)/
	sudo cp -R "$folder_firewire" "$HOME"/Documents/ScriptBackups/Firewire/$(date +%Y%m%d)/
	sudo srm -frv $folder_firewire
else
	echo $folder_firewire not found.
fi
wait
<<SINGLEUSER	
	#Force singleuser boot behavior
rcboot=/etc/rc.boot
if [ -f $rcboot ]
then
	echo "$rcboot found"
	if fgrep -H "fsck;fsck;reboot" $rcboot
		then echo "$rcboot is configured for fsck"
  		else echo "fsck;fsck;reboot" >> $rcboot
	fi
else 
	echo "$rcboot not found"
fi
wait
SINGLEUSER

	#Force singleuser boot behavior for AppleJack
rcboot=/etc/rc.boot
if [ -f $rcboot ]
then
	echo "$rcboot found"
	if fgrep -H "applejack" $rcboot
		then echo "$rcboot is configured for AppleJack"
  		else echo "applejack" > $rcboot
	fi
else 
	echo "$rcboot not found"
fi
wait

	#Empty Trash anything over 7+ days old
Trash="$HOME"/.Trash
find  $Trash -type f -mtime +7 && srm -frv $Trash
wait
read -p "Press [Enter] key to finish file maintenance..."
















