rm -rf /bin/kex
rm -rf /bin/kex-stop
echo " vncserver -kill :1 " >> /bin/kex
echo " vncserver -kill :2 " >> /bin/kex
echo " vncserver " >> /bin/kex
echo " vncserver -kill :1 " >> /bin/kex-stop
echo " vncserver -kill :2 " >> /bin/kex-stop
chmod +x /bin/kex
chmod +x /bin/kex-stop
clear
sudo apt update
## fix sudo and su start
chmod +s /bin/sudo
chmod +s /bin/su
sudo apt install xfce4 xfce4-whisker-meun -y
sudo apt install kali-themes firefox-esr dbus-x11 qterminal -y
