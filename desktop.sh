echo "vncserver -kill :* ; rm -rf /tmp/.X1-lock ; rm -rf /tmp/.X11-unix/X1">> /bin/kex-stop
chmod +x /bin/kex-stop
echo "vncserver " >> /bin/kex
chmod +x /bin/kex
rm -rf /etc/resolv.conf
echo 'nameserver 8.8.8.8 ' >> /etc/resolv.conf
echo 'nameserver 8.8.4.4 ' >> /etc/resolv.conf
apt update

sudo apt install udisks2 -y
rm /var/lib/dpkg/info/udisks2.postinst
echo '''' >> /var/lib/dpkg/info/udisks2.postinst
dpkg --configure -a
apt-mark hold udisks2 
## sudo and su fix start
chmod +s /bin/sudo
chmod +s /bin/su
sudo apt install kali-desktop-xfce dbus-x11 tigervnc-standalone-server -y
clear
exit
