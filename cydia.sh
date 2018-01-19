#!/bin/sh
echo "Input your iDevice ip address :"
read ipaddress
echo "create temporary directory at your desktop"
mkdir -p ~/Desktop/CydiaFileInstalls
echo "downloading Cydia"
cd ~/Desktop/CydiaFileInstalls && { curl -O http://cache.saurik.com/debs/cydia_1.1.13_iphoneos-arm.deb ; cd -; }
cd ~/Desktop/CydiaFileInstalls && { curl -O http://apt.saurik.com/debs/cydia-lproj_1.1.12_iphoneos-arm.deb ; cd -; }
ls -la ~/Desktop/CydiaFileInstalls
echo "default ssh password at your iphone is 'alpine' without quote"
echo "create directory installations at iDevice"
ssh root@$ipaddress "mkdir -p /var/root/Media/Cydia/AutoInstall"
echo "copying file installations to iDevice"
scp ~/Desktop/CydiaFileInstalls/*.deb root@$ipaddress:/var/root/Media/Cydia/AutoInstall
echo "Listing cydia file at iDevice"
ssh root@$ipaddress "ls -la /var/root/Media/Cydia/AutoInstall"
echo "MAKE SURE THAT FILE WAS COPIED FROM YOUR PC TO YOUR IDEVICE, IF NO, PLEASE CTR+C (EXIT FROM THIS SCRIPT, AND START OVER.). PRESS ANY KEY TO CONTINUE."
read idihmasbog
echo "Rebooting iDevice"
ssh root@$ipaddress "chmod 7777 /var/root/Media/Cydia/AutoInstall/*; reboot"