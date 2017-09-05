#!/bin/bash

#get info on disk
isoinfo -d -i /dev/cdrom | grep -i -E 'block size|volume size' 

# put this on one variable Logical block size is: 2048
# this on another Volume size is: 327867

#block_size=$(isoinfo -d -i /dev/cdrom | grep -i -E 'block size')
#volume_size=$(isoinfo -d -i /dev/cdrom | grep -i -E 'volume size')

dd if=/dev/cdrom of=test.iso bs=$block_size count=$volume_size


#2. Running dd with the parameters for block size and volume size:
echo 'dd if=/dev/cdrom of=test.iso bs=<block size from above> count=<volume size from above>'

#open tray
#eject 

#close it
#eject -t
