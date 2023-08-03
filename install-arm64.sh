# Add some colours
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'
cd
printf "${blue} install  nethunter"${reset}\n
apt update
apt upgrade
apt install proot-distro wget
cd $PREFIX/var/lib
mkdir proot-distro
cd proot-distro
mkdir installed-rootfs
cd installed-rootfs
printf "${blue} download rootfs${reset}\n "
wget https://kali.download/nethunter-images/current/rootfs/kalifs-arm64-minimal.tar.xz
printf "${blue} extract rootfs${reset}\n"
proot --link2symlink tar -xf kalifs-arm64-minimal.tar.xz 2> /dev/null || :

cp -r kali-arm64 debian
rm -rf kali-arm64 


echo '' proot-distro login --user kali debian --shared-tmp '' >> $PREFIX/bin/nh
echo '' proot-distro login debian '' >> $PREFIX/bin/nh-r
echo '' proot-distro login --user Kali debian '' >> $PREFIX/bin/nethunter
echo '' proot-distro login debian '' >> $PREFIX/bin/nethunter-r
chmod +x  $PREFIX/bin/nh
chmod +x  $PREFIX/bin/nh-r
chmod +x $PREFIX/bin/nethunter
chmod +x $PREFIX/bin/nethunter-r
cd
cd Kali-linux-nethunter-termux
CHROOT=$PREFIX/var/lib/proot-distro/installed-rootfs/debian
cp desktop.sh $CHROOT/root
clear
printf "${blue} no install desktop bash desktop.sh "
nh-r



clear
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

printf "${blue} [+] nethunter = nethunter start${reset}\n "
printf "${blue} [+] nethunter =nethunter start as root${reset}\n "
printf "${blue} [+] nh = start nethunter as root shortcut${reset}\n "
printf "${blue} [+] nh-r = start nethunter as root shortcut${reset}\n "


