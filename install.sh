cd
clear
# Add some colours 
 red='\033[1;31m'
 green='\033[1;32m' 
 yellow='\033[1;33m' 
 blue='\033[1;34m' 
 light_cyan='\033[1;96m' 
 reset='\033[0m' 
 function unknown_architechure () {
 ## unknown architecture this stop is session
 printf "${red}[×]unknown architecture${reset}\n"
 sleep 1
 exit 1
 }
 function checking_architecture () {
case `dpkg --print-architecture` in
                aarch64)
                        archurl="arm64" ;;
                arm)
                        archurl="armhf" ;;
                amd64)
                        archurl="amd64" ;;
                x86_64)
                        archurl="amd64" ;;

                *)
                unknown_architechure
                  
                esac 
}                
function install_package () {
CHROOT=kali-${archurl}
## install all package 
apt update
apt upgrade -y
apt install proot wget x11-repo -y
apt install xwayland -y
apt install termux-x11-nightly 
}

function download_rootfs () {
wget -O kali.tar.xz https://kali.download/nethunter-images/current/rootfs/kalifs-${archurl}-minimal.tar.xz
}
function extract_rootfs () {
proot --link2symlink tar -xf kali.tar.xz 2> /dev/null || :  
CHROOT=kali-${archurl}
}
function select_user () {

read -p "type username for kali: " select
read -p "type password for $select: " password
rm -rf $CHROOT/root/.bashrc
cat > $CHROOT/root/.bashrc <<- EOM
rm -rf /home/kali
deluser kali
useradd -m -s /bin/bash $select
echo "$select:$password" | chpasswd
echo "$select ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$select
EOM
 }

function add_kali_launcher () {
cd

KALI_LAUNCHER=$PREFIX/bin/kali
rm -rf $KALI_LAUNCHER
cat > $KALI_LAUNCHER <<- EOM
#!$PREFIX/bin/bash
## termux-exec sets LD_PRELOAD so let's unset it before continuing
unset LD_PRELOAD
home="/home/$select"
start="sudo -u $select bash"
if grep -q "$select" ${CHROOT}/etc/passwd; then
    kaliuser="1";
else
    kaliuser="0";
fi
## kali nethunter launch as root cmd type "-r" enter
if [[ \$kaliuser == "0" || ("\$#" != "0" && ("\$1" == "-r" || "\$1" == "-R")) ]];then
    home="/root"
    start="bash --login"
    if [[ "\$#" != "0" && ("\$1" == "-r" || "\$1" == "-R") ]];then
        shift
    fi
fi


command="proot -k 4.14.81 --link2symlink -0 -r $CHROOT -b /dev -b /dev/null:/proc/sys/kernel/cap_last_cap -b /proc -b /dev/null:/proc/stat -b /sys -b /data/data/com.termux/files/usr/tmp:/tmp -b $CHROOT/tmp:/dev/shm -b /:/host-rootfs -b /sdcard -b /storage -b /mnt -w \$home  /usr/bin/env -i HOME=\$home PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games TERM=$TERM LANG=C.UTF-8 \$start"
                  
 cmd="\$@"
if [ "\$#" == "0" ];then
    exec \$command
else
    \$command -c "\$cmd"
fi                 
EOM
chmod +x $KALI_LAUNCHER

}
function fix_sudo () {
   ## fix sudo error and su on termux session 
  chmod +s $CHROOT/usr/bin/sudo
  chmod +s $CHROOT/usr/bin/su
}
function add_user () {
kali -r
}
function fix_net () {
## fix internet and add ip address 
rm -rf /etc/resolv.conf
cat > $CHROOT/etc/resolv.conf <<- EOM
nameserver 8.8.8.8
nameserver 8.8.4.4
EOM
}
function install_xfce_desktop () {
cd
cat > $HOME/$CHROOT/root/.bashrc <<- EOM
sudo apt update
sudo apt install xfce4 xfce4-whiskermenu-plugin -y
sudo apt install qterminal dbus-x11 tigervnc-standalone-server kali-themes firefox-esr -y
rm -rf .bashrc
exit
EOM
kali -r
}
function start-kali () {
 cat > $PREFIX/bin/start-kali <<- EOM
 kali vnc -s
 clear
# Add some colours 
 red='\033[1;31m'
 green='\033[1;32m' 
 yellow='\033[1;33m' 
 blue='\033[1;34m' 
 light_cyan='\033[1;96m' 
 reset='\033[0m' 
printf "wellcome to kali nethunter*\${reset}\\n"
printf "update repo type : sudo apt update\${reset}\\n"
printf "and install package type : sudo apt install <package>\${reset}\\n"
printf "create by termuxkali\${reset}\\n"
printf "\${red} start chroot kali${reset}\n"
kali
EOM
chmod +x $PREFIX/bin/start-kali
echo "start-kali " >> $HOME/.bashrc
}
function add_vnc () {
cat > $CHROOT/usr/bin/vnc <<- EOM
if [[ \$ubuntu == "0" || ("\$#" != "0" && ("\$1" == "-s" || "\$1" == "-S")) ]];then
    vncsever -kill :1
    vncserver -kill :2
    vncserver
    if [[ "\$#" != "0" && ("\$1" == "-s" || "\$1" == "-S") ]];then
        shift
    fi
fi
if [[ \$ubuntu == "0" || ("\$#" != "0" && ("\$1" == "-p" || "\$1" == "-P")) ]];then
     vncserver -kill :1
     vncserver -kill :2
    if [[ "\$#" != "0" && ("\$1" == "-p" || "\$1" == "-P") ]];then
        shift
    fi
fi
EOM
chmod +x $CHROOT/usr/bin/vnc
}
function kali_logo() {
clear
printf "${light_cyan}"
echo "                                           
######## ##    ##    ###    ##       ####            
   ##    ##   ##    ## ##   ##        ##                        
   ##    ##  ##    ##   ##  ##        ##                        
   ##    #####    ##     ## ##        ##                       
   ##    ##  ##   ######### ##        ##                 
   ##    ##   ##  ##     ## ##        ##                         
   ##    ##    ## ##     ## ######## ####  
           
                       kali nethunter           
    "                                                                     
                                                                      
   printf "${green}by termuxkali${reset}\n"
    
}
function ask () {
printf "${red}minimum requirement 1GB internet and ${reset}\n"
printf "${red}minimum requirement 6GB free storage${reset}\n"
sleep 20
}
clear
ask
kali_logo
printf "${blue}[*]checking architecture ....${reset}\n"
checking_architecture
printf "${blue}[+]install package${reset}\n"
install_package
printf "${blue}[+]download rootfs${reset}\n"
download_rootfs
printf "${blue}[+]extract rootfs${reset}\n"
extract_rootfs
printf "${blue}[+]configure termux for kali${reset}\n"
sleep 10
cd
cd
fix_sudo
kali_logo
select_user
sleep 4
echo "your username $select and password $password "
sleep 10
add_kali_launcher
start-kali
add_vnc
printf "${green}[+]add user${reset}\n"
fix_net
add_user
printf "${green}[+]install xfce desktop${reset}\n"
install_xfce_desktop
clear
kali_logo
echo 
echo
printf "${green}$password = is your password${reset}\n"
printf "${green}kali = start kali${reset}\n"
printf "${green}kali -r = start kali as root${reset}\n"
printf "${green}kali <command> = run command in kali env${reset}\n"
printf "${green}kali -r <command> = run command in kali env as root ${reset}\n"
printf "${green}kali vnc -s = start vncserver${reset}\n"
printf "${green}kali vnc -p = stop vncserver${reset}\n"
 printf "${green}kali -r vnc -s = start vncserver as root${reset}\n"
printf "${green}kali -r vnc -p = stop vncserver as root${reset}\n"
                        
