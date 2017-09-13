#!/bin/bash

#get info on disk
#isoinfo -d -i /dev/cdrom | grep -i -E 'block size|volume size'

#loop so program may restart if user wishes new backup
while : ; do

  #checks if there's a cd inserted
  blkid /dev/cdrom/

  #if not, warn user and open tray
  if [ $? -eq 2 ]; then
    echo "Please insert a disk"
    eject
  fi

  echo -n "Enter your desired iso name and press [ENTER]: "
  read iso_name

  # put this on one variable Logical block size is: 2048
  # this on another Volume size is: 327867

  #find information with grep, take numbers from information and removes newlines
  block_size=$(isoinfo -d -i /dev/cdrom | grep -i -E 'block size' | grep -o '[0-9*]' | tr -d '\n')
  volume_size=$(isoinfo -d -i /dev/cdrom | grep -i -E 'volume size' | grep -o '[0-9*]' | tr -d '\n')

  #for debugging
  #echo dd if=/dev/cdrom of=$iso_name.iso bs=$block_size count=$volume_size

  dd if=/dev/cdrom of=$iso_name.iso bs=$block_size count=$volume_size status=none & PID=$! #simulate a long process

  printf "Running backup..."

  printf "["
  # While process is running...
  while kill -0 $PID 2> /dev/null; do
      printf  "#"
      sleep 3
  done
  printf "]\n"

  #to add: error handling
  printf "Operation concluded succesfully!\n"

  while true; do
      read -p "Do you want to eject disk? " yn
      case $yn in
          [Yy]* ) eject; break;;
          [Nn]* ) break;;
          * ) printf "Please answer yes or no.";;
      esac
  done

  while true; do
      read -p "Backup another disk? " yn
      case $yn in
          [Yy]* ) eject -t; break;;
          [Nn]* ) eject -t; exit;; #exits program
          * ) printf "Please answer yes or no.";;
      esac
  done

  done
