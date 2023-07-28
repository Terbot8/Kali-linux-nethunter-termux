# Add some colours
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'

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
chmod +x  $PREFIX/bin/nh
chmod +x  $PREFIX/bin/nh-r
cd
cd 
clear
printf "${blue} [+] nh = nethunter start${reset}\n "
printf "${blue} [+] nh-r =nethunter start as root${reset}\n "

