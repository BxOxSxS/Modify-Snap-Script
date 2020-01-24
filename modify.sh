#!/bin/sh
snapM=/var/lib/snapd/snap/

if [ "$1" == "modify" ];  then
     read -p "Enter snap name e.g. spotify "  snapN
     read -p "Enter snap revision e.g. 38 " snapR
     sudo umount ${snapM}${snapN}/$snapR

     sudo unsquashfs /var/lib/snapd/snaps/${snapN}_${snapR}.snap
     echo Now you can modify snap in folder squashfs-root
     echo Call me with done parametr to mount snap
elif [ "$1" == "done" ]; then
     read -p "Enter snap name e.g. spotify "  snapN
     read -p "Enter snap Rev e.g. 38 " snapR

     sudo mksquashfs squashfs-root ${snapN}_${snapR}.snap
     sudo cp ${snapN}_${snapR}.snap /var/lib/snapd/snaps/${snapN}_${snapR}.snap
     sudo mount -t squashfs -o ro,nodev,relatime,x-gdu.hide /var/lib/snapd/snaps/${snapN}_${snapR}.snap ${snapM}${snapN}/$snapR
     sudo rm -r squashfs-root
     sudo rm ${snapN}_${snapR}.snap

else
     echo Unkown parametr
fi
