# Modify Snap Script
This is small script that unsquashfs snap to let you modify it. After that you can mount it with changes.
## How to use
After starting script it will let you choose snap name and revision.
* Use `modify` to unsquashfs snap. Snap will be in folder `[snap name]_[revision number]` Snap will be still able to run
* Use `done` to mount snap with changes. Snap cannot be started during this. Script will remove work folder and file

Example of usage: `sudo bash modify.sh modify`
