apt remove sudo
rm -rf /etc/resolv.conf
echo 'nameserver 8.8.8.8 ' >> /etc/resolv.conf
echo 'nameserver 8.8.4.4 ' >> /etc/resolv.conf
apt update
apt install sudo
sudo apt install udisks2 
rm /var/lib/dpkg/info/udisks2.postinst
echo '''' >> /var/lib/dpkg/info/udisks2.postinst
dpkg --configure -a
apt-mark hold udisks2 
apt install sudo
sudo apt install xfce4 xfce4-whiskermenu-plugin -y
sudo apt install kali-themes dbus-x11 qterminal firefox-esr tigervnc-standalone-server -y
clear
echo ' now vncserver and enter '
sudo su kali
