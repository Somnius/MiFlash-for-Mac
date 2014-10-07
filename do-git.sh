#!/bin/bash
clear #clears the air of your terminal
# variables
###############################################################
###############################################################
################ VARIABLES TO EDIT ############################
APPNAME="MiFlash-For-Mac"
BACKPATH="../MiFlash-For-Mac_backup" #always a folder outside git
################ DO NOT EDIT AFTER THESE LINES ################
###############################################################
###############################################################
VER="0.8"
echo "Do GIT script v.$VER"
echo "by @SomniusX (Somnius on GitHub)"
echo " "
echo "The program checks for backup directory, if it doesn't exist it creates it."
echo "Then it zip's with -r -q -9 flags (recursive/quiet/max compression) with date."
echo "Then it displays backup folder size and starts commit all, pull and then push."
echo " "
echo "-------------------------------------------------------"
echo " " 
if [ -d $BACKPATH ]
then
    echo "Backup Directory exists."
	echo "Starting process.."
	zip -r -q -9 $BACKPATH/backup-$(date +%Y%m%d_%H%M).zip * # the zipping using date
	du -sh $BACKPATH/*.zip|tail -1|sed -e "s/..\/\"$APPNAME\"_backup\//is the back'ed up file\: /" # the du to check the file size
	echo "Backup folder size is.."
	du -sh $BACKPATH|sed -e "s/..\/\"$APPNAME\"_/holds the folder\: /" # the du with sed to display the backup folder size
	echo " "
	sleep 1 # wait for 1sec
	git commit -a # the commit all
	git pull # the pull
	git push # the push
	echo " "
	echo "All done.."
else
    echo "Backup Directory doesn't exist, creating.."
	mkdir $BACKPATH # creating the backup directory for 1st time use
	echo "Starting process.."
	zip -r -q -9 $BACKPATH/backup-$(date +%Y%m%d_%H%M).zip * # the zipping using date
	du -sh $BACKPATH/*.zip|tail -1|sed -e "s/..\/\"$APPNAME\"_backup\//is the back'ed up file\: /" # the du to check the file size
	echo "Backup folder size is.."
	du -sh $BACKPATH|sed -e "s/..\/\"$APPNAME\"_/holds the folder\: /" # the du with sed to display the backup folder size
	echo " "
	sleep 1 # wait for 1sec
	git commit -a # the commit all
	git pull # the pull
	git push # the push
	echo " "
	echo "All done.."
fi
