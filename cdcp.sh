#!/bin/bash

#get info on disk
#isoinfo -d -i /dev/cdrom | grep -i -E 'block size|volume size' 

echo -n "Enter your desired iso name and press [ENTER]: "
read iso_name

# put this on one variable Logical block size is: 2048
# this on another Volume size is: 327867

#find information with grep, take numbers from information and removes newlines
block_size=$(isoinfo -d -i /dev/cdrom | grep -i -E 'block size' | grep -o '[0-9*]' | tr -d '\n')
volume_size=$(isoinfo -d -i /dev/cdrom | grep -i -E 'volume size' | grep -o '[0-9*]' | tr -d '\n')

#for debugging
#echo dd if=/dev/cdrom of=$iso_name.iso bs=$block_size count=$volume_size

dd if=/dev/cdrom of=$iso_name.iso bs=$block_size count=$volume_size

eject

#open tray
#echo "Do you wish to open the disk tray?"
#select yn in "Yes" "No"; do
#    case $yn in
#        Yes ) eject; break;;
#        No ) exit;;
#    esac
#done 

#close it
#echo "Do you wish to close the disk tray?"
#select yn in "Yes" "No"; do
#    case $yn in
#        Yes ) eject -t; break;;
#        No ) exit;;
#    esac
#done
