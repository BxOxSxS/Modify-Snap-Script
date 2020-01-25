#!/bin/sh
mount=/var/lib/snapd/snap/

if [ "$1" == "modify" ];  then
     read -p "Enter snap name e.g. spotify "  name
     read -p "Enter snap revision e.g. 38 " rev
     sudo umount ${mount}${name}/$rev

     sudo unsquashfs /var/lib/snapd/snaps/${name}_${rev}.snap
     sudo chmod -R 777  squashfs-root
     mv squashfs-root ${name}_${rev}
     echo Now you can modify snap in folder ${name}_${rev}
     echo Call me with done parametr to mount snap

elif [ "$1" == "done" ]; then
     read -p "Enter snap name e.g. spotify "  name
     read -p "Enter snap rev e.g. 38 " rev

     sudo mksquashfs ${name}_${rev} ${name}_${rev}.snap
     sudo cp ${name}_${rev}.snap /var/lib/snapd/snaps/${name}_${rev}.snap
     sudo mount -t squashfs -o ro,nodev,relatime,x-gdu.hide /var/lib/snapd/snaps/${name}_${rev}.snap ${mount}${name}/$rev
     sudo rm -r ${name}_${rev}
     sudo rm ${name}_${rev}.snap

else
     echo Unkown parametr
fi
