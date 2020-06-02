#!/bin/bash

yum -y install kernel-devel gcc make perl net-tools

# Create temp workign directory
mkdir /mnt/cdrom

# Mount VMware Tools ISO
mount /dev/cdrom /mnt/cdrom

# Retrieve the VMware Tools package name from the directory
VMW_TOOLS=$(ls /mnt/cdrom | grep .gz)

# Copy VMware Tools package to /tmp
cp -f /mnt/cdrom/${VMW_TOOLS} /tmp/

# Unmount the VMware Tools ISO
umount /mnt/cdrom

# Clean up and remove temp mount directory
rmdir /mnt/cdrom

# Extract VMware Tools installer to /tmp
tar -zxf /tmp/${VMW_TOOLS} -C /tmp/

# Change into VMware Tools installer directory
cd /tmp/vmware-tools-distrib/

# Create silent answer file for VMware Tools Installer

# If you wish to change which Kernel modules get installed
# The last four entries (no,no,yes,no) map to the following:
#   VMware Host-Guest Filesystem
#   vmblock enables dragging or copying files
#   VMware automatic kernel modules
#   Guest Authentication
# and you can also change the other params as well
cat > /tmp/answer << __ANSWER__
yes
/usr/bin
/etc/rc.d
/etc/rc.d/init.d
/usr/sbin
/usr/lib/vmware-tools
yes
/usr/lib
/var/lib
/usr/share/doc/vmware-tools
yes
yes
no
no
no
__ANSWER__

# Install VMware Tools and redirecting the silent instlal file
./vmware-install.pl < /tmp/answer

# Final clean up
rm -rf vmware-tools-distrib/
rm -f /tmp/${VMW_TOOLS}
cd ~
