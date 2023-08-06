# Add some colours 
 red='\033[1;31m' 
 green='\033[1;32m' 
 yellow='\033[1;33m' 
 blue='\033[1;34m' 
 light_cyan='\033[1;96m' 
 reset='\033[0m' 
 cd 
 printf "${blue}##################################################\n" 
     printf "${blue}##                                              ##\n" 
     printf "${blue}##  88      a8P         db        88        88  ##\n" 
     printf "${blue}##  88    .88'         d88b       88        88  ##\n" 
     printf "${blue}##  88   88'          d8''8b      88        88  ##\n" 
     printf "${blue}##  88 d88           d8'  '8b     88        88  ##\n" 
     printf "${blue}##  8888'88.        d8YaaaaY8b    88        88  ##\n" 
     printf "${blue}##  88P   Y8b      d8''''''''8b   88        88  ##\n" 
     printf "${blue}##  88     '88.   d8'        '8b  88        88  ##\n" 
     printf "${blue}##  88       Y8b d8'          '8b 888888888 88  ##\n" 
     printf "${blue}##                                              ##\n" 
     printf "${blue}####  ############# NetHunter ####################${reset}\n\n" 
  
  
 ################################## 
 ##              Main            ## 
  
 printf "${blue} install arm64  nethunter${reset}\n "
 apt update 
 apt upgrade 
 apt install proot-distro wget 
 cd $PREFIX/var/lib 
 mkdir proot-distro 
 cd proot-distro 
 mkdir installed-rootfs 
 cd installed-rootfs 
 printf "${blue} download rootfs${reset}\n " 
wget https://kali.download/nethunter-images/current/rootfs/kalifs-arm64-nano.tar.xz
printf "${blue} extract rootfs${reset}\n"
proot --link2symlink tar -xf kalifs-arm64-nano.tar.xz 2> /dev/null || :
cp -r kali-arm64 debian
rm -rf kali-arm64
cd kali-arm64/root
wget https://raw.githubusercontent.com/Terbot8/Kali-linux-nethunter-termux/main/Desktop.sh
clear
printf "${red} bash desktop.sh and enter${reset}\n"
echo " proot-distro login --user Kali debian " >> $PREFIX/bin/nh
echo " proot-distro login debian " >> $PREFIX/bin/nh-r
chmod +x $PREFIX/bin/nh
chmod +x $PREFIX/bin/nh-r
nh-r
echo " nh = nethunter start "
echo " nh-r = nethunter start as root "
