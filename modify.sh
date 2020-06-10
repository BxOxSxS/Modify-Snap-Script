#!/bin/sh
mount=/snap/
opwd=$PWD
if [ "$1" == "modify" ];  then
     cd $mount
     n=-1
     for i in $(ls -d */); do {
          ((n++))
          printf $n.  | sed "s/0.//" && echo ${i%%/} | sed "/^bin/Id"
          s[$n]=$i
          } done
     echo
     read -p "Choose snap number " n
     cd ${s[$n]%%/}
     n2=0
     for i in $(ls -d */); do {
          ((n2++))
          echo $n2. ${i%%/} | sed "s/$n2. current//"
          r[$n2]=$i
          } done
     read -p "Choose snap revision number " n2
     snap="${s[$n]%%/}_${r[$n2]%%/}"
     read -p "You have chosen $snap Continue? [Y/N] " con
     if [ "$con" == "y" ] || ["$con" == "Y" ]; then echo; else exit 130; fi

     cd "$opwd"
     sudo unsquashfs -quiet /var/lib/snapd/snaps/$snap.snap
     sudo chmod -R 777  squashfs-root
     mv squashfs-root $snap
     echo Now you can modify snap in folder $snap
     echo Call me with done parametr to mount snap

elif [ "$1" == "done" ]; then
     n=0
     for i in $(ls -d */); do {
          ((n++))
          echo $n. ${i%%/}
          s[$n]=$i
          } done
     read -p "Choose snap folder number " n
     snap="${s[$n]%%/}"
     echo
     echo You have chosen $snap it will be umounted so make sure it does not run!
     read -p "Continue? [Y/N] " con
     if [ "$con" == "y" ] || ["$con" == "Y" ]; then echo; else exit 130; fi

     rev=$(echo $snap | grep -o "_.*" | cut -c 2-)
     name=$(echo $snap | grep -o ".*_" | rev | cut -c 2- | rev)

     sudo umount ${mount}${name}/$rev
     sudo mksquashfs ${name}_${rev} ${name}_${rev}.snap -quiet
     sudo cp ${name}_${rev}.snap /var/lib/snapd/snaps/${name}_${rev}.snap
     sudo mount -t squashfs -o ro,nodev,relatime,x-gdu.hide /var/lib/snapd/snaps/${name}_${rev}.snap ${mount}${name}/$rev
     sudo rm -r ${name}_${rev}
     sudo rm ${name}_${rev}.snap

else
     echo Unkown parametr
fi
