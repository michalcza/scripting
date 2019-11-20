#!/bin/sh

###################################################################
#Script Name    :WordpressPermissions.sh
#Description    :Cleanup wordpress folder permissions.
#Created        :19 November 2019
#Args           :
#Author         :Michal Czarnecki
#Email          :mczarnecki@gmail.com
#GitHub         :http://www.github.com/michalcza
###################################################################
#To Do          :
###################################################################
#Status         :Good enough
###################################################################
#
# Set exit code to assume bad exit
exitcode=1
# Declare variables
pwd=/usr/share/wordpress #Assume generic install location
cd $pwd &&
chown www-data:www-data  -R * &&
find . -type d -exec chmod 755 {} \; &&
find . -type f -exec chmod 644 {} \;
