# Modify Snap Script
This is small script that unmount snap and unsquashfs it to let you modify it. After that you can mount it with changes.

**Note: the default snap mount folder is** `/var/lib/snapd/snap/` **if your distribution has a different one, change the**  `snapM` **value in the script**
## How to use
After starting script it will ask you about snap name and revision.
* Use `modify` to unmount snap. Snap will be in folder `[snap name]_[revision number]`
* Use `done` to mount snap with changes. Script will remove work folder and file

Example of usage: `sudo bash modify.sh modify`
